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
        require("neodev").setup()
        require("lsp-zero").on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            require("lsp-zero").default_keymaps({buffer = bufnr})
        end)

        require("mason").setup()

        require("mason-lspconfig").setup{
            ensure_installed = {
                "lua_ls",
                "pyright",
                "verible",
                "clangd",
                "cmake",
            },
            handlers = {
                require("lsp-zero").default_setup,
                verible = function()
                    require("lspconfig").verible.setup({
                        root_dir = function() return vim.loop.cwd() end
                    })
                end,
                cmake = function()
                    require("lspconfig").cmake.setup({
                        cmd = {"cmake-language-server"},
                        filetypes = {"cmake"},
                        -- on_attach = custom_attach,
                        init_options = {
                            buildDirectory = "build/"
                        }
                    })
                end,
            },
        }
    end,
}
