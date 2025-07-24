{
  meta,
  pkgs,
}:
pkgs.writeShellApplication {
  # runtimeInputs = with pkgs; [];
  name = "${meta.name}-${meta.version}";
  text = builtins.readFile ../main.sh;
}
