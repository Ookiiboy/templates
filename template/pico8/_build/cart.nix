{
  meta,
  self,
  pkgs,
  system,
}:
pkgs.stdenv.mkDerivation rec {
  pname = meta.pname;
  version = meta.version;
  src = ../.;
  buildInputs = [self.packages.${system}.pico8];
  buildPhase = ''
    pico8 -x ./src/cart/main.p8 -export ${pname}-${version}.p8.png
  '';
  installPhase = ''
    mkdir -p $out
    cp -r *.p8.png $out
  '';
}
