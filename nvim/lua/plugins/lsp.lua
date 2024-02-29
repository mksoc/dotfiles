return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
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
                -- "svls",
                "clangd",
            },
            handlers = {
                require("lsp-zero").default_setup,
            },
        }
    end,
}
