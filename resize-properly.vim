scriptencoding utf-8

" vim-surii-saizu
" Author: Sheldon Johnson
" Version: 0.1

if exists('g:loaded_surii_saizu') || &compatible
  finish
endif

let g:loaded_surii_saizu = 1

augroup ResizeProperly
  autocmd!
  autocmd WinNew,WinEnter * call RPUpdateWindowRatios()
  autocmd VimResized * call RPResizeWindows() | call RPUpdateWindowRatios() | redraw
augroup END

function! RPUpdateWindowRatios()
  let g:rp_window_ratios = RPGetWindowRatios()
endfunction

function! RPGetWindowRatios()
  let l:dict = {}

  for i in range(1, winnr('$'))
    let l:dict[i] = RPGetWindowRatio(i)
  endfor

  return l:dict
endfunction

function! RPGetWindowRatio(winnr)
  let l:width_fraction = floor(winwidth(a:winnr)) / floor(&columns)
  let l:height_fraction = floor(winheight(a:winnr)) / floor(&lines)
  return [l:width_fraction, l:height_fraction]
endfunction

function! RPResizeWindows()
  for i in keys(g:rp_window_ratios)
    let l:width = float2nr(round(g:rp_window_ratios[i][0] * floor(&columns)))
    let l:cmd = "vertical " . i . "resize " . l:width
    execute l:cmd

    let l:height = float2nr(round(g:rp_window_ratios[i][1] * floor(&lines)))
    let l:cmd =  "resize " . l:height
    execute l:cmd
  endfor
endfunction

call RPUpdateWindowRatios()
