{
  description = "大きいBOY's Development Templates";

  outputs = {self}: {
    templates = {
      # Generic
      generic.path = ./template/default;
      generic.description = "Generic Development Flake + Tooling";
      # Deno
      deno.path = ./template/deno;
      deno.description = "Deno 2 Flake + Tooling";
    };
    defaultTemplate = self.templates.generic;
  };
}
