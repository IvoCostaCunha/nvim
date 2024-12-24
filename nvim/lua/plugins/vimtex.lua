return {
  "lervag/vimtex",

  init = function()
    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_method = "skim" -- For macOS
    vim.g.vimtex_view_method = "zathura"
  end,

  keys = {
    { "<leader>lt", "<cmd>VimtexTocToggle<cr>", desc = "LaTeX toggle" },
    { "<leader>lc", "<cmd>VimtexCompile<cr>",   desc = "LaTeX compile" },
    { "<leader>lr", "<cmd>VimtexReload<cr>",    desc = "LaTeX reload" },
    { "<leader>ls", "<cmd>VimtexStop<cr>",      desc = "LaTeX stop" },
    { "<leader>lw", "<cmd>VimtexClean<cr>",     desc = "LaTeX clean" },
    { "<leader>lv", "<cmd>VimtexView<cr>",      desc = "LaTeX view" },
    { "<leader>lx", "<cmd>VimtexErrors<cr>",    desc = "LaTeX errors" },
    { "<leader>li", "<cmd>VimtexInfo<cr>",      desc = "LaTeX info" },
  }
}
