{pkgs}: let
  pico8App = pkgs.stdenv.mkDerivation {
    name = "PICO-8.app";
    src = pkgs.fetchzip {
      url = "https://www.lexaloffle.com/dl/7tiann/pico-8_0.2.6b_osx.zip";
      hash = "sha256-9a/KKQYN2QtjbOipTMHNBxxbHkTun2XkoSKKJZIkLe8=";
    };
    buildPhase = false;
    installPhase = ''
      mkdir -p $out
      cp -r * $out
    '';
  };
in
  pkgs.writeShellApplication {
    name = "pico8";
    runtimeInputs = [pico8App];
    text = ''
      ${pico8App}/PICO-8.app/Contents/MacOS/pico8 -windowed 1 -home ./ -root_path ./src/cart "$@"
    '';
  }
