# Documentation for nvim configuration


## Table of contents
1. [General](#General)
    1. [Directory structure](#directory-structure)
    2. [Lua modules loading order](#lua-modules-loading-order)
2. [Neovim configuration](#neovim-configuration)
    1. [Mappings](#mappings)
        1. [Mapping set up function](#mapping-setup-function)
        2. [Mappings logic](#mappings-logic)
        3. [Mappings groups](#mappings-groups)
3. [Plugins](#puglins)
    1. [Plugin configuration template](#plugin-configuration-template)
    2. [Plugin list](#plugin-list)
    3. [Themes](#themes)
    4. [Core plugins](#core-plugins)
        1. [Lualine](#lualine)
        2. [Treesitter](#treesitter)
        3. [LSP and DAP configuration](#lsp-and-dap-configuration)
            1. [List of LSP servers](#list-of-lsp-servers)
            2. [mason plugin configuration](#mason-plugin-configuration)
            3. [mason-nvim-dap plugin](#mason-nvim-dap-plugin)
            4. [lspconfig configuration](#lspconfig-configuration)
            5. [nvim-cmp plugin configuration](#nvim-cmp-plugin-configuration)
    5. [Markdown and personal wiki plugins](#markdown-and-personal-wiki-plugins)
        1. [Render-markdown](#render-markdown)
        2. [Wiki](#wiki)
    6. [LaTeX related plugins]
        1. [Vimtex](#vimtex)

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
        │   ├── mappings.lua
        │   ├── lazy.lua
        │   ├── options.lua
        │   └── autocmds.lua
        └── plugins
            ├── plugin.lua
            └── ...
```

### Loading order
init.lua uniquely imports other files.
In order of import:
1. options.lua: [vim.opt](https://neovim.io/doc/user/lua-guide.html#_vim.opt) options, same as vim set options.
2. autocmds.lua: Custom [autocmds](https://neovim.io/doc/user/api.html#nvim_create_autocmd).
3. lazy.lua: [lazy.nvim](https://lazy.folke.io/) package manager configuration.
4. mappings.lua: Contains most mappings, it's loaded last since it may require plugins loaded by lazy.

## Neovim configuration
The general configuration of Neovim is located in `lua/config`.

### Mappings
Mappings are set in the file `lua/config/mappings.lua`,

#### Mapping set up function
The Neovim function `vim.key.map.set()` is used to set up mappings. See the [official documentation](https://neovim.io/doc/user/lua.html#vim.keymap.set()).
It takes the following parameters:

```lua
vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
-- {mode} -> mode in which the mappings will be usable "n" for normal mode or "i" for insert mode for example.
-- {lhs} is the mapping.
-- {rhs} is the command to be executed.
-- Can be a lua function or a vim <cmd>.
-- {desc} is optional but used for which-key plugin mappings descriptions.
```

#### Mappings logic
Mappings follow a certain logic when possible.
- Mappings that focus something use Vim default bindings for movement. For example moving between buffers use `Alt` and `h` or `l` to move to previous or next buffer.
- Mappings that delete something use `w`. For example `Alt+w` deletes a buffer.
- Mappings that start a function or an action start by the first letter of that action. For example `<leader>lc` start LaTeX compiler. (l(atex)c(ompile))
- Finally more basic Vim function don't use `<leader>`, `<leader>` is used for plugin or LSP functions.

#### Mapping groups
There are also mappings groups declared. These are a feature of [which-key](https://github.com/folke/which-key.nvim) plugin. See [group attribute](https://github.com/folke/which-key.nvim?tab=readme-ov-file#%EF%B8%8F-mappings).
Groups are like a category of bindings. For example all Telescope bindings start with `<leader>f`, so it is also used as group for all Telescope bindings.
This way of organizing mappings enables a sort of "menu-like" mappings.

```lua
lua/config/mappings.lua

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

## Plugins configurations
Plugins individual configurations are then in `lua/plugins`.
Most are individual, one for each plugin, except for `lua/plugins/lspconfig.lua` that contains multiple configurations for plugins related to [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
Not all plugins will be features here, only those who require explanations since this is mostly a personal project destined to myself.

### Plugin configuration template
Adding plugins is straightforward in most cases however LSP related plugins have particularities.
This template follows the official [documentation](https://www.lazyvim.org/configuration) of lazy.

```lua
-- lua/plugins/example-plugin.lua
return {
    "<author>/<repository>",
    -- Optional - If the plugin has other plugins as dependencies add these here.
    depedencies = {
        "<author>/<repository>",
        {"<author>/<repository>", event = "<event>", opts = {...}, ...}, -- or with properties
        -- ...
    },
    -- Optional - If the plugins is to be loaded when an event is triggered.
    event = "<event>",
    -- Optional - If the plugin is to be loaded when a certain key sequence is used.
    -- desc is optional but used by which-key plugin mappings descriptions.
    keys = {
        {"<mapping>", "< <cmd> or lua function>", desc = "<description>"}
    },
    -- Optional - Add here plugins options, check each plugin for its options.
    opts = {
        color = "#111111" -- for example
        -- ...
    },
    -- Optional - config is always called with opts as parameter even if not explicitly overrided.
    -- To change plugin options it is simpler to just add those to opts
    config = function(_, opts) {
        -- ...
        require('<plugin>').set up(opts) -- Call setup since modifying config will override it.
        -- ...
    }
}
```

Other properties can be overridden, see lazy [documentation](https://lazy.folke.io/spec).

In this repository an effort to separate plugin configurations has been made for code clarity, but the `return{}` function can return multiple configurations instead of only one, they just have to be in an array.
Once the configuration can be considered complete, a script to condense all files into `init.lua` will be provided for simpler dotfiles.

### Plugin list
This is the list of all installed plugins without their dependencies by theme.
- Plugin manager:
    - [lazy](https://lazy.folke.io/): Plugin manager.
- LSP and DAP (Debug) related:
    - [mason](https://github.com/williamboman/mason.nvim): Installs LSP, linters, DAP and formatters.
    - [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim): Bridges missing bits between lspconfig and mason.
    - [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim): Sets up automatically DAPs (Debug Adapter Protocol).
    - [lspconfig](https://github.com/neovim/nvim-lspconfig): Presets of LSP servers. Used to configure LSPs in Neovim.
    - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Provides auto-completions based on sources.
- Welcome page:
    - [alpha-nvim](https://github.com/goolord/alpha-nvim): Neovim welcome page.
- Theme(s):
    - [catppucin](https://github.com/catppuccin/nvim): Used main theme.
- UI:
    - [which-key](https://github.com/folke/which-key.nvim): Displays mappings possibilities with descriptions as they are typed.
    - [lualine](https://github.com/nvim-lualine/lualine.nvim): Easy way to configure the statusline, and has features to configure the tabline and the titleline.
    - [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim): Better renderer for Markdown.
    - [indent-backline](https://github.com/lukas-reineke/indent-blankline.nvim): Visually display indents.
    - [highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors): Displays colours of different formats of colours.
- Ease of use:
    - [mini.nvim](https://github.com/echasnovski/mini.nvim): Adds small Lua modules to improve Neovim in general.
    - [nvim-autopairs](https://github.com/windwp/nvim-autopairs): Automatic generation of corresponding brackets pairs and more.
    - [glow](https://github.com/ellisonleao/glow.nvim): Uses [Glow](https://github.com/charmbracelet/glow) CLI utility to preview Markdown inside Neovim.
- Code and general navigation:
    - [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim): Displays a file tree and has features to edit files.
    - [tree-sitter](https://github.com/tree-sitter/tree-sitter): Imprived Code analysis and syntax colouration.
    - [telescope](https://github.com/nvim-telescope/telescope.nvim): Simple and fast way to find different files, information and more.
    - [trouble](https://github.com/folke/trouble.nvim): A more easily readable output of telescope functionalities.
- Debug:
    - [dap](https://github.com/mfussenegger/nvim-dap): Neovim debugger adapter protocol Plugin.
    - [dap-ui](https://github.com/rcarriga/nvim-dap-ui): A better UI for dap.
- LaTeX related:
    - [vimtex](https://github.com/lervag/vimtex): LaTeX tools for Vim.
- Personal wiki related:
    - [wiki](https://github.com/lervag/wiki.vim): A lightweight alternative to [vimwiki](https://github.com/vimwiki/vimwiki). Enhanced note-taking plugin.

### Themes
Published themes like [tokyonight](https://github.com/folke/tokyonight.nvim) are plugins and can be configured in the same way as the previous template.
If the theme is to be the main theme loaded and set up at start then it has to include `priority` attribute.


```lua
-- lua/plugins/example-theme.lua
{
	priority: 1000, -- To be loaded 1st by lazy.nvim
-- ...
	config = function (_, opts)
    	require("catppuccin").set up(opts)
    	vim.cmd.colorscheme("catppuccin") -- Set the theme, can be anywhere in the configuration.
  	end
}
```

### Core plugins
#### Treesitter
[treesitter](https://github.com/nvim-treesitter/nvim-treesitter) is a plugin that improves syntax and code logic recognition greatly. It also permits to use classic Vim mappings like `daf` (delete a function), `dac` (delete a class), `yib` (yank inner-block), or `vil` (select inner block) to be able to be used on objects.
It comes with a good out of the box settings, but these settings can be improved.

```lua
  opts = {
    -- Any element in this array will be installed if not already.
    ensure_installed = {
      "vim", "vimdoc", -- vim
      "c", "cpp", "make", "cmake", -- C/C++
      "java", "kotlin", -- Java
      "javascript", "typescript", "css", "scss", -- Web
      "dockerfile", "doxygen", -- Docker
      "lua",
      "python",
      "bash",
      "json", "toml", "yaml", -- Config files
      "latex",
      "markdown", "markdown_inline", -- Markdown
    },
    -- Depends on tree-sitter CLI installed locally.
    -- Auto installs languages when entering any buffer those language is missing.
    auto_install = false,
    highlight = {
      enable = true
    },
  },
-- ...
```

#### LSP and DAP configuration
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is built-in Neovim. It provides to [Neovim LSP Client](https://neovim.io/doc/user/lsp.html) (Language Server Protocol) presets for configurations of each [LSP Server](https://microsoft.github.io/language-server-protocol/).

With nvim-lspconfig alone each LSP Server has to be installed by the user in the system. To simplify LSP server management the [mason](https://github.com/williamboman/mason.nvim) plugin is used. It installs LSP Servers during its set up or by Neovim command line, both are persistent.

Neovim LSP Client has also no automatic autocompletion only mappings to complete, by default with the mapping `<C-x> / <C-o>`.
Another plugin [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) is therefore used to enable a [VSCodium](https://vscodium.com/) like autocompletion.

These 3 configurations then have to be configured and loaded in a specific order.

Configuration code will not be fully present here since the point is to explain only the logic. But the file lspconfig. The actual files also have documentation if there is need of precisions on code missing here.

##### List of LSP servers
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
-- ...
local lsp_servers = {
-- ...

    {
        name = "<server name>",
        settings = { ... <server settings> ... },
        -- Optional
        on_init = function() ... end
    },
-- ...
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

##### mason plugin configuration
This list will then be installed by mason.

```lua
-- lua/plugins/lspconfig.lua
-- ...
{
    "williamboman/mason.nvim",
    config = function()
    	require("mason").set up()
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
-- ...
```

mason require these 2 plugins.

##### mason-nvim-dap
[mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim) is a plugin that configures DAPs (Debugger Adaptater Protocol).

```lua
-- lua/plugins/lspconfig.lua
{
    "williamboman/mason.nvim",
    config = function()
      require("mason").set up()
    end
},
-- ...
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
      require("mason-nvim-dap").set up(opts)
    end
},
-- ...
```
These plugins must be loaded in this specific order.


`dap_list` is a list of DAP with [specific names](https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua) for mason-nvim-dap.

```lua
...
-- lua/plugins/lspconfig.lua
local dap_list = { "python", "codelldb"}
...
```

##### dap-ui
dap-ui is a plugin that displays a better UI for nvim-dap

##### lspconfig configuration
Then mason installed LSP servers must be connected to lspconfig.

```lua
-- lua/plugins/lspconfig.lua
{
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    -- nvim-lspconfig is dependent on cmp-nvim-lsp being loaded
    -- to be able to be used by cmp plugins as a source completion.
    dependencies = {"hrsh7th/cmp-nvim-lsp"},
   --  ...
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

      -- For each server the set up in run with the override of capabilities and settings properties if on_init exists it is also override.
      for _,s in pairs(lsp_servers) do
        if s.on_init ~= nil then
          lspconfig[s.name].set up({
            capabilities = lsp_capabilities,
            settings = s.settings,
            on_init = s.on_init
          })
        else
          lspconfig[s.name].set up({
            capabilities = lsp_capabilities,
            settings = s.settings,
          })
        end
      end

    end
  },
```

At this point Neovim LSP Client can use the LSP servers but not offer auto-completions.
So nvim-cmp still need to be set up.

##### nvim-cmp plugin configuration
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
    -- ...
}
```

nvim-cmp has a number of properties that have to be set in its set up.

```lua
-- lua/plugins/lspconfig.lua
{
    -- ...
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.set up({

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
    -- ...
  }
```

At this point autocompletion should be enabled.

### UI plugins
#### Lualine
[lualine](https://github.com/nvim-lualine/lualine.nvim) provides an easier way to configure the statusline.
It also features a way to configure the tabline and the titleline.
In this configuration lualine is used to display on the top left all open buffers and in the top right the tabs open and for each tab which buffers are open in different windows.

```lua
-- lua/plugins/lualine.lua
-- ...
sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename", "searchcount", "selectioncount" },
    lualine_x = { "encoding", "filesize", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" }
},
-- ..
tabline = {
    lualine_a = { "buffers" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "windows" },
    lualine_z = { "tabs" }
},
-- ...


```

#### render-markdown
[render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim) features a better markdown renderer. It is also quite configurable, see the [wiki](https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki) for available options.

```lua
-- lua/plugins/render-markdown.lua
-- ...
opts = {
    -- Display all lines concealed except selected line
    render_modes = true,
    debounce = 100,
    sign = {
        enabled = false,
    },
    code = {
        language_pad = 1,
        left_pad = 2,
        right_pad = 2
    },
    heading = {
        width = "full",
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    paragraph = {
        enabled = false
    },
    bullet = {
        icons = { "●", "○", "◆", "◇" },
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
            -- Link icons.
            web = { pattern = "^http", icon = "󰖟 " },
            -- ...
            kitty = { pattern = "kovidgoyal%.net", icon = "󰄛 " },

            -- Languages
            c = { pattern = "%.c$", icon = " " },
            -- ...
            angular = { pattern = "angular.*.js$", icon = " " },
        },
}
-- ...
```

### Personal wiki related plugins
#### Wiki
[Wiki](https://github.com/lervag/wiki.vim) features a way to use backlinks inside Neovim and provides useful commands to navigate and create notes. Backlinks are links between note files that together form a network.
Unlike [vimwiki](https://github.com/vimwiki/vimwiki), wiki is only focused on the wiki aspect of note-taking, leaving UI functions to the user.

This plugin is mostly just mappings configurations to only load the plugin when necessary.
```lua
return {
  "lervag/wiki.vim",
  init = function()
    vim.g.wiki_root = "~/wiki-notes"
  end,
  keys = {
    {"<leader>ww", "<cmd>WikiIndex<cr>", desc = "Index"},
    {"<leader>wj", "<cmd>WikiJournal<cr>", desc = "Journal"},
    {"<leader>wp", "<cmd>WikiPages<cr>", desc = "Pages"},
  }
}
```

### LaTeX related plugins
#### Vimtex
[Vimtex](https://github.com/lervag/vimtex) facilitates editing LaTeX (.tex) files. It provides a lot of extra tools and syntax help.
One of these tools in a real time viewer that updates each time the LaTeX file is recompiled. In Linux distributions this preview is done with [zathura](https://pwmt.org/projects/zathura/) PDF viewer.
However, on macOS zathura can have compatibility problems, so an easier solution is to use [Skim](https://skim-app.sourceforge.io/) instead.
zathura can also be used if the document is opened manually with `sh zathura /path/to/file`, but the command `:VimtexView` won't be functional.

To do so a simple change in Vimtex configuration must be done.
```lua
-- lua/plugins/vimtex.lua
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

