return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
          vim.o.timeout = true
          vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require("which-key")
            wk.register({
              ["<leader>f"] = { name = "File/find" },
              ["<leader>b"] = { name = "Buffers" },
              ["<leader>g"] = { name = "Git" },
            })
        end,
    },

    {
        'folke/neodev.nvim',
        dependencies = { 'hrsh7th/nvim-cmp' }
    },

    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {"rebelot/kanagawa.nvim"},

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup()
        end,
    },

    {
        "numToStr/Comment.nvim",
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {"vim-scripts/systemrdl.vim"},
}
