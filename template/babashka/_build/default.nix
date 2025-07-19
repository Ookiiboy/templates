{
  meta,
  pkgs,
}:
pkgs.writeBabashkaApplication {
  runtimeInputs = [];
  name = "${meta.name}-${meta.version}";
  text = builtins.readFile ../script.clj;
}
