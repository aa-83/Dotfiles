"""""""""""""""""""
"""Neovim Config"""
"""""""""""""""""""

" This is needed for plugins
"set nocompatible
execute pathogen#infect('/Users/eirikliehegre/.config/nvim/bundle/{}')
syntax on
"set autoindent
filetype plugin indent on
let g:python3_host_prog = '/Users/eirikliehegre/.local/bin/pynvim-python'
set sessionoptions-=options


""""""""""""""""""""""""""""""
"""Making Vim behave nicely"""
""""""""""""""""""""""""""""""

"let mapleader = ','

" Set tab-completion, pretty much built in fzf when combined with find
set path+=**

" Enable Auto Completion
set wildmode=longest,list,full
set wildmenu

" Disable Automatic Commenting on New Line
	autocmd Filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fix splits
set splitbelow splitright

" Shortcutting Split Navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Automatically deletes all trailing whitespaces on save
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Bunch of different setting, should be sorted
set title
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set encoding=utf-8
set number relativenumber
set textwidth=80
set history=5000
set shiftwidth=4
set softtabstop=4
set display=lastline
set backspace=eol,start,indent
set ruler
set wrap
set linebreak
set autoread
set ignorecase
set smartcase
set showmatch
set showcmd
set noerrorbells
set novisualbell
set nobackup
set nowritebackup
set noswapfile
set noexpandtab
set smarttab
set linebreak
set cmdheight=1
set modifiable
set complete+=kspell
set completeopt=menuone,noinsert
set shortmess-=c
set exrc
set secure
set updatetime=300
set signcolumn=yes

augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

"""""""""""""""""""""
"""Plugin settings"""
"""""""""""""""""""""

"""""""""""""""""""""
""""" Vimtex
"""""""""""""""""""""
"let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_zathura_use_synctex = 0

"""""""""""""""""""""
""""" ALE
"""""""""""""""""""""

highlight ALEWarning ctermbg=DarkMagenta

let g:ale_echo_msg_format = '%linter% says %s'

let b:ale_linters = {'c': ['gcc'], 'cpp': ['g++']}
let b:ale_fixers= {'c': ['clangtidy'], 'cpp': ['clangtidy']}
let g:ale_cpp_gcc_exexutable = '/usr/bin/g++'
let g:ale_cpp_gcc_options ='-Wall -03'
let g:ale_c_gcc_exexutable = '/usr/bin/gcc'
let g:ale_c_gcc_options ='-Wall -03'
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace', 'latexindent', 'textlint']}

function! LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))

	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors

	return l:counts.total == 0 ? 'OK' : printf(
	\	'%dW|%dE',
	\	all_non_errors,
	\	all_errors
	\)
endfunction

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_fix_on_save = 1

"""""""""""""""""""""
""""" COC """""""""""
"""""""""""""""""""""

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"""""""""""""""""""""
""""" FZF
"""""""""""""""""""""

"""""""""""""""""""""
""""" Goyo
"""""""""""""""""""""

"Turn on Goyo for Prose Writing
"Enable Goyo by default for mutt writing
"	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
"	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
"Quit Vim if this is the only remaining buffer
function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction
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

"""""""""""""""""""""
""""" Neomake
"""""""""""""""""""""

" When writing a buffer
call neomake#configure#automake('w')

""""" Nerdtree
" Start nerdtree when vim opens
	autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" Exit Vim if NERDTree is the only window left.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
		\ quit | endif
" Toggle Nerdtree with leader n t
nnoremap <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""
"""""Ultisnips
"""""""""""""""""""""

let g:UltiSnipsExpandTrigger = '<C-e>'

""""""""""
"""Tags"""
""""""""""
set tags=./.tags;
command! MakeTags !ctags -R .


" Spell Check
map <leader>oe :setlocal spell! spelllang=en_gb<cr>
map <leader>on :setlocal spell! spelllang=nb<cr>

""""""""""""""""
"""""SCVIM""""""
""""""""""""""""
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au Filetype supercollider packadd scvim

""""""""""""""""
"""Statusline"""
""""""""""""""""

set laststatus=2
set statusline=
set statusline=%t       "tail of the filename
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=\ %y      "filetype
set statusline+=\ %m      "modified flag
set statusline+=\ %h      "help file flag
set statusline+=\ %r      "read only flag
set statusline+=%=      "left/right separator
set statusline+=\ %{LinterStatus()}
set statusline+=\ %c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P\     "percent through file
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Colours
set colorcolumn=80
set notermguicolors
"set colorscheme eirik
"source $HOME/.config/nvim/bundle/cyberdream.nvim/colors/cyberdream.lua
"set background=light
"set background=dark
highlight ColorColumn ctermbg=red
highlight ColorColumn ctermfg=cyan
highlight Comment ctermfg=blue
