vim.keymap.set("", "<Space>", "<Nop>", { silent = true })

-- Telescope
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

vim.keymap.set("",  "<leader>ff", function() tb.find_files() end,                                                           { desc = "Find files" })
vim.keymap.set("",  "<leader>fr", function() tb.oldfiles() end,                                                             { desc = "Open recent" })
vim.keymap.set("",  "<leader>fc", function() tb.grep_string() end,                                                          { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fg", function() tb.current_buffer_fuzzy_find() end,                                            { desc = "Fuzzy find in current buffer" })
vim.keymap.set("v", "<leader>fg", function() tb.current_buffer_fuzzy_find({ default_text = vim.getVisualSelection() }) end, { desc = "Fuzzy find in current buffer" })
vim.keymap.set("n", "<leader>fG", function() tb.live_grep() end,                                                            { desc = "Live grep" })
vim.keymap.set("v", "<leader>fG", function() tb.live_grep({ default_text = vim.getVisualSelection() }) end,                 { desc = "Live grep" })
vim.keymap.set("",  "<leader>fb", function() require("telescope").extensions.file_browser.file_browser() end,               { desc = "File browser" })

-- LazyGit
vim.keymap.set("", "<leader>gg", "<cmd>LazyGitCurrentFile<CR>", { desc = "LazyGit" })
