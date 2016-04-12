set ch=2
set nu
set nocompatible
set softtabstop=4

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set ruler  " show the cursor position all the time
set showcmd "display icomplete commands 
set incsearch

"set color scheme
"set background=dark
colorscheme desert

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


""""""""""""""""""""""""""""""""""""""""""
"  Plugins
""""""""""""""""""""""""""""""""""""""""""
""""""""""""  TagList """"""""""""
let Tlist_Show_One_File=1
let Exit_OnlyWindow=1
"set tags=/cygdrive/e/proot/ucode/0001/workareas/zhenghr/units/scu/source/ewarp/appl/tags

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
nnoremap <silent> <F12> :A<CR> 

"""""""" Grep """"""""""
nnoremap <silent> <F3> :Grep<CR>

"""""""  New-Omni-Completion """"""""
filetype plugin indent on
"set completeopt=longest,menu

"""""""" Super Tab """"""""""
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"


""""""""""""""""""""""""""""""""""""""""""
"  Programmings abbrevs
""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set backupdir=~/.vim/backup

au BufWinLeave *.txt mkview
au BufWinEnter *.txt silent loadview

let g:HiMtchBrktOn= 1
