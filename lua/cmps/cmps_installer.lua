local servers = {
    "html",
    "cssls",
    "lua_ls",
    --"sumneko_lua",
    --"clangd",
    --"rust_analyzer",
    "julials",
    "csharp_ls",
    --"pyright",
    "pylsp",
    "tsserver",
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
    "cmake",
    "bashls",
    "vimls",
    --"cssls",
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
}
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
})
