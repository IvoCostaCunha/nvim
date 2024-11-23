return {
  "goolord/alpha-nvim",

  dependencies = {"nvim-tree/nvim-web-devicons"},

  event = "VimEnter",

  config = function()
    local sf = require("alpha.themes.startify")
 
    sf.section.header.opts.position = "center"
    sf.section.header.val = {
                [[                                   __                ]],
                [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }

    sf.section.top_buttons.val = {
      sf.button( "e", "New file", "<cmd>ene <bar> startinsert<cr>"),
      sf.button( "f", "Open Telescope (files)" , "<cmd>Telescope find_files<cr>"),
      sf.button( "k", "Keybinds", "<cmd>e ~/.config/nvim/lua/config/keybinds.lua<cr>"),
      sf.button( "o", "Options", "<cmd>e ~/.config/nvim/lua/config/options.lua<cr>"),
      sf.button( "p", "Plugin Manager (Lazy)", "<cmd>Lazy<cr>"),
      sf.button( "q", "Quit NVIM" , "<cmd>qa<cr>"),
    }
    sf.section.bottom_buttons.val = {}

    require("alpha").setup(
      sf.config
    )
  end,
}
