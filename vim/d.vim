" Clear out trailing whitespace
autocmd BufWritePre *.d,*.di :call Preserve("%s/\\s\\+$//e")
autocmd BufWritePre *.d,*.di :retab!
