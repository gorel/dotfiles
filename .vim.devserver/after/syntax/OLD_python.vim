" put in $HOME/.vim/after/syntax/python.vim
if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif

syn include @SQL syntax/hql.vim
syn include @Stan syntax/stan.vim

if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif


" We don't need these (a string inside a string!)
syn cluster SQL remove=sqlString,sqlComment
syn cluster Stan remove=stanString

" Clear existing syntax
syntax clear pythonString

" Triple-quoted strings can contain SQL. This is the same as the original
" except with @SQL added in contains=
syn region  pythonString
  \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
  \ contains=pythonEscape,@Spell
syn region  pythonTString
  \ start=+[uU]\=\z('''\|"""\)+hs=s+3 end="\z1"he=s-3 keepend
 \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
syn region  pythonRawString
  \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
  \ contains=@Spell
syn region  pythonTRawString
  \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend
  \ contains=pythonSpaceError,pythonDoctest,@Spell

syn region SQLEmbedded contains=@SQL contained containedin=pythonTString,pythonTRawString
  \ start=+\('''\|"""\)\(\_.\("""\)\@!\)*\%(ALTER\|COMMENT\|CREATE\|DELETE\|DROP\|EXPLAIN\|ANALYZE\|INSERT\|GROUP BY\|USING\|GROUPING SET\|CUBE\|SELECT\|UNION ALL\)+rs=s+3,hs=s+3,ms=s+3
  \ end=+\%$+re=s-3,he=s-3,me=s-3
  \ keepend

syn region StanEmbedded contains=@Stan contained containedin=pythonTString,pythonTRawString
  \ start=+\z('''\|"""\)\%(\_.\%("""\|'''\)\@!\)*\%(data\)\%(\s\|\_$\)*{\%(\_.\%('''\|"""\)\@!\)*}\%(\_.\%('''\|"""\)\@!\)*model\%(\s\|\_$\)*{\%(\_.\%('''\|"""\)\@!\)*}+rs=s+3,hs=s+3,ms=s+3
  \ end=+\z1+re=s-3,he=s-3,me=s-3
  \ keepend

let b:current_syntax = 'python'
