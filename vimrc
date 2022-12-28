set number
set title 
set showmatch
set runtimepath+=/usr/local/Cellar/vim/8.1.2400/share/vim/vim81
source $VIMRUNTIME/macros/matchit.vim 
set backspace=indent,eol,start
syntax on
set tabstop=4
set smartindent 
set ruler
" 改行を無くす
set nofixeol

set nocompatible
filetype off

set wildmenu
set history=5000

set ignorecase 
set smartcase 
set wrapscan 

set list
set listchars=tab:»-,extends:»,precedes:«,nbsp:%
if has("syntax")
    syntax on
    syn sync fromstart
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    endfunction 
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

set expandtab

set nocompatible
filetype off

call plug#begin()
Plug 'tpope/vim-sensible'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'preservim/nerdtree'
" Multiple commands
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }

" Loaded when clojure file is opened
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Multiple file types
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }

" On-demand loading on both conditions
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }

" Code to execute when the plugin is lazily loaded on demand
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
autocmd! User goyo.vim echom 'Goyo is now loaded!'
call plug#end()

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

"insert here your Neobundle plugins
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'hashivim/vim-terraform'
call neobundle#end()

let g:terraform_align=1
let g:terraform_fmt_on_save = 1
let g:terraform_fold_sections=1
"====for nerd tree setting====
"info:https://github.com/kumonopanya/dotfiles/blob/master/.vim/userautoload/NERDTree.vim

nnoremap <silent><C-e> :NERDTreeToggle<CR>
autocmd vimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif                        
let NERDTreeShowBookmarks=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"NERDTreeIgnore	無視するファイルを設定する。
"'\.vim$'ならばfugitive.vimなどのファイル名が表示されない。
"\ エスケープ記号
"$ ファイル名の最後
"f コマンドの設定値
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
"let g:NERDTreeIgnore=['\.vim$', '\.clean$']
"let g:NERDTreeIgnore=['\.vim$', '\~$']
"let g:NERDTreeIgnore=[]

"NERDTreeShowHidden	隠しファイルを表示するか？
"I コマンドの設定値
"0 : 隠しファイルを表示しない。
"1 : 隠しファイルを表示する。
"Values: 0 or 1.
"Default: 0.
let g:NERDTreeShowHidden=1

filetype plugin indent on


"ディレクトリだけ表示してファイル名は隠す。
"ファイルの表示、非表示をトグルするときの初期値。
"F コマンドの設定初期値
"0 : 最初からファイルを表示しない。
"1 : 最初からファイルを表示する。
"Values: 0 or 1.
"Default: 1.
"let g:NERDTreeShowFiles=0
"let g:NERDTreeShowFiles=1

"カーソルラインをハイライト表示する。
"（カラースキーマが優先される？）
"0 : 色付けしない。
"1 : カラー表示をする。
"Values: 0 or 1.
"Default: 1.
"let g:NERDTreeHighlightCursorline=0
"let g:NERDTreeHighlightCursorline=1

"ブックマークリストの表示。
"0 : ブックマークリストを最初から表示しない。
"1 : ブックマークリストを最初から表示する。
"Values: 0 or 1.
"Default: 0.
"let g:NERDTreeShowBookmarks=0
"let g:NERDTreeShowBookmarks=1

"NERDTreeのツリーを開く場所、左側か、右側か。
"Values: "left" or "right"
"Default: "left".
"let g:NERDTreeWinPos="left"
"let g:NERDTreeWinPos="right"

"NERDTreeのツリーの幅
"Default: 31.
"let g:NERDTreeWinSize=45

"ブックマークや、ヘルプのショートカットをメニューに表示する。
"0 表示する
"1 表示しない
"Values: 0 or 1.
"Default: 1.
let g:NERDTreeMinimalUI=0
"let g:NERDTreeMinimalUI=1

"NERDTreeを+|`などを使ってツリー表示をする。
"ディレクトリが閉じている場合には+を先頭につける。
"ディレクトリが開いている場合には~を先頭につける。
"ファイルには-を先頭につける。
"0 : 綺麗に見せる。
"1 : +|`などを使わない
"Values: 0 or 1
"Default: 1.
let g:NERDTreeDirArrows=0
"let g:NERDTreeDirArrows=1

"マウス操作方法
"NERDTreeMouseMode
"Values: 1, 2 or 3.
"Default: 1.
"1 : ファイル、ディレクトリ両方共ダブルクリックで開く。
"2 : ディレクトリのみシングルクリックで開く。
"3 : ファイル、ディレクトリ両方共シングルクリックで開く。
let g:NERDTreeMouseMode=1
"let g:NERDTreeMouseMode=2
"let g:NERDTreeMouseMode=3

"NERDTreeBookmarksFile
"ブックマークを記録したファイルの設置場所を指定。
"Values: a path
"Default: $HOME/.NERDTreeBookmarks

"NERDTreeShowLineNumbers
"0 : 行番号を表示しない。
"1 : 行番号を表示する。
"Values: 0 or 1.
"Default: 0.
"let NERDTreeShowLineNumbers=0
"let NERDTreeShowLineNumbers=1

"NERDTreeStatusline		NERDtreeウィンドウにステータスラインを表示。
"Values: Any valid statusline setting.
"Default: %{b:NERDTreeRoot.path.strForOS(0)}

"==========



