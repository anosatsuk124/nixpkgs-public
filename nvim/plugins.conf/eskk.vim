" eskk
" https://alwei.hatenadiary.org/entry/20111029/1319905783
let g:eskk#directory = "~/.eskk"
let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L.utf8", 'sorted': 1, 'encoding': 'utf-8'}
let g:eskk#server = {
\   'host': 'localhost',
\   'port': 55100,
\}
let g:eskk#enable_completion = 1
set imdisable
let g:eskk#egg_like_newline = 1

imap jk <Plug>(eskk:toggle)
cmap jk <Plug>(eskk:toggle)
