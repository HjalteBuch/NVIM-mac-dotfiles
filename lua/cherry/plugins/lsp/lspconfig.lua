return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            opts.desc = "Show hover information"
            keymap.set("n", "K", vim.lsp.buf.hover, opts)
            opts.desc = "Show definition"
            keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            opts.desc = "Show type definition"
            keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
            opts.desc = "Show implementations"
            keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            opts.desc = "Show references"
            keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
            opts.desc = "Rename globally"
            keymap.set("n", "<leader>R", vim.lsp.buf.rename, opts)
            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Show error message"
            keymap.set("n", "<leader>ds", vim.diagnostic.open_float, opts)
            opts.desc = "Go to next diagnostic"
            keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
            opts.desc = "Go to prev diagnostic"
            keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
            opts.desc = "Show list of diagnostic"
            keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- configure html server
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure typescript server with plugin
        lspconfig["tsserver"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure css server
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure tailwindcss server
        lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure golang server
        lspconfig["gopls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
            Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    -- make language server aware of runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                },
            },
        },
    })
end,
}
