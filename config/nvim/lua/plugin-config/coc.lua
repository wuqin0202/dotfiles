require('g')
-- 插件安装
g.coc_global_extensions =
{
    'coc-marketplace',
    'coc-lua', 'coc-clangd', 'coc-jedi', 'coc-vimlsp', 'coc-sh',
    'coc-json', 'coc-xml',
    'coc-translator',
    'coc-pairs',
}
-- 键位映射
maps({
    -- 代码跳转
    { "n", "gd", "<Plug>(coc-definition)", {silent=true} },         -- normal 模式下 gd 跳转到定义
    { "n", "gy", "<Plug>(coc-type-definition)", {silent=true} },    -- normal 模式下 gy 跳转到类型定义
    { "n", "gi", "<Plug>(coc-implementation)", {silent=true} },     -- normal 模式下 gi 跳转到实现
    { "n", "gr", "<Plug>(coc-references)", {silent=true} },         -- normal 模式下 gr 跳转到引用
    { "n", "<c-k>", "<Plug>(coc-diagnostic-prev)", {silent=true} }, -- normal 模式下 空格+- 跳转到上一条报错
    { "n", "<c-j>", "<Plug>(coc-diagnostic-next)", {silent=true} }, -- normal 模式下 空格+= 跳转到下一条报错
    -- 智能选择
    { 'x', 'if', '<Plug>(coc-funcobj-i)', {silent = true} },
    { 'o', 'if', '<Plug>(coc-funcobj-i)', {silent = true} },
    { 'x', 'af', '<Plug>(coc-funcobj-a)', {silent = true} },
    { 'o', 'af', '<Plug>(coc-funcobj-a)', {silent = true} },
    { 'x', 'ic', '<Plug>(coc-classobj-i)', {silent = true} },
    { 'o', 'ic', '<Plug>(coc-classobj-i)', {silent = true} },
    { 'x', 'ac', '<Plug>(coc-classobj-a)', {silent = true} },
    { 'o', 'ac', '<Plug>(coc-classobj-a)', {silent = true} },
    -- 代码补全
    { 'i', '<TAB>', "coc#pum#visible() ? coc#pum#next(1) : col('.') == 1 || getline('.')[col('.') - 2] =~# '\\W' ? \"\\<TAB>\" : coc#refresh()", {silent=true, noremap=true, expr=true} },
    { 'i', '<s-tab>', "coc#pum#visible() ? coc#pum#prev(1) : \"\\<s-tab>\"", {silent=true, noremap=true, expr=true} },
    -- 代码重构
    { "n", "<F2>", "<Plug>(coc-rename)", {silent=true} },     -- nromal 模式下 <F2> 变量重命名
    -- 预览浮动窗口上下滑动
    { "n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', {silent=true, nowait=true, expr=true} },
    { "n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', {silent=true, nowait=true, expr=true} },
    { "i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', {silent=true, nowait=true, expr=true} },
    { "i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', {silent=true, nowait=true, expr=true} },
    { "v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', {silent=true, nowait=true, expr=true} },
    { "v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', {silent=true, nowait=true, expr=true} },
    -- 翻译
    { 'n', 'ss', "<Plug>(coc-translator-p)", {silent=true} },
    { 'v', 'ss', "<Plug>(coc-translator-pv)", {silent=true} },
    -- 显示帮助
    { 'n', 'gh', '<Cmd>call CocAction("doHover")<CR>', {silent=true} },
})
-- 外观
cmd("hi! link CocPum Pmenu")
cmd("hi! link CocMenuSel PmenuSel")
-- 高亮光标下的单词
api.nvim_create_augroup("CocGroup", {})
api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
