return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
	},
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            formatting = {
                format = require("lspkind").cmp_format(),
            },
            mapping = {
                ["<Tab>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
                ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i' }),
                ["<Right>"] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
                ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
                ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

    end
}
