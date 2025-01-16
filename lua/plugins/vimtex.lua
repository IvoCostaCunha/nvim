return {
  "lervag/vimtex",
  -- Only loads when entering a .tex file.
  ft = { { "tex" }, { "lytex" } },

  init = function()
    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_method = "skim" -- For macOS
    vim.g.vimtex_view_method = "zathura"
  end,
}
