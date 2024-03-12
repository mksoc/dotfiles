return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local fb_actions = require("telescope").extensions.file_browser.actions
            local actions = require("telescope.actions")
            require("telescope").setup {
                defaults = {
                  sorting_strategy = "ascending",
                  layout_strategy = "horizontal",
                  layout_config = {
                    prompt_position = "top",
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
                },
            }
            require("telescope").load_extension "file_browser"
        end,
    },

    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    },
}
