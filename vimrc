" Try vim settings from https://coderwall.com/p/yiot4q
set guifont=Inconsolata\ for\ Powerline:h12
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

:set autoindent
:set showmatch
:set shiftwidth=4
:set softtabstop=4
:set expandtab
:set number

" match pairs of < and >
autocmd FileType cpp set mps+=<:>

:syn on
:map #4 :set shiftwidth=4
:map #5 :set shiftwidth=5
:map #8 :set shiftwidth=8
:map #9 :set wrapmargin=15

nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>

