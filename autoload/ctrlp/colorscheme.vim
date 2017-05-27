" =============================================================================
" File:          autoload/ctrlp/colorscheme.vim
" Description:   Color scheme extension for ctrlp.vim
" =============================================================================

" Load guard
if ( exists('g:loaded_ctrlp_colorscheme') && g:loaded_ctrlp_colorscheme )
      \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_colorscheme = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
      \ 'init': 'ctrlp#colorscheme#init()',
      \ 'accept': 'ctrlp#colorscheme#accept',
      \ 'lname': 'colorscheme',
      \ 'sname': 'colo',
      \ 'type': 'line',
      \ 'enter': 'ctrlp#colorscheme#enter()',
      \ 'exit': 'ctrlp#colorscheme#exit()',
      \ 'opts': 'ctrlp#colorscheme#opts()',
      \ 'sort': 0,
      \ 'specinput': 0,
      \ })


" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#colorscheme#init()
  let input = map(
        \ split(globpath(&rtp, 'colors/*.vim'), '\n'),
        \ 'fnamemodify(v:val, ":t:r")')
  return input
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#colorscheme#accept(mode, str)
  call ctrlp#exit()
  if exists('g:ctrlp_ext_color_command')
    execute g:ctrlp_ext_color_command a:str
  else
    execute 'colorscheme' a:str
  endif
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#colorscheme#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#colorscheme#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#colorscheme#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#colorscheme#id()
  return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/colorscheme.vim
" command! CtrlPColorScheme call ctrlp#init(ctrlp#colorscheme#id())


" vim:nofen:fdl=0:ts=2:sw=2:sts=2
