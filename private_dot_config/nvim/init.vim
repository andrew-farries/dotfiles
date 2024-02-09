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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'psliwka/vim-smoothie'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'kevinhwang91/nvim-bqf'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'svban/YankAssassin.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ojroques/vim-oscyank'
Plug 'github/copilot.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()
" }}}

" Plugin settings lightline {{{
let g:lightline = { 'colorscheme': 'blue-moon' }
" }}}
"
" Plugin settings: nvim-web-devicons {{{
lua << EOF
require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = false;
}
EOF
" }}}

" Plugin settings: nvim-tree {{{
lua << EOF
require'nvim-tree'.setup{
  create_in_closed_folder = false,
  respect_buf_cwd = true,
  actions = {
    open_file = {
      resize_window = true,
      window_picker = {
        enable = false
      }
    },
  },
  view = {
    float = {
      enable = true,
      open_win_config = {
        relative = "win",
        border = "rounded",
        width = 50,
        height = 100,
        row = 0,
        col = 0,
      }
    }
  },
  hijack_directories = {
    auto_open = false
  },
  hijack_unnamed_buffer_when_opening = true,
  update_focused_file = {
    enable = true
  },
  renderer = {
    add_trailing = false,
    highlight_opened_files = "all",
    root_folder_modifier = ':~',
    group_empty = false,
    special_files = { "README.md" },
    icons = {
      padding = " ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    indent_markers = {
      enable = true,
    },
  }
}

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

EOF

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
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

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A
" }}}

" Plugin settings: coc-snippets {{{
"
" All of this section taken from the project README.
"
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
" }}}

" Plugin settings: Treesitter {{{
" Enable syntax highlighting for Go. Taken from the nvim-treesitter docs at
" https://github.com/nvim-treesitter/nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "go", "typescript", "javascript", "bash", "tsx", "sql", "nix", "rust", "vim"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
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
let g:floaterm_autoclose = 2
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

" Plugin settings: copilot {{{
" See :h copilot for other mappings.
inoremap jk <Plug>(copilot-next)
inoremap kj <Plug>(copilot-previous) 

imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
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
nnoremap <leader>/ :Lines<CR>
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

" Bind Y to yank to end of line as suggested in `:h Y
" This is now default behavior in neovim, so doesn't strictly need to be here.
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

" Make it so <esc> can be used to save.
inoremap <silent><esc> <esc>:wa<cr>
nnoremap <silent><esc> <esc>:wa<cr>
vnoremap <silent><esc> <esc>:wa<cr>

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

lua << EOF

-- Set the command height to 1. This is the default.
vim.o.ch = 1

-- Set the last status to 0
vim.o.ls = 0

EOF
" }}}

" TextYankPost setup {{{
" Use TextYankPost to highlight yanked region.
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

augroup osc_yank
  autocmd!
  autocmd TextYankPost * if $SSH_CLIENT != '' && v:event.operator is 'y' && v:event.regname is '*' | execute 'OSCYankReg *' | endif
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
silent! colorscheme blue-moon
" }}}

" Swap and backup files {{{
set noswapfile
set nobackup
set nowritebackup
" }}}

" Search {{{
set ignorecase
set smartcase
" }}}

" Focus events {{{
" Reload buffers when focus is gained
" Save buffers when focus is lost
augroup andrewFarriesfocusStuff
  autocmd!
  au FocusGained,BufEnter * :silent! !
  au FocusLost,WinLeave * :silent! update
augroup END
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

" Misc {{{
" Autosave buffers on lots of different events, eg jumps to other files, :make
" etc
:set autowrite

" Briefly show the matching bracket after typing it
set showmatch matchtime=1

" no mouse support
set mouse=
" }}}

" Set the modeline to enable code folding in this file.
" vim:foldmethod=marker:foldlevel=0
