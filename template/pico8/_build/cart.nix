{
  meta,
  self,
  pkgs,
  system,
}:
pkgs.stdenv.mkDerivation rec {
  inherit meta;
  name = meta.name;
  src = ../.;
  buildInputs = [self.packages.${system}.pico8];
  buildPhase = ''
    pico8 -x ./src/cart/main.p8 -export ${meta.pname}-${meta.version}.p8.png
  '';
  installPhase = ''
    mkdir -p $out
    cp -r *.p8.png $out
  '';
}
