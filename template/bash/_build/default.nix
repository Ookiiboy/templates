{
  meta,
  pkgs,
}:
pkgs.writeShellApplication {
  runtimeInputs = with pkgs; [bash];
  name = "${meta.name}-${meta.version}";
  text = builtins.readFile ../main.sh;
}
