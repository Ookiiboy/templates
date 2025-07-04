{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    ignoreBoy.url = "github:Ookiiboy/ignoreBoy";
    # Non-flake
    editorconfig.url = "github:Ookiiboy/editor-config/";
    editorconfig.flake = false;
  };

  outputs = {
    self,
    systems,
    nixpkgs,
    pre-commit-hooks,
    editorconfig,
    ignoreBoy,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs (import systems);
    meta = {
      pname = "game";
      version = "0.0.0";
    };
  in {
    packages =
      nixpkgs.lib.attrsets.recursiveUpdate
      # Build Exports
      (forAllSystems (system: let
        pkgs = import nixpkgs {inherit system;};
      in rec {
        default = cart;
        web = pkgs.callPackage ./_build/web.nix {inherit meta self pkgs system;};
        cart = pkgs.callPackage ./_build/cart.nix {inherit meta self pkgs system;};
        bin = pkgs.callPackage ./_build/bin.nix {inherit meta self pkgs system;};
      }))
      # Pico for different archs.
      rec {
        x86_64-darwin.pico8 = aarch64-darwin.pico8;
        aarch64-darwin.pico8 = let
          system = "aarch64-darwin";
          pkgs = import nixpkgs {inherit system;};
        in
          pkgs.callPackage ./_pico8/universal-darwin.nix {inherit pkgs;};

        aarch64-linux.pico8 = let
          system = "aarch64-linux";
          pkgs = import nixpkgs {inherit system;};
        in
          pkgs.callPackage ./_pico8/aarch64-linux.nix {inherit pkgs;};
        x86_64-linux.pico8 = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {inherit system;};
        in
          pkgs.callPackage ./_pico8/x86_64-linux.nix {inherit pkgs;};
      };
    # Nix Formatter
    formatter = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in
      pkgs.alejandra);
    # Pre-Commit Checks
    checks = forAllSystems (system: {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          # Nix
          alejandra.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          flake-checker.enable = true;
          # Lua
          luacheck.enable = true;
          # Generic - .editorconfig
          editorconfig-checker.enable = true;
        };
      };
    });
    # Development Shell(s)
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      ignoreSettings = {
        github.languages = ["Lua"];
        # gitignoreio.languages = [];
        # gitignoreio.hash = "";
        # Anything custom you might want in your .gitignore you can place in extraConfig.
        extraConfig = ''
          .pre-commit-config.yaml
          .editorconfig
          backup
          bbs
          carts
          cdata
          cstore
          plates
          activity_log.txt
          log.txt
          sdl_controllers.txt
        '';
      };
    in {
      default = pkgs.mkShell {
        # Environment Variables
        ENV = "dev";
        name = "Development_Shell";
        shellHook = ''
          if [ ! -d ".git" ]; then git init; fi
          ln -sf ${editorconfig}/.editorconfig ./.editorconfig
          ${self.checks.${system}.pre-commit-check.shellHook}
          ${ignoreBoy.lib.${system}.gitignore ignoreSettings}
        '';

        buildInputs =
          [
            self.packages.${system}.pico8 # Pico8
          ]
          ++ self.checks.${system}.pre-commit-check.enabledPackages;
      };
    });
  };
}
