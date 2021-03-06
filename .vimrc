set nocompatible
filetype off                  " required

set guifont="Consolas 12"

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
" Useful for opening files
Plug 'ctrlpvim/ctrlp.vim'

Plug 'derekprior/vim-colorpack'
Plug 'flazz/vim-colorschemes'
Plug 'joshdick/onedark.vim'

" Syntax analisys
" Neomake should be faster but it doesn't currently work with ensime
" Plug 'neomake/neomake'
Plug 'scrooloose/syntastic'
" Plug 'w0rp/ale'

" Startup screen
Plug 'mhinz/vim-startify'

" Tabs light and status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

" Color schema nice and clean
"Plug 'reedes/vim-colors-pencil'

" Automatic closing brackets, parenthesis...
Plug 'Raimondi/delimitMate'

" Quickness tools
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

Plug 'terryma/vim-expand-region'

Plug 'mhinz/vim-signify'
Plug 'ekalinin/Dockerfile.vim'

" UltiSnips y vimSnippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Easymotion
Plug 'Lokaltog/vim-easymotion'

" Easy clip
" Plug 'svermeulen/vim-easyclip'

" Tagbar
Plug 'majutsushi/tagbar'

" Scala
Plug 'derekwyatt/vim-scala', { 'for': ['scala', 'sbt.scala']}
Plug 'ensime/ensime-vim', { 'for': ['scala',  'sbt.scala']}

" NERD
Plug 'scrooloose/nerdtree'

" BufferGator
Plug 'jeetsukumaran/vim-buffergator'

" Python
Plug 'python-mode/python-mode'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Python
Plug 'davidhalter/jedi-vim'

" Deoplete for neovim
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Other plugins
Plug 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call plug#end()            " required

" required for vundle and go plugins and a nice settings to have.
filetype plugin indent on
syntax on
colorscheme onedark

set mouse=a
   
" basic options
set encoding=utf-8
set fileformat=unix
set modelines=0
    
set backupdir=~/.cache/vim/,/tmp
set directory=~/.cache/vim/,/tmp
     
" indent stuff
set autoindent
set smartindent

" Setting system's clipboard
set clipboard=unnamed

set showmode
set showcmd
set hidden
        
" turning off bell signs
set noerrorbells
set visualbell

"set t_vb=
"autocmd VimEnter * set t_vb=

" Line number settings
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

set number
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
nnoremap <C-n> :call NumberToggle()<CR>

" Others quick settings for easy editing
set cursorline
set ruler
set backspace=eol,start,indent
set laststatus=2
set undofile
set history=10000
set undoreload=10000
set shell=/bin/zsh
" set lazyredraw
set matchtime=3
set nostartofline
set splitbelow splitright
set ttimeout
set notimeout
set autowrite autoread
set shiftround
set formatoptions=crql
set title
set foldmethod=marker
set dictionary=/usr/share/dict/words

set completeopt+=menuone
set completeopt+=noinsert

" wildmenu settings
set wildmenu
set wildmode=list:longest,full

set wildignore+=*/.hg/*,*/.git/*,*/.svn/*
set wildignore+=.pyc
set wildignore+=.class
set wildignore+=.jpg
set wildignore+=.png
set wildignore+=.gif
set wildignore+=.jar
set wildignore+=.swp
set wildignore+=*/build/*
set wildignore+=*/node_modules/*

" allows using the repeat operation with visual selection
vnoremap . :normal .<CR>

" tabs and spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap
set formatoptions=qrnl

" Setting mapleader
let mapleader="\<space>"
let maplocalleader="\\"

" Autocomplete and complete
set complete=.,w,b,u,U,t,i,d

"set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
 
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set virtualedit+=block

" Color settings
" color hybrid_reverse

"Use [RO] for [readonly]
set shortmess-=atI
set shortmess+=r
 
let xml_use_xhtml=1

" Stop the annoying window popping up when pressing q:
map q: :q

" ==================================
" Tabs
" ==================================
noremap <Leader>t :badd<Space>
imap <C-Left> <Esc>:bprev<CR>
noremap <C-Left> :bprev<CR>
imap <C-Right> <Esc>:bnext<CR>
noremap <C-Right> :bnext<CR>

" ==================================
" Windows
" ==================================
nnoremap <Leader>w :split 

" ==================================
" File types and custom autocommands
" ==================================

" Some file types user real tabs
au FileType {make,gitconfig} set noexpandtab sw=4

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json setf javascript
"  
" Make Python follow PEP8
au FileType python set sts=4 ts=4 sw=4 tw=79

" Make sure all markdown files have the correct filetype
au BufRead,BufNewFile *.md setf markdown
au BufRead,BufNewFile *.markdown setf markdown
  
au BufRead,BufNewFile *.dockerfile setf Dockerfile
   
" MultiMarkdown requires 4-space tabs
au FileType markdown set sts=4 ts=4 sw=4
     
" autoformat xml with xmllint and gg=G
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
      
" remove trailing whitespace on save and save cursor position
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

au FileType c,cpp,java,php,ruby,python,.vimrc,md,markdown,scala autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
 
" ctags setup
set tags=./.tags,.tags,./tags,tags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" startify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom indices
  
let g:startify_bookmarks = [
     \ '~/.vimrc',
     \ '~/.zshrc'
     \ ]

autocmd FileType startify setlocal nocursorline
                
let g:startify_skiplist = [
     \ 'COMMIT_EDITMSG',
     \ '^/tmp',
     \ '.*.un\~',
     \ '.+/MERGE_MSG$',
     \ '.+/COMMIT_EDITMSG$',
     \ $VIMRUNTIME .'/doc',
     \ 'bundle/.*/doc',
     \ '\.DS_Store'
     \ ]
