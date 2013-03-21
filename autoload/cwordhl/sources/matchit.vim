
let s:save_cpo = &cpo
set cpo&vim

let s:matchit_highlight = {
      \ 'name': 'matchit',
      \ 'highlight': 'CurrentWord', 
      \ 'priority': 9,
      \}

function! s:init_matchit()
  if !exists('b:match_words')
    return
  endif
  let l:mw = filter(split(b:match_words, ',\|:'), 'v:val !~ "^[(){}[\\]]$"')
  let b:reserved_regexp = join(l:mw, '\|')
  let mwre = '\%(' . b:reserved_regexp . '\)'
  let b:mwre = substitute(mwre, "'", "''", 'g')
endfunction

function! s:matchit_highlight.pattern()
  if !exists('b:match_words')
    return ''
  endif
  if !exists('b:reserved_regexp')
    call s:init_matchit()
  endif
  if expand("<cword>") !~ b:reserved_regexp || empty(b:reserved_regexp)
    return ''
  endif
  let lcs = []
  let wsv = winsaveview()
  while 1
    exe 'normal %'
    let lc = {'line': line('.'), 'col': col('.')}
    if len(lcs) > 0 && (lcs[0] == lc || lcs[-1] == lc)
      break
    endif
    call add(lcs, lc)
  endwhile
  call winrestview(wsv)

  call map(lcs, '"\\%" . v:val.line . "l\\%" . v:val.col . "c"')
  let lcre = join(lcs, '\|')
  " final \& part of the regexp is a hack to improve html
  return '.*\%(' . lcre . '\).*\&' . b:mwre
  "return '.*\%(' . lcre . '\).*\&' . b:mwre . '\&\% (<\_[^>]\+>\|.*\)'
endfunction

function! cwordhl#sources#matchit#define()
  return s:matchit_highlight
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

