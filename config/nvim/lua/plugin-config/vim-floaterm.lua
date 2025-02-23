require('g')
local m = {}
-- run code
function m.floaterm_run_code()
    cmd('w')
    local filetype = bo.filetype
    if filetype == 'python' then
        cmd('FloatermNew python %')
    elseif filetype == 'cpp' then
        cmd('FloatermNew g++ % -o %:r && ./%:r')
    elseif filetype == 'c' then
        cmd('FloatermNew gcc % -o %:r && ./%:r')
    elseif filetype == 'java' then
        cmd('FloatermNew javac % && java %:r')
    elseif filetype == 'go' then
        cmd('FloatermNew go run %')
    elseif filetype == 'rust' then
        cmd('FloatermNew rustc % && ./%:r')
    elseif filetype == 'javascript' then
        cmd('FloatermNew node %')
    elseif filetype == 'typescript' then
        cmd('FloatermNew ts-node %')
    elseif filetype == 'html' then
        cmd('FloatermNew --silent chromium %')
    elseif filetype == 'css' then
        cmd('FloatermNew --silent chromium %')
    elseif filetype == 'sh' then
        cmd('FloatermNew bash %')
    elseif filetype == 'lua' then
        cmd('FloatermNew lua %')
    elseif filetype == 'vim' then
        cmd('FloatermNew vim %')
    elseif filetype == 'markdown' then
        cmd('MarkdownPreview')
    elseif filetype == 'json' then
        cmd('FloatermNew --silent chromium %')
    elseif filetype == 'yaml' then
        cmd('FloatermNew --silent chromium %')
    elseif filetype == 'toml' then
        cmd('FloatermNew --silent chromium %')
    elseif filetype == 'xml' then
        cmd('FloatermNew --silent chromium %')
    elseif filetype == 'sql' then
        cmd('FloatermNew sqlite3 %')
    elseif filetype == 'php' then
        cmd('FloatermNew php %')
    elseif filetype == 'ruby' then
        cmd('FloatermNew ruby %')
    elseif filetype == 'perl' then
        cmd('FloatermNew perl %')
    elseif filetype == 'bash' then
        cmd('FloatermNew bash %')
    elseif filetype == 'zsh' then
        cmd('FloatermNew zsh %')
    end
end

function m.floaterm_inter_run()
    local filetype = bo.filetype
    if filetype == 'python' then
        cmd('FloatermNew --name=repl --wintype=vsplit --position=right --width=0.3 ipython')
    end
end

function m.floaterm_send_select()
    -- 判断名为repl的floaterm终端是否存在
    local repl = vim.fn['floaterm#terminal#exists']('repl')
    if repl == 1 then
        -- 获取选中的文本
        local text = vim.fn.getreg('v')
        -- 发送选中的文本到repl终端
        cmd('FloatermSend --name=repl ' .. text)
    end
end
--
g.floaterm_title = ''
g.floaterm_width = 0.6
g.floaterm_height = 0.6
g.floaterm_autoclose = 0
--  键位映射
maps({
    { 'n', '<Leader>tn', '<Cmd>FloatermNew<CR>', { noremap=true, silent=true } },
    { 'n', '<Leader>tk', '<Cmd>FloatermKill<CR>', { noremap=true, silent=true } },
    { 'n', '<C-t>', '<Cmd>FloatermToggle<CR>', { noremap=true, silent=true } },
    { 't', '<C-t>', '<Cmd>FloatermToggle<CR>', { noremap=true, silent=true } },
    { 'n', '<F5>', '<Cmd>lua require("plugin-config/vim-floaterm").floaterm_run_code()<CR>', { noremap=true, silent=true } },
    { 'i', '<F5>', '<ESC><Cmd>lua require("plugin-config/vim-floaterm").floaterm_run_code()<CR>', { noremap=true, silent=true } },
    { 'n', '<A-F5>', '<Cmd>lua require("plugin-config/vim-floaterm").floaterm_inter_run()<CR>', { noremap=true, silent=true } },
    { 'i', '<A-F5>', '<ESC><Cmd>lua require("plugin-config/vim-floaterm").floaterm_inter_run()<CR>', { noremap=true, silent=true } },
    { 'v', 'si', '<Cmd>lua require("plugin-config/vim-floaterm").floaterm_send_select()<CR>', { noremap=true, silent=true } },
})
-- 浮动终端边框颜色
cmd('hi FloatermBorder guifg=cyan')
-- floaterm 窗口不显示行号
autocmds('Floaterm', {
    {
        {'FileType'}, {
            pattern = 'floaterm',
            command = 'setl norelativenumber signcolumn=no nonumber',
        },
    },
})
-- python 设置
--function m.auto_start_ipython()
--    if os.getenv('CONDA_SHLVL') then
--        cmd('FloatermNew --name=repl --position=right --width=0.35 --wintype=vsplit ipython')
--    end
--end
--autocmd('FileType', {
--    pattern = 'python',
--    callback = m.auto_start_ipython,
--})

return m
