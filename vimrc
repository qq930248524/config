syntax on
set backspace=indent,eol,start
set ai
set background=dark
set number
set novisualbell
set showcmd
set hlsearch    "highlight search
set incsearch   "incremental search
filetype plugin indent on
set autoindent
set smartindent
set cindent
"always show filename
set laststatus=2
set mouse=a
set fileencodings=utf-8,gb18030,gbk,gb2312
set tags=tags
set autochdir
set backspace=indent,eol,start
set foldlevel=19999
set tag=/usr/local/arm-sam/usr/tags
set tags=/home/arm/sam/buildroot-2009.05/build_arm/staging_dir/usr/arm-linux/tags
set tags=/home/ztm2003/ztm2003-nj-board/src/tags
set tags=tags;
set autochdir
 
" 按F11生成个人tags
noremap <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/tags/tags_self<CR>
" 设置tags路径,自动加载个人tags
set tags+=~/.vim/tags/tags_self


"#
" use follow cmd build system header tags
" $ ctags -I __THROW -I __wur -I __attribute_pure__ -I __nonnull -I __attribute__ --c-kinds=+px --fields=+aiKSz --extra=+qf -f ~/.vim/systags /usr/include/* /usr/include/bits/* /usr/include/linux/* /usr/include/sys/*
set tags+=~/.vim/systags
"#
let g:Tlist_Auto_Update=1
let g:Tlist_Process_File_Always=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_WinWidth=25
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Auto_Highlight_Tag=1
let g:Tlist_File_Fold_Auto_Close=1
let g:Tlist_Use_SingleClick=1
"#
"you can use :TOhtml trans a page to a html
"set default use css
let g:html_use_css=1
"#
"This will cause a ":ptag" to be executed for the keyword under the cursor,
	"update time is 4s, or you can use <F3> key to make it work
	":au! CursorHold *.[ch] nested exe "silent! ptag " . expand("<cword>")
	"nnoremap <silent><F3> :exe "silent! ptag " . expand("<cword>")<CR>
	nnoremap <silent><F3> :call PreviewWord("ptjump ")<CR>
	set updatetime=3000
	"#
	"A nice addition is to highlight the found tag, avoid the ":ptag" when there
	"is no word under the cursor, and a few other things: >
	"bug fix: wincmd p/P can't work as hopes
	:au! CursorHold *.[ch] nested call PreviewWord("1ptag ")
:func PreviewWord(cmd)
	:  if &previewwindow                    " don't do this in the preview window
	   "    if in preview window, when use F3, also process
	   "    but autopreview not work.
	   :    if (a:cmd == "1ptag ")
	   :       return
	   :    endif
	   :  endif
	   :  let w = expand("<cword>")            " get the word under cursor
	   :  let cwnum = winnr()                  " get current window number for return back
	   :  if w =~ '\a'                 " if the word contains a letter
		  :
		   :    " Delete any existing highlight before showing another tag
			 :    silent! wincmd P                   " jump to preview window
				:    if &previewwindow                  " if we really get there...
				   :      match none                       " delete existing highlight
				   "      wincmd p                 " back to old window
				   :      exe cwnum . "wincmd w"
				   :    else
				   :      return
				   "      botright split
				   "      resize 8
				   "      set previewwindow
				   "      exe cwnum . "wincmd w"
				   :    endif
				   :
				   :    " Try displaying a matching tag for the word under the cursor
				   :    try
				   :       exe a:cmd . w
				   :    catch
				   :      return
				   :    endtry
				   :
				   :    silent! wincmd P                   " jump to preview window
				   :    if &previewwindow          " if we really get there...
				   :        if has("folding")
				   :          silent! .foldopen          " don't want a closed fold
				   :        endif
				   :        call search("$", "b")                " to end of previous line
				   :        let w = substitute(w, '\\', '\\\\', "")
				   :        call search('\<\V' . w . '\>')       " position cursor on match
				   :        " Add a match highlight to the word at this position
					   :      hi previewWord term=bold ctermbg=green guibg=green
							  :        exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
									"      wincmd p                 " back to old window
										  :      exe cwnum . "wincmd w"
											 :    endif
												:  endif
												   :endfun
												   "#
												   "#
												   "use <F9> to toggle tlist 
												   "nmap <F9> :TlistToggle<CR>:botright split<CR>z10<CR>:set previewwindow<CR><C-W>p
												   nmap <F9> :TlistToggle<CR>
												   "Tlist auto open preview window
	nnoremap <silent><F8> :call MakeIDE()<CR>
				  :func MakeIDE()
						   :    let cwnum = winnr()                " get current window number for return back
								:    silent! wincmd P                   " jump to preview window
									 :    if &previewwindow                  " don't do this in the preview window
										:      wincmd q                         " close it!
										   :      TlistClose                       " close tlist window
										   "      wincmd p                         " return to last window
										   :      exe cwnum . "wincmd w"
										   :      return
										   :    endif
										   :    silent! wincmd b                   " jump to bottom window
										   :    TlistOpen
										   :    wincmd p                           " return to org window
										   "    exe cwnum . "wincmd w"
										   :    botright split
										   :    resize 8
										   :    set previewwindow
										   "    set fix height
										   :    set winfixheight
										   :    wincmd p
										   "    exe cwnum . "wincmd w"
										   :endfun
										   "#
										   map <C-J> <C-W>j<C-W>_
										   map <C-K> <C-W>k<C-W>_
										   set wmh=0
										   "#
										   "for list all match
										   nmap <C-]> g<C-]>
"让vim记忆上次编辑的位置
autocmd BufReadPost *
	\ if line("'\"")>0&&line("'\"")<=line("$") |
	\	exe "normal g'\"" |
	\ endif
"让vim记忆上次编辑的位置
