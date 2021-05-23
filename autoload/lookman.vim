let s:save_cpo = &cpo
set cpo&vim

"======================
"VALIABLES
"======================
let s:defWindow = {"position":"right","height":10,"width":50}
let s:pluginPath = expand("<sfile>:p:h:h")
let s:window = get(g:,'lookmanWindow',s:defWindow)
let s:shell = get(g:,'shellPath','/bin/bash')
let s:canvas = get(g:,'lookmanCanvas', s:pluginPath.'/canvas.txt')

"======================
"GET SELECTED WORD
"======================
function! lookman#getCommand() abort
	let l:tmp = @@
	silent normal gvy
	let l:selected = @@
	let @@ = l:tmp
	return l:selected
endfunction

"======================
"SHOW LOOK MAN WINDOW
"======================
function! lookman#showlookmanWindow()
	"l:direction 'v'/''
	let l:direction = ""
	let l:windowsize = 0
	let l:splitright = &splitright
	let l:splitbelow = &splitbelow
	if s:window['position'] == "right"
		let &splitright = 1
		let l:direction = "v"
		let l:windowsize = s:window["width"]
	elseif s:window['position'] == "left"
		let &splitright = 0
		let l:direction = "v"
		let l:windowsize = s:window["width"]
	elseif s:window['position'] == "below"
		let &splitbelow = 1
		let l:direction = ""
		let l:windowsize = s:window["height"]
	elseif s:window['position'] == "above"
		let &splitbelow = 0
		let l:direction = ""
		let l:windowsize = s:window["height"]
	endif
	execute l:windowsize.l:direction."new"
            print(expected,actual)
	let &splitright = l:splitright
	let &splitbelow = l:splitbelow
endfunction

let bufnr = bufadd('someName')
call bufload(bufnr)
call setbufline(bufnr, 1, ['some', 'text'])
let &cpo = s:save_cpo
unlet s:save_cpo
