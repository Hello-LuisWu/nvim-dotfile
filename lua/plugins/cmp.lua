return {
    -- 补全引擎 (nvim-cmp)
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP 补全源
            "hrsh7th/cmp-buffer",   -- 缓冲区文本补全
            "hrsh7th/cmp-cmdline",  -- 命令补全
            "hrsh7th/cmp-path",     -- 文件路径补全
            "onsails/lspkind.nvim", -- 美化补全
            "hrsh7th/cmp-emoji",    -- emoji 补全菜单图标
            -- "f3fora/cmp-spell",     -- 拼写补全插件
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp"
            }
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            lspkind.init({
                mode = 'symbol_text',
                -- default: 'default'
                preset = 'codicons',
                -- default: {}
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    -- Function = "🐂",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },

            })
            cmp.setup({
                preselect = 'item',        -- 使完成菜单中的第一个项目始终被选中。
                sources = {
                    { name = "nvim_lsp" }, -- LSP 补全
                    { name = "buffer" },   -- 缓冲区文本
                    { name = "path" },     -- 文件路径
                    { name = 'emoji' },    -- emoji 补全
                    -- { name = "spell" },    -- 拼写检查补全
                },
                snippet = {
                    expand = function(args)
                        -- You need Neovim v0.10 to use vim.snippet
                        vim.snippet.expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                mapping = cmp.mapping.preset.insert({
                    -- 设置禁用自动补全，输入字符 cmp 不会自动弹出补全列表
                    -- 只有主动触发时（例如按 <C-Space>）才会出现补全列表。
                    -- ['<C-k>'] = cmp.mapping.complete(),

                    -- Tab 键向下选择补全项
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback() -- 默认 Tab 行为
                        end
                    end, { "i", "s" }),

                    -- Shift + Tab 向上选择补全项
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback() -- 默认 Shift+Tab 行为
                        end
                    end, { "i", "s" }),
                    -- 其他快捷键
                    ["<C-e>"] = cmp.mapping.abort(),                                                    -- Ctrl + e 放弃补全  ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter 确认选择
                    ["<C-Space>"] = cmp.mapping.complete(),                                             -- 手动触发补全
                    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- 下一个补全项
                    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- 上一个补全项
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                formatting = {
                    -- changing the order of fields so the icon is the first
                    fields = { 'menu', 'abbr', 'kind' },
                    -- -- 使用 lspkind 的格式化函数
                    format = lspkind.cmp_format({
                        -- ██ 图标显示模式 ██
                        -- 'text'    : 仅显示文字（无图标）
                        -- 'symbol'  : 仅显示图标（默认）
                        -- 'symbol_text' : 图标 + 文字
                        mode = 'symbol_text', -- show only symbol annotations

                        -- ██ 最大显示宽度配置 ██
                        maxwidth = {
                            menu = 50,         -- 标签部分（如 [LSP]）的最大宽度（单位：字符）
                            abbr = 50,         -- 补全项文本（如函数名）的最大宽度
                        },
                        ellipsis_char = '...', -- 当文本超过 maxwidth 时显示的省略符号
                        -- ██ 是否显示来源标签 ██
                        -- true  : 显示补全项来源（如 [LSP]、[Buffer]）
                        -- false : 隐藏来源标签（默认）
                        show_labelDetails = true,

                        -- ██ 自定义预处理函数 ██
                        -- 在应用 lspkind 格式前对补全项进行自定义修改
                        -- entry : 补全项数据源信息（包含来源类型等）
                        -- vim_item : 当前补全项的显示内容
                        before = function(entry, vim_item)
                            -- 示例：可在此处修改图标颜色/添加前缀
                            -- vim_item.kind = string.format('%s %s', '🎯', vim_item.kind)
                            return vim_item
                        end
                    })
                    -- here is where the change happens
                    --    format = function(entry, item)
                    --        local menu_icon = {
                    --            nvim_lsp = 'λ',
                    --            luasnip = '⋗',
                    --            buffer = 'Ω',
                    --            path = '🖫',
                    --            nvim_lua = 'Π',
                    --            emoji = '💤',
                    --        }
                    --        item.menu = menu_icon[entry.source.name]
                    --        return item
                    --    end,
                },
            })
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}
