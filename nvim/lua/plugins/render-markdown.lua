return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "latex" },
  dependencies = {
    { "nvim-tree/nvim-web-devicons",    opt = true },
    { "nvim-treesitter/nvim-treesitter" }
  },

  opts = {
    render_modes = true,
    anti_conceal = {
      enabled = true,
      -- Which elements to always show, ignoring anti conceal behavior. Values can either be booleans
      -- to fix the behavior or string lists representing modes where anti conceal behavior will be
      -- ignored. Possible keys are:
      --  head_icon, head_background, head_border, code_language, code_background, code_border
      --  dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
      ignore = {
        code_background = true,
        sign = true,
      },
      above = 0,
      below = 0,
    },
    debounce = 200,
    sign = {
      enabled = false,
    },
    code = {
      language_pad = 1,
      left_pad = 2,
      right_pad = 2
    },
    heading = {
      width = "full",
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    paragraph = {
      enabled = false
    },
    bullet = {
      icons = { "●", "○", "◆", "◇" },
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
        youtube = { pattern = "youtube%.com", icon = "󰗃 " },
        github = { pattern = "github%.com", icon = "󰊤 " },
        neovim = { pattern = "neovim%.io", icon = " " },
        gitlab = { pattern = "gitlab%.org", icon = " " },
        wikipedia = { pattern = "wikipedia%.org", icon = " " },
        open_source_initiative = { pattern = "opensource%.org", icon = "󰮮 " },
        sci_hub = { pattern = "sci_hub%.st", icon = "󰨈 " },
        kitty = { pattern = "kovidgoyal%.net", icon = "󰄛 " },

        -- Languages
        c = { pattern = "%.c$", icon = " " },
        cpp = { pattern = "%.cpp$", icon = " " },
        cxx = { pattern = "%.cxx$", icon = " " },
        h = { pattern = "%.h$", icon = " " },
        hpp = { pattern = "%.hpp$", icon = " " },
        hxx = { pattern = "%.hxx$", icon = " " },
        cs = { pattern = "%.cs$", icon = " " },
        html = { pattern = "%.html$", icon = " " },
        css = { pattern = "%.css$", icon = " " },
        md = { pattern = "%.markdown$", icon = " " },
        json = { pattern = "%.json$", icon = " " },
        js = { pattern = "%.js$", icon = " " },
        jsx = { pattern = "%.jsx$", icon = " " },
        rb = { pattern = "%.rb$", icon = " " },
        php = { pattern = "%.php$", icon = " " },
        py = { pattern = "%.py$", icon = "󰌠 " },
        conf = { pattern = "%.conf$", icon = " " },
        ini = { pattern = "%.ini$", icon = " " },
        yml = { pattern = "%.yml$", icon = " " },
        yaml = { pattern = "%.yaml$", icon = " " },
        toml = { pattern = "%.toml$", icon = " " },
        bat = { pattern = "%.bat$", icon = " " },
        jpg = { pattern = "%.jpg$", icon = "󰥶 " },
        jpeg = { pattern = "%.jpeg$", icon = "󰥶 " },
        bmp = { pattern = "%.bmp$", icon = "󰥶 " },
        png = { pattern = "%.png$", icon = "󰥶 " },
        webp = { pattern = "%.webp$", icon = "󰥶 " },
        gif = { pattern = "%.gif$", icon = "󰥶 " },
        ico = { pattern = "%.ico$", icon = "󰥶 " },
        lua = { pattern = "%.lua$", icon = " " },
        java = { pattern = "%.java$", icon = " " },
        sh = { pattern = "%.sh$", icon = " " },
        fish = { pattern = "%.fish$", icon = " " },
        bash = { pattern = "%.bash$", icon = " " },
        sql = { pattern = "%.sql$", icon = " " },
        scala = { pattern = "%.scala$", icon = " " },
        go = { pattern = "%.go$", icon = " " },
        dart = { pattern = "%.dart$", icon = " " },
        rss = { pattern = "%.rss$", icon = " " },
        fsharp = { pattern = "%.fsharp$", icon = " " },
        ts = { pattern = "%.ts$", icon = "󰛦 " },
        tsx = { pattern = "%.tsx$", icon = "󰜈 " },
        vue = { pattern = "%.vue$", icon = "﵂ " },
        swift = { pattern = "%.swift$", icon = " " },
        dockerfile = { pattern = "%dockerfile$", icon = " " },
        compose = { pattern = "%compose.yaml$", icon = " " },
        makefile = { pattern = "%makefile$", icon = " " },
        jquery = { pattern = "jquery.*.js$", icon = " " },
        angular = { pattern = "angular.*.js$", icon = " " },
      },
    }
  },
}
