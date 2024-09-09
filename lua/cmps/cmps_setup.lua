local on_attach = require("cmps.cmp_onattach")

local prequire = require("prequire")
-- for lsp developing and lspsettings
local persettings = prequire("settings")

local nvim_lsp = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local not_package_json = not file_exists("package.json")

require("flutter-tools").setup({
    flutter_path = "/usr/bin/flutter",
    lsp = {
        capabilities = capabilities,
        on_attach = on_attach,
    },
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
}) -- use defaults
-- clangd start here
--require("clangd_extensions").setup({
--    server = {
--        capabilities = capabilities,
--        on_attach = on_attach,
--        -- options to pass to nvim-lspconfig
--    },
--    extensions = {
--        -- defaults:
--        -- Automatically set inlay hints (type hints)
--        autoSetHints = false,
--        -- Whether to show hover actions inside the hover window
--        -- This overrides the default hover handler
--        hover_with_actions = true,
--        -- These apply to the default ClangdSetInlayHints command
--        inlay_hints = {
--            -- Only show inlay hints for the current line
--            only_current_line = false,
--            -- Event which triggers a refersh of the inlay hints.
--            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
--            -- not that this may cause  higher CPU usage.
--            -- This option is only respected when only_current_line and
--            -- autoSetHints both are true.
--            only_current_line_autocmd = "CursorHold",
--            -- whether to show parameter hints with the inlay hints or not
--            show_parameter_hints = true,
--            -- whether to show variable name before type hints with the inlay hints or not
--            show_variable_name = false,
--            -- prefix for parameter hints
--            parameter_hints_prefix = "<- ",
--            -- prefix for all the other hints (type, chaining)
--            other_hints_prefix = "=> ",
--            -- whether to align to the length of the longest line in the file
--            max_len_align = false,
--            -- padding from the left if max_len_align is true
--            max_len_align_padding = 1,
--            -- whether to align to the extreme right or not
--            right_align = false,
--            -- padding from the right if right_align is true
--            right_align_padding = 7,
--            -- The color of the hints
--            highlight = "Comment",
--        },
--    },
--})

require("rust-tools").setup({
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
        -- project settings for rust_analyzer , include features
        settings = (function()
            if persettings and persettings.lspsettings and persettings.lspsettings.rust then
                return persettings.lspsettings.rust
            else
                return nil
            end
        end)(),
    },
    tools = {
        inlay_hints = {
            auto = false,
        },
    },
})
local servers_lsp = {
    "gdscript",
    "hls",
    "denols",
    "mesonlsp",
    "html",
    "cssls",
    --"r_language_server",
    "lua_ls",
    "clangd",
    "gradle_ls",
    --"rust_analyzer",
    "julials",
    "csharp_ls",
    --"pyright",
    "pylsp",
    --"ruff_lsp",
    "ts_ls",
    --"omnisharp",
    "fsautocomplete",
    --"hls",
    "texlab",
    "jsonls",
    --"dartls",
    "vala_ls",
    --"volar",
    "vuels",
    "kotlin_language_server",
    "gopls",
    --"jedi_language_server",
    "jdtls",
    --"cmake",
    "bashls",
    "vimls",
    --"cssls
    "lemminx",
    --"groovyls",
    --"graphql",
    --"html",
    "yamlls",
    "ocamllsp",
    --"denols",
    "taplo",
    "zls",
    "slint_lsp",
    "teal_ls",
    "typst_lsp",
    "nushell",
    "dockerls"
    --"typos_lsp"
}

for _, lsp in ipairs(servers_lsp) do
    local opts = {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
        on_attach = on_attach,
    }
    if lsp == "clangd" then
        opts = {
            -- on_attach = my_custom_on_attach,
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        }
    elseif lsp == "lua_ls" then
        opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Setup your lua path
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
    elseif lsp == "denols" then
        opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = nvim_lsp.util.root_pattern("deno.json"),
            init_options = { --settings,
                lint = true,
            },
            single_file_support = not_package_json,
        }
    elseif lsp == "kotlin_language_server" then
        opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            single_file_support = true,
        }
    elseif lsp == "ts_ls" then
        opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = nvim_lsp.util.root_pattern("package.json"),
            init_options = {
                lint = true,
            },
            single_file_support = false,
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
            },
        }
    elseif lsp == "csharp_ls" then
        opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = {
                ["textDocument/definition"] = require("csharpls_extended").handler,
            },
            flags = {
                --allow_incremental_sync = false,
            },
        }
    end
    nvim_lsp[lsp].setup(opts)
end

--- testing
local configs = require("lspconfig.configs")
local opts = {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
                relative_pattern_support = true,
            },
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    },
    on_attach = on_attach,
}
if persettings and persettings.lsp and persettings.lsp.neocmake then
    opts = persettings.lsp.neocmake
end

nvim_lsp.neocmake.setup(opts)

--- mime cmake lsp

if persettings and persettings.lsp and persettings.lsp.neoqml then
    configs.neoqml = persettings.lsp.neoqml
    nvim_lsp.neoqml.setup({})
else
    configs.qml_lsp = {
        default_config = {
            --cmd = { "/usr/lib/qt6/bin/qmlls" },
            cmd = { "/usr/bin/qmlls6" },
            filetypes = { "qmljs" },
            root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname)
            end,
            single_file_support = true,
            on_attach = on_attach,
        },
    }
    nvim_lsp.qml_lsp.setup({})
end
