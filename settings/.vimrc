set nu
set ruler  " show the cursor position all the time
set nocompatible
set softtabstop=4
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"set backspace=2 "sel the flexibility of Backspace<BS> and Delete
set tabstop=4 "set tap width
set shiftwidth=4 "set auto shift width
set smartindent "set smart indent
set expandtab
set et|retab
set showcmd "display icomplete commands 
set incsearch
set hlsearch      "set high light search
set nobackup
set nowb
set backupdir=~/.vim/backup
set history=100 "how many line of history to rember
set showmatch "show matching brackets
"set spell
"set autochdir
"set ignorecase
"set nowrap
set ttymouse=xterm2
set mouse=a  "set mouse function

syntax on
set background=dark
colorscheme gruvbox
"colorscheme desert
"colorscheme molokai
"colorscheme solarized
"colorscheme dracula
if &diff  
    colorscheme gruvbox
endif

filetype plugin indent on

"syntax on

set cursorline
set cursorcolumn
"hi cursorline cterm=NONE ctermbg=darkgrey guibg=darkgrey guifg=white
"hi cursorcolumn cterm=NONE ctermbg=darkgrey guibg=darkgrey guifg=white

filetype on "detect the type of file


"set report=0   "tell us anything is changed via :... 

"if has("unnamedplus")
"  set clipboard=unnamedplus
"elseif has("clipboard")
set clipboard=unnamed
"endif

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
au BufRead,BufNewFile *.vx setfiletype verilog
au BufRead,BufNewFile *.mfs setfiletype c
au BufRead,BufNewFile *.epl setfiletype c
au BufRead,BufNewFile *.chc setfiletype c
au BufRead,BufNewFile *.md  set filetype=
""""""""""""""""""""""""""""""""""""""""""
"  Plugins
""""""""""""""""""""""""""""""""""""""""""
""""""""""""" ctags """"""""""""""""""
set tags=$CMOD_TOP/tags,$TREE_TRACE/tags
"" configure tags - add additional tags here or comment out not-used ones
"set tags+=~/.vim/tags/cpp
"" build tags of your own project with Ctrl-F12
nmap <C-_><F12> :!cd $CMOD_TOP;ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --exclude="g*_Linux_x86*" --exclude="vmod*" --exclude="syn" --exclude="gpu" --exclude="tool*" --exclude="*uvm*" --exclude="diag*" --extra=+q .;cscope -Rbq<CR>
nmap <F5> :vertical stjump 
"nmap <F6> :vertical stag 
nmap <F7> :ts
set splitright
"set splitbelow

""""""""""""  Cscope """"""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-
"silent cs add $CMOD_TOP/cscope.out $CMOD_TOP
"Find this C symbol: func name, macros, enum etc
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"Find this definition
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"Find functions calling this function
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"Find assignments to
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"Find this egrep pattern
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"Find this file
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"Find files #including this file
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
"Find functions called by this function
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

""""""""""""  TagList """"""""""""
let Tlist_Show_One_File=1
let Exit_OnlyWindow=1
set completeopt=longest,menu
autocmd BufWritePost *.cpp :TlistUpdate

""""""""""" WinManager """""""""""
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=40
let g:persistentBehaviour=0
nmap wm :WMToggle<cr>

""""""""" MiniBufExplore """"""""""
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
"nmap <F6> :cn<cr>
"nmap <F7> :cp<cr>

"""""""" A Auto-open .h file """"""""""
nnoremap <silent> <F4> :A<CR> 

"""""""" Grep """"""""""
nnoremap <silent> <F3> :Rgrep<CR>

"""""""" Super Tab """"""""""
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-P>"

""""""""""""""""""""""""""""""""""""""""""
"  Programmings abbrevs
""""""""""""""""""""""""""""""""""""""""""
"au BufWinLeave *.txt mkview
"au BufWinEnter *.txt silent loadview
"
"let g:HiMtchBrktOn= 1
"
":map <M-Esc>[62~ <MouseDown>
":map! <M-Esc>[62~ <MouseDown>
":map <M-Esc>[63~ <MouseUp>
":map! <M-Esc>[63~ <MouseUp>
":map <M-Esc>[64~ <S-MouseDown>
":map! <M-Esc>[64~ <S-MouseDown>
":map <M-Esc>[65~ <S-MouseUp>
":map! <M-Esc>[65~ <S-MouseUp>
"
"let g:netrw_dirhistmax=0

"" YCM
"set nocompatible              " be iMproved, required
"filetype off                  " required
"set rtp+=~/.vim/bundle/Vundle.vim
"
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"call vundle#end()            " required
"
"filetype plugin indent on    " required
"nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
"nnoremap <leader>gt :YcmCompleter GetType<CR>
"nnoremap <leader>gp :YcmCompleter GetParent<CR>

" replace tab with space
":retab
" paste mode, no autoindent
"set paste

map ,k :pyf ~/clang-format.py<CR>
"function! Formatonsave()
"  let l:formatdiff = 1
"  pyf ~/clang-format.py
"endfunction
"autocmd BufWritePre *.hpp,*.h,*.cc,*.cpp call Formatonsave()

