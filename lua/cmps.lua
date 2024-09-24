require("cmps.cmps_installer")
require("cmps.cmps_setup")

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
-- luasnip
local luasnip = require("luasnip")
require("cmps.snippets")
require("luasnip.loaders.from_vscode").lazy_load()
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- nvim-cmp setup
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok or cmp == nil then
    return
end
local kind_icons = {
    Text = "  ",
    Method = "  ",
    Function = "  ",
    Constructor = "  ",
    Field = "  ",
    Variable = "  ",
    Class = "  ",
    Interface = "  ",
    Module = "  ",
    Property = "  ",
    Unit = "  ",
    Value = "  ",
    Enum = "  ",
    Keyword = "  ",
    Snippet = "  ",
    Color = "  ",
    File = "  ",
    Reference = "  ",
    Folder = "  ",
    EnumMember = "  ",
    Constant = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
}
--local kind_icons = {
--    Text = "T", --"",
--    Method = "m",
--    Function = "F", --"",
--    Constructor = "",
--    Field = "",
--    Variable = "V", --"",
--    Class = "C", -- "",
--    Interface = "",
--    Module = "",
--    Property = "",
--    Unit = "",
--    Value = "Va", --"",
--    Enum = "",
--    Keyword = "🔑", --"",
--    Snippet = "",
--    Color = "Color", --"",
--    File = "File", -- "",
--    Reference = "",
--    Folder = "Folder", --"",
--    EnumMember = "",
--    Constant = "Con", --"",
--    Struct = "",
--    Event = "",
--    Operator = "operator", --"",
--    TypeParameter = "Type", --"",
--}
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Down>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                --elseif luasnip.expand_or_jumpable() then
                --    luasnip.expand_or_jump()
                --elseif has_words_before() then
                --    cmp.complete()
            else
                fallback()
            end
        end,
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                --elseif luasnip.expand_or_jumpable() then
                --    luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end,
        ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                --elseif luasnip.jumpable(-1) then
                --    luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                dap = "[Dap]",
                emoji = "[Emoji]",
            })[entry.source.name]
            return vim_item
        end,
    },
    view = {
        entires = "native",
    },
    experimental = {
        ghost_text = {
            hl_group = false,
        },
    },
    enabled = function()
        return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "dap" },
        { name = "emoji" },
    },
})
require("cmp").setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline" },
    },
})
require("cmp").setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
