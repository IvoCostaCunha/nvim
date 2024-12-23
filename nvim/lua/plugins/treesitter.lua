return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  opts = {
    ensure_installed = { 'markdown', 'markdown_inline', ... },
    highlight = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
