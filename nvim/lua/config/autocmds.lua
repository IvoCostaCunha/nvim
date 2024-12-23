-- Deletes whitespaces on save
-- Cursor is saved in order to avoid it jumpinging at start on line on save.
-- pcall functions returns false in the function running inside encounters errors.
-- vim.fn.getpos(".") return current cursor position.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  callback = function()
    local cursor_position = vim.fn.getpos(".")
    local status = pcall(function() vim.cmd [[%s/\s\+$//e]] end)
    if not status then
      vim.notify("Error on whitespaces removal on save autocmd.")
    end
    vim.fn.setpos(".", cursor_position)
  end
})

-- If a command message is longer in lines than cmdheight then it will take focus until enter is pressed !
-- Change cmdheight when a command is typed or before writing in a file.
-- vim.api.nvim_create_autocmd({ "CmdlineEnter", "BufWritePre" }, {
--   pattern = {"*"},
--   callback = function()
--     vim.opt.cmdheight = 1
--   end
-- })
--
-- -- Set cmdheight to 0 (hidden) once a command is executed or after writing on a file.
-- vim.api.nvim_create_autocmd({ "CmdlineLeave", "BufWritePost" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.opt.cmdheight = 0
--   end
-- })
--
-- "CmdlineLeave seems executed after BufWritePost"
