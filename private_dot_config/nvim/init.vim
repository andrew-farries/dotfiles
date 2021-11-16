set modelines=1

" Leader key definitions {{{
" unmap space from its usual function (in normal, visual and operator pending
" modes).
noremap <space> <nop>
" Set the leader key to space.
let mapleader = " "
" }}}

" Plugins {{{
call plug#begin()

Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'kyazdani42/blue-moon'
Plug 'unblevable/quick-scope'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'psliwka/vim-smoothie'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'kevinhwang91/nvim-bqf'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" According to its documentation, the vim-devicons plugin should always be
" loaded last.
Plug 'ryanoasis/vim-devicons'

call plug#end()
" }}}

" Plugin settings: coc {{{
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references-used)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Add '-' as an additional char for completion so that hyphenated words are
" suggested in their entirety.
autocmd FileType * let b:coc_additional_keywords = ["-"]
" }}}

" Plugin settings: Treesitter {{{
" Enable syntax highlighting for Go. Taken from the nvim-treesitter docs at
" https://github.com/nvim-treesitter/nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "c_sharp", "typescript", "javascript" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
" }}}

" Plugin settings: Lightline {{{
set laststatus=2
set noshowmode

" Most of the below comes from the 'Lightline setup' section of `:h devicons`
let g:lightline = {
      \ 'colorscheme': 'blue-moon',
      \ 'component_function': {
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ }
    \ }
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
" }}}

" Plugin settings: Nerdtree {{{
" Open nerdtree when vim is started with a directory argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Close vim when nerdtree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Define a key binding to toggle nerdtree and highlight the current file
map <C-n> :NERDTreeFind<CR>

" Set 'minimal UI so you don't have the help message at the top
let NERDTreeMinimalUI=1
" }}}

" Plugin settings: vim-tmux-navigator {{{
" Disable tmux navigator when zooming the Vim pane
" This means that the vim pane won't get un-zoomed.
let g:tmux_navigator_disable_when_zoomed = 1
" }}}

" Plugin settings: fzf.vim {{{

" Open fzf windows as a floating window.
let g:fzf_layout = { 'window': {
                \ 'width': 0.9,
                \ 'height': 0.7,
                \ 'highlight': 'Comment',
                \ 'rounded': v:false } }
" Alter the default RG command so that it doesn't match against filenames,
" only their contents.See: https://github.com/junegunn/fzf/issues/1109
command! -nargs=* -bang RGNoMatchFileNames call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
  \ <bang>0
  \ )
"" }}}

" Plugin settings: floaterm {{{
" Don't bother showing a title for the floating terminal.
let g:floaterm_title = ""

" Set the shell to use in floatterm windows
let g:floaterm_shell = 'fish'

" Use the current editor for editing git commit mesages initiated from the
" terminal (open in a new tab).
let g:floaterm_opener= 'vsplit'

" Set the dimensions for the floating terminal
let g:floaterm_width = 0.99
let g:floaterm_height = 0.99

" Autoclose the window when the process it was opened with exits
let g:floaterm_autoclose = v:true
" Set transparency for the floating terminal window
let g:floaterm_winblend = 0
" }}}

" Plugin settings: quickscope {{{
" Disable quickscope in certain buffer types.
let g:qs_buftype_blacklist = ['terminal', 'nofile']
" }}}

" Plugin settings: vim-sneak {{{
" Enable labels as a minimalist alternative to vim-easymotion.
let g:sneak#label = 1
" }}}

" Plugin settings: nvim-scrollview {{{
" Set the opacity of the scrollbar.
let g:scrollview_winblend=0

" Set the column in which the scrollbar appears.
let g:scrollview_column=1
" }}}

" Netrw settings {{{
" Hide annoying 'help' banner
let g:netrw_banner = 0
" Use treeview by default
let g:netrw_liststyle = 3
" Smaller default window size
let g:netrw_winsize = '30'
" }}}

" Leader key mappings {{{
" Define some leader mappings for using fzf.vim functionality.
nnoremap <leader><space> :Buffers<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fg :GFiles?<CR>
nnoremap <leader>rg :RGNoMatchFileNames<CR>
nnoremap <leader>RG :RGNoMatchFileNames!<CR>

" Define some fugitive key mappings.
noremap <leader>ga :Gwrite<CR>
noremap <leader>gb :Git blame<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gd :Gdiff<CR>
" }}}

" Yank settings {{{
" Use the system clipboard for all yanks.
nnoremap y "*y
vnoremap y "*y

" Bind Y to yank to end of line as suggested in `:h Y`
nnoremap Y "*y$

" Define some copy/paste with system clipboard mappings.
noremap <leader>p "*p
noremap <leader>P "*P
noremap <leader>gp "*gp
noremap <leader>gP "*gP
" }}}

" Insert mode mappings {{{
" Break undo sequence at punctuation marks
inoremap . .<c-g>u
inoremap , ,<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
" }}}
"
" Normal mode mappings {{{
" Make some common jumps center the screen after the cursor moves
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz

