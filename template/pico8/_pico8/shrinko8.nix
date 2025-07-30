{pkgs}: let
  shrinko8 = pkgs.fetchFromGitHub {
    owner = "thisismypassport";
    repo = "shrinko8";
    rev = "bb035c55b8c6caea6661c983ccd6a560238dc95d";
    hash = "sha256-dSDCBlax/jhbx0L/4VN4sL6cAtKX3T8deaQrsvZHT5Q=";
  };
in
  pkgs.writeShellApplication {
    name = "shrinko8";
    runtimeInputs = with pkgs; [python313 python313Packages.pillow];
    # https://github.com/thisismypassport/shrinko8?tab=readme-ov-file
    text = ''
      python ${shrinko8}/shrinko8.py "$@"
    '';
  }
