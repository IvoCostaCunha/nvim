# Documentation for nvim configuration

## Table of contents
1.  [General](#General)
    1.  [Directory structure](#Directory-structure)
    2.  [File loading order](#File-loading-order)
2.  [Neovim configuration](#Neovim-configuration)
    1.  [Keybinds](#Keybinds)
3.  [Plugins configurations](#Plugin-configurations)
    1.  [Plugin configuration template](#Plugin-configuration-template)
	2.  [Themes](#Themes)
    3.  [LSP configuration](#LSP-configuration)
        1.  [List of LSP servers](#List-of-LSP-server)
        2.  [mason plugin configuration](#mason-plugin-configuration)
        3.  [lspconfig configuration](#lspconfig-configuration)
        4.  [nvim-cmp plugin configuration](#nvim-cmp-plugin-configuration)

## General
### Directory structure
This [Neovim](https://neovim.io/) configuration follows [lazy.nvim](https://lazy.folke.io/) plugin manager recommended directory structure.

```txt
nvim
    ├── doc
    │   └── nvim.md
    ├── init.lua
    ├── lazy-lock.json
    ├── lazyvim.json
    └── lua
        ├── config
        │   ├── keybinds.lua
        │   ├── lazy.lua
        │   └── options.lua
        └── plugins
            ├── plugin.lua
            └── ...
```

### Loading order
init.lua only import other files.  
In order of import :

1.  options.lua - vim.opt options, same as vim set options.
2.  lazy.lua - lazy.nvim package manager configuration.
3.  keybinds.lua - Contains most keybinds, it's loaded last since it may require plugins loaded by Lazy.

## Neovim configuration
The general configuration of Neovim is located in the config directory.

### Keybinds
Keybinds are set in the file `lua/config/keybinds.lua`,  
The Neovim function `vim.key.map.set()` is used to setup keybinds.  
It takes the following parameters :

```lua
vim.keymap.set({mode}, {lhs}, {rhs}, {opts}) 
-- {mode} -> mode in which the keybinds will be usable "n" for normal mode or "i" for insert mode for example.
-- {lhs} is the keybind.
-- {rhs} is the command to be executed.
-- Can be a lua function or a vim <cmd>.
-- {desc} is optional but used for which-key plugin keybinds descriptions.
```

## Plugins configurations
Plugins individual configurations are then in the plugins directory.  
All are individual, one for each plugin, except for lspconfig.lua that contains multiple configurations for plugins related to [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).

### Plugin configuration template
Adding plugins is straightforward in most cases however LSP related plugins have particularities.  
This template follows the official [documentation](https://www.lazyvim.org/configuration) of lazy.nvim.

```lua
-- lua/plugins/example-plugin.lua
return {
    "<author>/<repository>",
    -- Optional - If the plugin has other plugins as dependencies add these here.
    depedencies = {
        "<author>/<repository>",
        {"<author>/<repository>", event = "<event>", opts = {...}, ...}, -- or with properties
        ...
    },
    -- Optional - If the plugins is to be loaded when an event is triggered.
    event = "<event>",
    -- Optional - If the plugin is to be loaded when a certain key sequence is used.
    -- desc is optional but used by which-key plugin keybinds descriptions.
    keys = {
        {"<keybind>", "< <cmd> or lua function>", desc = "<description>"}
    },
    -- Optional - Add here plugins options, check each plugin for its options.
    opts = {
        color = "#111111" -- for example
        ...
    },
    -- Optional - config is always called with opts as parameter even if not explicitly overrided.
    -- To change plugin options it is simpler to just add those to opts
    config = function(_, opts) {
        ...
        require('<plugin>').setup(opts) -- Call setup since modifying config will override it.
        ...
    }
}
```

Other properties can be overridden, see lazy.nvim [documentation](https://lazy.folke.io/spec) documentation for it.

In this repository an effort to separate plugin configurations has been made for code clarity, but the `return{}` function can return multiple configurations instead of only one, they juste have to be in an array.

### Themes
Published themes like [tokyonight](https://github.com/folke/tokyonight.nvim) are plugins and can be configured in the same way as the previous template.
If the theme is to be the main theme loaded and setup at start then it has to include the following:
```lua
-- lua/plugins/example-theme.lua
{
	priority: 1000, -- To be loaded 1st by lazy.nvim
	
	***
  	
	config = function (_, opts)
    	require("catppuccin").setup(opts)
    	vim.cmd.colorscheme("catppuccin") -- Set the theme, can be anywhere in the configuration.
  	end
}
```


### LSP configuration
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is builtin Neovim. It provides to [Neovim LSP Client](https://neovim.io/doc/user/lsp.html) (Language Server Protocol) presets for configurations of each [LSP Server](https://microsoft.github.io/language-server-protocol/).

With nvim-lspconfig alone each LSP Server has to be installed by the user in the system. To simplify LSP server management the [mason](https://github.com/williamboman/mason.nvim) plugin is used. It install LSP Servers during its setup or by Neovim command line, both are persistent.

Neovim LSP Client has also no automatic autocompletion only a keybinds to complete, by default with the keybind `<C-x> / <C-o>`.  
Another plugin [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) is therefore used to enable a [VS-Codium](https://vscodium.com/) like autocompletion.

These 3 configurations then have to be configured and loaded in a specific order.

Configuration code will not be fully present here since the point is to explain only the logic. But the file lspconfig.lua also has documentation if there is need of precisions on code missing here.

#### List of LSP servers
First of a list of LSP servers has to be defined.

```lua
-- lua/plugins/lspconfig.lua
local lsp_servers_to_install = {
  "html",
  "cssls",
  "quick_lint_js",
  "ts_ls",
  "angularls",
  "clangd",
  "jdtls",
  "lua_ls",
  "pylsp",
  "bashls",
  "dockerls",
  "texlab",
}
```

mason also manages [linters](https://en.wikipedia.org/wiki/Lint_%28software%29 "https://en.wikipedia.org/wiki/Lint_(software)"), [DAPs](https://microsoft.github.io/debug-adapter-protocol/) (Debug Adapter Protocol) servers and code formatters.  
In this example not all are LSPs , some are linters only, they do not provide any completion suggestions.  
For example for Javascript [quick-lint-js](https://quick-lint-js.com/) linter is used with [ts_ls](https://github.com/typescript-language-server/typescript-language-server) LSP.

However only LSPs will be covered in this section.

*Ideally each server should have its options set here but I've not not done it yet.*

#### mason plugin configuration
This list will then be installed by mason.

```lua
-- lua/plugins/lspconfig.lua
{
    "williamboman/mason.nvim",
    config = function()
    	require("mason").setup()
    end
},

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
        -- Install LSP servers
      	ensure_installed = lsp_servers_to_install,
      	automatic_installation = true
    }
},
```

mason require these 2 plugins.

#### lspconfig configuration
Then mason installed LSP servers must be connected to lspconfig.

```lua
-- lua/plugins/lspconfig.lua
{
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    -- nvim-lspconfig is dependent on cmp-nvim-lsp being loaded 
    -- to be able to be used by cmp plugins as a source completion.
    dependencies = {"hrsh7th/cmp-nvim-lsp"},
    
    ...
    
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local lspconfig = require("lspconfig")

      -- Adding LSP capabilities to nvim-cmp .
      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      lsp_capabilities = cmp_nvim_lsp.default_capabilities(lsp_capabilities)

      -- Recovering mason-lspconfig installed servers, not only those that are in lsp_servers_to_install.
      local lsp_servers = require("mason-lspconfig").get_installed_servers()

      -- For each server the setup in run with the override of capabilities property. 
      for _,s in pairs(lsp_servers) do
        lspconfig[s].setup({
          capabilities = lsp_capabilities
        })
      end
  },
```

At this point Neovim LSP Client can use the LSP servers but not offer autocompletions.  
So nvim-cmp still need to be setup.

#### nvim-cmp plugin configuration
nvim-cmp is dependent on a number of "sub" plugins.

```lua
-- lua/plugins/lspconfig.lua
{
    "hrsh7th/nvim-cmp",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      {
      	-- Optional - to enable automatic pairs or () {} [] "" ...
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
      },
      {
      	-- REQUIRED - nvim-cmp requires an snippet source.
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp"
      },
      "saadparwaiz1/cmp_luasnip"
    },
}
```

nvim-cmp has a number of properties that have to be set in its setup.

```lua
-- lua/plugins/lspconfig.lua
{
    ...
    
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({

        -- REQUIRED, luasnip is used here but there are other options.
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },

        -- REQUIRED, cmp autocomplete sources.
        -- The object structure must be respected!
        sources = cmp.config.sources(
          {
            {name = "nvim_lsp"}, -- keyboard_lenght => To auto complete at x chars.
            {name = "path"},
            {name = "buffer"},
            {name = "luasnip"}
          },
          {
            {name = "buffer"}
          }
        ),
        
    ...
    
  }

```

A this point autocompletion should be enabled.
