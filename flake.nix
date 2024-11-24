{
  description = "Development Templates";

  outputs = {self}: {
    templates = {
      deno = {
        path = ./template/deno;
        description = "Deno 2 Flake + Tooling";
      };
    };
    defaultTemplate = self.templates.deno;
  };
}
