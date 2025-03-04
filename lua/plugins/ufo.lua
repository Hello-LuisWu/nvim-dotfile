return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async'
    },
    config = function()
        -- 配置
        require('ufo').setup {
            provider_selector = function()
                return { 'treesitter', 'indent' } -- 优先使用 Treesitter
            end
        }

        -- 快捷键
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end

}
