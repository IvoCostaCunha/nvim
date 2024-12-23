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
