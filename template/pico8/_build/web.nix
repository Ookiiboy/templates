{
  meta,
  self,
  pkgs,
  system,
}:
pkgs.stdenv.mkDerivation rec {
  inherit meta;
  src = ../.;
  buildInputs = [self.packages.${system}.pico8];
  buildPhase = ''
    pico8 -x ./src/cart/main.p8 -export ${meta.pname}-${meta.version}.html
  '';
  installPhase = ''
    mkdir -p $out
    cp -r *.js $out
    cp -r *.html $out
  '';
}
