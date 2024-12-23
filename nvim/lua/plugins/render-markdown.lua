return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "latex" },
  dependencies = {
    { "nvim-tree/nvim-web-devicons", opt = true },
    { "nvim-treesitter/nvim-treesitter" }
  },
  opts = {
    render_modes = true,
    debounce = 200,
    sign = {
      enabled = false,
    },
    code = {
      style = "full",
      position = "left",
      language_name = false,
      width = "full",
      left_pad = 5,
      right_pad = 5
    },
    heading = {
      width = "full",
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    paragraph = {
      enabled = false
    },
    bullet = {
      icons = { '●', '○', '◆', '◇' },
      left_pad = 1,
      right_pad = 1
    },
    link = {
      enabled = true,
      footnote = {
        superscript = true,
        prefix = "",
        suffix = "",
      },
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
      custom = {
        web = { pattern = "^http", icon = "󰖟 " },
      },
    }
  },
}
