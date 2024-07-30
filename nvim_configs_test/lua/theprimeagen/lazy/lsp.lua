-- lsp.lua
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        --"L3MON4D3/LuaSnip",
        --"saadparwaiz1/cmp_luasnip",
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        "j-hui/fidget.nvim",
        "b0o/schemastore.nvim", -- Add this line to include schemastore
    },

    config = function()
        local cmp = require('cmp')
        local luasnip = require 'luasnip'
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "sqlls",
                "jsonls",
                "angularls",
                "clangd",
                "html",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["html"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.html.setup {
                        capabilities = capabilities,
                    }
                end,
                ["tsserver"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.tsserver.setup {
                        capabilities = capabilities,
                        settings = {
                            typescript = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                                inlayHints = {
                                    parameterNames = {
                                        enabled = "all",
                                    },
                                    parameterTypes = { enabled = true },
                                    variableTypes = { enabled = true },
                                    propertyDeclarationTypes = { enabled = true },
                                    functionLikeReturnTypes = { enabled = true },
                                    enumMemberValues = { enabled = true },
                                },
                            },
                        },
                    }
                end,
                ["rust_analyzer"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.rust_analyzer.setup {
                        capabilities = capabilities,
                        settings = {
                            ["rust-analyzer"] = {
                                assist = {
                                    importGranularity = "module",
                                    importPrefix = "by_self",
                                },
                                cargo = {
                                    allFeatures = true,
                                },
                                checkOnSave = {
                                    command = "clippy",
                                },
                            }
                        }
                    }
                end,
                ["sqlls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.sqlls.setup {
                        capabilities = capabilities,
                        settings = {
                            sql = {
                                connections = {
                                    {
                                        driver = "postgres",
                                        dataSourceName = "host=localhost port=5432 user=myuser password=mypassword dbname=mydb sslmode=disable",
                                    },
                                },
                            },
                        },
                    }
                end,
                ["jsonls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.jsonls.setup {
                        capabilities = capabilities,
                        settings = {
                            json = {
                                schemas = require('schemastore').json.schemas(),
                                validate = { enable = true },
                            },
                        },
                    }
                end,
                ["angularls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.angularls.setup {
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern("angular.json"),
                    }
                end,
                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup {
                        capabilities = capabilities,
                        filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
                        root_dir = lspconfig.util.root_pattern("buildServer.json", "*.xcodeproj", "*.xcworkspace", "compile_commands.json", "Package.swift", ".git"),
                    }
                end,}
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                ['<cr>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                --{ name = 'luasnip' },
                { name = 'vsnip' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

