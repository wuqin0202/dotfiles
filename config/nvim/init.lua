if vim.g.vscode then
    package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '/lua/?.lua'
    require('vscode_config')
    require('lazyplugins')
else
    require('profile')
    require('keymap')
end
