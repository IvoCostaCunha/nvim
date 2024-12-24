return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  opts = {
    -- Any element in this array will be installed if not already.
    ensure_installed = {
      "vim", "vimdoc",                           -- vim
      "c", "cpp", "make", "cmake",               -- C/C++
      "java", "kotlin",                          -- Java
      "javascript", "typescript", "css", "scss", -- Web
      "dockerfile", "doxygen",                   -- Docker
      "lua",
      "python",
      "bash",
      "json", "toml", "yaml",        -- Config files
      "latex",
      "markdown", "markdown_inline", -- Markdown
    },
    -- Depends on tree-sitter CLI installed locally.
    -- Auto installs languages when entering any buffer those language is missing.
    auto_install = false,
    highlight = {
      enable = true
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
