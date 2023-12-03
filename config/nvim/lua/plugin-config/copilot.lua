require('g')

g.copilot_no_tab_map = true

maps({
    {'i', '<A-Enter>', 'copilot#Accept("<A-Enter>")', {script=true,silent=true,expr=true}},
})
