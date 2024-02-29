return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()

        local servers = {
            "lua_ls",
            "verible",
            "svls",
        }

        require("mason-lspconfig").setup{
            ensure_installed = servers,
        }

        require("mason-lspconfig").setup_handlers{
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function (server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup {}
            end,
        }

        -- Set up lspconfig
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        for _, server in ipairs(servers) do
            require('lspconfig')[server].setup {
                capabilities = capabilities
            }
        end
    end,
}
