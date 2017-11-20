scriptencoding utf-8

" vim-surii-saizu
" Author: Sheldon Johnson
" Version: 0.1

if exists('g:loaded_surii_saizu') || &compatible
  finish
endif

let g:loaded_surii_saizu = 1

augroup surii_saizu
  autocmd!
  autocmd WinNew,WinEnter * call surii_saizu#UpdateWindowRatios()
  autocmd VimResized * call surii_saizu#ResizeWindows() |
        \ call surii_saizu#UpdateWindowRatios() |
        \ redraw
augroup END

function! surii_saizu#UpdateWindowRatios()
  let g:surii_saizu_window_ratios = surii_saizu#GetWindowRatios()
endfunction

function! surii_saizu#GetWindowRatios()
  let l:dict = {}

  for i in range(1, winnr('$'))
    let l:dict[i] = surii_saizu#GetWindowRatio(i)
  endfor

  return l:dict
endfunction

function! surii_saizu#GetWindowRatio(winnr)
  let l:width_fraction = floor(winwidth(a:winnr)) / floor(&columns)
  let l:height_fraction = floor(winheight(a:winnr)) / floor(&lines)
  return [l:width_fraction, l:height_fraction]
endfunction

function! surii_saizu#ResizeWindows()
  for i in keys(g:surii_saizu_window_ratios)
    let l:width = float2nr(round(g:surii_saizu_window_ratios[i][0] * floor(&columns)))
    let l:cmd = "vertical " . i . "resize " . l:width
    execute l:cmd

    let l:height = float2nr(round(g:surii_saizu_window_ratios[i][1] * floor(&lines)))
    let l:cmd =  "resize " . l:height
    execute l:cmd
  endfor
endfunction

call surii_saizu#UpdateWindowRatios()
