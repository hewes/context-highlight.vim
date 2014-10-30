
let g:context_highlight_disable_file_type = ["", "unite", "txt", "tmp"]
let g:context_highlight_enable = 1
let g:context_highlight_enable_source_name = ["current_word", "matchit", "indent"]

call context_highlight#start()

highlight link CurrentWord MatchParen
highlight link Indent      CursorColumn

