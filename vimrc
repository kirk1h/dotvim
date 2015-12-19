" -"{{{
autocmd!
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"}}}

" PLUGINS "{{{
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tmhedberg/matchit'
Plugin 'tomtom/tcomment_vim'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'junegunn/vim-easy-align'
Plugin 'gerw/vim-HiLinkTrace'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'

if has("gui_running")
   Plugin 'Yggdroot/indentLine'
endif

" Plugin 'honza/vim-snippets'
Plugin 'groenewege/vim-less'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'marijnh/tern_for_vim'
Plugin 'airblade/vim-gitgutter'
" Plugin 'rking/ag.vim'

"}}}

" MISC KEY MAPS"{{{
let mapleader = ","
nmap <tab> %
nmap k gk
nmap j gj

nnoremap <silent>K :bd<cr>
" nnoremap <silent>K :bp<bar>sp<bar>bn<bar>bd<CR>
map . .`[
nnoremap Q @q
nnoremap * *``:set hlsearch<cr>
nmap <silent> gn :cnext<cr>
nmap <silent> gN :cprev<cr>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <silent> <esc><esc> :set nohlsearch<cr>
nnoremap <silent> <cr> :w<cr>
nnoremap <space> za
nnoremap <S-space> zM

nmap <silent> <leader>ev :e ~/.vim/vimrc<cr>
nmap <silent> <leader>/ :TComment<cr>
xmap <silent> <leader>/ :TComment<cr>
nmap <silent> <leader>b :b#<cr>
nmap <silent> <leader>p :CtrlP<cr>
nmap <silent> <leader>t :CtrlPMRU<cr>
if has("gui_macvim")
  noremap <D-1> :tabn 1<CR>
  noremap <D-2> :tabn 2<CR>
  noremap <D-3> :tabn 3<CR>
  noremap <D-4> :tabn 4<CR>
  noremap <D-5> :tabn 5<CR>
  noremap <D-j> }
  noremap <D-k> {
endif
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nmap s <Plug>(easymotion-s)
"}}}
" BASIC EDITING CONFIGURATION"{{{
set encoding=utf-8
set mouse=a
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=3
set shiftwidth=3
set softtabstop=3

set autoindent

set laststatus=2
set showmatch
set matchtime=2
set incsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set number
set cmdheight=1
set switchbuf=useopen
set numberwidth=5
set winwidth=79

" set shell=/bin/zsh
set shell=/bin/bash\ -l

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=2
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
set completeopt-=preview
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Use OSX/Win Clipboard
set clipboard=unnamed
" Get rid of the left scrollbar in vsplit
set go-=L
set foldmethod=marker
set foldcolumn=0
set foldopen-=block
set autoread

set wildignore+=.git,node_modules/**,.git/**
set pumheight=10
let &previewheight=&lines / 2

" Get rid of wrapping
set textwidth=0
set wrapmargin=0
set nowrap

set autochdir
" set iskeyword+=<,>

set foldtext=MyFoldText()
function! StripFoldText(f, m)
   let c = substitute(&commentstring, '%s', a:m, '')  " replace the commentstring %s with the real one
   let c = substitute(c, '\*', '\\*', 'g')            " escape * if present
   let f = substitute(a:f, c, '', '')                 " strip the commentstring with marker
   let f = substitute(f, a:m, '', '')                 " strip the marker only
   return f
endfunction
function! MyFoldText()
   let markerstart = strpart(&foldmarker, 0, 3)
   let markerend = strpart(&foldmarker, 4, 3)
   let foldstart = StripFoldText(getline(v:foldstart), markerstart)
   let foldend = StripFoldText(getline(v:foldend), markerend)
   let foldend = substitute(foldend,'^\s\+', '', '')
   if (foldend == "")
      return foldstart
   else
      return foldstart . " ... " . foldend
   endif
endfunction

function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction

"}}}
" COLOR AND GUI"{{{
set background=dark
colorscheme monokaibright

set list
set cursorline
set listchars=tab:\ \ ,eol:¬
set fillchars=fold:\ 
set guifont=Menlo:h14

set linespace=1
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guicursor+=n-v-ve:blinkoff0-Cursor
set guicursor+=i:ver25-iCursor

set statusline=%<%.99f\ %h%w%m%r\ 
" set statusline+=%{SL('fugitive#statusline')}\ %#warningmsg#%{SL('SyntasticStatuslineFlag')}%*
set statusline+=%{SL('fugitive#statusline')}\ %#errormsg#%{SL('SyntasticStatuslineFlag')}%*
" let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
set statusline+=%=
set statusline+=\ %y\ 
set statusline+=[%{&ff}]\ 
set statusline+=[%{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\\"}%k]\ 

"}}}
" PLUGINS CONFIG"{{{
let g:indentLine_char = ''
let g:indentLine_color_gui = '#393939'
let g:jsx_ext_required = 0

let g:UltiSnipsSnippetsDir='~/.vim/snips'
" let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']
let g:UltiSnipsSnippetDirectories=['snips' , 'UltiSnips']

let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_clear_cache_on_exit = 1

let g:syntastic_auto_jump = 1
let g:syntastic_enable_signs = 0
let g:syntastic_mode_map = {
   \ 'mode': 'active',
   \ 'passive_filetypes': ['html'] }
let g:syntastic_javascript_checkers = ['eslint']

let javascript_enable_domhtmlcss = 1

let g:user_emmet_expandabbr_key = '<S-space>'

" -----
function! g:Smart_tab()
   call UltiSnips#ExpandSnippet()
   if g:ulti_expand_res == 0
      if pumvisible()
         return "\<C-n>"
      else
         call UltiSnips#JumpForwards()
         if g:ulti_jump_forwards_res == 0
            return "\<tab>"
         endif
      endif
   endif
   return ""
   " endif
endfunction

let g:UltiSnipsJumpForwardTrigger="<cr>"
autocmd BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:Smart_tab()<cr>"
" -----

"}}}
" AUTOCMD"{{{
" Reload on save
autocmd! bufwritepost ~/.vim/vimrc source ~/.vim/vimrc
autocmd! bufwritepost monokaibright.vim colorscheme monokaibright
" Tap indent in visual mode
autocmd VimEnter * xmap <tab> >gv
autocmd VimEnter * xmap <s-tab> <gv
" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" No bell
autocmd VimEnter * set vb t_vb=
autocmd BufNewFile,BufRead *rc set filetype=json
autocmd BufNewFile,BufRead vimrc set filetype=vim
autocmd Syntax mustache setlocal foldmarker=[[[,]]]
autocmd Syntax mustache setlocal commentstring={{!%s}}
"}}}

" autocmd FileType * 2match none
autocmd FileType javascript 2match WHITE /;\|,\|<\//

fun! g:Findfile()
   if !empty(matchstr(getline("."), '<'))
      if !empty(matchstr(getline("."), '<Route'))
         if !empty(matchstr(getline("."), 'require'))
            exe 'norm! $F.gf'
         else
            exe "norm! mz0/component\<cr>Wve\"xygg"
            call search(@x)
            exe "norm! \"xyi'`z"
            exe "edit " . @x
         endif
      else
         exe "norm! mz0f<wve\"xygg"
         call search(@x)
         exe "norm! \"xyi'`z"
         exe "edit " . @x
      endif
   else
      exe 'norm! $F.gf'
   endif
endf
nnoremap <silent> gf :call g:Findfile()<cr>

autocmd FileType javascript setlocal omnifunc=tern#Complete
" fixme:
autocmd FileType php setlocal omnifunc=

" map <D-k> :NERDTreeToggle<cr>

" function! g:ExpandOrJump(direction)
"    call UltiSnips#ExpandSnippet()
"    if g:ulti_expand_res == 0
"       " No expansion occurred.
"       if pumvisible()
"          " Pop-up is visible, let's select the next (or previous) completion.
"          if a:direction == 'N'
"             return "\<C-N>"
"          else
"             return "\<C-P>"
"          endif
"       else
"          call UltiSnips#JumpForwards()
"          if g:ulti_jump_forwards_res == 0
"             " We did not jump forwards.
"             return "\<Tab>"
"          endif
"       endif
"    endif
"
"    " No popup is visible, a snippet was expanded, or we jumped, so nothing to do.
"    return ''
" endfunction

" " YouCompleteMe and UltiSnips compatibility.
" let g:UltiSnipsExpandTrigger = '<Tab>'
" let g:UltiSnipsJumpForwardTrigger = '<Tab>'

" " TODO: change UltiSnips to not try mapping if this is empty; setting this to
" " <C-k> here rather than <S-Tab> to prevent it from getting clobbered in:
" " ultisnips/pythonx/UltiSnips/snippet_manager.py: _map_inner_keys
" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
"
" let g:ycm_key_list_select_completion = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
"
" let g:ulti_jump_forwards_res = 0
" let g:ulti_expand_res = 0

" augroup WincentAutocomplete
"    autocmd!
"
"    " Override late bindings set up by YouCompleteMe in autoload file.
"    autocmd BufEnter * exec 'inoremap <silent> <Tab> <C-R>=g:ExpandOrJump("N")<CR>'
"    autocmd BufEnter * exec 'inoremap <silent> <S-Tab> <C-R>=g:ExpandOrJump("P")<CR>'
"
"    " TODO: ideally would only do this while snippet is active
"    " (see pythonx/UltiSnips/snippet_manager.py; might need to open a feature
"    " request or a PR to have _map_inner_keys, _unmap_inner_keys fire off
"    " autocommands that I can subscribe to)
"    " BUG: seems you have to do <CR> twice to actual finalize completion
"    " (this happens even with the standard <C-Y>
"    inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "<CR>"
" augroup END

let g:vim_json_syntax_conceal = 0
let g:gitgutter_sign_modified = '▪'
let g:gitgutter_sign_modified_removed = '▪'
let g:gitgutter_sign_column_always = 1

nnoremap <leader>s vi{:sort<cr>
