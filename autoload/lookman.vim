let s:save_cpo = &cpo
set cpo&vim

"======================
"SCRITP VALIABLES
"======================
let s:defWindow = {"position":"right","height":10,"width":83}
let s:pluginPath = expand("<sfile>:p:h:h")
let s:window = get(g:,'lookmanWindow',s:defWindow)
let s:shell = get(g:,'shellPath','/bin/bash')
let s:canvas = get(g:,'lookmanCanvas', s:pluginPath.'/canvas.txt')
let s:os = get(g:,'lookmanOS',system('uname'))[0:-2]

"======================
"GLOBAL VALIABLES
"======================

let g:lookman#man_sessions = {}

function! lookman#test()
  echo s:os
endfunction

"======================
"GET MANPAGE
"======================

function! lookman#getmanpage(cmd)
  if s:os == "Linux"
    return "man " . a:cmd
  elseif s:os == "Darwin"
    return "man " . a:cmd . "| colcrt -"
  else
    return s:os
  endif
endfunction

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
function! lookman#showmanpage(bufname,cmd) abort
	"l:direction 'v'/''
	let l:direction = ""
	let l:windowsize = 0
	let l:splitright = &splitright
	let l:splitbelow = &splitbelow
  let current_winid = bufwinid('%')

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
  
  if bufexists(a:bufname)
    call win_gotoid(g:lookman#man_sessions[a:bufname])
  else
    execute l:windowsize.l:direction."new " . a:bufname
  endif

  set buftype=nofile
  let g:lookman#man_sessions[a:bufname] = bufwinid(a:bufname)
  let l:cmd = lookman#getmanpage(a:cmd)
  let l:txt = system("bash -c \"". l:cmd . " > .man.txt\"")
  execute("e .man.txt")
  set readonly
  set syntax=man

	let &splitright = l:splitright
	let &splitbelow = l:splitbelow
  call win_gotoid(l:current_winid)

endfunction

function! lookman#getman(cmd)
  !/bin/bash -c "man ls | colcrt - > ls.txt"   
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
