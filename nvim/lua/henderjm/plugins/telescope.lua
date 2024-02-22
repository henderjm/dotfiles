return {
	"nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { 
        "nvim-lua/plenary.nvim",
	    "nvim-telescope/telescope-file-browser.nvim" 
    },
	--{"nvim-telescope/telescope-project.nvim", dependencies = "nvim-lua/plenary.nvim" },
	config = function()
		require('telescope').setup({})

		local builtin = require('telescope.builtin')


		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		vim.keymap.set('n', '<leader>pF', ':Telescope file_browser<CR>', {})
		vim.keymap.set('n', '<leader>pp', ':Telescope project<CR>', {})
		vim.keymap.set('n', '<C-p', builtin.git_files, {})
		vim.keymap.set('n', '<leader>ps', builtin.grep_string, {})
		--require("telescope").load_extension "file_browser"
		--require("telescope").load_extension "project"
	end
}
