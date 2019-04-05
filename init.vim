" Enable true colour
if (empty($TMUX))
 if (has("nvim"))
   let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 endif
 if (has("termguicolors"))
   set termguicolors
 endif
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'farmergreg/vim-lastplace'
Plug 'sjl/vitality.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'rakr/vim-one'
Plug 'unblevable/quick-scope'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'tpope/vim-fugitive'
call plug#end()

"""""""""""""""
""" Base config
"""""""""""""""
set backup
set backupdir=/private/tmp
set dir=/private/tmp
set backspace=indent,eol,start
set ruler
set tabstop=2
set expandtab
set mouse=n
set shiftwidth=2
set smarttab
set linebreak
set smartindent
set cindent
set autoindent
set ignorecase
set smartcase
set number
set relativenumber
set splitright
set splitbelow
set cursorline
set cursorcolumn
set hidden
set clipboard=unnamed

"""""""""""
""" Theming
"""""""""""
syntax on
set background=dark
let g:one_allow_italics = 1
colorscheme one

"""""""""""""""""""
"" Language Servers
"""""""""""""""""""

""""""""""""""""""
""" Plugins config
""""""""""""""""""
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:SuperTabCrMapping = 1
let NERDSpaceDelims = 1
let NERDTreeHijackNetrw = 0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:fzf_history_dir = '~/.local/share/fzf-history'

highlight SignifySignChange guibg='#61afef' guifg='#61afef' 
highlight SignifySignAdd guibg='#98c379' guifg='#98c379'
highlight SignifySignDelete guibg='#d19a66' guifg='#d19a66'

" Airline
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '::'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#whitespace#enabled = 1

" COC
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

highlight CocErrorSign guibg='#f74b3c' guifg='#f74b3c'
highlight CocWarningSign guibg='#be5046' guifg='#be5046'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" ALE
" let g:ale_linters = { 'javascript': ['eslint'] }
" let g:ale_javascript_eslint_executable = 'eslint'
" let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1
" let g:airline#extensions#ale#enabled = 1
" highlight ALEErrorSign guibg='#f74b3c' guifg='#f74b3c'
" highlight ALEWarningSign guibg='#be5046' guifg='#be5046'

""""""""""""""""
""" Key mappings
""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-w> <C-w>w
nnoremap , i_<Esc>r
nnoremap <esc> :noh<return><esc>
map <C-d> :%bd\|e#\|bd#<CR>
nnoremap <Leader>r :e ~/dotfiles/init.vim<return>
map <Leader>s :e ~/Desktop/scratchpad.md<return>
map <Leader>f :FZF<return>
map <C-p> :FZF<return>
map <Leader>g :Rg<return>
map ; :Buffers<return>
map <silent> e <Plug>CamelCaseMotion_e
sunmap e

"""""""""""""""""
""" Commands
"""""""""""""""""

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"""""""""""""""""
""" Bug fixes etc
"""""""""""""""""

""" fix airline slowness leaving insert mode "
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

