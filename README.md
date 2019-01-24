# newLISP GTK Demos
Minimal examples of GTK applications written completely in newLISP.

Inspired by a Common Lisp project, [Gtk-Demos](https://github.com/mifpasoti/Gtk-Demos).

#### Build library documentation
```bash
$ ./doc/build
$ xdg-open ./doc/index.html
```

#### Run demos as scripts
```bash
$ chmod +x ./src/demo[1-4].nl
$ ./src/demo4.nl
```

#### Build standalone executables
```bash
$ ./bin/build
$ ./bin/demo4
```

#### Project Structure
```
.
├── bin
│   └── build         # Build demos as standalone executables
├── doc
│   └── build         # Build library documentation
├── lib
│   ├── gtk.nl        # GTK FFI
│   ├── roman.nl      # Roman numeral representation from integer
│   ├── spell-int.nl  # Spell out integer in English
│   └── ui.nl         # Stateful wrapper around GTK
├── README.md
└── src
    ├── demo1.nl      # Four buttons demo
    ├── demo2.nl      # Numerals demo
    ├── demo3.nl      # Dates demo
    └── demo4.nl      # Menu demo
```

#### Dependencies
- [newLISP](http://www.newlisp.org/)
- [GTK3](https://www.gtk.org/)

#### Project Notes
The GTK3 shared library path is assumed to be: `/usr/lib/libgtk-3.so.0`
<br>If this is not the case for your system, modify `lib/gtk.nl` accordingly.

Tested on newLISP v.10.7.5 64-bit on Linux, with UTF-8 & libffi support enabled.

#### newLISP Setup Notes

The following [AUR package](https://aur.archlinux.org/packages/newlisp-devel/) is recommended for [Arch Linux](https://www.archlinux.org/) users.

Below is an example of how you could achieve syntax highlighting and REPL integration with [Neovim](https://neovim.io/).

Install [vim-plug](https://github.com/junegunn/vim-plug):
``` bash
$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Modify the init file (`~/.config/nvim/init.vim`):

```vim
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Neovim terminal wrapper
Plug 'kassio/neoterm'

" Precision editing for S-expressions
Plug 'guns/vim-sexp'

" newLISP syntax highlighting
Plug 'joefromct/vim-newlisp.vim'

" Initialize plugin system
call plug#end()

" Map space as leader
let mapleader = "\<Space>"

" Autoscrolling terminal
let g:neoterm_autoscroll = '1'

" Enable vim-sexp
let g:sexp_filetypes = 'newlisp'

" Detect filetype & syntax
autocmd BufNewFile,BufRead *.nl set filetype=newlisp
autocmd FileType newlisp setlocal commentstring=;\ %s

" Send all newLISP forms wrapped in [cmd] tags
" Modified version of TREPLSendSelection
" https://github.com/kassio/neoterm/blob/b4156bd3208c1b96efe53b5407ecda0cf5b5d0f8/autoload/neoterm/repl.vim#L45-L55
function! NlSendSel()
  let [l:lnum1, l:col1] = getpos("'<")[1:2]
  let [l:lnum2, l:col2] = getpos("'>")[1:2]
  if &selection ==# 'exclusive'
    let l:col2 -= 1
  endif
  let l:lines = getline(l:lnum1, l:lnum2)
  let l:lines[-1] = l:lines[-1][:l:col2 - 1]
  let l:lines[0] = l:lines[0][l:col1 - 1:]
  call g:neoterm.repl.exec(["[cmd]"] + l:lines + ["[/cmd]"])
endfunction

command! -range NlSendSel
 \ call NlSendSel()

" Send current top-level compound form to REPL
" space + F
autocmd FileType newlisp nmap <Leader>F v<Plug>(sexp_outer_top_list):NlSendSel<CR>``

" Send current compound form to REPL
" space + f
autocmd FileType newlisp nmap <Leader>f v<Plug>(sexp_outer_list):NlSendSel<CR>``

" Send current element to REPL
" space + e
autocmd FileType newlisp nmap <Leader>e v<Plug>(sexp_inner_element):NlSendSel<CR>``

" Clear REPL
" space + l
autocmd FileType newlisp nmap <Leader>l :Tclear<CR>

" Open REPL
function! Newlisp()
  :vsplit new
  :T newlisp
  :set syntax=newlisp
  :wincmd h
  :TREPLSet 1
endfunction

command! -range Newlisp
 \ call Newlisp()
```

Start Neovim, run `:PlugInstall`.
<br>Open a newLISP file and `:Newlisp` should open a REPL.
