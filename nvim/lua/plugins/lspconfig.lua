-- lsp_servers array are LSP servers to be installed.
-- (Additional servers installed via Mason are added added in.)
-- name -> Name of the server
-- settings -> options of the server.
-- on_init -> (Optional) If an on_init function is needed.
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

-- Reducing to an array with only the names of LSP servers.
local lsp_servers_to_install = {}
for key,value in pairs(lsp_servers) do
  table.insert(lsp_servers_to_install, value.name)
end

local function is_in_lsp_servers(list, item)
  local is_in = false
  for _,i in pairs(list) do
    if i.name == item then is_in = true end
  end
  return is_in
end

return {
  -- Mason plugins install automaticaly lsp servers in the lsp_servers array.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = lsp_servers_to_install,
      automatic_installation = true
    }
  },

  -- nvim-lspconfig is a collection of lsp servers templates and is connected to mason by mason-lspconfig.
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    -- nvim-lspconfig is dependent on cmp-nvim-lsp being loaded to be able to be used by cmp plugins as source completion.
    dependencies = {"hrsh7th/cmp-nvim-lsp"},

    init = function()
      -- LSP diagnostics display configuration.
      vim.diagnostic.config({
        underline = true,
        signs = true,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = true
      })

      -- Floating LSP error/warn/info/hint tooltip config.
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local opts = {
            focusable = false,
            -- severity = "Error", -- To limit which diagnostic types trigger the floating window. 
            close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
            -- source is the source of the error like diagnostics from lspconfig or other
            source = "if_many",
            -- prefix = "",
            -- suffix = "",
            scope = "line", -- scope is the scope from which the diagnostic is displayed.
            severity_sort = true,
            border = "single",
          }

          vim.diagnostic.open_float(opts)
          -- The following code objective is to have a fixed floating window of diagnostic instead of one following the cursor.
          -- Get window number of diagnostic floating window.
          -- local _,window_id = vim.diagnostic.open_float(opts)
          -- if not(window_id == nil) then
          --   local window_config = vim.api.nvim_win_get_config(window_id)
          --   -- vim.tbl_extends merges multiple tables is "force" mode here.
          --   -- Merging window_config and a new table here.
          --   window_config = vim.tbl_extend("force", window_config, {
          --     -- With relative set to "win" the window is created "inside" a relative window.
          --     -- In this case nvim.api.get_current_win() that returns the window in which the cursor is placed before creating the diagnostic window.
          --     relative = "win",
          --     win = vim.api.nvim_get_current_win(),
          --     row = 0,
          --     col = 0,
          --     border = "rounded"
          --   })
          --   -- print(win_screenpos(vim.api.nvim_get_current_win()))
          --   vim.api.nvim_win_set_config(window_id, window_config)
          -- end
        end
      })
    end,

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

      -- For each server the setup in run with the override of capabilities and settings properties. If on_init exists it is also override. 
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
  {
    "hrsh7th/nvim-cmp",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
      },
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp"
      },
      "saadparwaiz1/cmp_luasnip"
    },

    -- Load plugin only on entering insert mode.
    event = "InsertEnter",

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

        -- Autocompletion window style choices.
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:CmpNormal"
          },
          documentation = {
            border = "rounded",
            winhighlight  = "Normal:CmpDocNormal"
          },
        },

        -- To display a prefix or icon before the suggestion indicating its source.
        formating = {
          fields = {"menu", "abbr", "kind"},
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = "[lsp]",
              luasnip = "[lua]",
              buffer = "[buf]",
              path = "[path]"
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end
        },

        -- Keybinds
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }),

          -- Use Tab to navigate suggestions.
          ["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

          -- Use Alt-Tab to navigate in reverse.
          ["<A-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" })
        }),
      })

      -- Use buffer source for `/`.
      cmp.setup.cmdline("/", {
        completion = { autocomplete = false },
        sources = {
            -- { name = "buffer" }
            { name = "buffer", opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
        }
      })

      -- Use cmdline & path source for ":".
      cmp.setup.cmdline(":", {
        completion = { autocomplete = false },
        sources = cmp.config.sources(
        {
            { name = "path" }
        },
        {
            { name = "cmdline" }
        })
      })
    end
  }
}
