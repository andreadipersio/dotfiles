set nocompatible 
filetype off

"
" Vundle
"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'git://github.com/tpope/vim-sensible.git'
Plugin 'git://github.com/mileszs/ack.vim.git'
Plugin 'git://github.com/ctrlpvim/ctrlp.vim.git'
Plugin 'git://github.com/vim-scripts/wombat256.vim'
Plugin 'git://github.com/fatih/vim-go.git'
Plugin 'elixir-editors/vim-elixir'
Plugin 'mhinz/vim-mix-format'
Plugin 'thinca/vim-ref'
Plugin 'slashmili/alchemist.vim'

call vundle#end()
filetype plugin indent on 

colorscheme wombat256mod

runtime! plugin/sensible.vim

"
" Go 
"

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_metalinter_enabled = ['gotype']
let g:go_metalinter_command = "--enable=gotype --enable=vet --vendor"


"
" Hide as much as possible
"
set laststatus=0
set noruler

"
" Tab behaviour
"

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

set runtimepath^=~/.vim/bundle/ctrlp.vim

"
" Keep track of changes to a file across sessions
"

set undofile
set undodir=~/.vim/undo

"
" Make ctrl-p use the_silver_searcher (ag)
"
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif
