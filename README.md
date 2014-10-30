# context-highlight.vim

## Introduction

context-highlight.vim is a vim plugin for highlight according to cursor situatoin.

In default, this plugin provides 3 sources for highlight

- `current_word`
   highlight words in current buffer it is same word as cursor on.
- `matchit`
   highlight matchit word when cursor is on matchit keywords.
- `indent`
   highlight vertical line which has the same level indent as cursor is on.

In CursorHold and CursorHoldI, highlight some words related to current word.

## Install

Install the distributed files into your Vim script directory which is usually
$HOME/.vim,  or $HOME/vimfiles on Windows.

## Usage

### enable sources

set source names which you want to use to `g:context_highlight_enable_source_name`

    let g:context_highlight_enable_source_name = ["current_word", "indent", "matchit"]

### disable filetype

you can specify filetypes for disabling `context-highlight.vim`.
It is spcified as list of filetypes in `g:context_highlight_disable_file_type`.

    let g:context_highlight_disable_file_type = ["", "unite", "txt", "tmp"]

The string will be compared with `&filetype` of a buffer.

# Sources
## current_word
- pattern: expand('\<cword\>')
- highlight the words as `CurrentWord`

Highlight expand('\<cword\>') words on the current buffer.
This match pattern use highlight 

## matchit
- pattern: `execute normal %` pattern
- highlight the words as `CurrentWord`

When execute `normal %` and move to next word, highlight pair words of `b:match_words`.
It assumes that the macro of matchit is loaded.

## indent
- pattern: blanks on the last space of top on the line
- highlight name: `Indent`

