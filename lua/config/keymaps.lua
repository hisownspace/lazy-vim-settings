-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local keymap = vim.keymap -- for conciseness

-- debugging
keymap.set("n", "<F5>", ":cd %:p:h<CR>:!gcc -g %<CR>:lua require'dap'.continue()<CR>")
-- try to build and debug in one command
keymap.set("n", "<F9>", ":lua require'dap'.step_into()<CR>")
keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
keymap.set("n", "<leader>dbt", ":lua require'dapui'.toggle()<CR>")

-- compile and run c script
keymap.set("n", "<F8>", ":split | term gcc % && ./a.out<CR>I")
keymap.set("n", "<F8>", ":!gcc % && ./a.out && rm ./a.out<CR>")

keymap.set("n", "<leader>/", function()
  require("comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
keymap.set("x", "<leader>/", function()
  require("comment.api").toggle.linewise(vim.fn.visualmode())
end, { noremap = true, silent = true })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- increment/decrement numbersi
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window horizontally
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  'go to previous tab'

keymap.set("n", "<C-n>", ":tabn<CR>") --  go to next tab
keymap.set("n", "<C-p>", ":tabp<CR>") --  'go to previous tab'

-- plugin keymaps

-- show linter output in float
keymap.set("n", "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
keymap.set({ "n", "v" }, "<leader>fl", function()
  require("conform").format({
    lsp_fallback = false,
    async = false,
    timeout_ms = 500,
  })
end)

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set({ "n", "v" }, "<leader>/", "gcc")

-- vscode bindings
keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)")
keymap.set("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)gv")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags:
