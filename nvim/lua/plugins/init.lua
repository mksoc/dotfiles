return {
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      config = function()
	local wk = require("which-key")
	wk.register({
	  ["<leader>f"] = { name = "File/find" },
	  ["<leader>g"] = { name = "Git" },
	})
      end,
    },
    
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
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
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
      "rebelot/kanagawa.nvim"
    },
}
