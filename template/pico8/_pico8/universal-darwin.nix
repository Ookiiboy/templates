{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "pico8";
  src = pkgs.fetchzip {
    url = "https://www.lexaloffle.com/dl/7tiann/pico-8_0.2.6b_osx.zip";
    hash = "";
    postFetch = "cp -r * $out/";
  };
  buildPhase = ''
    ls -la >> files
  '';
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
