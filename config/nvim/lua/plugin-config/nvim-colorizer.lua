local G = require('g')
local M = {}

function M.setup()
    --
    G.map('n', '<Leader>c', '<Cmd>ColorizerToggle<CR>', { noremap=true })
end

function M.config()
    --
end

return M
