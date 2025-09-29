vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>K")
vim.keymap.del("n", "<leader>N")
vim.keymap.del("n", "<leader>qq")
vim.keymap.del("n", "<leader>/")
vim.keymap.del("n", "<leader>,")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "gc")
-- vim.keymap.del("n", "<leader>fn")
vim.keymap.del("n", "<leader>n")
vim.keymap.del("n", "p")

-- motion
vim.keymap.set("v", "w", "iW", { noremap = true })
vim.keymap.set({ "n", "v" }, "gh", "^", { noremap = true })
vim.keymap.set({ "n", "v" }, "gl", "$", { noremap = true })
vim.keymap.set({ "n", "v" }, "gj", "%", { noremap = true })
vim.keymap.set("v", "R", '"hy:%s/<c-r>h//gc<left><left><left>')

-- Empty Line
vim.keymap.set("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Empty Line Above" })
vim.keymap.set("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "Empty Line Below" })

vim.keymap.set("n", "<C-f>", "<C-w>w", { noremap = true })
vim.keymap.set("x", "p", function()
  vim.cmd('normal! "_dP')
end, { noremap = true, silent = true })

-- quit
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Lua dev
vim.keymap.set("n", "<leader>xs", "<cmd>source %<CR>", { desc = "Source Lua File" })
vim.keymap.set("n", "<leader>xS", "<cmd>.lua<CR>", { desc = "Source Lua Current Line" })
vim.keymap.set("v", "<leader>xS", "<cmd>lua<CR>", { desc = "Source Lua Selected Lines" })

-- Custom
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy file content" })
vim.keymap.set("x", "<C-t>", "<cmd>AddSurroundingTag<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>", { desc = "LSP Restart" })
vim.keymap.set("n", "<leader>k", function()
  return vim.lsp.buf.hover()
end, { desc = "Hover Documentation" })
vim.keymap.set("n", "q", "<Nop>")
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
vim.keymap.set("n", "gA", LazyVim.lsp.action.source)

-- Scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<S-j>", "<C-d>zz")
vim.keymap.set("n", "<S-k>", "<C-u>zz")

-- Increment / Decrement with - and +
vim.keymap.set("n", "-", "<C-x>")
vim.keymap.set("n", "+", "<C-a>")

-- Execute macro on visually selected
vim.keymap.set("x", ".", ":norm .<CR>")
vim.keymap.set("x", "@", ":norm @q<CR>")

vim.keymap.set("n", "<leader>ci", function()
  local cmd = "npm i"
  local job_id = vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("npm install completed successfully", vim.log.levels.INFO)
      else
        vim.notify("npm install failed with exit code: " .. exit_code, vim.log.levels.ERROR)
      end
    end,
    detach = true,
    cwd = vim.fn.getcwd(),
  })

  if job_id <= 0 then
    vim.notify("Failed to start npm install", vim.log.levels.ERROR)
  else
    vim.notify("npm install started...", vim.log.levels.INFO)
  end
end, { desc = "npm install" })
