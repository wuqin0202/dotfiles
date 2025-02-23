require('g')

maps({
    { 'n', '<leader>mm', '<Plug>MarkdownPreviewToggle', {silent=true,noremap=true} },
    { 'n', '<leader>ms', '<Plug>MarkdownPreview', {silent=true,noremap=true} },
    { 'n', '<leader>me', '<Plug>MarkdownPreviewStop', {silent=true,noremap=true} },
})

g.mkdp_filetypes = { "markdown" }
g.mkdp_browser = "wyeb"       -- 指定浏览器
g.mkdp_auto_start = 0         -- 1 为打开 markdown 文件自动预览
g.mkdp_auto_close = 0         -- 1 为自动关闭
g.mkdp_refresh_slow = 0       -- 0 为光标移动时自动更新预览，1 为写入文件时
g.mkdp_command_for_global = 0 -- 1 所有文件都可用 MarkdownPreview 命令
g.mkdp_open_to_the_world = 0  -- 1 为其他人可访问预览
g.mkdp_open_ip = ''           -- 指定预览的 ip 地址
g.mkdp_echo_preview_url = 0   -- 1 为预览时打印 url
g.mkdp_browserfunc = ''       -- 指定 vim 函数名来打开预览页面，函数接收一个 url 参数
g.mkdp_preview_options = {
    mkit={},                  -- markdown-it options for render
    katex={},                 -- katex 选项
    uml={},                   -- markdown-it-plantuml options
    maid={},                  -- mermaid 选项
    disable_sync_scroll=0,    -- 关闭同步滚动
    sync_scroll_type='middle',-- 取值 ‘top’ ‘relative’
    hide_yaml_meta=1,         -- 隐藏 yaml 元数据
    sequence_diagrams={},     -- js-sequence-diagrams options
    flowchart_diagrams={},
    content_editable=false,   -- 预览页面是否可编辑
    disable_filename=0,
    toc={}
 }
g.mkdp_markdown_css = ''      -- 预览 css 样式路径
g.mkdp_highlight_css = ''     -- 高亮 css 路径
g.mkdp_port = ''              -- 指定端口号，空为随机分配
g.mkdp_page_title = '「${name}」' -- 预览页面标题，${name} 将替换为文件名
g.mkdp_filetypes = {'markdown'} -- 指定哪些文件类型可用 MarkdownPreview 命令
g.mkdp_theme = 'dark'         -- 预览主题

