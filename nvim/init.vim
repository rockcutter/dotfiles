set number

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'ajmwagar/vim-deus'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'machakann/vim-sandwich'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'vim-airline/vim-airline'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

:colorscheme deus
:command Tr NERDTree
:command RET call SaveTempFiles()
:command Term term powershell

:function SaveTempFiles()
:mks! C:\vim\sessions\memos.vim
:wqa
:endfunction

nnoremap <C-f> <C-v> 
nnoremap <Space> :bn<CR>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>

