" Vim Config

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'lervag/vimtex'
Plugin 'dense-analysis/ale'
Plugin 'neomake/neomake'
Plugin 'vim-syntastic/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'junegunn/goyo.vim'
Plugin 'vifm/vifm.vim'
Plugin 'preservim/nerdtree'

call vundle#end()

set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus


set nocompatible
set encoding=utf-8
filetype plugin indent on
syntax on
set relativenumber
set textwidth=80
set colorcolumn=80
highlight ColorColumn ctermbg=darkgreen
set history=500
set shiftwidth=4
set tabstop=4
set softtabstop=4
set display=lastline
set backspace=eol,start,indent

set number
set ruler
set wrap
set linebreak
set autoread
set ignorecase
set smartcase
set showmatch
set noerrorbells
set novisualbell
set nobackup
set nowb
set noswapfile
set noexpandtab
set smarttab
set lbr

" Enable Auto Completion
set wildmode=longest,list,full

" Disable Automatic Commenting on New Line
autocmd Filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Hex Mode
" Hex Read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex Write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Turn on Goyo for Prose Writing
map <leader>f :Goyo \| set bg=light \| set linebreak<cr>

"Spell Check
map <leader>oe :setlocal spell! spelllang=en<cr>
map <leader>on :setlocal spell! spelllang=nb_NO<cr>

"Fix splits
set splitbelow splitright

"Shortcutting Split Navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespaces on save
    autocmd BufWritePre * %s/\s\+$//e

" Recompile suckless programs automatically
    autocmd BufWritePost config.h,config.def.h !sudo make install

" Update binds when sxhkdrc is updated
    autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Plugins

" Vimxtex setting
let g:tex_flavor = 'latex'
let g:tex_view_method = 'zathura'
let g:tex_view_general_viewer = 'zathura'
let g:tex_vimtex_viewer = 'zathura'

" Start nerdtree when vim opens
"	autocmd vimenter * NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	map <C-n> :NERDTreeToggle<CR>

"Enable Goyo by default for mutt writing
"Goyo's width will be the line limit in mutt
"autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

" Quit Vim if this is the only remaining buffer
function! s:goyo_leave()
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Ultisnips config
let g:SuperTabDefaultCompletionType    = '<C-b>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Statusline
set statusline+=%#warningsmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntatistic_always_populate_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set tags=~/tags
set tags=./tags;

set laststatus=2
set statusline=
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
