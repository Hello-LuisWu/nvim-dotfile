local function load_config_modules()
    local config_dir = vim.fn.stdpath('config') .. '/lua/config'
    local files = vim.fn.globpath(config_dir, '*.lua', false, true)
    for _, file in ipairs(files) do
        local module_name = vim.fn.fnamemodify(file, ':t:r')
        local status, _ = pcall(require, 'config.' .. module_name)
        if not status then
            vim.notify('Failed to load config module: ' .. module_name, vim.log.levels.WARN)
        end
    end
end
load_config_modules()
