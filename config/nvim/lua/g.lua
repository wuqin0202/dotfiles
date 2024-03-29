opt = vim.opt
api = vim.api
fn = vim.fn
g = vim.g
o = vim.o
bo = vim.bo

diagnostic = vim.diagnostic
log = vim.log

cmd = api.nvim_command
map = api.nvim_set_keymap
exec = api.nvim_exec

function maps(_maps)
    for _,_map in pairs(_maps) do
        map(_map[1], _map[2], _map[3], _map[4])
    end
end

function autocmds(group_name, cmds, clear)
    api.nvim_create_augroup(group_name, {clear=clear})
    for _,cmd in pairs(cmds) do
        cmd[2].group = group_name
        api.nvim_create_autocmd(cmd[1], cmd[2])
    end
end

