
let g:cwordhl_disable_file_type = ["", "unite", "txt", "tmp"]
let g:cwordhl_enable = 1
let g:cwordhl_enable_source_name = ["current_word", "matchit", "indent"]

call cwordhl#start()

highlight link CurrentWord MatchParen
highlight link Indent      CursorColumn

