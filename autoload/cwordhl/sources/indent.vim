
let s:save_cpo = &cpo
set cpo&vim

let s:indent_highlight = {
      \ 'name': 'indent',
      \ 'highlight': 'Indent', 
      \ 'priority': 10,
      \}

function! s:indent_highlight.pattern()
  let l:line = getline('.')
  let l:indent = matchstr(l:line, '^\zs\s\+\ze\S')
  let l:len = len(l:indent) - 1
  if l:len > 0
    return '^\s\{'. l:len . '}\zs\s\ze'
  else
    return '^\zs\s\ze'
  endif
endfunction
call cwordhl#define_source(s:indent_highlight)

function! cwordhl#sources#indent#define()
  return s:indent_highlight
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

