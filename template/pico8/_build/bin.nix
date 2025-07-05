{
  meta,
  self,
  pkgs,
  system,
}:
pkgs.stdenv.mkDerivation {
  inherit meta;
  src = ../.;
  buildInputs = [self.packages.${system}.pico8];
  buildPhase = ''
    pico8 -x ./src/cart/main.p8 -export ${meta.pname}-${meta.version}.bin
  '';
  installPhase = ''
    mkdir -p $out
    cp -r *.bin $out
  '';
}
