
let g:cwordhl_disable_file_type = ["", "unite", "txt", "tmp"]
let g:cwordhl_enable = 1

call cwordhl#start()

highlight CurrentWord term=NONE ctermbg=52  ctermfg=NONE guibg=darkred
highlight Indent      term=NONE ctermbg=238 ctermfg=NONE guibg=#444444 guifg=NONE

