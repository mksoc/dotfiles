return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "folke/neodev.nvim",
    },
    config = function()
        local lsp0 = require("lsp-zero")
        local lspconfig = require("lspconfig")
        local util = require("lspconfig/util")

        require("neodev").setup()
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "clangd",
                "verible",
                "pyright",
            },
            handlers = {
                lsp0.default_setup,

                pyright = function()
                    lspconfig.pyright.setup({
                        root_dir = function(fname)
                            return util.root_pattern("pyproject.toml")(fname) or
                            util.path.dirname(fname)
                        end
                    })
                end,

                verible = function()
                    lspconfig.verible.setup({
                        root_dir = function() return vim.loop.cwd() end
                    })
                end,

                cmake = function()
                    lspconfig.cmake.setup({
                        cmd = {"cmake-language-server"},
                        filetypes = {"cmake"},
                        -- on_attach = custom_attach,
                        init_options = {
                            buildDirectory = "build/"
                        }
                    })
                end,
            },
        })

        lsp0.on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp0.default_keymaps({buffer = bufnr})
        end)
    end,
}
