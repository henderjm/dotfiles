return {
    "elentok/format-on-save.nvim",
    config = function()
        local format_on_save = require("format-on-save")
        local formatters = require("format-on-save.formatters")

        format_on_save.setup({
            exclude_path_patterns = {
                "/node_modules/",
                ".local/share/nvim/lazy",
            },
            formatter_by_ft = {
                css = formatters.lsp,
                html = formatters.lsp,
                java = formatters.lsp,
                javascript = formatters.lsp,
                json = formatters.lsp,
                lua = formatters.lsp,
                markdown = formatters.prettierd,
                openscad = formatters.lsp,
                rust = formatters.lsp,
                scad = formatters.lsp,
                scss = formatters.lsp,
                sh = formatters.shfmt,
                terraform = formatters.lsp,
                typescript = formatters.prettierd,
                typescriptreact = formatters.prettierd,
                yaml = formatters.lsp,
                myfiletype = formatters.shell({ cmd = { "myformatter", "%" } }),
                my_custom_formatter = function()
                    if vim.api.nvim_buf_get_name(0):match("/README.md$") then
                        return formatters.prettierd
                    else
                        return formatters.lsp()
                    end
                end,
                filetype1 = formatters.remove_trailing_whitespace,
                filetype2 = formatters.custom({
                    format = function(lines)
                        return vim.tbl_map(function(line)
                            return line:gsub("true", "false")
                        end, lines)
                    end
                }),
                python = {
                    formatters.remove_trailing_whitespace,
                    formatters.shell({ cmd = "tidy-imports" }),
                    formatters.black,
                    formatters.ruff,
                },
                go = {
                    formatters.shell({
                        cmd = { "goimports" },
                    }),
                    formatters.shell({ cmd = { "gofmt" } }),
                },
            },
            fallback_formatter = {
                formatters.remove_trailing_whitespace,
                formatters.remove_trailing_newlines,
                formatters.prettierd,
            },
            run_with_sh = false,
        })
    end
}
