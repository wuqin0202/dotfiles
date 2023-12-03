require('g')
maps({
    -- 退出终端模式
    { 't', '<Esc>', '<C-\\><C-n>', { noremap=true } },
    -- 光标移动
    { 'n', 'j', 'gj', { noremap=true } },
    { 'n', 'k', 'gk', { noremap=true } },
    { 'n', 'J', '5j', { noremap=true } },
    { 'n', 'K', '5k', { noremap=true } },
    { 'v', 'J', '5j', { noremap=true } },
    { 'v', 'K', '5k', { noremap=true } },
    -- 保存
    { 'n', '<C-s>', '<Cmd>w<CR>', { noremap=true } },
    -- 退出
    { 'n', 'Q', '<Cmd>qa<CR>', { noremap=true } },
    ---- 标签切换
    --{ 'n', '<PageDown>', '<Cmd>tabn<CR>', { noremap=true } },
    --{ 'n', '<PageUp>', '<Cmd>tabp<CR>', { noremap=true } },
    ---- 缓冲区切换
    --{ 'n', '<A-PageDown>', '<Cmd>bnext<CR>', { noremap=true } },
    --{ 'n', '<A-PageUp>', '<Cmd>bprevious<CR>', { noremap=true } },
    -- 分屏聚焦
    { 'n', '<A-k>', '<C-w>k', { noremap=true } },
    { 'n', '<A-j>', '<C-w>j', { noremap=true } },
    { 'n', '<A-h>', '<C-w>h', { noremap=true } },
    { 'n', '<A-l>', '<C-w>l', { noremap=true } },
    { 't', '<A-k>', '<C-\\><C-n><C-w>k', { noremap=true } },
    { 't', '<A-j>', '<C-\\><C-n><C-w>j', { noremap=true } },
    { 't', '<A-h>', '<C-\\><C-n><C-w>h', { noremap=true } },
    { 't', '<A-l>', '<C-\\><C-n><C-w>l', { noremap=true } },
})
