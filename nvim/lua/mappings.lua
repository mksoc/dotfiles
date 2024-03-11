vim.keymap.set("", "<Space>", "<Nop>", { silent = true })

-- General keymaps
vim.keymap.set("v",  "<Tab>", ">gv")
vim.keymap.set("v",  "<S-Tab>", "<gv")
vim.keymap.set("",  "<leader>Q", "<CMD>qa<CR>", { desc = "Quit" })
vim.keymap.set("n",  "<leader>/", function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end, { desc = "Toggle comment line" })
vim.keymap.set("v",  "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment for selection" })

-- Files
function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ''
  end
end

local tb = require("telescope.builtin")

vim.keymap.set("",  "<leader>ff", function() tb.find_files() end, { desc = "Find files" })
vim.keymap.set("",  "<leader>fh", function() tb.oldfiles() end, { desc = "Open recent" })
vim.keymap.set("",  "<leader>fc", function() tb.grep_string() end, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fg", function() tb.current_buffer_fuzzy_find() end, { desc = "Fuzzy find in current buffer" })
vim.keymap.set("v", "<leader>fg", function() tb.current_buffer_fuzzy_find({ default_text = vim.getVisualSelection() }) end, { desc = "Fuzzy find in current buffer" })
vim.keymap.set("n", "<leader>fG", function() tb.live_grep() end, { desc = "Live grep" })
vim.keymap.set("v", "<leader>fG", function() tb.live_grep({ default_text = vim.getVisualSelection() }) end, { desc = "Live grep" })
vim.keymap.set("",  "<leader>fb", function() require("telescope").extensions.file_browser.file_browser() end, { desc = "File browser" })
-- vim.keymap.set("",  "<leader>fb", function() require("telescope").extensions.file_browser.file_browser({path = "%:p:h", select_buffer = true}) end, { desc = "File browser" })

-- Buffers
vim.keymap.set("",  "<leader>w", "<CMD>w<CR>", { desc = "Save" })
vim.keymap.set("",  "<leader>W", "<CMD>wa<CR>", { desc = "Save all" })
vim.keymap.set("",  "<leader>bd", "<CMD>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("",  "<leader>bb", function() tb.buffers() end, { desc = "List open buffers" })
vim.keymap.set("",  "<leader>bn", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("",  "<leader>bp", "<CMD>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>", "<CMD>b#<CR>", { desc = "Recent buffer" })

-- Git
vim.keymap.set("", "<leader>gg", "<CMD>LazyGitCurrentFile<CR>", { desc = "LazyGit" })
