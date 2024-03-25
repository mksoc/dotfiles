return {
    "neovim/nvim-lspconfig",
    branch = 'v3.x',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig/util")
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local default_setup = function(server)
            require('lspconfig')[server].setup({
                capabilities = lsp_capabilities,
            })
        end

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
                default_setup,

                pyright = function()
                    lspconfig.pyright.setup({
                        capabilities = lsp_capabilities,
                        root_dir = function(fname)
                            return util.root_pattern("pyproject.toml")(fname) or
                            util.path.dirname(fname)
                        end
                    })
                end,

                verible = function()
                    lspconfig.verible.setup({
                        capabilities = lsp_capabilities,
                        root_dir = function() return vim.loop.cwd() end
                    })
                end,

                cmake = function()
                    lspconfig.cmake.setup({
                        capabilities = lsp_capabilities,
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
    end,
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
    })
}
