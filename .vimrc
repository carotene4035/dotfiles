nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>


"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
"
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

 " NERDTreeを設定
NeoBundle 'scrooloose/nerdtree' 
NeoBundle 'Shougo/unite.vim' 
NeoBundle 'Shougo/neomru.vim' 
NeoBundle 'Townk/vim-autoclose' 
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
nnoremap <silent><C-e> :VimFiler -split -simple -winwidth=35 -no-quit<CR>
NeoBundle 'mattn/emmet-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'miyakogi/seiya.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kana/vim-submode'
NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Space><Space>'
let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm'

"NeoBundle 'Yggdroot/indentline'
"let g:indentLine_faster = 1
"nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

NeoBundle 'YankRing.vim'
nmap ,y :YRShow<CR>

" phpコーディング規約に従って修正
NeoBundleLazy 'stephpy/vim-php-cs-fixer', {
            \   'autoload'  : {
            \        'filetypes': 'php',},}
let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')
function! s:hooks.on_source(bundle)
    let g:php_cs_fixer_path = '$HOME/.vim/phpCsFixer/php-cs-fixer'
    let g:php_cs_fixer_level = 'all'
    let g:php_cs_fixer_config = 'default'
    let g:php_cs_fixer_php_path = 'php'
    let g:php_cs_fixer_enable_default_mapping = 1
    let g:php_cs_fixer_dry_run = 0
    let g:php_cs_fixer_verbose = 0

    nnoremap <Leader>php :call PhpCsFixerFixFile()<CR>
endfunction
unlet s:hooks


" color schemeを設定
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'
NeoBundle 'evidens/vim-twig'

call neobundle#end()

 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------



"-------------------------
" emmet settings
"-------------------------

let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<C-Y>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
    \ 'lang' : 'ja',
    \ 'html' : {
    \   'filters' : 'html',
    \ },
    \ 'css' : {
    \   'filters' : 'fc',
    \ },
    \ 'php' : {
    \   'extends' : 'html',
    \   'filters' : 'html',
    \ },
    \}
augroup EmmitVim
	autocmd!
	autocmd FileType * let g:user_emmet_settings.indentation = '               '[:&tabstop]
augroup END


"-------------------------
" lightline settings
"-------------------------
let g:lightline = {
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [['mode','paste'],['fugitive','filename']]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ }
      \ }


function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction


function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%') ? expand('%') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction


function! LightLineFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction


function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction


function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction


function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction


function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;


noremap <Leader><Leader> :up<CR>

noremap <CR> o<ESC>

imap <C-f> <C-x><C-o>

"insertモードから抜ける
inoremap <silent> jf <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k


" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>


" カーソル前の文字削除
inoremap <silent> <C-h> <C-g>u<C-h>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" カーソルから行頭まで削除
inoremap <silent> <C-d>e <Esc>lc^
" カーソルから行末まで削除
inoremap <silent> <C-d>0 <Esc>lc$
" カーソルから行頭までヤンク
inoremap <silent> <C-y>e <Esc>ly0<Insert>
" カーソルから行末までヤンク
inoremap <silent> <C-y>0 <Esc>ly$<Insert>


" 引用符, 括弧の設定
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

syntax on
colorscheme molokai
set t_Co=256

let g:seiya_auto_enable=1



call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set number

"php 用
let php_sql_query = 1
let php_htmlInStrings = 1
let php_baselib = 1
let php_noShortTags = 1
let php_parent_error_close = 1


