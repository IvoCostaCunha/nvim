# Documentation for nvim configuration


## Table of contents
1. [General](#General)
    1. [Directory structure](#directory-structure)
    2. [File loading order](#file-loading-order)
2. [Neovim configuration](#neovim-configuration)
    1. [Keybinds](#keybinds)
        1. [Keybinds logic](#keybinds-logic)
3. [Plugins configurations](#lugin-configurations)
    1. [Plugin configuration template](#plugin-configuration-template)
    2. [Plugin list](#plugin-list)
	3. [Themes](#themes)
    4. [Vimtex](#vimtex)
    5. [Lualine](#lualine)
    6. [Render-markdown](#render-markdown)
   7 . [LSP  and DAP configuration](#lsp-and-dap-configuration)
        1. [List of LSP servers](#list-of-lsp-servers)
        2. [mason plugin configuration](#mason-plugin-configuration)
        3. [mason-nvim-dap plugin](#mason-nvim-dap-plugin)
        4. [lspconfig configuration](#lspconfig-configuration)
        5. [nvim-cmp plugin configuration](#nvim-cmp-plugin-configuration)

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
        │   ├── options.lua
        │   └── autocmds.lua
        └── plugins
            ├── plugin.lua
            └── ...
```

### Loading order
init.lua only import other files.
In order of import:
1. options.lua: vim.opt options, same as vim set options.
2. autocmds.lua: Custom autocmds.
3. lazy.lua: lazy.nvim package manager configuration.
4. keybinds.lua: Contains most keybinds, it's loaded last since it may require plugins loaded by Lazy.

## Neovim configuration
The general configuration of Neovim is located in the config directory.

### Keybinds
Keybinds are set in the file `lua/config/keybinds.lua`,
The Neovim function `vim.key.map.set()` is used to setup keybinds.
It takes the following parameters:

```lua
vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
-- {mode} -> mode in which the keybinds will be usable "n" for normal mode or "i" for insert mode for example.
-- {lhs} is the keybind.
-- {rhs} is the command to be executed.
-- Can be a lua function or a vim <cmd>.
-- {desc} is optional but used for which-key plugin keybinds descriptions.
```

There are also keybinds groups declared. These are a feature of [which-key](https://github.com/folke/which-key.nvim) plugin.
Groups are like a category of bindings. For example all Telescope bindings start with `<leader>f`, so it is also used as group for all Telescope bindings.

```lua
lua/config/keybinds.lua

local wk = require("which-key")
wk.add {
  { "<leader>f",  group = "Telescope" },
  { "<leader>l",  group = "LaTeX" },
  { "<leader>g",  group = "GoTo" },
  { "<leader>e",  group = "LSP Diagnostics" },
  { "<leader>fG", group = "Telescope git" },
  { "<leader>fl", group = "Telescope LSP" },
  { "<leader>d",  group = "Debug" },
  { "<leader>x",  group = "Diagnostic list" },
  { "<leader>m",  group = "Markdown preview" },
}
```

#### Keybinds logic
Keybinds follow a certain logic when possible.
- Keybinds that focus something use Vim default bindings for movement. For example moving between buffers use `Alt` and `h` or `l` to move to previous or next buffer.
- Keybinds that delete something use `w`. For example `Alt+w` deletes a buffer.
- Keybinds that start a function or an action start by the first letter of that action. For example `<leader>lc` start LaTeX compiler. (l(atex)c(compile))
- Finally more basic Vim function don't use `<leader>`, `<leader>` is used for plugin or LSP functions.

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

Other properties can be overridden, see lazy.nvim [documentation](https://lazy.folke.io/spec).

In this repository an effort to separate plugin configurations has been made for code clarity, but the `return{}` function can return multiple configurations instead of only one, they just have to be in an array.

### Plugin list
Plugins used by this configuration of Neovim, some use dependencies that won't be listed here.
- [alpha-nvim](https://github.com/goolord/alpha-nvim): Neovim welcome page.
- [catppucin](https://github.com/catppuccin/nvim): Used theme.
- [indent-backline](https://github.com/lukas-reineke/indent-blankline.nvim): A line that displayed indents.
- [lazy](https://lazy.folke.io/): Plugin manager.
- [lualine](https://github.com/nvim-lualine/lualine.nvim): Makes easy to configure the statusline, and has features to configure the tabline and the titleline.
- [mason](https://github.com/williamboman/mason.nvim): Installs LSP, linters, DAP and formatters.
- [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim): Displays a file tree and has features to edit files.
- [highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors): Displays colours of different formats of colours.
- [lspconfig](https://github.com/neovim/nvim-lspconfig): Presets of LSP servers. Used to configure LSPs in Neovim.
- [telescope](https://github.com/nvim-telescope/telescope.nvim): Simple and fast way to find different files, information and more.
- [vimtex](https://github.com/lervag/vimtex): LaTeX tools for Vim.
- [which-key](https://github.com/folke/which-key.nvim): Displays keybinds possibilities with descriptions as they are typed.
- [tree-sitter](https://github.com/tree-sitter/tree-sitter): Code analysis and improved colouration.
- [trouble](https://github.com/folke/trouble.nvim): A more easily readable output of telescope functionalities.
- [dap](https://github.com/mfussenegger/nvim-dap): Neovim debugger adapter protocol Plugin.
- [dap-ui](https://github.com/rcarriga/nvim-dap-ui): A better UI for dap.
- [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim): Better renderer for markdown.

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

### Vimtex
Vimtex is the plugin that facilitates editing LaTeX (.tex) files. It provides a lot of extra tools and syntax help.
One of these tools in a real time viewer that updates each time the LaTeX file is recompiled. In Linux distributions this preview is done with [zathura](https://pwmt.org/projects/zathura/) PDF viewer.
However, on macOS zathura can have compatibility problems, so an easier solution is to use [Skim](https://skim-app.sourceforge.io/) instead.

To do so a simple change in Vimtex configuration must be done.
```lua
return {
  "lervag/vimtex",
  event = "VeryLazy",
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- Replace zathura by skim here !
    vim.g.vimtex_view_method = "zathura"
  end
}
```

zathura can also be used if the document is opened manually with `sh zathura /path/to/file`, but the command `:VimtexView` won't be functional.

### Lualine
[lualine](https://github.com/nvim-lualine/lualine.nvim) provides an easier way to configure the statusline.
It also features a way to configure the tabline and the titleline.
In this configuration lualine is used to display on the top left all open buffers and in the top right the tabs open and for each tab which buffers are open in different windows.

```lua
tabline = {
    lualine_a = { "buffers" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "windows" },
    lualine_z = { "tabs" }
},
```

### render-markdown
render-mardown features a better markdown renderer. It is also quite configurable.

```lua
opts = {
    render_modes = true,
    debounce = 200,
    sign = {
      enabled = false,
    },
    code = {
      style = "full",
      position = "left",
      language_name = false,
      width = "full",
      left_pad = 5,
      right_pad = 5
    },
    heading = {
      width = "full",
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    paragraph = {
      enabled = false
    },
    bullet = {
      icons = { '●', '○', '◆', '◇' },
      left_pad = 1,
      right_pad = 1
    },
    link = {
      enabled = true,
      footnote = {
        superscript = true,
        prefix = "",
        suffix = "",
      },
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
      custom = {
        web = { pattern = "^http", icon = "󰖟 " },
      },
    }
  },
```

### LSP and DAP configuration
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is builtin Neovim. It provides to [Neovim LSP Client](https://neovim.io/doc/user/lsp.html) (Language Server Protocol) presets for configurations of each [LSP Server](https://microsoft.github.io/language-server-protocol/).

With nvim-lspconfig alone each LSP Server has to be installed by the user in the system. To simplify LSP server management the [mason](https://github.com/williamboman/mason.nvim) plugin is used. It install LSP Servers during its setup or by Neovim command line, both are persistent.

Neovim LSP Client has also no automatic autocompletion only a keybinds to complete, by default with the keybind `<C-x> / <C-o>`.
Another plugin [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) is therefore used to enable a [VSCodium](https://vscodium.com/) like autocompletion.

These 3 configurations then have to be configured and loaded in a specific order.

Configuration code will not be fully present here since the point is to explain only the logic. But the file lspconfig. The actual files also have documentation if there is need of precisions on code missing here.

#### List of LSP servers
First of a list of LSP servers should to be defined.

```lua
-- lua/plugins/lspconfig.lua
local lsp_servers = {
  {name = "lua_ls",
    -- Enables Neovim diagnostics.
    on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Most likely LuaJIT in the case of Neovim.
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
    end,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT"
        }
      }
    }
  },
  -- ltex only provides orthographic corrections.
  {name = "ltex",
    settings = {
      ltex = {
        language = "EN-GB",
        disabledRules = {
          ["en-GB"] = {"PROFANITY"}
        },
        -- User dictionaries
        dictionary = {
          ["en-GB"] = {},
          ["fr"] = {}
        },
        checkFrequency = "edit",
        sentenceCacheSize = "2500",
      }
    }
  },
  {name = "bashls", settings = {}},
  {name = "dockerls", settings = {}},
  {name = "texlab", settings = {}},
  {name = "html", settings = {}},
  {name = "cssls", settings = {}},
  {name = "quick_lint_js", settings = {}},
  {name = "ts_ls", settings = {}},
  {name = "angularls", settings = {}},
  {name = "clangd", settings = {}},
  {name = "jdtls", settings = {}},
}
```

`lsp_servers` is an array of the different servers that mason will install at launch if not installed already.
Each server has 2 mandatory properties.
```lua
local lsp_servers = {

...

    {
        name = "<server name>",
        settings = { ... <server settings> ... },
        -- Optional
        on_init = function() ... end
    },

...

}
```

- **name**: Name of the servers as used in [MasonInstall](https://github.com/williamboman/mason.nvim/blob/main/doc/mason.txt#L201).
- **settings**: specific LSP servers options.
- **(optional) on_init**: function to execute when a LSP server is initiated. Not always used that is why it is optional.

mason also manages [linters](https://en.wikipedia.org/wiki/Lint_%28software%29 "https://en.wikipedia.org/wiki/Lint_(software)"), [DAPs](https://microsoft.github.io/debug-adapter-protocol/) (Debug Adapter Protocol) servers and code formatters.
In this example not all are LSPs , some are linters only, they do not provide any completion suggestions.
For example for Javascript [quick-lint-js](https://quick-lint-js.com/) linter is used with [ts_ls](https://github.com/typescript-language-server/typescript-language-server) LSP.

However, only LSPs will be covered in this section.

*Ideally each server should have its options set here, but I've not done it yet.*

#### mason plugin configuration
This list will then be installed by mason.

```lua
-- lua/plugins/lspconfig.lua
...

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

...
```

mason require these 2 plugins.

#### mason-nvim-dap
[mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim) is a plugin that configures DAPs (Debugger Adaptater Protocol).

```lua
-- lua/plugins/lspconfig.lua
{
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
},

...

{
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Add breakpoint" }
    },
},

{
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = dap_list,
      handlers = {},
    },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
    end
},

...
```
These plugins must be loaded in this specific order.


`dap_list` is a list of DAP with [specific names](https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua) for mason-nvim-dap.

```lua
...

-- lua/plugins/lspconfig.lua
local dap_list = { "python", "codelldb"}

...
```

#### dap-ui
dap-ui is a plugin that displays a better UI for nvim-dap

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

      -- Adding LSP capabilities to nvim-cmp.
      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
      lsp_capabilities = cmp_nvim_lsp.default_capabilities(lsp_capabilities)

      -- Recovering mason-lspconfig installed servers, not only those that are in lsp_servers_to_install.
      -- Then these are added to lsp_servers without any settings.
      local mason_installed_lsp_servers = require("mason-lspconfig").get_installed_servers()
      for _,ms in pairs(mason_installed_lsp_servers) do
        if not is_in_lsp_servers(lsp_servers, ms) then
          table.insert(lsp_servers, { name = ms, settings = {} })
        end
      end

      -- For each server the setup in run with the override of capabilities and settings properties if on_init exists it is also override.
      for _,s in pairs(lsp_servers) do
        if s.on_init ~= nil then
          lspconfig[s.name].setup({
            capabilities = lsp_capabilities,
            settings = s.settings,
            on_init = s.on_init
          })
        else
          lspconfig[s.name].setup({
            capabilities = lsp_capabilities,
            settings = s.settings,
          })
        end
      end

    end
  },
```

At this point Neovim LSP Client can use the LSP servers but not offer auto-completions.
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

At this point autocompletion should be enabled.

## Performance
This tables is done with values obtained via lazy internal profiler.
Nvim is started 10 times on this configuration to determine an average.
The Macbook Pro is tested on battery.

Macbook pro configuration:
- CPU: i5@2,3 GHz (4 Cores)
- GPU: Intel Iris Plus Graphics 655
- RAM: 8 Gb LPDDR3 @2133MHz
- OS: macOS Sequoia 15.2

| PC | date | average startup time | best time | worst time |
| :---: |:---: | :---: | :--: | :--: |
| Macbook Pro i5 2018 | 20/12/2024 | x | x | x |


