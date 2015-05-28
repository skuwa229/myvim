let g:hybrid_use_Xresources = 1
syntax on

" set encoding=utf-8
" set fileencodings=euc-jp
set hlsearch
set ruler
set noswapfile
set title
set incsearch

set wildmenu wildmode=list:full

if has('vim_starting')
   set nocompatible      " Be iMproved

   "Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

"Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" ==========================================
"My Bundles Plugin
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'nelstrom/vim-visual-star-search' " ビジュアルモードで選択した範囲を*で検索できるようにする
NeoBundle 'scrooloose/nerdtree'  " ディレクトリをツリー表示できる
NeoBundle 'Shougo/unite.vim'     " ファイルを開くのが便利になる
NeoBundle 'Shougo/neomru.vim'    " unite.vimで最近使ったファイルを開くのに必要
NeoBundle 'tpope/vim-endwise'    " Ruby向けにendを自動挿入
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'soramugi/auto-ctags.vim' " ctagsを使ったタグの自動生成
NeoBundle 'mattn/emmet-vim' " html/cssの入力補助
NeoBundle 'othree/html5.vim' " html5のシンタックスカラーon
" =========================================

call neobundle#end()
" Required:
filetype plugin on

colorscheme hybrid

"autocmd FileType php :set dictionary=~/.vim/dict/php.dict
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
set completeopt=menuone

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1
 
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
 
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
 
" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
 
let g:neocomplcache_enable_camel_case_completion  =  1

" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1
 
" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20
 
" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3
 
" php用なのでいったん外すディクショナリ定義
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'php' : $HOME . '/.vim/dict/php.dict',
"    \ 'ctp' : $HOME . '/.vim/dict/php.dict'
"    \ }
 
if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
 
" スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
 
" 前回行われた補完をキャンセルします
inoremap <expr><C-g> neocomplcache#undo_completion()
 
" 補完候補のなかから、共通する部分を補完します
inoremap <expr><C-l> neocomplcache#complete_common_string()
 
" 改行で補完ウィンドウを閉じる
" inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
 
"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
 
" <C-h>や<BS>を押したときに確実にポップアップを削除します
inoremap <expr><C-h> neocomplcache#smart_close_popup().”\<C-h>”
 
" 現在選択している候補を確定します
inoremap <expr><C-y> neocomplcache#close_popup()
" inoremap <expr><C-CR> neocomplcache#close_popup()
 
" 現在選択している候補をキャンセルし、ポップアップを閉じます
inoremap <expr><C-e> neocomplcache#cancel_popup()

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" 括弧の保管
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" コマンドモードで現在開いているファイルのパスを「%%」で表示
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

" 複数行を選択して連続してインデントできるようにする
vnoremap > >gv
vnoremap < <gv

" NERDTreeを開く
nnoremap :tree :NERDTreeToggle

" 入力モードで行の先頭と最後に移動するショートカット
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^a
map <C-e> <Esc>$a
map <C-a> <Esc>^a

" ヤンクレジスタから貼付け
noremap PP "0p
noremap x "_x

" ===============================================================
" unite.vimの設定
noremap <C-U><C-F> :Unite -buffer-name=file file<CR> " ファイル一覧
noremap <C-U><C-R> :Unite file_mru<CR> " 最近使ったファイル一覧

au FileType unite nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('split') " ウィンドウを分割して開く
au FileType unite inoremap <silent> <buffer> <expr> <C-i> unite#do_action('split')

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
" ===============================================================
"
" emmetの設定
let g:user_emmet_expandabbr_key = '<C-y><C-y>'
let g:user_emmet_settings = {
\  'indentation':'  '
\}
" ===============================================================
