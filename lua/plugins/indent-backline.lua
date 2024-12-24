return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config

  event = "VeryLazy",

  opts = {
    enabled = true,
    indent = { char = "╎" },
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = {
      show_start = false,
      show_end = false,
      show_exact_scope = true
    },
    exclude = {
      filetypes = {}
    }
  },
}
