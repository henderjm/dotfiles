local ftMap = {
    vim = 'indent',
    python = { 'indent' },
    git = ''
}
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end


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
                return { "treesitter", "indent" }
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
