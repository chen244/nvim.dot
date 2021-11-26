local opt = vim.opt
opt.number=true
opt.wrap=true;
opt.mouse = 'a'
opt.guifont = "DroidSansMono_Nerd_Font:h11"
vim.cmd [[filetype off]]
vim.cmd [[packadd packer.nvim]]
opt.foldmethod="syntax"
require('plug').loadplug();
require('key').keys();
require('nvim-tree').setup()
require('gitsigns').setup()
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
--require'gitsigns'.setup{}

--local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
--local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
--local sumneko_root_path = '/usr/bin/lua-language-server'
--local sumneko_binary = '/usr/bin/lua-language-server'
opt.termguicolors=true
opt.background="dark"
opt.cursorline=true
opt.relativenumber = true
opt.undofile=true
opt.inccommand="nosplit"
--opt.undodir="/home/cht/.vim/undo"
opt.undodir=os.getenv("HOME") .. '/.vim/undo'
vim.cmd [[colorscheme one]]
vim.cmd [[hi CursorLine cterm=bold  guibg=#333333]]
vim.cmd [[hi CocFadeOut cterm=bold  guibg=#666666]]
vim.cmd [[let g:airline#extensions#tabline#enabled = 1 ]]
vim.cmd [[let g:airline_powerline_fonts = 1]]
vim.cmd [[autocmd ColorScheme * hi Normal guibg=#1b1e27]]
vim.cmd [[let g:Hexokinase_highlighters = ['backgroundfull'] ]]
vim.cmd [[autocmd BufNewFile,BufWritePre,BufRead *.* exec ":lua require('functions/files').Settab()" ]]
vim.cmd [[autocmd BufNewFile,BufRead *.conf,*.ini set filetype=dosini ]]
vim.cmd [[autocmd!   BufNewFile,BufRead *    setlocal nofoldenable]]
vim.cmd [[let g:blamer_enabled = 1]]
vim.cmd [[ augroup ScrollbarInit
  autocmd!
  autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end]]
