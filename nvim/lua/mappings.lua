-- Utility functions
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

local function concat(t1, t2)
    for key, val in pairs(t2) do
        t1[key] = val
    end
    return t1
end


vim.keymap.set("", "<Space>", "<Nop>", { silent = true })

-- General keymaps
vim.keymap.set("v",  "<Tab>", ">gv")
vim.keymap.set("v",  "<S-Tab>", "<gv")
vim.keymap.set("",  "<leader>Q", "<CMD>qa<CR>", { desc = "Quit" })

-- Files
local tb = require("telescope.builtin")
local tm = require('telescope').extensions.menufacture
local tf = require("telescope").extensions.file_browser

vim.keymap.set("",  "<leader>ff", function() tm.find_files() end, { desc = "Find files" })
vim.keymap.set("",  "<leader>fh", function() tb.oldfiles() end, { desc = "Open recent" })
vim.keymap.set("",  "<leader>fb", function() tf.file_browser() end, { desc = "File browser" })

-- Buffers
vim.keymap.set("",  "<leader>w", "<CMD>w<CR>", { desc = "Save" })
vim.keymap.set("",  "<leader>W", "<CMD>wa<CR>", { desc = "Save all" })
vim.keymap.set("",  "<leader>bd", "<CMD>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("",  "<leader>bb", function() tb.buffers() end, { desc = "List open buffers" })
vim.keymap.set("",  "<leader>bn", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("",  "<leader>bp", "<CMD>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>", "<CMD>b#<CR>", { desc = "Recent buffer" })

-- Windows
vim.keymap.set("", "<leader>v", "<CMD>vnew<CR>", { desc = "New vertical split" })
vim.keymap.set("", "<leader>h", "<CMD>new<CR>", { desc = "New horizontal split" })
vim.keymap.set("", "<C-Left>", "<C-W><C-H>", { desc = "Go to windows on the left" })
vim.keymap.set("", "<C-Down>", "<C-W><C-J>", { desc = "Go to windows below" })
vim.keymap.set("", "<C-Up>", "<C-W><C-K>", { desc = "Go to windows above" })
vim.keymap.set("", "<C-Right>", "<C-W><C-L>", { desc = "Go to windows on the right" })

-- Git
local gs = require("gitsigns")

function gs.diff()
    if vim.opt.diff:get() then
        vim.cmd("wincmd p | q")
    else
        gs.diffthis()
    end
end

vim.keymap.set("", "<leader>gg", "<CMD>LazyGitCurrentFile<CR>", { desc = "LazyGit" })
vim.keymap.set("", "<leader>gb", function() gs.blame_line() end, { desc = "Show line blame" })
vim.keymap.set("", "<leader>gp", function() gs.preview_hunk_inline() end, { desc = "Preview hunk" })
vim.keymap.set("", "<leader>gr", function() gs.reset_hunk() end, { desc = "Reset hunk" })
vim.keymap.set("", "<leader>gd", function() gs.diff() end, { desc = "Git diff" })

-- Search and replace
local lg_args = {
    additional_args = {
        "-g", "!**/.git/*",
        "-g", "!**/node_modules/*",
        "-g", "!**/.repro/*", -- just to hide .repro rtp
    }
}

vim.keymap.set("n", "<ESC>", "<CMD>:noh<CR>", { desc = "Cancel highlighting" })
vim.keymap.set("",  "<leader>fc", function() tm.grep_string() end, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fg", function() tb.current_buffer_fuzzy_find() end, { desc = "Fuzzy find in current buffer" })
vim.keymap.set("v", "<leader>fg", function() tb.current_buffer_fuzzy_find({ default_text = vim.getVisualSelection() }) end, { desc = "Fuzzy find in current buffer" })
vim.keymap.set("n", "<leader>fG", function() tm.live_grep(lg_args) end, { desc = "Live grep" })
vim.keymap.set("v", "<leader>fG", function() tm.live_grep(concat(lg_args, { default_text = vim.getVisualSelection() })) end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fr", function() require("replacer").run() end, { desc = "Replacer" })
