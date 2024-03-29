require 'g'
local m = {}
local opts = { noremap = true, silent = true }

function m.config()
    maps({
        { 'n', '<PageUp>', '<Cmd>BufferPrevious<CR>', opts },
        { 'n', '<PageDown>', '<Cmd>BufferNext<CR>', opts },
        { 'n', '<A-,>', ':BufferMovePrevious<CR>', opts },
        { 'n', '<A-.>', ':BufferMoveNext<CR>', opts },
        { 'n', '<A-0>', ':BufferCloseAllButCurrent<CR>', opts },
        { 'n', '<A-1>', ':BufferGoto 1<CR>', opts },
        { 'n', '<A-2>', ':BufferGoto 2<CR>', opts },
        { 'n', '<A-3>', ':BufferGoto 3<CR>', opts },
        { 'n', '<A-4>', ':BufferGoto 4<CR>', opts },
        { 'n', '<A-5>', ':BufferGoto 5<CR>', opts },
        { 'n', '<A-6>', ':BufferGoto 6<CR>', opts },
        { 'n', '<A-7>', ':BufferGoto 7<CR>', opts },
        { 'n', '<A-8>', ':BufferGoto 8<CR>', opts },
        { 'n', '<A-9>', ':BufferLast<CR>', opts },
        { 'n', '<A-x>', ':BufferClose<CR>', opts },
        { 'n', '<A-s>', ':BufferPick<CR>', opts },
        { 'n', '<A-=>', ':BufferPin<CR>', opts },
        { 'n', '<A-`>', ':BufferOrderByDirectory<CR>', opts },
        { 'n', '<A-~>', ':BufferOrderByLanguage<CR>', opts },
    })
end

return m
