-- <leader> key is set in config/options.lua
-- <cmd> equals to ":"

local map = vim.keymap

-- Buffers
map.set("n", "<leader>b", "", {desc = "Buffers"})
map.set("n", "<leader>ba", "<cmd>bn<cr>", {desc = "New Buffer"})
map.set("n", "<leader>bp", "<cmd>bp<cr>", {desc = "Previous buffer"})
map.set("n", "<leader>bd", "<cmd>bd<cr>", {desc = "Delete current buffer"})


-- Tabs
map.set("n", "<leader>t", "", {desc = "Tabs"})
map.set("n", "<leader>ta", "<cmd>tabnew<cr>", {desc = "Add new tab"})
map.set("n", "<leader>th", "<cmd>tabprevious<cr>", {desc = "Previous tab"})
map.set("n", "<leader>tl", "<cmd>tabnext<cr>", {desc = "Next tab"})
map.set("n", "<leader>tx", "<cmd>tabclose<cr>", {desc = "Close current tab"})

-- Telescope
local telescope = require("telescope.builtin")
map.set("n", "<leader>f", "", {desc = "Telescope"})
map.set("n", "<leader>ff", telescope.find_files, {desc ="Telescope find files"})
map.set("n", "<leader>fg", telescope.live_grep, {desc = "Telescope live grep"})
map.set("n", "<leader>fb", telescope.buffers, {desc = "Telescope buffers"})
map.set("n", "<leader>fo", telescope.oldfiles, {desc = "Telescope old_files"})
map.set("n", "<leader>fm", telescope.man_pages, {desc = "Telescope man_pages"})
map.set("n", "<leader>ft", telescope.colorscheme, {desc = "Telescope colorscheme"})
map.set("n", "<leader>fp", telescope.search_history, {desc = "Telescope search_history"})
map.set("n", "<leader>fh", telescope.help_tags, {desc = "Telescope help_tags"})

-- Trouble
map.set("n", "<leader>x", "", {desc = "Diagnostics list"})

-- LateX (Vimtext)
map.set("n", "<leader>l", "", {desc = "Latex"})
map.set("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>", {desc = "Latex toggle"})
map.set("n", "<leader>lc", "<cmd>VimtexCompile<cr>", {desc = "Latex compile"})
map.set("n", "<leader>lr", "<cmd>VimtexReload<cr>", {desc = "Latex reload"})
map.set("n", "<leader>ls", "<cmd>VimtexStop<cr>", {desc = "Latex stop"})
map.set("n", "<leader>lcc", "<cmd>VimtexClearCache<cr>", {desc = "Latex clear cache"})
map.set("n", "<leader>lv", "<cmd>VimtexView<cr>", {desc = "Latex view"})
map.set("n", "<leader>lx", "<cmd>VimtexErrors<cr>", {desc = "Latex errors"})
map.set("n", "<leader>li", "<cmd>VimtexInfo<cr>", {desc = "Latex info"})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    map.set("n", "<leader>g", "", {desc = "GoTo"})
    map.set("n", "<leader>k", vim.lsp.buf.hover, {desc = "Cursor doc"})
    map.set("n", "<leader>gD", vim.lsp.buf.definition, {desc = "Go to definition"})
    map.set("n", "<leader>gd", vim.lsp.buf.declaration, {desc = "Go to declaration(s)"})
    map.set("n", "<leader>gi", vim.lsp.buf.implementation, {desc = "Go to implementation"})
    map.set("n", "<leader>gs", vim.lsp.buf.signature_help, {desc = "Signature help"})
    
    map.set("n", "<leader>R", vim.lsp.buf.rename, {desc = "Rename"})
    
    map.set("n", "<leader>e", "", {desc = "Error diagnostics"})
    map.set("n", "<leader>ef", vim.diagnostic.open_float, {desc = "Diagnostic open float"})
    map.set("n", "<leader>eh", vim.diagnostic.goto_prev, {desc = "Diagnostic previous"})
    map.set("n", "<leader>el", vim.diagnostic.goto_next, {desc = "Diagnostic next"})
  end
})

-- lazy.vim allows to load plugins on input but if require(<plugin>) is used then the plugin is loaded before anyway. So these keybinds must be set per plugin at least until a better solution arises.

-- DAP (Debug) -> In lua/plugins/dap.lua
-- map.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", {desc = "Add breakpoint"}) -- set in plugin conf file
map.set("n", "<leader>d", "", {desc = "Debug"})
map.set("n", "<leader>dc", "<cmd>DapContinue<cr>", {desc ="Launch debug"})
map.set("n", "<leader>dn", "<cmd>DapStepOver<cr>", {desc = "Next step"})
map.set("n", "<leader>dp", "<cmd>DapStepInto<cr>", {desc = "Previous step"})
map.set("n", "<leader>di", "<cmd>DapToggleRepl<cr>", {desc = "Inspect state"})
map.set("n", "<leader>dr", "<cmd>DapRestartFrame<cr>", {desc = "Restart DAP"})

-- Cmp -> In lua/plugins/lspconfig.lua
