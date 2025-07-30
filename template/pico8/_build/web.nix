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
  buildInputs = [
    self.packages.${system}.pico8
    self.packages.${system}.shrinko8
  ];
  buildPhase = ''
    shrinko8 ./src/cart/main.p8 ${toString meta.shrinkoOptions} ./minified.p8
    pico8 -x ./minified.p8 -export ${meta.pname}-${meta.version}.html
  '';
  installPhase = ''
    mkdir -p $out
    cp -r *.js $out
    cp -r *.html $out
  '';
}
