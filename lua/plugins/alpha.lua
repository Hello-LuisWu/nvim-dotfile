return {
    "goolord/alpha-nvim",
    version = "bc5d57d",
    event = "VimEnter",
    enabled = true,
    keys = {
        { "<leader>a", mode = "n", "<cmd>Alpha<CR>", desc = "主页" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" }, -- 添加 telescope 依赖
    config = function()
        -- 获取 nvim 配置目录路径
        local config_dir = vim.fn.expand("~/.config/nvim")
        -- 获取 Lazy.nvim 启动时间
        local lazy_stats = require("lazy").stats()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- 自定义 ASCII 艺术 Logo
        local logo = [[
██╗     ██╗   ██╗██╗███████╗    ███████╗██████╗ ██╗████████╗ ██████╗ ██████╗
██║     ██║   ██║██║██╔════╝    ██╔════╝██╔══██╗██║╚══██╔══╝██╔═══██╗██╔══██╗
██║     ██║   ██║██║███████╗    █████╗  ██║  ██║██║   ██║   ██║   ██║██████╔╝
██║     ██║   ██║██║╚════██║    ██╔══╝  ██║  ██║██║   ██║   ██║   ██║██╔══██╗
███████╗╚██████╔╝██║███████║    ███████╗██████╔╝██║   ██║   ╚██████╔╝██║  ██║
╚══════╝ ╚═════╝ ╚═╝╚══════╝    ╚══════╝╚═════╝ ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝
    ]]

        -- Dashboard 配置
        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.buttons.val = {
            dashboard.button("e", "  新建文件", ":ene <BAR> startinsert <CR>"),
            dashboard.button("o", "  历史文件", ":lua require('telescope.builtin').oldfiles() <CR>"),
            dashboard.button("f", "󰈞  查找文件", ":lua require('telescope.builtin').find_files() <CR>"),
            dashboard.button("g", "  查找文本", ":lua require('telescope.builtin').live_grep() <CR>"),
            dashboard.button("c", "  配置文件", ":Telescope find_files cwd=" .. config_dir .. "<CR>"),
            dashboard.button("q", "󰅚  推出 NVIM", ":qa<CR>"),
        }

        -- 高级配置
        dashboard.config.opts.noautocmd = true
        vim.cmd([[autocmd User AlphaReady echo 'ready']])

        -- 应用配置
        alpha.setup(dashboard.config)
        -- 页脚配置（显示插件启动数量）
        dashboard.section.footer.val = {
            "",
            "Hello Luis, 🚀 your Lazy.nvim loaded " ..
            lazy_stats.loaded .. "/" .. lazy_stats.count .. " plugins. "
        }
        -- dashboard.section.footer.val = function()
        --   local stats = require("lazy").stats()
        --   return string.format("Loaded: %d/%d plugins", stats.loaded, stats.count)
        -- end
        -- 自动关闭 Lazy 窗口
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function()
                vim.cmd [[
        if winnr('$') == 1 && &filetype == 'lazy'
            q
        endif
        ]]
            end,
        })
    end,
}
