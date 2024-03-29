return {
    {
        'nvim-telescope/telescope.nvim',
        -- 'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local actions = require("telescope.actions")
            local fb_actions = require("telescope").extensions.file_browser.actions
            require("telescope").setup {
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        prompt_position = "top",
                    },
                    mappings = {
                            i = {
                                ["<S-Down>"] = actions.cycle_history_next,
                                ["<S-Up>"] = actions.cycle_history_prev,
                            },
                            n = {
                                ["<S-Down>"] = actions.cycle_history_next,
                                ["<S-Up>"] = actions.cycle_history_prev,
                            },
                        },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "rg", "--files",
                            "-g", "!**/.git/*",
                            "-g", "!**/node_modules/*",
                            "-g", "!**/.repro/*", -- just to hide .repro rtp
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        path = "%:p:h",
                        hijack_netrw = true,
                        prompt_path = true,
                        hidden = {
                            file_browser = true,
                            folder_browser = true
                        },
                        mappings = {
                            i = {
                                ["<Left>"] = fb_actions.backspace,
                                ["<Right>"] = actions.select_default,
                            },
                            n = {
                                ["<Left>"] = fb_actions.backspace,
                                ["<Right>"] = actions.select_default,
                            },
                        }
                    },
                    menufacture = {
                        mappings = {
                            toggle_no_ignore = { [{ 'i', 'n' }] = '<C-g>' },
                            toggle_hidden = { [{ 'i', 'n' }] = '<C-h>' },
                            search_relative_to_current_buffer = { [{ 'i', 'n' }] = '<C-r>' },
                        },
                    },
                },
            }
            require("telescope").load_extension "file_browser"
        end,
    },

    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    },

    {
        'molecule-man/telescope-menufacture',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
}
