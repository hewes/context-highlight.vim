
let s:save_cpo = &cpo
set cpo&vim

function! s:escape_text( text )
  return substitute( escape(a:text, '\' . '^$.*[~'), "\n", '\\n', 'ge' )
endfunction

let s:cword_highlight = {
      \ 'name': 'current_word',
      \ 'highlight': 'CurrentWord',
      \ 'priority': 10,
      \}

function! s:cword_highlight.pattern()
  let l:cwd = expand('<cword>')
  if empty(l:cwd)
    return ''
  else
    let l:regexp = s:escape_text(l:cwd)
    return l:cwd =~# '^\k\+$' ? '\<' . l:regexp . '\>' : l:regexp
  endif
endfunction

function! context_highlight#sources#cword#define()
  return s:cword_highlight
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
