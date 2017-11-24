scriptencoding utf-8

" vim-in-proportion
" Author: Sheldon Johnson
" Version: 0.1

if exists('g:loaded_in_proportion') || &compatible
  finish
endif

let g:loaded_in_proportion = 1

augroup in_proportion
  autocmd!
  autocmd WinNew,WinEnter * call in_proportion#UpdateWindowRatios()
  autocmd VimResized *
        \ call in_proportion#ResizeWindows() |
        \ call in_proportion#UpdateWindowRatios() |
        \ redraw
augroup END

function! in_proportion#UpdateWindowRatios()
  let g:in_proportion_window_ratios = in_proportion#GetWindowRatios()
endfunction

function! in_proportion#GetWindowRatios()
  let l:dict = {}

  for i in range(1, winnr('$'))
    let l:dict[i] = in_proportion#GetWindowRatio(i)
  endfor

  return l:dict
endfunction

function! in_proportion#GetWindowRatio(winnr)
  let l:width_fraction = floor(winwidth(a:winnr)) / floor(&columns)
  let l:height_fraction = floor(winheight(a:winnr)) / floor(&lines - 2)
  return [l:width_fraction, l:height_fraction]
endfunction

function! in_proportion#ResizeWindows()
  for i in keys(g:in_proportion_window_ratios)
    let l:width = float2nr(round(g:in_proportion_window_ratios[i][0] * floor(&columns)))
    let l:cmd = "vertical " . i . "resize " . l:width
    execute l:cmd

    let l:height = float2nr(round(g:in_proportion_window_ratios[i][1] * floor(&lines - 2)))
    let l:cmd =  "resize " . l:height
    execute l:cmd
  endfor
endfunction

call in_proportion#UpdateWindowRatios()
