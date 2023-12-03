require('g')

-- 自动命令
autocmds('Auto Back to Normal', {
    {{'BufLeave'}, {
        pattern = '*',
        command = 'call feedkeys("\\<Esc>")',
    }},
})
-- autocmds('Format Options', {
--     {'FileType',{
--         pattern = '*',
--         command = 'set fo-=ro',
--     }},
-- })
-- 选项设置
g.mapleader = " "
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
-- 键位映射
maps({
    -- 刷新配置文件
    { 'n', '<Leader>ss', '<Cmd>source $HOME/.config/nvim/init.lua<CR>', { noremap=true } },
    -- 光标移动
    { 'n', 'J', '5j', { noremap=true } },
    { 'n', 'K', '5k', { noremap=true } },
    { 'v', 'J', '5j', { noremap=true } },
    { 'v', 'K', '5k', { noremap=true } },
    { 'o', 'J', '5j', { noremap=true } },
    { 'o', 'K', '5k', { noremap=true } },
    { 'n', 'H', 'g0', { noremap=true } },
    { 'n', 'L', 'g$', { noremap=true } },
    { 'v', 'H', 'g0', { noremap=true } },
    { 'v', 'L', 'g$', { noremap=true } },
    -- 多光标
    { 'v', 'gb', '<Cmd>call VSCodeNotify("editor.action.addSelectionToNextFindMatch")<CR>', { noremap=true } },
    -- 代码跳转
    { 'n', 'gd', '<Cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>', { noremap=true } },
    { 'n', 'gD', '<Cmd>call VSCodeNotify("editor.action.goToDeclaration")<CR>', { noremap=true } },
    { 'n', 'gi', '<Cmd>call VSCodeNotify("editor.action.goToImplementation")<CR>', { noremap=true } },
    { 'n', 'gr', '<Cmd>call VSCodeNotify("editor.action.goToReferences")<CR>', { noremap=true } },
    { 'n', 'gt', '<Cmd>call VSCodeNotify("editor.action.goToTypeDefinition")<CR>', { noremap=true } },
    -- 缓冲区操作
    { 'n', '<Leader>bb', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>', { noremap=true } }, -- 显示所有正在编辑的文件
    { 'n', '<Leader>bd', '<Cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>', { noremap=true } }, -- 关闭当前正在编辑的文件
    { 'n', '<Leader>bh', '<Cmd>call VSCodeNotify("workbench.action.moveEditorToLeftGroup")<CR>', { noremap=true } }, -- 移动当前正在编辑的文件到左边
    { 'n', '<Leader>bj', '<Cmd>call VSCodeNotify("workbench.action.moveEditorToBelowGroup")<CR>', { noremap=true } },
    { 'n', '<Leader>bk', '<Cmd>call VSCodeNotify("workbench.action.moveEditorToAboveGroup")<CR>', { noremap=true } },
    { 'n', '<Leader>bl', '<Cmd>call VSCodeNotify("workbench.action.moveEditorToRightGroup")<CR>', { noremap=true } },
    { 'n', '<Leader>bm', '<Cmd>call VSCodeNotify("workbench.action.closeOtherEditors")<CR>', { noremap=true } }, -- 关闭其他已打开编辑器
    { 'n', '<Leader>bp', '<Cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>', { noremap=true } },
    { 'n', '<Leader>bn', '<Cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>', { noremap=true } },
    { 'n', '<Leader>bu', '<Cmd>call VSCodeNotify("workbench.action.reopenClosedEditor")<CR>', { noremap=true } },
    -- 代码缩略图
    { 'n', '<Leader>m', '<Cmd>call VSCodeNotify("editor.action.toggleMinimap")<CR>', { noremap=true } },
    --
    { 'n', '<Leader>n', '<Cmd>noh<CR>', { noremap=true } },
    -- 打开
    { 'n', '<Leader>od', '<Cmd>call VSCodeNotify("workbench.action.files.openFolder")<CR>', { noremap=true } },
    { 'n', '<Leader>or', '<Cmd>call VSCodeNotify("workbench.action.openRecent")<CR>', { noremap=true } },
    { 'n', '<Leader>of', '<Cmd>call VSCodeNotify("workbench.action.files.openFile")<CR>', { noremap=true } },
    -- 快速浏览
    { 'n', '<Leader>pd', '<Cmd>call VSCodeNotify("editor.action.peekDefinition")<CR>', { noremap=true } },
    { 'n', '<Leader>pD', '<Cmd>call VSCodeNotify("editor.action.peekDeclaration")<CR>', { noremap=true } },
    { 'n', '<Leader>pi', '<Cmd>call VSCodeNotify("editor.action.peekImplementation")<CR>', { noremap=true } },
    { 'n', '<Leader>pr', '<Cmd>call VSCodeNotify("editor.action.referenceSearch.trigger")<CR>', { noremap=true } },
    { 'n', '<Leader>pt', '<Cmd>call VSCodeNotify("editor.action.peekTypeDefinition")<CR>', { noremap=true } },
    -- 分割
    { 'n', '<Leader>v', '<Cmd>call VSCodeNotify("workbench.action.splitEditor")<CR>', { noremap=true } },
    { 'n', '<Leader>h', '<Cmd>call VSCodeNotify("workbench.action.splitEditorDown")<CR>', { noremap=true } },
})
