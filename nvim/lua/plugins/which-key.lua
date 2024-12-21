return {
  "folke/which-key.nvim",
  dependencies = {
    { "echasnovski/mini.nvim",      version = "*" },
    { "nvim-tree/nvim-web-devicons" }
  },
  event = "VeryLazy",
  opts = {
    preset = "helix",
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
