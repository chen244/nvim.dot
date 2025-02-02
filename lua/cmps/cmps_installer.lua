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
    "bashls",
    "vimls",
    --"cssls",
    "lemminx",
    "gradle_ls",
    --"graphql",
    --"html",
    "yamlls",
    --"ocamllsp",
    --"denols",
    "taplo",
    "zls",
    "slint_lsp",
    "teal_ls",
    "typos_lsp",
    "dockerls",
}
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
})
