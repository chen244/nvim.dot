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
    flutter_sdk_path = "/home/cht/Flutter",
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
    "rust_analyzer",
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
    "tinymist",
    "nushell",
    "dockerls",
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
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            cmd = { "clangd", "--experimental-modules-support" },
        }
    elseif lsp == "rust_analyzer" then
        opts = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = (function()
                if persettings and persettings.lspsettings and persettings.lspsettings.rust then
                    return persettings.lspsettings.rust
                else
                    return {
                        ['rust-analyzer'] = {
                            --checkOnSave = false
                        }
                    }
                end
            end)(),
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
            },
        }
    elseif lsp == "rust_analyzer" then
        opts = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ['rust-analyzer'] = {
                    checkOnSave = false
                }
            }
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
                    snippetSupport = true,
                },
            },
        },
    },
    on_attach = on_attach,
}
if persettings and persettings.lsp and persettings.lsp.neocmake then
    opts = persettings.lsp.neocmake
end

nvim_lsp.neocmake.setup(opts)

local opts_kt = {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        kotlin = {
            inlayHints = {
                typeHints = true,
                chainedHints = true
            },
            snippetsEnabled = true,
            formatting = {
                ktfmt = {
                    style = "google",
                    indent = 2,
                    continuationIndent = 4
                }
            },
            completion = {
                snippets = {
                    enabled = true
                }
            }
        }
    }
}
--- mime cmake lsp

if persettings and persettings.lsp and persettings.lsp.kotlin_language_server then
    opts_kt = persettings.lsp.kotlin_language_server
end
nvim_lsp.kotlin_language_server.setup(opts_kt)
