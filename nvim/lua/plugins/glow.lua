return {
  "ellisonleao/glow.nvim",
  opts = {
    border = "shadow", -- floating window border config
    pager = true,
    width_ratio = 0.9, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
    height_ratio = 0.9,
  },
  config = function(_, opts)
    require("glow").setup(opts)
  end,
  keys = {
    { "<leader>mp", "<cmd>Glow<cr>", desc = "Markdown preview" }
  }
}
