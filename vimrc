set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'

Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'iamcco/markdown-preview.nvim'

Plugin 'peterhoeg/vim-qml'
" Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

packadd! termdebug
let g:termdebug_wide=1
au User TermdebugStartPost call TermDebugSendCommand('source .gdbinit')


filetype off

" set tabstop=4 shiftwidth=4 expandtab
set autoindent noexpandtab tabstop=4 shiftwidth=4
set number
set list
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
hi Search cterm=NONE ctermfg=white ctermbg=darkBlue

set mouse-=a

execute pathogen#infect()

" All about the NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close if last closed

" All about the vim-devicons
filetype plugin indent on 
" These are the basic settings to get the font to work (required):
""set guifont=DroidSansMono\ Nerd\ Font:h12
""set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
""set GuiFont Droid Sans Mono for Powerline Nerd Font Complete:h12
""set guifont=DroidSansMono\ Nerd\ Font\ 11
set guifont=Anonymice\ Nerd\ Font\ Mono\ 13
set encoding=utf-8
" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>ji :YcmCompleter GoToImplementation<CR>
nnoremap <leader>ja :YcmCompleter GoToAlternateFile<CR>
nnoremap <leader>jr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>jRw <cmd>execute 'YcmCompleter RefactorRename' input( 'Rename to: ' )<CR>
map <F9> :YcmCompleter FixIt<CR>

augroup python_files
    autocmd!
    autocmd FileType python setlocal noexpandtab
    autocmd FileType python set tabstop=4
    autocmd FileType python set shiftwidth=4
augroup END

set autoread
