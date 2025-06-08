return {
  'goolord/alpha-nvim',
  config = function()
    local alpha = require("alpha")
    local db = require("alpha.themes.dashboard")
    db.section.header.val = {
      [[      ___           ___           ___                                     ___      ]],
      [[     /\  \         /\__\         /\  \          ___                      /\  \     ]],
      [[     \:\  \       /:/ _/_       /::\  \        /\  \        ___         |::\  \    ]],
      [[      \:\  \     /:/ /\__\     /:/\:\  \       \:\  \      /\__\        |:|:\  \   ]],
      [[  _____\:\  \   /:/ /:/ _/_   /:/  \:\  \       \:\  \    /:/__/      __|:|\:\  \  ]],
      [[ /::::::::\__\ /:/_/:/ /\__\ /:/__/ \:\__\  ___  \:\__\  /::\  \     /::::|_\:\__\ ]],
      [[ \:\~~\~~\/__/ \:\/:/ /:/  / \:\  \ /:/  / /\  \ |:|  |  \/\:\  \__  \:\~~\  \/__/ ]],
      [[  \:\  \        \::/_/:/  /   \:\  /:/  /  \:\  \|:|  |   ~~\:\/\__\  \:\  \       ]],
      [[   \:\  \        \:\/:/  /     \:\/:/  /    \:\__|:|__|      \::/  /   \:\  \      ]],
      [[    \:\__\        \::/  /       \::/  /      \::::/__/       /:/  /     \:\__\     ]],
      [[     \/__/         \/__/         \/__/        ~~~~           \/__/       \/__/     ]],
    }
    db.section.buttons.val = {
      db.button("e", "  New file", "<cmd>ene <bar> startinsert<cr>"),
      db.button("<leader>ff", "  Open Telescope (files)", "<cmd>Telescope find_files<cr>"),
      db.button("k", "󰌌  Keybinds", "<cmd>e ~/.config/nvim/lua/config/mappings.lua<cr>"),
      db.button("o", "  Options", "<cmd>e ~/.config/nvim/lua/config/options.lua<cr>"),
      db.button("p", "󰒲  Plugin Manager (Lazy)", "<cmd>Lazy<cr>"),
      db.button("l", "  LSP Manager (Mason)", "<cmd>Mason<cr>"),
      db.button("qa", "󰈆  Quit NVIM", "<cmd>qa<cr>"),
    }

    db.config.opts.noautocmd = true
    alpha.setup(db.config)

  end
}
