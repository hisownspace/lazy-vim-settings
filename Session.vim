let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
let Taboo_tabs = ""
let NvimTreeSetup =  1 
let NvimTreeRequired =  1 
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess+=aoO
badd +11 lua/config/keymaps.lua
badd +47 lua/plugins/init.lua
badd +1 ~/.config/nvim
badd +8 lua/config/mason-null-ls.lua
badd +6 lua/config/options.lua
badd +8 lua/config/lazy.lua
badd +19 lua/config/colorscheme.lua
badd +12 lua/plugins/codex.lua
badd +43 lua/plugins/colorscheme.lua
badd +36 lua/plugins/example.lua
badd +81 lua/plugins/nvim-cmp.lua
badd +2 lua/plugins/nvim-tree.lua
badd +21 lua/plugins/conform.lua
badd +37 lua/utils/conform_helpers.lua
argglobal
%argdel
$argadd ~/.config/nvim
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit lua/plugins/conform.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt lua/plugins/init.lua
setlocal foldmethod=expr
setlocal foldexpr=v:lua.LazyVim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
6
sil! normal! zo
7
sil! normal! zo
20
sil! normal! zo
21
sil! normal! zo
23
sil! normal! zo
36
sil! normal! zo
let s:l = 16 - ((15 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 16
normal! 015|
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/init.lua", ":p")) | buffer lua/plugins/init.lua | else | edit lua/plugins/init.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/init.lua
endif
balt lua/plugins/conform.lua
setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.lsp.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
1
sil! normal! zo
let s:l = 37 - ((24 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 37
normal! 0
wincmd w
wincmd =
tabnext
edit lua/plugins/init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt lua/plugins/nvim-cmp.lua
setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.lsp.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
1
sil! normal! zo
let s:l = 49 - ((15 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 49
normal! 013|
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/nvim-cmp.lua", ":p")) | buffer lua/plugins/nvim-cmp.lua | else | edit lua/plugins/nvim-cmp.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/nvim-cmp.lua
endif
balt lua/plugins/init.lua
setlocal foldmethod=expr
setlocal foldexpr=v:lua.LazyVim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
1
sil! normal! zo
2
sil! normal! zo
6
sil! normal! zo
19
sil! normal! zo
24
sil! normal! zo
30
sil! normal! zo
38
sil! normal! zo
47
sil! normal! zo
56
sil! normal! zo
65
sil! normal! zo
18
sil! normal! zo
21
sil! normal! zo
26
sil! normal! zo
27
sil! normal! zo
41
sil! normal! zo
47
sil! normal! zo
57
sil! normal! zo
66
sil! normal! zo
26
sil! normal! zo
27
sil! normal! zo
41
sil! normal! zo
47
sil! normal! zo
57
sil! normal! zo
66
sil! normal! zo
86
sil! normal! zo
let s:l = 15 - ((14 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 08|
wincmd w
wincmd =
tabnext 2
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
