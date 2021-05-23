let s:save_cpo = &cpo
set cpo&vim
if exists('g:loaded_lookman')
	finish
endif


let &cpo = s:save_cpo
unlet s:save_cpo