" use F1 to start startify
:nmap <F1> :Startify<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='onedark'
" molokai, jellybeans, powerlineish, wombat, luna
let g:airline_powerline_fonts = 1
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'mixed-indent-file' ]
set guifont=Source\ Code\ Pro\ for\ Powerline:12

let g:Powerline_symbols = 'fancy'

set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_scala_checkers = ['ensime']
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_full_redraws=0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_shell = "/bin/sh"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ensime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

let ensime_server_v2=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-snippets && ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <Nul> <Space>
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>o :CtrlPMRU<CR>
map <Leader><Leader>o :CtrlPBufTag<CR>
map <Leader><Leader><Leader>o :CtrlPTag<CR>
nmap ; :CtrlPBuffer<CR>

" remap default ctrlp setting to leader t
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_show_hidden=1
let g:ctrlp_mruf_max=500
  
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 1
  
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn|idea|cache)$|tmp|temp',
  \ 'file': '\v\~$|\.(o|swp|class|pyc|wav|un~|mp3|ogg|blend|DS_Store)'
  \ }
  
let g:ctrlp_user_command={
  \ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files'],
  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': 'find %s -type f'
  \ }
                                       
let g:ctrlp_reuse_window = 'startify'
                                          
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 1
let g:ctrlp_extensions = ['tag', 'buffertag', 'mixed']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_auto_select = 1

if !exists('g:deoplete#sources#omni#input_patterns')
  let g:deoplete#sources#omni#input_patterns = {}
endif

let g:deoplete#sources={} 
let g:deoplete#sources._=['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips'] 
let g:deoplete#sources#omni#input_patterns.java = '\k\.\k*'
let g:deoplete#sources#omni#input_patterns.scala = '[^. *\t]\.\w*'

" Map escape
inoremap jk <ESC>

" Plugin key-mappings.
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

" Ctrl-Space for completions. Heck Yeah! 
inoremap <C-Space> <C-x><C-o>
imap <buffer> <Nul> <C-Space>
smap <buffer> <Nul> <C-Space>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType scala setlocal omnifunc=scalacomplete#CompleteTags

" ============================
" TAGBAR
" ============================

nmap <F8> :TagbarToggle<CR>

let g:tagbar_autofocus = 1
let g:tagbar_autopreview = 1
let g:tagbar_previewwin_pos = "belowright"

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }

" =====================================
" FUGITIVE
" =====================================

map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>ge :Gedit<CR>
map <Leader>gl :Glog<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F2> :NERDTreeToggle<CR>

" ====================
" SCALA
" ====================

autocmd BufWritePost *.scala :EnTypeCheck
nnoremap <Leader>et :EnTypeCheck<CR>
nnoremap <Leader>eb :EnDeclarationSplit<CR>
nnoremap <Leader><CR> :EnSuggestImport<CR>
nnoremap <Leader><F6> :EnRename<CR>
nnoremap <Leader><F1> :EnDocBrowse<CR>
nnoremap <Leader>ep :EnInspectType<CR>
nnoremap <Leader>eo :EnSearch<Space>
nnoremap <Leader>ea :EnAddImport<Space>

" ====================
" Expand Region
" ====================
map <C-Up> <Plug>(expand_region_expand)
map <C-Down> <Plug>(expand_region_shrink)

let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'i]'  :1, 
      \ 'ib'  :1, 
      \ 'iB'  :1, 
      \ 'il'  :0, 
      \ 'ip'  :0,
      \ 'ie'  :0, 
      \ }

call expand_region#custom_text_objects({
      \ "\/\\n\\n\<CR>": 0, 
      \ 'a]' :1, 
      \ 'ab' :1, 
      \ 'aB' :1, 
      \ 'ii' :0, 
      \ 'ai' :0, 
      \ })

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""
" No highlight
""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>h :noh<CR>


""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""
map <C>p :FZF<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" Python-Mode
""""""""""""""""""""""""""""""""""""""""""""""""
let g:pymode = 1
let g:pymode_options_colorcolumn = 1
let g:pymode_indent = 1
let g:pymode_python = 'python3'
let g:pymode_folding = 0


""""""""""""""""""""""""""""""""""""""""""""""""
" FZF vim
""""""""""""""""""""""""""""""""""""""""""""""""

