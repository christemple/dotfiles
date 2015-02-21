set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
let g:vundle_default_git_proto = 'git'
call vundle#rc()

Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'craigemery/vim-autotag'
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/vitality.vim'
Bundle 'tomtom/tinykeymap_vim'
Bundle 'lchi/vim-toffee'

filetype plugin indent on
syntax on
" setting hidden allows undo to work after buffer was closed
set hidden
set noswapfile
set nobackup
set mouse=a
set nocompatible
set tabstop=2 shiftwidth=2 expandtab
set number
set nowrap
set backspace=indent,eol,start
set textwidth=0
set wrapmargin=0
set t_Co=256
set relativenumber
colorscheme molokai
set background=dark
map <C-n> :NERDTreeToggle<CR>
map ,n :NERDTreeFind<CR>
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = {
      \ 'types': {
          \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
      \ },
      \ 'fallback': 'find %s -type f'
  \ }
set cursorline
set wildignore=*.keep,*~,*.swp
" To quit all files quickly - useful for quitting 'git d' by holding down on Q
map Q :qa<CR>
au FileType css setl ofu=csscomplete#CompleteCSS
au FocusLost * :wa

" Use this to toggle between the last used 2 files
nmap <Tab> :b#<CR>

" Airline settings
let g:airline_powerline_fonts = 1
set laststatus=2

" Function and key mapping for running cucumber test
" ,t - Run scenario under cursor
" ,T - Run whole feature file
let mapleader = ","
autocmd FileType cucumber nmap <leader>t :call RunCucumberTest(line('.'))<CR>
autocmd FileType cucumber nmap <leader>T :call RunCucumberTest()<CR>
function! RunCucumberTest(...)
        let cmd = 'cd functional-test; bundle exec cucumber -r features'
        let @t = cmd . ' ' . s:featuresPath() . (a:0 == 1 ? ':'.line('.') : '')
        if strlen(@t > 0)
                execute ':wa'
                :call RunBashCommand(@t)
        elseif
                echoerr "No test command to run"
        endif
endfunction

function! RunBashCommand(cmd)
  execute ':!echo Running: "' . a:cmd . '"; bash --login -c "' . a:cmd . '"'
endfunction

function! s:featuresPath()
  return join(split(expand('%'),'/')[1:],'/')
endfunction

set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Auto remove all trailing characters
autocmd BufWritePre * :%s/\s\+$//e

set timeout         " Do time out on mappings and others
set timeoutlen=2000 " Wait {num} ms before timing out a mapping

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Format cucumber table
map \| :Tab /\|<CR>

" ,r - Run spec under cursor
autocmd FileType ruby nmap <leader>r :call RunRspecTest()<CR>
function! RunRspecTest()
  execute 'wa | !rspec ' . expand('%') . ':' . line('.')
endfunction

" ,R - Run whole spec file
autocmd FileType ruby nmap <leader>R :call RunAllRspecTests()<CR>
function! RunAllRspecTests()
  execute 'wa | !rspec %'
endfunction

