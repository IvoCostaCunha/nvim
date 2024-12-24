-- <leader> key is set in config/options.lua
-- <cmd> equals to ":"

-- lazy.vim allows to load plugins on input. So these mappings must be set per plugin at least until I find a better solution. So missing mappings will be on each plugin Lua configuraton file.

-- The following mappings set by whick-key are only used to show a general description in which-key plugin popup mappings "groups".
-- Example "<leader>g" shows GoTo as description, before showing "Go to definition" when "<leader>gD" (go to definition) is pressed.
local wk = require("which-key")
wk.add {
  { "<leader>f",  group = "Telescope" },
  { "<leader>l",  group = "LaTeX" },
  { "<leader>g",  group = "GoTo" },
  { "<leader>e",  group = "LSP Diagnostics" },
  { "<leader>fG", group = "Telescope git" },
  { "<leader>fl", group = "Telescope LSP" },
  { "<leader>d",  group = "Debug" },
  { "<leader>x",  group = "Diagnostic list" },
  { "<leader>m",  group = "Markdown preview" },
  { "<leader>w",  group = "Wiki" },
}

-- Keybinds
local map = vim.keymap

-- Buffers
map.set("n", "<A-n>", "<cmd>new<cr>", { desc = "New buffer (new window)" })
map.set("n", "<A-a>", "<cmd>enew<cr>", { desc = "New buffer" })
map.set("n", "<A-l>", "<cmd>bn<cr>", { desc = "Next buffer" })
map.set("n", "<A-h>", "<cmd>bp<cr>", { desc = "Previous buffer" })
map.set("n", "<A-w>", "<cmd>bd<cr>", { desc = "Delete current buffer" })

-- Tabs
map.set("n", "<C-n>", "<cmd>tabnew<cr>", { desc = "Add new tab" })
map.set("n", "<C-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map.set("n", "<C-h>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map.set("n", "<C-w>", "<cmd>tabclose<cr>", { desc = "Close current tab" })

-- Telescope
map.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map.set("n", "<leader>fe", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Old_files" })
map.set("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Man pages" })
map.set("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>", { desc = "Colorschemes" })
map.set("n", "<leader>fp", "<cmd>Telescope search_history<cr>", { desc = "Search history" })
map.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP definitions" })
map.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP implementations" })
map.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "LSP symbols" })
map.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP references" })

map.set("n", "<leader>fGc", "<cmd>Telescope git_commits<cr>", { desc = "Git commit" })
map.set("n", "<leader>fGb", "<cmd>Telescope git_branches<cr>", { desc = "Git branch" })
map.set("n", "<leader>fGs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

-- Render-markdown
map.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", { desc = "Render Markdown toggle" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    map.set("n", "K", vim.lsp.buf.hover, { desc = "Cursor doc" })
    map.set("n", "R", vim.lsp.buf.rename, { desc = "Rename" })
    map.set("n", "F", vim.lsp.buf.format, { desc = "Format buffer" })
    map.set("n", "E", vim.diagnostic.open_float, { desc = "Diagnostic open float" })
    map.set("n", "En", vim.diagnostic.goto_next, { desc = "Diagnostic next" })
    map.set("n", "EN", vim.diagnostic.goto_prev, { desc = "Diagnostic previous" })

    map.set("n", "<leader>gD", vim.lsp.buf.definition, { desc = "Go to definition" })
    map.set("n", "<leader>gd", vim.lsp.buf.declaration, { desc = "Go to declaration(s)" })
    map.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    map.set("n", "<leader>gs", vim.lsp.buf.signature_help, { desc = "Signature help" })
  end
})
