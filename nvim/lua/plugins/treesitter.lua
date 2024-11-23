return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufAdd",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
}
