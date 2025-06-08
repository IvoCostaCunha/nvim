return {
  "vague2k/vague.nvim",
  priority = 1000,

  opts = {
    transparent = false,
    style = {
      boolean = "none",
    },
    colors = {
      bg = "#242429",
      fg = "#cdcdcd",
      floatBorder = "#878787",
      line = "#252530",
      comment = "#606079",
      builtin = "#cdcdcd",
      func = "#c48282",
      string = "#e8b589",
      number = "#e0a363",
      property = "#c3c3d5",
      constant = "#aeaed1",
      parameter = "#cdcdcd",
      visual = "#333738",
      error = "#d8647e",
      warning = "#f3be7c",
      hint = "#7e98e8",
      operator = "#90a0b5",
      keyword = "#6e94b2",
      type = "#c48282",
      search = "#405065",
      plus = "#7fa563",
      delta = "#f3be7c",
    },
  },
  config = function(_, opts)
    require("vague").setup(opts)
    vim.cmd.colorscheme("vague")
  end
}
