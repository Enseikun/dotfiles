" Escの設定
" Normal mode mappings
nnoremap H ^
nnoremap L $
nnoremap c "_c
nnoremap C "_C
nnoremap U u

" Visual mode mappings  
vnoremap H ^
vnoremap L $
vnoremap c "_c
vnoremap C "_C
vnoremap U u

" Insert mode mappings
inoremap jj <Esc>

" クリップボード連携
set clipboard=unnamed

" ノーマルモードではデフォルトのキー入力を英数にする

" tab移動
exmap tabnext obcommand workspace:next-tab
nmap gt :tabnext

exmap tabprev obcommand workspace:previous-tab
nmap gT :tabprev
