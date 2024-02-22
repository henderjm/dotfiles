return {
    'VonHeikemen/lsp-zero.nvim',
    --"ray-x/go.nvim",
    branch = 'v3.x',
    dependencies = {
        --- Uncomment these if you want to manage LSP servers from neovim
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
        {"mfussenegger/nvim-dap"},
        {"jay-babu/mason-nvim-dap.nvim"},
        {'leoluz/nvim-dap-go'},
        {'rcarriga/nvim-dap-ui'},
        {'j-hui/fidget.nvim'},
        {'nvim-telescope/telescope-dap.nvim'},
        {'ray-x/guihua.lua'},
        {'neovim/nvim-lspconfig'},
        {'nvim-treesitter/nvim-treesitter'},
    },

        --event = {"CmdlineEnter"},
        --ft = {"go", 'gomod'},
        --build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>"),
    vim.keymap.set("n", "<F5>", ":DapStepInto<CR>"),
    vim.keymap.set("n", "<F6>", ":DapStepOut<CR>"),
    vim.keymap.set("n", "<F7>", ":DapStepOver<CR>"),
    vim.keymap.set("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>"),
    vim.keymap.set("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.fn.input('breakpoint condition: '))<CR>"),
    vim.keymap.set("n", "<leader>dui", ":lua require('dapui').open()<CR>"),
    vim.keymap.set("n", "<leader>dci", ":lua require('dapui').close()<CR>"),
    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.preset("recommended")

        lsp_zero.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}
            lsp_zero.default_keymaps({buffer = bufnr})
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        --require("go").setup()
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {'gopls', 'eslint', 'lua_ls', 'bashls', 'rust_analyzer'},
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                    require('lspconfig').lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,
            }
        })

        require("mason-nvim-dap").setup({
            ensure_installed = { "delve" }
        })

        require("dap-go").setup()
        require("dapui").setup()
        --local on_attach = require("lspconfig").on_attach
        --local capabilities = require("lspconfig").capabilities

        --local lspconfig = require("lspconfig")
        --lspconfig.gopls.setup {
            --on_attach = on_attach,
            --capabilities = capabilities,
            --cmd = {"gopls"},
            --filetypes = { "go", "gomod", "gowork", "gotmpl" },
            --settings = {
                --gopls = {
                    --completeUnimported = true,
                    --usePlaceholders = true,
                    --analyses = {
                        --unusedparams = true,
                    --},
                --},
            --},
        --}


        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        cmp.setup({
            sources = {
                {name = 'path'},
                {name = 'nvim_lsp'},
                {name = 'luasnip', keyword_length = 2},
                {name = 'buffer', keyword_length = 3},
            },
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })

        require("fidget").setup({})
        vim.diagnostic.config({
            virtual_text = true
        })
    end
}
