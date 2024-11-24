{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    # Non-flake
    stylelint-config-recommended.url = "github:stylelint/stylelint-config-recommended";
    stylelint-config-recommended.flake = false;
    editorconfig.url = "github:Ookiiboy/editor-config/";
    editorconfig.flake = false;
  };

  outputs = {
    self,
    systems,
    nixpkgs,
    pre-commit-hooks,
    stylelint-config-recommended,
    editorconfig,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs (import systems);
  in {
    formatter = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in
      pkgs.alejandra);
    checks = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          # Nix
          alejandra.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          flake-checker.enable = true;
          # Deno
          denofmt.enable = true;
          denolint.enable = true;
          # Shell Scripts
          shellcheck.enable = true;
          beautysh.enable = true;
          # JSON
          check-json.enable = true;
          # Github Actions
          actionlint.enable = true;
          # Generic - .editorconfig
          editorconfig-checker.enable = true;
          check-toml.enable = true;
          # CSS - .stylelint.json
          stylelint = {
            enable = true;
            name = "Stylelint";
            entry = "${pkgs.stylelint}/bin/stylelint --fix";
            files = "\\.(css)$";
            types = ["text" "css"];
            language = "system";
            pass_filenames = true;
          };
        };
      };
    });
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        name = "development";
        shellHook = ''
          ln -sf ${stylelint-config-recommended}/index.js ./stylelint.config.mjs
          ln -sf ${editorconfig}/.editorconfig ./.editorconfig
          ${self.checks.${system}.pre-commit-check.shellHook}
        '';
        ENV = "dev";
        buildInputs = with pkgs;
          [
            deno
          ]
          ++ self.checks.${system}.pre-commit-check.enabledPackages;
      };
    });
  };
}
