set number

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'ajmwagar/vim-deus'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'vim-airline/vim-airline'
Plug 'kassio/neoterm'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:deoplete#enable_at_startup = 1
let g:neoterm_default_mod='belowright'
let g:neoterm_size=10
let g:neoterm_shell="pwsh"

if(has('unix'))
	g:neoterm_shell="bash"
endif

:colorscheme deus
:command Tr NERDTree
:command RET call SaveTempFiles()
:command TN Tnew
:command TT Ttoggle
:command X call CloseBuffer()
:command VIMRC :e $MYVIMRC
:command S call SetUpEnvironment()
:command Q qa!

" :function OpenTerminal()
" :sp
" :term "C:\Program Files\PowerShell\7\pwsh.exe"
" :endfunction

:function CloseBuffer()
:vs
:wincmd l
:bn
:wincmd h
try
:bd
:catch /.*/
:q
:endtry
:endfunction

:function SetUpEnvironment()
:TT
:Tr
:endfunction

:function SaveTempFiles()
:mks! C:\vim\sessions\memos.vim
:wqa
:endfunction

nnoremap vv <C-v> 
nnoremap <Space> :bn<CR>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
tnoremap <ESC> <C-\><C-n>


inoremap { {}<Left>
inoremap {} {}
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap () ()
inoremap (<Enter> ()<Left><CR><ESC><S-o>

