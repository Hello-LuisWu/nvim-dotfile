return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",          -- LSP 安装工具
                  version = "^1.0.0"
 
            },
            {
                "williamboman/mason-lspconfig.nvim", -- 自动安装 LSP
                version = "^1.0.0"
            }
            },
        event = { "BufReadPre", "BufNewFile" },  -- 在打开文件时加载
        config = function()
            local lspconfig = require("lspconfig")

            -- 自动安装 LSP
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "lua_ls"
                },                             -- 示例: 自动安装的 LSP
                automatic_installation = true, -- 自动安装缺失的 LSP
                -- 定义语言服务器的配置处理程序
                handlers = {
                    -- 通用处理函数，适用于所有列出的语言服务器
                    function(server_name)
                        -- 为每个服务器调用 lspconfig 的配置方法
                        -- 使用空配置对象 {} 表示采用默认配置
                        require('lspconfig')[server_name].setup({})
                    end,
                },
            })


            -- 将 nvim-cmp（自动补全插件）的能力合并到 LSP 默认能力中
            -- 获取 Neovim LSP 配置的默认设置
            -- local lspconfig_defaults = lspconfig.util.default_config
            local lspconfig_defaults = lspconfig.util.default_config

            -- 使用深度合并方式扩展 LSP 能力配置
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',                                       -- 合并模式：强制覆盖相同字段
                lspconfig_defaults.capabilities,               -- LSP 默认能力
                require('cmp_nvim_lsp').default_capabilities() -- nvim-cmp 提供的增强能力
            )

            -- LSP 基础配置
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' } -- 声明 vim 为已知全局变量
                        },
                        workspace = {
                            -- 添加 Neovim 运行时路径
                            library = vim.api.nvim_get_runtime_file("", true)
                        }
                    }
                }

            })

            -- lspconfig.pyright.setup({})  -- Python 配置
            -- lspconfig.html.setup({})     -- Python 配置
            -- lspconfig.emmet_ls.setup({}) -- Python 配置
            -- lspconfig.tsserver.setup({}) -- TypeScript 配置

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    vim.keymap.set('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = "悬停信息", buffer = event.buf })
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',
                        { desc = "跳转定义", buffer = event.buf })
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
                        { desc = "跳转到声明", buffer = event.buf })
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
                        { desc = "跳转到实现", buffer = event.buf })
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
                        { desc = "跳转到类型定义", buffer = event.buf })
                    vim.keymap.set('n', 'gy', '<cmd>lua vim.lsp.buf.references()<cr>',
                        { desc = "查看引用", buffer = event.buf })
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
                        { desc = "显示函数签名帮助", buffer = event.buf })
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = "重命名符号", buffer = event.buf })
                    vim.keymap.set({ 'n', 'x' }, 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                        { desc = "代码格式化", buffer = event.buf })
                    vim.keymap.set('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<cr>',
                        { desc = "代码操作", buffer = event.buf })
                end,
            })
        end,
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                lsp_zero.highlight_symbol(client, bufnr)
                lsp_zero.buffer_autoformat()
            end)

            lsp_zero.ui({
                float_border = 'rounded',
                sign_text = {
                    error = '✘',
                    warn = '▲',
                    hint = '⚑',
                    info = '»',
                },
            })
            lsp_zero.omnifunc.setup({
                trigger = '<C-Space>',
                tabcomplete = true,
                use_fallback = true,
                update_on_delete = true,
                -- You need Neovim v0.10 to use vim.snippet.expand
                expand_snippet = vim.snippet.expand
            })

            lsp_zero.new_client({
                cmd = { 'intelephense', '--stdio' },
                filetypes = { 'php' },
                root_dir = function(bufnr)
                    return vim.fs.root(bufnr, { 'composer.json' })
                end,
            })

            -- 自动格式化配置（保存时自动格式化）
            lsp_zero.format_on_save({
                servers = {
                    ['lua_ls'] = { 'lua' },     -- Lua 使用 lua_ls 格式化
                    ['pyright'] = { 'python' }, -- Python 使用 pyright 格式化
                }
            })
            -- 创建新的 LSP 客户端配置
            lsp_zero.new_client({
                -- 指定语言服务器的启动命令
                cmd = { 'lua-language-server' }, -- 需要确保该命令在系统 PATH 环境变量中

                -- 指定处理的文件类型
                filetypes = { 'lua' }, -- 仅针对 Lua 文件启用此语言服务器

                -- 客户端初始化时的回调函数
                on_init = function(client)
                    -- 配置 Neovim 特有的 Lua 运行时设置
                    -- 此函数会为 Lua 语言服务器添加 Neovim 的 API 支持
                    lsp_zero.nvim_lua_settings(client, {})
                end,

                -- 定义如何确定项目根目录（用于 LSP 的 workspace 配置）
                root_dir = function(bufnr)
                    -- 使用 Neovim v0.10+ 的 vim.fs.root 方法查找项目根目录
                    -- 查找标准包含以下任意文件的目录：
                    -- 1. .git 文件夹（版本控制目录）
                    -- 2. .luarc.json 或 .luarc.jsonc（Lua 配置文件）
                    -- 注意：建议在 Neovim 配置的根目录包含 .git 文件夹以提高检测准确性

                    return vim.fs.root(bufnr, { '.git', '.luarc.json', '.luarc.jsonc' })
                end,
            })
        end
    }
}
