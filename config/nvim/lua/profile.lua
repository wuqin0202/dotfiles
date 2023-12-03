require('g')

-- 设置 leader 键为空格
g.mapleader = " "

opt.updatetime = 300    -- 单位 ms
-- 缩进对齐
opt.expandtab = true      -- tab 键替换为空格
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.shiftwidth=4
opt.tabstop=4
opt.softtabstop=4
-- 搜索
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
-- 外观
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 5
opt.signcolumn = "yes"  -- 行号合并
opt.termguicolors = true  -- 显示真彩色

-- 自动命令
autocmds('Format Options', {
    {'FileType',{
        pattern = '*',
        command = 'set fo-=ro',
    }},
})
