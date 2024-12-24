# nvim

## Introduction
This repository contains my personal configuration of Neovim.
Use it if you like, but I do not guarantee stability.
Check the [documentation](doc/config-doc.md) at `doc/config-doc.md`.

## Neovim version
This configuration has been tested in Neovim@0.10.2 (LuaJIT@2.1). It might have compatibility issues with lesser versions of Neovim.

## Plugin external dependencies
Run `:checkhealth` to know if critical plugin external dependencies are missing.
[Vimtex](https://github.com/lervag/vimtex) requires [zathura](https://pwmt.org/projects/zathura) PDF reader to be able to display a live version of the edited LaTeX document, an alternative [Skim](https://skim-app.sourceforge.io/) is recommended since zathura can have compatibility issues on macOS.

## LSPs
The plugin [mason](https://github.com/williamboman/mason.nvim) manages LSP servers and DAPs.
