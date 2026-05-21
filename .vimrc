" --- Mapleader ---
let mapleader = " "            " Set Spacebar as the mapleader shortcut prefix

" --- General Quality of Life ---
set nocompatible            " Disable compatibility with old Vi (essential)
set number                  " Show line numbers
set mouse=a                 " Enable mouse support for scrolling/clicking
set clipboard=unnamedplus   " Share clipboard with the system

" --- Search Settings ---
set hlsearch                " Highlight search results
set incsearch               " Search as you type
set ignorecase              " Ignore case when searching...
set smartcase               " ...unless search contains a capital letter
nnoremap <leader><space> :nohlsearch<CR>  
" Tap Spacebar twice to clear highlights!

" --- Indentation & Tabs (Crucial for config files) ---
set expandtab               " Convert tabs to spaces
set tabstop=4               " Insert 4 spaces for a tab
set shiftwidth=4            " Number of spaces for auto-indenting
set autoindent              " Copy indent from current line on newline

" --- UI & Extras ---
syntax on                   " Enable syntax highlighting
set wildmenu                " Visual autocomplete menu for command mode
set backspace=indent,eol,start " Make backspace work like a normal text editor

" --- Hybrid Line Numbers ---
set number                  " Show the absolute line number for the current line
set relativenumber          " Show distance to other lines in the gutter

" --- Visualizing Hidden Traps ---
set list                    " Reveal invisible characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:« " Tailor what those look like

" --- Structural Navigation & Context ---
set cursorline              " Highlight the current line text is on
set scrolloff=7             " Keep 7 lines of context visible above/below cursor
set wrap                    " Wrap visually long strings...
set linebreak               " ...but break them cleanly at words, not mid-syllable

" --- Better Navigation ---
nnoremap j gj
nnoremap k gk

" --- YAML ---
autocmd FileType yaml,yml setlocal ts=2 sw=2

" --- Auto-create missing directories ---
augroup BW_AutoCreateDir
  autocmd!
  autocmd BufWritePre * if expand("<afile>") !~ '://' | call mkdir(expand("<afile>:p:h"), "p") | endif
augroup END

" --- Centralize backup and swap file ---
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile

" --- Statusline Customization ---
set laststatus=2            " Always show the statusline
set showcmd                 " Show incomplete commands in the bottom right
set noshowmode              " Hide the default '-- INSERT --' text

" --- Statusline ---
let &statusline = '%#StatusLineMode# %{StatuslineMode()} '
let &statusline .= '%#StatusLineFile# %f '
let &statusline .= '%#StatusLineModified#%m'
let &statusline .= '%='
let &statusline .= '%#StatusLineFormat# %y '
let &statusline .= '%#StatusLineFormat# %{&ff} '
let &statusline .= '%#StatusLinePos# %l/%L :%c '
let &statusline .= ' %p%% '

" --- Helper function to get a clean mode name ---
function! StatuslineMode()
    let l:mode = mode()
    if l:mode==#"n"  | return "NORMAL" | endif
    if l:mode==#"i"  | return "INSERT" | endif
    if l:mode==#"v"  | return "VISUAL" | endif
    if l:mode==#"V"  | return "V-LINE" | endif
    if l:mode==#"\<C-v>" | return "V-BLOCK" | endif
    if l:mode==#"R"  | return "REPLACE" | endif
    if l:mode==#"c"  | return "COMMAND" | endif
    return l:mode
endfunction

" Basic colors for the statusline blocks (Works well with dark themes)
highlight StatusLineMode     ctermfg=0 ctermbg=4 guifg=#000000 guibg=#6699cc
highlight StatusLineFile     ctermfg=7 ctermbg=8 guifg=#ffffff guibg=#333333
highlight StatusLineModified ctermfg=1 ctermbg=8 guifg=#ff3333 guibg=#333333
highlight StatusLineFormat   ctermfg=7 ctermbg=8 guifg=#cccccc guibg=#333333
highlight StatusLinePos      ctermfg=0 ctermbg=7 guifg=#000000 guibg=#cccccc

" --- Prose Utilities (No Plugins) ---
set spelllang=en_gb             " Set spelling language to British English
set dictionary=/usr/share/dict/words " Use the system dictionary for completion
set complete+=kspell            " Allow Ctrl+N autocomplete to suggest dictionary words
nnoremap <leader>s :setlocal spell!<CR> 
" Space + s to toggle spell check

" --- Clean paragraph formatting shortcuts ---
nnoremap Q gqap
vnoremap Q gq

" --- Undo breaks on punctuation (makes undo behavior normal) ---
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" --- Prose & Writing Mode Optimization ---
augroup ProseWriting
  autocmd!
  autocmd FileType markdown,text setlocal nolist
augroup END
