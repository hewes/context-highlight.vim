# cwordhl.vim

## Introduction

cwordhl.vim is a vim plugin for highlighting current word

In default, this plugin provides 3 sources for highlight

- current_word
- matchit
- indent

In CursorHold and CursorHoldI, highlight some words related to current word.

## Install

Install the distributed files into your Vim script directory which is usually
$HOME/.vim,  or $HOME/vimfiles on Windows.

## Usage

### enable sources

set source names which you want to use to *g:cwordhl_enable_source_name*

    let g:cwordhl_enable_source_name = ["current_word", "indent", "matchit"]

### disable filetype

set filetype you don't want to use cwordhl to *g:cwordhl_disable_file_type*

    let g:cwordhl_disable_file_type = ["", "unite", "txt", "tmp"]

The string will be compared with &filetype of a buffer.

# Sources
## current_word
- pattern:
   expand('\<cword\>')
- highlight name:
   CurrentWord

Highlight expand('\<cword\>') words on the current buffer.
This match pattern use highlight 

## matchit
- pattern:
   *execute normal %* pattern
- highlight name:
   CurrentWord

When execute *normal %* and move to next word, highlight pair words of *b:match_words*.
It assume that macro of matchit is loaded.
This match pattern use highlight CurrentWord

## indent
- pattern:
   space on the last space of top on the line
- highlight name:
   Indent

