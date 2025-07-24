{
  description = "大きいBOY's Development Templates";

  outputs = {self}: {
    templates = {
      # Generic
      generic.path = ./template/generic;
      generic.description = "Generic Development Flake + Tooling";
      # Clojure - Babashka
      babashka.path = ./template/babashka;
      babashka.description = "Babashka Development Flake + Tooling";
      # Deno
      deno.path = ./template/deno;
      deno.description = "Deno 2 Development Flake + Tooling";
      # Pico8 - Fantasy Console
      pico8.path = ./template/pico8;
      pico8.description = "Pico8 Development Flake + Tooling";
      # Bash - Shell
      bash.path = ./template/bash;
      bash.description = "Bash Development Flake + Tooling";
    };
    defaultTemplate = self.templates.generic;
  };
}
