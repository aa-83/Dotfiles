"""""""""""""""""""
"""Neovim Config"""
"""""""""""""""""""

" This is needed for plugins
set nocompatible
execute pathogen#infect('~/.config/nvim/bundle/{}')
syntax enable
filetype plugin indent on

" Reload init.vim on change
autocmd BufWritePost /home/eirik/.config/nvim/init.vim source %

"""""""""""""""""""""
"""Plugin settings"""
"""""""""""""""""""""

" ALE
let b:ale_linters = {'c': ['gcc'], 'cpp': ['g++']}
let b:ale_fixers= {'c': ['clangtidy'], 'cpp': ['clangtidy']}
let g:ale_cpp_gcc_exexutable = '/usr/bin/g++'
let g:ale_cpp_gcc_options ='-Wall -03'
let g:ale_c_gcc_exexutable = '/usr/bin/gcc'
let g:ale_c_gcc_options ='-Wall -03'
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}

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

" Goyo
"Turn on Goyo for Prose Writing
map <leader>f :Goyo \| set bg=light \| set linebreak<cr>
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

" Neomake
" When writing a buffer
call neomake#configure#automake('w')

" Nerdtree
" Start nerdtree when vim opens
	autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" Exit Vim if NERDTree is the only window left.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
		\ quit | endif
" Toggle Nerdtree with leader n t
map <leader>nt :NERDTreeToggle<CR>

" Netrw
" File browsing fixes
let g:netrw_banner=0 " disables banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyles=3 " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S+'

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = { 'type': 'style' }

"Ultisnips
let g:UltiSnipsExpandTrigger='<c-tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" Vimtex
let g:vimtex_compiler_program='nvr'

""""""""""""""""""""""""""""""
"""Making Vim behave nicely"""
""""""""""""""""""""""""""""""

" Set tab-completion, pretty much built in fzf when combined with find
set path+=**

" Enable Auto Completion
set wildmode=longest,list,full
set wildmenu

" Disable Automatic Commenting on New Line
	autocmd Filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Hex Mode
" Hex Read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
" Hex Write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Spell Check
map <leader>oe :setlocal spell! spelllang=en_us<cr>
map <leader>on :setlocal spell! spelllang=nb_no<cr>

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

" Recompile suckless programs automatically
"	autocmd BufWritePost config.h,config.def.h !sudo make install

" Update binds when sxhkdrc is updated
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


""""""""""
"""Tags"""
""""""""""
set tags=~/.local/share/tags
set tags=./tags;
command! MakeTags !ctags -R .

""""""""""""""""
"""Statusline"""
""""""""""""""""

set laststatus=2
set statusline=
set statusline=%t       "tail of the filename
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=\%h      "help file flag
set statusline+=\%r      "read only flag
set statusline+=\ %y      "filetype
set statusline+=\ %m      "modified flag
set statusline+=%=      "left/right separator
set statusline+=%{LinterStatus()}
set statusline+=\ %c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P\     "percent through file
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Colours
set colorcolumn=80
set background=light
"set background=dark
highlight ColorColumn ctermfg=red
highlight Comment ctermfg=blue

" Bunch of different setting, should be sorted
set title
set guioptions=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set encoding=utf-8
set number relativenumber
set textwidth=80
set history=5000
set shiftwidth=4
set tabstop=4
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
set shortmess-=c
