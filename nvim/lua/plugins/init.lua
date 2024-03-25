return {
    {"moll/vim-bbye"},

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
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },

    { "kdheepak/lazygit.nvim", dependencies = { "nvim-lua/plenary.nvim" }, },

    {
        "rebelot/kanagawa.nvim",
        opts = {
            overrides = function(colors)
                local theme = colors.theme
                return {
                    Search = { fg = theme.ui.fg, bg = theme.ui.nontext },
                }
            end,
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            sections = {
                lualine_c = {{'filename', path = 1}},
            },
            options = {
                -- disabling section separators fixes
                -- the disappearing start screen issue
                section_separators = '',
            },
        },
    },

    {
        "numToStr/Comment.nvim",
        opts = {
            mappings = {basic = true},
        },
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

    { "lewis6991/gitsigns.nvim", opts = {}, },

    { "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent =  {
            char = "▏",
        },
    },
},

    {"gabrielpoca/replacer.nvim"},
}
