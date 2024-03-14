return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
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
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "rg", "--files",
                            "--hidden",
                            "-g", "!**/.git/*",
                            "-g", "!**/node_modules/*",
                            "-g", "!**/.repro/*", -- just to hide .repro rtp
                        },
                    },
                    live_grep = {
                        additional_args = {
                            "--hidden",
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
                        mappings = {
                            ["i"] = {
                                ["<Left>"] = fb_actions.backspace,
                                ["<Right>"] = actions.select_default,
                            },
                        }
                    },
                    menufacture = {
                        mappings = {
                            main_menu = { [{ 'i', 'n' }] = '<C-^>' },
                            toggle_no_ignore = { [{ 'i', 'n' }] = '<C-i>' },
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
