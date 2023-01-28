function! z#callback(item)
  if len(a:item) < 2
    return
  endif
  let cmd = a:item[0]
  let path = a:item[1]
  if !isdirectory(path)
    echoerr "z: <" . path . "> is not found!"
    return
  endif

  if cmd == 'ctrl-t'
    exec 'tabnew'
  endif
  exec printf('cd %s', path)
  doautocmd User Zcd
endfunction

function! z#run(data)
  call fzf#run(fzf#wrap({
        \ 'source': a:data,
        \ 'sink*': function('z#callback'),
        \ 'options': '--ansi --expect=ctrl-t --prompt "Path-z > " --delimiter :',
        \ }))
endfunction
