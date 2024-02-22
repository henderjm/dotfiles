local ftMap = {
    vim = 'indent',
    python = { 'indent' },
    git = ''
}
return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter' },

    config = function()
        require('ufo').setup({
            --vim.o.foldcolumn = '1', -- '0' is not bad
            --vim.o.foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
            --vim.o.foldlevelstart = 99,
            --vim.o.foldenable = true,
            preview = {
                win_config = {
                    border = { '', '─', '', '', '', '─', '', '' },
                    winhighlight = 'Normal:Folded',
                    winblend = 0
                },
                --mappings = {
                --scrollU = '<C-u>',
                --scrollD = '<C-d>',
                --jumpTop = '[',
                --jumpBot = ']'
                --}
            },
            provider_selector = function(bufnr, filetype, buftype)
                return ftMap[filetype]
            end
        })
        vim.o.foldlevel = 100000
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
        vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
        --vim.keymap.set('n', 'K', function(),
        --local winid = require('ufo').peekFoldedLinesUnderCursor()
        --if not winid then
        ---- choose one of coc.nvim and nvim lsp
        --vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        --vim.lsp.buf.hover()
        --end
        --end}),
    end
}
