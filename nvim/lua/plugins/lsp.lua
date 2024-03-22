return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- "williamboman/mason.nvim",
        -- "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "folke/neodev.nvim",
    },
    config = function()
        require("neodev").setup()

        local lsp0 = require("lsp-zero")

        lsp0.on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp0.default_keymaps({buffer = bufnr})
        end)

        -- Setup LSPs
        require("lspconfig").verible.setup({
            root_dir = function() return vim.loop.cwd() end
        })

        require("lspconfig").cmake.setup({
            cmd = {"cmake-language-server"},
            filetypes = {"cmake"},
            -- on_attach = custom_attach,
            init_options = {
                buildDirectory = "build/"
            }
        })

        local lsp_w_default = {
            "lua_ls",
            "pyright",
            "clangd",
            "jinja_lsp",
        }

        lsp0.setup_servers(lsp_w_default)
    end,
}
