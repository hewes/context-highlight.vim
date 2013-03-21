
let s:save_cpo = &cpo
set cpo&vim

let s:all_cword_highlights = {}

function! cwordhl#defined_sources()
  return s:all_cword_highlights
endfunction

function! cwordhl#define_source(src)
  if !has_key(s:all_cword_highlights, a:src.highlight)
    let s:all_cword_highlights[a:src.highlight] = {
          \ 'enable' : 1,
          \ 'sources' : [],
          \}
  endif
  call add(s:all_cword_highlights[a:src.highlight].sources, a:src)
  call sort(s:all_cword_highlights[a:src.highlight].sources, 's:compare_source')
endfunction

function! cwordhl#start()
  command! -bar ToggleCwordhl call s:toggle_auto_highlight()
  command! -bar StartCwordhl call s:start_highlight()

  augroup cwordhl
    autocmd!
    autocmd WinEnter,BufEnter * call s:check_enable_highlight_cword()
    autocmd CursorHold,CursorHoldI * call s:start_highlight()
  augroup END

  call s:load_sources()
endfunction

function! s:compare_source(i1, i2)
  return a:i1.priority == a:i2.priority ? 0 : a:i1.priority > a:i2.priority ? 1 : -1
endfunction

function! s:init_window_auto_highlight()
  let l:info = {}
  for highlight_kind in keys(s:all_cword_highlights)
    let l:info[highlight_kind] ={
          \ 'current_match_pattern' : '',
          \ 'current_match_id' : -1,
          \}
  endfor
  return l:info
endfunction

function! s:load_sources()
  for define in map(split(globpath(&runtimepath, 'autoload/cwordhl/sources/*.vim'), '\n'),
        \ "cwordhl#sources#{fnamemodify(v:val, ':t:r')}#define()")
    call cwordhl#define_source(define)
  endfor
endfunction

function! s:start_highlight()
  if !get(g:, "cwordhl_enable", 0) || index(get(g:, 'cowrdhl_disable_file_type', []), &filetype) >= 0
    return
  endif
  if !exists('w:auto_highlight_info')
    let w:auto_highlight_info = s:init_window_auto_highlight()
  endif
  for [item, value] in items(s:all_cword_highlights)
    for src in value.sources
      let l:pattern = src.pattern()
      if !empty(l:pattern)
        let l:target = w:auto_highlight_info[item]
        if l:target['current_match_pattern'] != l:pattern
          call s:clear_highlight(item)
          let l:target['current_match_pattern'] = l:pattern
          let l:target['current_match_id'] = matchadd(item, l:pattern, 0)
        endif
        break
      endif
    endfor
  endfor
endfunction

function! s:clear_highlight(kind)
  if exists('w:auto_highlight_info')
    if w:auto_highlight_info[a:kind].current_match_id >= 0
      call matchdelete(w:auto_highlight_info[a:kind].current_match_id)
      let w:auto_highlight_info[a:kind].current_match_id = -1
      let w:auto_highlight_info[a:kind].current_match_pattern = ''
    endif
  endif
endfunction

function! s:toggle_auto_highlight()
  let g:cwordhl_enable = !get(g:, "cwordhl_enable", 0)
  call s:check_enable_highlight_cword()
endfunction

function! s:check_enable_highlight_cword()
  if !g:cwordhl_enable
    for kind in keys(s:all_cword_highlights)
      call s:clear_highlight(kind)
    endfor
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

