local opt = vim.opt
opt.number = true
opt.wrap = true
opt.mouse = "a"
vim.g.do_filetype_lua = 1

local fn = vim.fn
local lazy_bootstrap = {}
local data_path = fn.stdpath("data")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    lazy_bootstrap = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

if lazy_bootstrap then
    opt.foldenable = false
    opt.termguicolors = true
    opt.background = "dark"
    opt.cursorline = true
    opt.relativenumber = true
    opt.undofile = true
    opt.inccommand = "nosplit"
    opt.undodir = data_path .. "/undo"
    vim.g.Hexokinase_highlighters = { "backgroundfull" }

    --opt.foldmethod = "syntax"

    local prequire = require("prequire")
    require("lazyplug")

    local nvim_lsp = prequire("lspconfig")
    if nvim_lsp then
        require("key")
        require("cmps")
        require("mydap")
    end
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

    if nvim_lsp then
        require("cmd")
    end
    -- for test
    require("mytreesitter")
end

-- Save the original `window/showMessage` handler
local original_show_message = vim.lsp.handlers["window/showMessage"]

-- Override the handler
vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
    -- Extract the message and message type from the LSP result
    local message = result.message
    local message_type = result.type

    -- Map LSP message types to Neovim's log levels
    local log_level = {
        [1] = vim.log.levels.ERROR, -- LSP `Error`
        [2] = vim.log.levels.WARN,  -- LSP `Warning`
        [3] = vim.log.levels.INFO,  -- LSP `Info`
        [4] = vim.log.levels.DEBUG  -- LSP `Log`
    }

    if message_type == 1 then
        vim.notify(message, log_level[message_type], {
            title = "Error", -- Custom notification title
            timeout = 3000,  -- Notification duration (milliseconds)
        })
        return
    end
    -- Use `vim.notify` to display the message
    -- Call the original handler to preserve default behavior
    original_show_message(err, result, ctx, config)
end
