set ch=2
set nu
set nocompatible
set softtabstop=4
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set ruler  " show the cursor position all the time
set showcmd "display icomplete commands 
set incsearch
set cursorline
set cursorcolumn

"set color scheme
"set t_Co=256
set background=dark
colorscheme default
"colorscheme darkblue
"colorscheme evening
"colorscheme morning
"colorscheme peachpuff

set backspace=2 "sel the flexibility of Backspace<BS> and Delete

set mouse=a  "set mouse function

set tabstop=4 "set tap width

set shiftwidth=4 "set auto shift width

set smartindent "set smart indent

syntax enable
syntax on

set hlsearch      "set high light search

filetype on "detect the type of file

set history=100 "how many line of history to rember

"set report=0   "tell us anything is changed via :... 

set showmatch "show matching brackets

set expandtab

"set spell
set showmatch
set incsearch
"set ignorecase
"set nowrap
set cursorline
if has("unnamedplus")
  set clipboard=unnamedplus
elseif has("clipboard")
  set clipboard=unnamed
endif

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
au BufRead,BufNewFile *.vx setfiletype verilog
au BufRead,BufNewFile *.mfs setfiletype c
au BufRead,BufNewFile *.epl setfiletype c
au BufRead,BufNewFile *.chc setfiletype c
""""""""""""""""""""""""""""""""""""""""""
"  Plugins
""""""""""""""""""""""""""""""""""""""""""
""""""""""""  TagList """"""""""""
let Tlist_Show_One_File=1
let Exit_OnlyWindow=1
set tags=$CMOD_TOP/tags
filetype plugin indent on
set completeopt=longest,menu
autocmd BufWritePost *.cpp :TlistUpdate
""""""""""""  Cscope """"""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-
cs add $CMOD_TOP/cscope.out $CMOD_TOP
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

""""""""""" WinManager """""""""""
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=40
let g:persistentBehaviour=0
nmap wm :WMToggle<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-f> :FirstExplorerWindow<cr>

""""""""" MiniBufExplore """"""""""
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>

"""""""" A Auto-open .h file """"""""""
nnoremap <silent> <F4> :A<CR> 

"""""""" Grep """"""""""
nnoremap <silent> <F3> :Grep<CR>

"""""""  New-Omni-Completion """"""""
filetype plugin indent on
map <C-_><F12> :!cd $CMOD_TOP;ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .;cscope -Rbq<CR>
"" configure tags - add additional tags here or comment out not-used ones
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
"" build tags of your own project with Ctrl-F12

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

"""""""" Super Tab """"""""""
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-P>"


""""""""""""""""""""""""""""""""""""""""""
"  Programmings abbrevs
""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set backupdir=~/.vim/backup

au BufWinLeave *.txt mkview
au BufWinEnter *.txt silent loadview

let g:HiMtchBrktOn= 1

:map <M-Esc>[62~ <MouseDown>
:map! <M-Esc>[62~ <MouseDown>
:map <M-Esc>[63~ <MouseUp>
:map! <M-Esc>[63~ <MouseUp>
:map <M-Esc>[64~ <S-MouseDown>
:map! <M-Esc>[64~ <S-MouseDown>
:map <M-Esc>[65~ <S-MouseUp>
:map! <M-Esc>[65~ <S-MouseUp>

