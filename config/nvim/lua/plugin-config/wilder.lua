require('g')
local m = {}

function m.setup()
    local wilder = require('wilder')
    wilder.setup({
        modes = { '/', '?', ':' },
    })
    wilder.set_option('pipeline', {
        wilder.branch(
            {
                wilder.check(function (_, x)
                    return fn.empty(x)
                end),
                wilder.history(15),
            },
            wilder.cmdline_pipeline({
                fuzzy = 1,
                fuzzy_filter = wilder.vim_fuzzy_filter(),
            }),
            wilder.search_pipeline()
        ),
        wilder.debounce(10)
    })
    wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
            highlights = {
                accent = "WilderAccent",
                selected_accent = "WilderSelectedAccent",
            },
            highlighter = wilder.basic_highlighter(),
            left = { ' ', wilder.popupmenu_devicons() },
            right = { ' ', wilder.popupmenu_scrollbar() },
            border = 'rounded',
            max_height = 17 -- 最大高度限制 因为要计算上下 所以17支持最多15个选项
        })
    ))
end

return m
