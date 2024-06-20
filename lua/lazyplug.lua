-- every time changed should compiled first
require("lazy").setup({
    --"tpope/vim-fugitive", --git blame
    "arkav/lualine-lsp-progress",
    "junegunn/fzf",
    "kongo2002/fsharp-vim", --hightight for fsharp
    --"peterhoeg/vim-qml",
    "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
    "hrsh7th/nvim-cmp", -- Autocompletion plugin
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    -- cmp's luasnip and luasnip engine
    "L3MON4D3/LuaSnip", -- Snippets plugin
    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    -- vscode snippets
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "rcarriga/cmp-dap",
    --"williamboman/nvim-lsp-installer",
    "mfussenegger/nvim-dap",
    "folke/lsp-colors.nvim",
    "simnalamburt/vim-mundo",
    --"rbong/vim-flog",
    "nvim-tree/nvim-web-devicons", --icons for Nvim tree
    --"aklt/plantuml-syntax",
    "tyru/open-browser.vim",
    "weirongxu/plantuml-previewer.vim",
    "simrat39/rust-tools.nvim",
    { dir = "~/git/csharpls-extended-lsp.nvim" },
    "p00f/clangd_extensions.nvim",
    "HiPhish/nvim-ts-rainbow2",
    --"leoluz/nvim-dap-go",
    "simrat39/symbols-outline.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nfnty/vim-nftables",
    {
        "kaarmu/typst.vim",
        ft = { "typst" },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup()
        end,
    },

    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function ()
            require("lsp-inlayhints").setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    -- Packer
    { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    --{
    --    "nvim-neorg/neorg",
    --    ft = "norg",
    --    config = function()
    --        require("neorg").setup({
    --            load = {
    --                ["core.defaults"] = {},
    --            },
    --        })
    --    end,
    --    dependencies = { "nvim-lua/plenary.nvim" },
    --},
    {
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup({
                input = {
                    min_width = { 60, 0.2 },
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "mypy" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        dependencies = { "anuvyklack/nvim-keymap-amend" },
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("pretty-fold").setup({})
        end,
    },
    {
        "anuvyklack/fold-preview.nvim",
        dependencies = { "anuvyklack/keymap-amend.nvim" },
        config = function()
            require("fold-preview").setup()
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            -- Default options:
            require("kanagawa").setup({
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = { italic = true },
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                --typeStyle = "NONE",
                variablebuiltinStyle = { italic = true },
                specialReturn = true, -- special highlight for the return keyword
                specialException = true, -- special highlight for exception handling keywords
                transparent = false, -- do not set background color
                dimInactive = false, -- dim inactive window `:h hl-NormalNC`
                globalStatus = false, -- adjust window separators highlight for laststatus=3
                colors = {},
                --overrides = {},
            })
            -- setup must be called before loading
            --vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
            require("notify").setup({
                -- Animation style (see below for details)
                stages = "fade_in_slide_out",
                -- Function called when a new window is opened, use for changing win settings/config
                on_open = nil,
                -- Function called when a window is closed
                on_close = nil,
                -- Render function for notifications. See notify-render()
                render = "default",
                -- Default timeout for notifications
                timeout = 5000,
                -- Max number of columns for messages
                max_width = nil,
                -- Max number of lines for a message
                max_height = nil,
                -- For stages that change opacity this is treated as the highlight behind the window
                -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
                background_colour = "#000000",
                -- Minimum width for notification windows
                minimum_width = 50,
                -- Icons for the different levels
                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✎",
                },
            })
            require("telescope").load_extension("notify")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append("space:⋅")
            --vim.opt.listchars:append("eol:↴")
            require("ibl").setup({
                --indent = { ["tab_char"] = "|" },
            })
        end,
    },
    {
        dir = "~/git/csv-tools.lua",
        --"~/git/csv-tools.lua",
        config = function()
            require("csvtools").setup({
                before = 70,
                after = 70,
                --showoverflow = false
            })
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("scrollbar").setup({
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = false, -- Requires gitsigns
                    handle = true,
                    search = false, -- Requires hlslens
                    ale = false, -- Requires ALE
                },
                marks = {
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                },
            })
        end,
    },
    --use({
    --    "sidebar-nvim/sidebar.nvim",
    --    config = function()
    --        require("sidebar-nvim").setup({})
    --    end,
    --})
    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup({
                --backends = { "lsp", "markdown" },
                filter_kind = {
                    "Class",
                    "Constructor",
                    "Enum",
                    "Function",
                    "Interface",
                    "Namespace",
                    "Package",
                    "Variable",
                    "Module",
                    "Method",
                    "Struct",
                    "Key",
                    "Object",
                    "String",
                },
            })
            require("telescope").load_extension("aerial")
            --require("plug.winbar")
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({
                symbol_in_winbar = {
                    enable = true,
                    separator = " ",
                    --hide_keyword = true,
                    show_file = true,
                    folder_level = 2,
                },
                lightbulb = {
                    enable = false,
                },
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        config = function()
            require("nvim-tree").setup({
                diagnostics = {
                    enable = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
            })
        end,
    },
    {
        "LhKipp/nvim-nu",
        build = ":TSInstall nu",
        config = function()
            require("nu").setup({
                use_lsp_features = false,
            })
        end,
    },

    --{ "wbthomason/packer.nvim", event = "VimEnter" },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = false,
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>hu", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    map("n", "<leader>hp", gs.preview_hunk)
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end)
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end)
                    map("n", "<leader>td", gs.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        config = function()
            require("lualine").setup({
                options = {
                    --theme = "onedark",
                    globalstatus = true,
                },
                sections = {
                    lualine_c = {
                        "filename",
                        "lsp_progress",
                        {
                            function()
                                local msg = "No Active Lsp"
                                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                                local clients = vim.lsp.get_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return client.name
                                    end
                                end
                                return msg
                            end,
                            icon = " LSP:",
                            color = { fg = "#ffffff", gui = "bold" },
                        },
                    },
                    --lualine_x = { "aerial" },
                    lualine_y = {
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                },
            })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, _, _)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                },
            })
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
    },
    --{ "rrethy/vim-hexokinase", build = "make hexokinase", lazy = false },
    { dir = "~/git/flutter-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                max_lines = 3,
            })
        end,
    },
    {
        dir = "~/git/nvim-treesitter",
        dependencies = { "nvim-treesitter/playground" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "BufWrite", "CursorHold" },
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
                ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
                ignore_install = { "r", "po" }, -- List of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                    -- disable = { "markdown" }, -- list of language that will be disabled
                    additional_vim_regex_highlighting = true,
                },
                --rainbow = {
                --    enable = true,
                --    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                --    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                --    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                --    -- colors = {}, -- table of hex strings
                --    -- termcolors = {} -- table of colour name strings
                --},
            })
        end,
    },
})
