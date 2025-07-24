# 大きいBOY's Development Environment Templates, for big boys...
... of all genders. Everyone who is not a total chud is welcome to use these templates for their project.

## What do these templates do?

These are the 大きいBOY group's `nix` development shell templates. The intent is to spend less time setting up development environments for new projects.

### Features Include
- Inits your git repo if not already.
- Automatic setup of Pre-Commit Hooks.
- Automatic, community derrived, sane defaults for your repo's `.gitignore`.
- Pre-defined .editorconfig file.

## Why would I want to use this?
- You're mentally exsausted, and don't want to setup the tooling for yet another project.
- Maybe you don't have a good idea of what a development shell in `nix` should look like, and just want a starting point to hack on.
- You are on a Apple, and you tired of dealing with `homebrew`'s bullshit, and want to use a real package manager for your projects for a change.
- You think sync'd up consistant development environments are groovy, and you think your team might dig it, too.

## Why would I not want to use this?
- You have differing opinons on how a development shell should be setup, and organized. Totally get it. 
- You don't agree with the default tooling, and you think it might be excessive. I have opinions, too.
- You think you could do better, and if that's the case, dude, make a PR and help everyone, hero!

## How to use these templates

### Before you use this
Some things need to be installed, right? Right.
Make sure:

- `git` is installed
- `nix` is installed
- nix flakes are enabled
- `direnv` is setup (optional, but reccomended)

### Getting Started
In a new project directory run one of the nix flake template command like so:

#### Generic Starter
```shell
nix flake init -t github:Ookiiboy/templates
```
Feel free to edit the `flake.nix` file's attribute path `outputs.devShells.<archtecture>.default`'s `buildInputs` array with your needed packages.

You may also look at `outputs.devShells.<archtecture>.ignoreSettings.github.languages` array and add the language(s) you're going to be working with. For more information see the [ignoreBoy project](https://github.com/Ookiiboy/ignoreBoy/blob/main/README.md)'s fairly spare documentation.


#### Bash/Shell
```shell
nix flake init -t github:Ookiiboy/templates#bash
```
#### Clojure/Babashka
```shell
nix flake init -t github:Ookiiboy/templates#babashka
```
#### Deno
```shell
nix flake init -t github:Ookiiboy/templates#deno
```
#### Pico8
```shell
nix flake init -t github:Ookiiboy/templates#pico8
```
### Starting the development shell

`direnv` should pick up that there is a `.envrc` file. To let it run:
```shell
direnv allow
```
If you dont' want to use `direnv` you could start the shell by using the `nix` command, not reccomended:
```shell
nix develop
```
On first run (and any time you save the `flake.nix` file), and when the shell reloads, it will check for a git project, and then the development enviroment will link (or copy in the case of `.gitignore`) files automatically. These don't need to be commited, except for gitignore. Side note: Git won't actually let you make a link to a .gitignore. Apparently at some point it was allowed. 

You should now be dropped into your environment. You can test this:
```shell
echo $ENV
# dev
```
Happy hacking, ookiiBoy.
