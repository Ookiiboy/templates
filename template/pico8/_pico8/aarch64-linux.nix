{pkgs}:
pkgs.buildFHSEnv rec {
  name = "pico8";
  pico8Src = pkgs.fetchzip {
    url = "https://www.lexaloffle.com/dl/7tiann/pico-8_0.2.6b_raspi.zip";
    hash = "";
    postFetch = "cp -r * $out/";
  };
  targetPkgs = pkgs: (with pkgs; [
    xorg.libX11
    xorg.libXext
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXi
    xorg.libXrandr
    xorg.libXScrnSaver
    xorg.libXxf86vm
    xorg.libxcb
    xorg.libXrender
    xorg.libXfixes
    xorg.libXau
    xorg.libXdmcp
    alsa-lib
    udev
    wget
  ]);
  runScript = "${pico8Src}/pico8 -windowed 1 -home ./ -root_path ./src/cart";
}