" Make j and k behave sensibly on wrapped lines
nnoremap j gj
nnoremap k gk
" }}}

" Visual mode mappings {{{
" Move selection up and down the file with J and K in visual mode.
vnoremap J :move '>+1 <CR>gv=gv
vnoremap K :move '<-2 <CR>gv=gv
" }}}

" Function key mappings {{{
nnoremap <silent> <F1> :FloatermToggle<CR>
inoremap <silent> <F1> <c-o>:FloatermToggle<CR>
tnoremap <silent> <F1> <c-\><C-n>:FloatermToggle<CR>
nmap <silent> <F2> <Plug>(coc-rename)
nnoremap <silent> <F3> :cprevious<CR>
nnoremap <silent> <F4> :cnext<CR>
nnoremap <silent> <F12> :RGNoMatchFileNames<CR>'
nnoremap <silent> <S-F12> :RGNoMatchFileNames!<CR>'
" }}}

" Control key mappings {{{
" Needs no explanation - the most frequently used mapping of all.
noremap <c-p> :Files<CR>

" Make it so <c-[> can be used to save.
inoremap <silent><c-[> <c-[>:wa<cr>
nnoremap <silent><c-[> <c-[>:wa<cr>
vnoremap <silent><c-[> <c-[>:wa<cr>

" Bind <c-c> to clear various things
nnoremap <silent> <c-c> :nohl<CR>

" Use <c-t> to open the terminal - F1 is inconvenient on macbook keyboards.
nnoremap <silent> <c-t> :FloatermToggle<CR>
inoremap <silent> <c-t> <c-o>:FloatermToggle<CR>
tnoremap <silent> <c-t> <c-\><C-n>:FloatermToggle<CR>
" }}}

" Navigation key mappings {{{
noremap <PageUp> [c
noremap <PageDown> ]c
" }}}

" Buffers {{{
" Make buffers behave in a sane way
set hidden

" Don't add a trailing newline at the end of the file
set nofixeol
" }}}

" Fold options {{{
" When searching in files with folds, don't cause moving onto a search result
" to open the containing fold, just highlight that there is a match inside the
" fold.
set foldopen-=search
" }}}

" UI Preferences {{{
" Use line numbers
set number

" Highlight the current line
set cursorline

" Keep some context on the screen at all times
set scrolloff=3

" Make new vsplits open to the right and splits underneath.
set splitbelow
set splitright

" Make the popup menu smaller
set pumheight=10
" }}}

" TextYankPost setup {{{
" Use TextYankPost to highlight yanked region.
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
" }}}

" Wildmenu settings {{{
" Make completion case insensitive
set wildignorecase
" }}}

" Vimgrep settings {{{
" Use rg if installed to power vimgrep
if executable("rg")
  set grepprg=rg\ --vimgrep
endif
" }}}

" Terminal settings {{{
tnoremap <esc> <c-\><c-n>
" }}}

" Indentation and tabs {{{
" Read helps and look at this:
" https://www.reddit.com/r/vim/wiki/tabstop
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Allow plugins and custom indentation on a per-filetype basis
filetype plugin indent on
" }}}
"
" Wrapping and linebreaks {{{
" Make wrapped lines continue at the same indentation level.
set breakindent

" Make wrapping occur only at word boundaries
set linebreak

" }}}

" Filetype specific settings {{{

" Always start with the cursor on the first line when editing a git commit
" message
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
" }}}

" Color scheme {{{
" Enable syntax highlighting
:syntax on

" Enable True Color mode. This assumes you are using a terminal emulator that
" supports it.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Enable italics. This doesn't work inside tmux though.
" Commented out after switching from one dark theme.
" Have to have another go at italics in tmux one day.
" let g:onedark_terminal_italics=1

" Set the colorscheme
colorscheme blue-moon
" }}}

" Swap and backup files {{{
set noswapfile
set nobackup
set nowritebackup
" }}}

" Search {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
" }}}

" Focus events {{{
" Reload buffers when focus is gained
au FocusGained,BufEnter * :silent! !
" Save buffers when focus is lost
au FocusLost,WinLeave * :silent! update
" }}}

" Window resizing {{{
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
" }}}

" Jumplist settings {{{
" Make the jumplist behave like a tagstack or browser history
set jumpoptions="stack"
" }}}

" Trailing whitespace {{{
" Highlight trailing whitespace except when in insert mode on the current
" line.
" Taken from the vim wiki: https://vim.fandom.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }}}

" Misc {{{
" Reload files changed outside of vim
set autoread

" Autosave buffers on lots of different events, eg jumps to other files, :make
" etc
:set autowrite

" Briefly show the matching bracket after typing it
set showmatch matchtime=1

" Set incommand so that the results of subsitution commands are previewed
" before taking effect. See: http://vimcasts.org/episodes/neovim-eyecandy/
set inccommand=nosplit
" }}}

" Set the modeline to enable code folding in this file.
" vim:foldmethod=marker:foldlevel=0
