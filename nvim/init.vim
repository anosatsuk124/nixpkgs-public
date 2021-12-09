set clipboard+=unnamedplus
set number
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
inoremap <silent> jj <ESC>
set completeopt=noselect,noinsert

" config for neovim-remote
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" Compiling when saved


if has('persistent_undo')
	let undo_path = expand('~/.config/nvim/.undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    <C-b>   <Nop>
" nmap    <C-b> <C-b>
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <C-b>'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

noremap  <C-b>c :tabnew<CR>
" tc 新しいタブを一番右に作る
noremap  <C-b>x :tabclose<CR>
" tx タブを閉じる
noremap  <C-b>n :tabnext<CR>
" tn 次のタブ
noremap  <C-b>p :tabprevious<CR>
" tp 前のタブ

noremap <C-b>t :tabnew <bar> terminal<CR>
