set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
"=======begin my own set====================
set number
set fileencodings=utf-8,gbk,unicode
set ruler
set tabstop=4
autocmd FileType python set tabstop=4
autocmd FileType cpp set tabstop=4
autocmd FileType cs set tabstop=4
set shiftwidth=4
set encoding=utf-8
"set smartindent
set showmatch
filetype indent plugin on
filetype on
colorscheme torte

" 高亮显示普通txt文件（需要txt.vim脚本）
"au BufRead,BufNewFile *  setfiletype txt

"indent
set ts=4
set expandtab
set autoindent


"TagList
map <F6> :Tlist<CR>
let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1

"NERDTree
map <F7> :NERDTreeToggle<CR>

"Omni Completion
fun! OmniComplete()
    let left = strpart(getline('.'), col('.') - 2, 1)
    if left =~ "^$"
        return ""
    elseif left =~ ' $'
        return ""
    else
        return "\<C-x>\<C-o>"
endfun
 
inoremap <silent> <S-Tab> <C-R>=OmniComplete()<CR>
"turn the txt green
"autocmd FileType txt colorscheme green

" turn on Omni completion
autocmd FileType c set ofu=ccomplete#Complete
autocmd FileType php set ofu=phpcomplete#CompletePHP
autocmd FileType python set ofu=pythoncomplete#Complete
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType javascript set ofu=javascriptcomplete#CompleteJS
autocmd FileType html set ofu=htmlcomplete#CompleteTags
autocmd FileType css set ofu=csscomplete#CompleteCSS
autocmd FileType xml set ofu=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"Grep
nnoremap <silent> <F3> :Grep<CR>
"xpdf
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
"latex
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

autocmd FileType tex map <F9> :TTarget pdf<CR>


" SCOPE script F5 submit


"autocmd FileType scopescript map <F6> :!scope submit -i % -vc vc://cosmos05/spo.prod -f yxshJob_%<CR>
"autocmd FileType scopescript map <F7> :!scope submit -i % -vc vc://cosmos05/spo.adhoc -f yxshJob_% -p 100<CR>
"autocmd FileType scopescript map <F8> :!scope submit -i % -vc vc://cosmos05/spo.prod -f yxshJob_% -p 100<CR>
" JSON
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd 
  autocmd! 
  autocmd FileType json set autoindent 
  autocmd FileType json set formatoptions=tcq2l 
  autocmd FileType json set textwidth=78 shiftwidth=2 
  autocmd FileType json set softtabstop=2 tabstop=8 
  autocmd FileType json set expandtab 
  autocmd FileType json set foldmethod=syntax 
augroup END

" highlight scope syntax
au! BufRead,BufNewFile *.script set filetype=scope
autocmd FileType scope set tabstop=4
autocmd FileType scope set foldmethod=marker
autocmd FileType scope map <F5> :!scope submit -i % -vc vc://cosmos08/MMRepository.prod -f yxshJob_%<CR>
"=========my own function==================

source $VIMRUNTIME/myfunction/convertCodeToXML.vim

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction




"=======end my own set======================
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
command! PrettyXML call DoPrettyXML()
