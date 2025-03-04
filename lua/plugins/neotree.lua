return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { -- 依赖插件
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = { -- 快捷键触发加载
        { "<C-e>", "<cmd>Neotree reveal toggle<cr>", mode = { "n", "v" }, desc = "切换文件树" },
        { "<C-n>", "<cmd>Neotree toggle<cr>", mode = { "n", "i", "v" }, desc = "切换文件树" },
    },
    config = function()
        require("neo-tree").setup({
            -- [[ 基础配置 ]] --------------------------------------------------------
            close_if_last_window          = true,         -- 当最后一个窗口时自动关闭
            enable_normal_mode_for_inputs = true,         -- 输入弹出窗默认使用正常模式
            enable_git_status             = true,         -- 显示 Git 状态
            enable_diagnostics            = false,        -- 显示 LSP 诊断
            default_source                = "filesystem", -- 默认显示文件系统,  默认数据源: filesystem/buffers/git_status
            popup_border_style            = "rounded",    -- 弹出窗口边框样式: "single"|"double"|"rounded"|"shadow"|"none"
            log_level                     = "info",       -- 日志级别: trace/debug/info/warn/error
            log_to_file                   = false,        -- 将日志写入文件 (调试用)
            use_popups_for_input          = true,         -- 使用弹出窗口进行输入操作
            sort_case_insensitive         = false,        -- 文件名排序是否忽略大小写

            -- [[ 窗口配置 ]] ---------------------------------------------------------
            window                        = {
                position = "left", -- 窗口位置: left/right/float/current
                width = 32,        -- 窗口宽度
                height = "80%",    -- 浮动窗口高度（像素或百分比）
                -- mappings = {       -- 自定义快捷键映射
                --     -- ["<space>"] = "toggle_node", -- 切换节点展开/折叠
                --     -- ["<cr>"] = "open",              -- 打开文件/目录
                --     ["<cr>"] = {
                --         "open",
                --         config = {
                --             use_float = false,      -- 在分割窗口打开
                --             open_target = "current" -- 打开方式：current(当前)/new(新窗口)
                --         }
                --     },                              -- 打开文件/目录
                --     ["S"] = "open_split",           -- 水平分割打开
                --     ["s"] = "open_vsplit",          -- 垂直分割打开
                --     ["t"] = "open_tabnew",          -- 新标签页打开
                --     ["H"] = "toggle_hidden",        -- 切换显示隐藏文件
                --     ["R"] = "refresh",              -- 刷新树状图
                --     ["d"] = "delete",               -- 删除文件
                --     ["r"] = "rename",               -- 重命名文件
                --     ["a"] = "add",                  -- 创建文件/目录
                --     ["y"] = "copy_to_clipboard",    -- 复制文件
                --     ["m"] = "move",                 -- 移动文件
                --     ["x"] = "cut_to_clipboard",     -- 剪切文件
                --     ["C"] = "close_node",           -- 关闭模式
                --     ["?"] = "show_help",            -- 帮助文件
                --     ["p"] = "paste_from_clipboard", -- 粘贴文件
                --     ["c"] = "copy",                 -- 复制文件
                --     ["q"] = "close_window",         -- 关闭窗口
                --     ["#"] = "fuzzy_sorter",         -- 模糊排序
                --     ["<bs>"] = "navigate_up",       -- 返回上级目录
                --     ["."] = "set_root",             -- 设置当前为根目录
                --     ["/"] = "fuzzy_finder",         -- 模糊搜索文件
                --     -- ["gd"] = "jump_to_symbol"       -- 跳转到符号定义（需LSP支持）
                -- },
                -- 浮动窗口配置
                popup = {
                    position = "50%",   -- 浮动窗口位置
                    size = { width = "80%", height = "60%" },
                    border = "rounded", -- 边框样式: single/double/rounded/shadow/none
                },
                -- 标题栏配置
                title = {
                    " NeoTree ",                -- 固定标题前缀
                    align = "center",           -- 对齐方式: left/center/right
                    highlight = "NeoTreeTitle", -- 高亮组
                },

            },

            -- [[ 文件系统配置 ]] ------------------------------------------------------
            filesystem                    = {
                hijack_netrw_behavior  = "open_default", -- 接管 netrw: open_default/open_current/disabled
                bind_to_cwd            = true,           -- 绑定当前工作目录
                follow_current_file    = true,           -- 自动跟踪当前文件
                use_libuv_file_watcher = true,           -- 使用 libuv 文件监视器
                cwd_target             = {               -- 目录绑定目标类型
                    sidebar = "tab",                     -- 侧边栏模式使用 tab 级目录
                    current = "window",                  -- 当前窗口模式使用窗口级目录
                },
                filtered_items         = {               -- 过滤文件配置
                    visible = false,                     -- 默认不显示隐藏项
                    hide_dotfiles = true,                -- 隐藏点文件
                    hide_gitignored = true,              -- 隐藏 Git 忽略文件
                    hide_hidden = true,                  -- 隐藏系统隐藏文件
                    hide_by_name = {                     -- 按名称隐藏
                        ".DS_Store",
                        "thumbs.db",
                        "node_modules",
                    },
                    hide_by_pattern = { -- 按模式隐藏 (Lua 正则)
                        -- "*.meta", "*/src/*/tsconfig.json"
                    },
                    always_show = { -- 始终显示 (优先级最高)
                        -- ".gitignore", ".env"
                    },
                    never_show = { -- 永不显示 (优先级高于 always_show)
                        -- ".null-ls_*"
                    },
                },
                -- components = { -- 自定义组件 (可选)
                --     name = function(config, node, state)
                --         -- 自定义文件名显示逻辑
                --     end,
                -- },
                -- 搜索配置
                search_limit           = 50,            -- 搜索结果最大数量
                find_command           = "fd",          -- 搜索命令: fd/rg/find (需安装)
                find_args              = {              -- 搜索命令参数
                    fd = { "--hidden", "--type", "f" }, -- fd 示例参数
                    rg = { "--files", "--hidden" },     -- rg 示例参数
                },
                -- 文件嵌套规则 (高级)
                nesting_rules          = {
                    ["js"] = { "js.map" }, -- .js 文件显示嵌套 .js.map
                    -- 高级模式:
                    -- ["docker"] = {
                    --   pattern = "^dockerfile$",
                    --   ignore_case = true,
                    --   files = { "docker-compose.*", ".dockerignore" }
                    -- }
                },

            },

            -- [[ 缓冲区源配置 ]] ------------------------------------------------------
            buffers                       = {
                show_unloaded = true,       -- 显示未加载的缓冲区
                group_empty_dirs = true,    -- 分组空目录
                follow_current_file = true, -- 跟踪当前文件
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete", -- 删除缓冲区
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                    },
                },
            },

            -- [[ Git 状态源配置 ]] ----------------------------------------------------
            git_status                    = {
                window = {
                    position = "float", -- Git 状态显示为浮动窗口
                    symbols = {
                        added    = "", -- 已添加文件
                        modified = "", -- 已修改文件
                        deleted  = "", -- 已删除文件
                        renamed  = "➜", -- 重命名文件
                        -- unstaged = "", -- 未暂存更改
                        unstaged = "$", -- 未暂存更改
                        staged   = "", -- 已暂存更改
                        conflict = "" -- 冲突文件
                    },
                    mappings = {
                        ["gaA"] = "git_add_all",      -- 暂存所有变更
                        ["gau"] = "git_unstage_file", -- 取消暂存
                        ["gaa"] = "git_add_file",     -- 暂存单个文件
                        ["gar"] = "git_revert_file",  -- 撤销修改
                        ["gac"] = "git_commit",       -- 提交变更
                        ["gap"] = "git_push",         -- 推送提交
                    },
                },
            },

            -- [[ 事件处理 ]] ----------------------------------------------------------
            event_handlers                = { -- 自定义事件处理器
                -- -- 文件打开后自动关闭浮动窗口
                -- {
                --     event = "file_opened",
                --     handler = function(file_path)
                --         neo_tree.close_all("float")
                --     end
                -- },
                -- 创建新文件后自动添加到Git跟踪
                {
                    event = "file_created",
                    handler = function(file_path)
                        vim.fn.system("git add " .. vim.fn.shellescape(file_path))
                    end
                },
                -- 自定义文件打开方式（使用Telescope）
            },

            -- [[ 主题与高亮定制 ]] ------------------------------------------------------
            highlight                     = {
                groups = {
                    NeoTreeGitAdded = { fg = "#98c379" },             -- 自定义Git添加颜色
                    NeoTreeGitModified = { fg = "#d19a66" },          -- 修改文件颜色
                    NeoTreeRootName = { bold = true, fg = "#e5c07b" } -- 根目录强调显示
                }
            },
            -- [[ 源选择器配置 ]] --
            source_selector               = {
                winbar = true, -- 在winbar显示源选择器
                statusline = false, -- 不在状态栏显示
                content_layout = "center", -- 标签内容布局: start/center/end
                tabs_layout = "equal", -- string
                tabs_min_width = nil, -- int | nil
                tabs_max_width = nil, -- int | nil
                truncation_character = "…", -- 截断符号
                show_scrolled_off_parent_node = false, -- boolean
                separator = { left = "▏", right = "▕", override = nil }, -- 分隔符
                sources = { -- 可用数据源配置
                    { source = "filesystem", display_name = " 󰉓 Files " },
                    { source = "buffers", display_name = " 󰈚 Buffers " },
                    { source = "git_status", display_name = " 󰊢 Git " }
                },
                show_separator_on_edge = false,                           -- boolean
                highlight_tab = "NeoTreeTabInactive",                     -- string
                highlight_tab_active = "NeoTreeTabActive",                -- string
                highlight_background = "NeoTreeTabInactive",              -- string
                highlight_separator = "NeoTreeTabSeparatorInactive",      -- string
                highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
            },

            -- [[ 诊断配置 ]] --------------------------------------------------------
            default_component_configs     = { -- 默认组件配置
                indent = { -- 缩进配置
                    -- 缩进线配置
                    indent_size = 2, -- 缩进宽度
                    padding = 1, -- 左侧填充
                    with_markers = true, -- 显示缩进标记线
                    indent_marker = "│", -- 缩进线符号
                    last_indent_marker = "└", -- 最后一级缩进符号
                    with_expanders = true, -- 显示展开/折叠图标
                    expander_collapsed = "", -- 折叠状态图标
                    expander_expanded = "", -- 展开状态图标
                    expander_highlight = "NeoTreeExpander",

                },
                name = { -- 文件名组件
                    use_git_status_colors = true, -- 使用 Git 状态颜色
                    trailing_slash = false, -- 文件夹名后不加斜线
                },
                icon = { -- 图标配置
                    folder_closed = "", -- 关闭文件夹图标
                    folder_empty = "", -- 空文件夹
                    folder_open = "", -- 打开文件夹图标
                    default = "", -- 默认文件图标
                },
                diagnostics = { -- 诊断符号配置
                    symbols = {
                        hint = "󰌶",
                        info = "󰋽",
                        warn = "󰀦",
                        error = "󰅚"
                    }
                },
                highlights = { -- 诊断高亮 (需定义对应的 highlight 组)
                    hint  = "DiagnosticSignHint",
                    info  = "DiagnosticSignInfo",
                    warn  = "NeoTreeDiagnosticError",
                    error = "DiagnosticSignError",
                },
                git_status = { -- Git 状态符号
                    symbols = {
                        added     = "✚", -- 新增文件
                        modified  = "", -- 修改文件
                        deleted   = "✖", -- 删除文件
                        renamed   = "󰁕", -- 重命名文件
                        untracked = "", -- 未跟踪文件
                        ignored   = "", -- 忽略文件
                        unstaged  = "󰄱", -- 未暂存
                        staged    = "", -- 已暂存
                        conflict  = "", -- 冲突文件
                    }
                },
            },
        })
        -- -- lua/config/neo-tree-highlights.lua
        -- -- 注意：需要在加载 neo-tree 之后调用此配置（建议放在 setup() 之后）

        -- -- 基础窗口样式
        -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#1a1b26" })      -- 主窗口背景色
        -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#1a1b26" })    -- 非活动窗口背景色
        -- vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#2a2c3c" })  -- 光标所在行背景色
        -- vim.api.nvim_set_hl(0, "NeoTreeSignColumn", { bg = "#1a1b26" })  -- 符号列背景
        -- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "#1a1b26" }) -- 窗口底部空白区域颜色

        -- -- 文件/目录显示
        -- vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#a9b1d6" })              -- 普通文件名颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#7aa2f7" })         -- 目录名颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#bb9af7", bold = true }) -- 根目录名称颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#bb9af7" })              -- 文件图标颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#7aa2f7" })         -- 目录图标颜色

        -- -- Git 相关高亮
        -- vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#98c379" })     -- 新增文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#e0af68" })  -- 修改文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#f7768e" })   -- 删除文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#ff9e64" })  -- 冲突文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#73daca" }) -- 未跟踪文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#545c7e" })   -- 忽略文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = "#98c379" })    -- 已暂存标记颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#e0af68" })  -- 未暂存标记颜色

        -- -- 特殊状态显示
        -- vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = "#545c7e" })            -- 点文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeHiddenByName", { fg = "#545c7e" })       -- 按名称隐藏的文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeWindowsHidden", { fg = "#545c7e" })      -- Windows 隐藏文件颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = "#2ac3de" }) -- 符号链接目标颜色

        -- -- 界面元素
        -- vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = "#3b4261", bg = "#1a1b26" }) -- 浮动窗口边框
        -- vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = "#7aa2f7", bg = "#3b4261" })  -- 浮动窗口标题
        -- vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = "#3b4261" })                    -- 标题栏背景
        -- vim.api.nvim_set_hl(0, "NeoTreeFilterTerm", { fg = "#bb9af7", bold = true })     -- 过滤搜索词颜色

        -- -- 结构辅助线
        -- vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#3b4261" }) -- 缩进辅助线颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#7aa2f7" })     -- 展开/折叠图标颜色

        -- -- 统计信息
        -- vim.api.nvim_set_hl(0, "NeoTreeStats", { fg = "#737aa2" })       -- 文件统计信息颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeStatsHeader", { fg = "#bb9af7" }) -- 统计标题颜色

        -- -- 窗口分隔符
        -- vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { fg = "#3b4261" })    -- 垂直分割线颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#3b4261" }) -- 窗口分隔符颜色

        -- -- 缓冲区源特有
        -- vim.api.nvim_set_hl(0, "NeoTreeBufferNumber", { fg = "#737aa2" }) -- 缓冲区编号颜色

        -- -- 其他辅助
        -- vim.api.nvim_set_hl(0, "NeoTreeDimText", { fg = "#545c7e" })      -- 次要文本颜色
        -- vim.api.nvim_set_hl(0, "NeoTreeStatusLine", { bg = "#1a1b26" })   -- 状态行背景色
        -- vim.api.nvim_set_hl(0, "NeoTreeStatusLineNC", { bg = "#1a1b26" }) -- 非活动状态行背景
    end
}
