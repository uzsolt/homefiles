" LaTeX filetype plugin
" Language:     LaTeX (ft=tex)
" Maintainer:   Benji Fisher, Ph.D. <benji@member.AMS.org>
" Version:	1.4
" Last Change:	Wed 19 Apr 2006
"  URL:		http://www.vim.org/script.php?script_id=411
" Only do this when not done yet for this buffer.

"colorscheme molokai
if exists("b:did_ftplugin")
  finish
endif

" Start with plain TeX.  This will also define b:did_ftplugin .
" source $VIMRUNTIME/ftplugin/plaintex.vim

" Avoid problems if running in 'compatible' mode.
let s:save_cpo = &cpo
set cpo&vim

" Allow "[d" to be used to find a macro definition:
" Recognize plain TeX \def as well as LaTeX \newcommand and \renewcommand .
" I may as well add the AMS-LaTeX DeclareMathOperator as well.
let &l:define .= '\|\\\(re\)\=new\(boolean\|command\|counter\|environment\|font'
	\ . '\|if\|length\|savebox\|theorem\(style\)\=\)\s*\*\=\s*{\='
	\ . '\|DeclareMathOperator\s*{\=\s*'

" Tell Vim how to recognize LaTeX \include{foo} and plain \input bar :
let &l:include .= '\|\\include{'
" On some file systems, "{" and "}" are inluded in 'isfname'.  In case the
" TeX file has \include{fname} (LaTeX only), strip everything except "fname".
let &l:includeexpr = "substitute(v:fname, '^.\\{-}{\\|}.*', '', 'g')"

" The following lines enable the macros/matchit.vim plugin for
" extended matching with the % key.
" ftplugin/plaintex.vim already defines b:match_skip and b:match_ignorecase
" and matches \(, \), \[, \], \{, and \} .
"if exists("loaded_matchit")
"  let b:match_words .= ',\\begin\s*\({\a\+\*\=}\):\\end\s*\1'
"endif " exists("loaded_matchit")

let &cpo = s:save_cpo

se textwidth=75

map <buffer> @a :TTemplate alap<CR><C-J>
map <buffer> @d :TTemplate dolgozat<CR><C-J>
map <buffer> @f :TTemplate feladatsor<CR><C-J>
map <buffer> @o :TTemplate osszefoglalo<CR><C-J>

" questions - exsheets package
let g:Tex_Env_pontozas="\\begin{pontozas}\<CR>\\pontoz{<++>}{<++>}{<++>}\<CR><++>\<CR>\\end{pontozas}"
let g:Tex_Env_questionpont="\\begin{question}{<++>}\<CR><++>\<CR>\\end{question}\<CR><++>"
let g:Tex_Env_question="\\begin{question}\<CR><++>\<CR>\\end{question}\<CR><++>"
let g:Tex_Env_tasks="\\begin{tasks}\<CR>\\task <++>\<CR>\\end{tasks}\<CR><++>"
let g:Tex_Env_taskspont="\\begin{tasks}\<CR>\\task\\subpoints{<++>} <++>\<CR>\\end{tasks}\<CR><++>"
let g:Tex_Env_mpc="\\begin{tasks}[style=multiplechoice](<++>)\<CR>\\task <++>\<CR>\\end{tasks}\<CR><++>"
let g:Tex_Com_hely="\\hely{<++>cm}<++>"
let g:Tex_Com_pontoz="\\pontoz{<+leírás+>}{<+pontszám+>}{<+megjegyzés+>}\<CR><++>"
let g:Tex_Com_subpoints="\\subpoints{<++>}\<CR><++>"
let g:Tex_Com_task="\\task "
let g:Tex_Com_Task="\\task\\subpoints{<++>} <++> "
let g:Tex_Com_vary="\\vary{<++>}{<++>}"
let g:Tex_Com_Vary="\\vary{\<CR><++>\<CR>}{\<CR><++>\<CR>}"
let g:Tex_Com_vegeredmeny="\\vegeredmeny{<++>}<++>"

let g:Tex_ItemStyle_pontozas=g:Tex_Com_pontoz

call IMAP('??',g:Tex_Env_questionpont,'tex')
call IMAP('?q',g:Tex_Env_question,'tex')
call IMAP('?t',g:Tex_Env_tasks,'tex')
call IMAP('?T',g:Tex_Env_taskspont,'tex')
call IMAP('?c',g:Tex_Env_mpc,'tex')
call IMAP('?p',g:Tex_Com_task,'tex')
call IMAP('?P',g:Tex_Com_Task,'tex')
call IMAP('?s',g:Tex_Env_pontozas,'tex')
call IMAP('?e',g:Tex_Com_hely,'tex')
call IMAP('?r',g:Tex_Com_pontoz,'tex')
call IMAP('?j',g:Tex_Com_subpoints,'tex')
call IMAP('?v',g:Tex_Com_vary,"tex")
call IMAP('?V',g:Tex_Com_Vary,"tex")
call IMAP('.v',Tex_Com_vegeredmeny,"tex")
call IMAP('?o',"\\ora{<++>}{<++>}\<CR><++>","tex")

call IMAP('.->',"\\rightarrow ",'tex')
call IMAP('.=>',"\\Rightarrow ",'tex')
call IMAP('.|>',"\\mapsto ",'tex')

call IMAP('.R',"\\mathbb{R}",'tex')
call IMAP('.Z',"\\mathbb{Z}",'tex')
call IMAP('.N',"\\mathbb{N}",'tex')

call IMAP('.D',"\\displaystyle ",'tex')
call IMAP('.T',"\\text{<++>}<++> ",'tex')

call IMAP('//',"\\frac{<++>}{<++>}",'tex')

" siunitx package
call IMAP('.si','\SI{<++>}{<++>}<++>','tex')
call IMAP('.n','\num{<++>}<++>','tex')
call IMAP('.c','\celsius','tex')
call IMAP('.p','\per ','tex')
call IMAP('.it',"\\begin{itemize}\<CR>\\item <++>\<CR>\\end{itemize}\<CR><++>",'tex')
call IMAP('.%','\SI{<++>}{\percent}<++>','tex')

call IMAP(':*','\cdot ','tex')

" to insert 'é'
imap <buffer> <leader>it <Plug>Tex_InsertItemOnThisLine

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
let g:Tex_ViewRule_ps = 'ghostview'
"let g:Tex_ViewRule_pdf = '/home/users/zsolt/bin/latex-viewer -watch -widgetless -scale 0.6'
let g:Tex_ViewRule_pdf = '/home/zsolt/bin/latex-viewer '
let g:Tex_ViewRule_dvi = 'xdvi'
let g:Tex_Leader = "'"
let g:Tex_Leader2 = ':'
let g:Tex_CompileRule_pdf = "/home/zsolt/bin/latex-compile -interaction=nonstopmode -shell-escape $*"
let s:target = 'pdf'

let g:Tex_IgnoredWarnings =
	\'Underfull'."\n".
	\'Overfull'."\n".
	\'specifier changed to'."\n".
	\'You have requested'."\n".
	\'Missing number, treated as zero.'."\n".
	\'There were undefined references'."\n".
	\'Citation %.%# undefined'."\n".
	\'Overwriting file'."\n".
    \'Marginpar on page'."\n" .
    \'LaTeX Font Warning: Font shape'."\n" .
    \'LaTeX Font Warning: Size substitutions'."\n" .
    \'Package auxhook Warning: Cannot patch' . "\n" .
    \'Package hyperref Warning: Option' . "\n" .
    \'Package pgfplots Warning: running' . "\n" .
    \'Package csquotes Warning: No style for language' . "\n" .
    \'Package magyar.ldf Warning: No effect on' . "\n"

let g:Tex_IgnoreLevel=20

let g:Imap_PlaceHolderStart = '|<'
let g:Imap_PlaceHolderEnd = '>|'

set spell
set spellsuggest=best,5

" vim:sts=2:sw=2:
