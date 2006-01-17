" HiMtchBrkt : a rudimentary attempt to highlight matching brackets
"  Author:  Charles E. Campbell, Jr.  <drNchipO@ScampbellPfamilyA.Mbiz>-NOSPAM
"  Date:    Jan 17, 2006
"  Version: 19
"
" A Vim v6.0 plugin with menus for gvim
"
" Usage: {{{1
"   \[i : initialize highlighting of matching bracket
"   \[s : stop       highlighting of matching bracket
"
"   Actually, <Leader> is used, so you may set mapleader to change
"   the leading backslash to whatever you want in your <.vimrc>
"   See :help mapleader.
"
" GetLatestVimScripts: 1435 1 :AutoInstall: HiMtchBrkt.vim
" GetLatestVimScripts: 1066 1 cecutil.vim
" ---------------------------------------------------------------------
" Load Once: {{{1
if &cp || exists("g:loaded_HiMtchBrkt")
 finish
endif
let g:loaded_HiMtchBrkt = "v19"
let s:keepcpo           = &cpo
set cpo&vim

" ---------------------------------------------------------------------
" Public Interface: {{{1
if !hasmapto('<Plug>HMBStart')
 map <unique> <Leader>[i	<Plug>HMBStart
endif
if !hasmapto('<Plug>HMBStop')
 map <unique> <Leader>[s	<Plug>HMBStop
endif
com! HMBstart	:set lz|call <SID>HMBStart()|set nolz
com! HMBstop 	:set lz|call <SID>HMBStop()|set nolz

" ---------------------------------------------------------------------
" Global Maps: {{{1
nmap <silent> <unique> <script> <Plug>HMBStart :set lz<CR>:call <SID>HMBStart()<CR>:set nolz<CR>
nmap <silent> <unique> <script> <Plug>HMBStop  :set lz<CR>:call <SID>HMBStop()<CR>:set nolz<CR>

" DrChip menu support:
if has("gui_running") && has("menu")
 if !exists("g:DrChipTopLvlMenu")
  let g:DrChipTopLvlMenu= "DrChip."
 endif
 exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[i	<Leader>[i'
endif

" =====================================================================
" HMBStart: {{{1
fun! <SID>HMBStart()
"  call Dfunc("HMBStart()")

  " set whichwrap
  let s:wwkeep= &ww
  set ww=b,s,<,>,[,]

  if exists("g:dohimtchbrkt") && g:dohimtchbrkt == 1
   " already in HiMtchBrkt mode
   if &cmdheight >= 2
    echo "[HiMtchBrkt]"
   endif
"   call Dret("HMBStart : already in HiMtchBrkt mode")
   return
  endif
  let g:dohimtchbrkt= 1
 
  " Save Maps (if any)
  call SaveUserMaps("n","",":F(","HiMtchBrkt")
  call SaveUserMaps("n","",":F)","HiMtchBrkt")
  call SaveUserMaps("n","",":F[","HiMtchBrkt")
  call SaveUserMaps("n","",":F]","HiMtchBrkt")
  call SaveUserMaps("n","",":F{","HiMtchBrkt")
  call SaveUserMaps("n","",":F}","HiMtchBrkt")
  call SaveUserMaps("n","",":f(","HiMtchBrkt")
  call SaveUserMaps("n","",":f)","HiMtchBrkt")
  call SaveUserMaps("n","",":f[","HiMtchBrkt")
  call SaveUserMaps("n","",":f]","HiMtchBrkt")
  call SaveUserMaps("n","",":f{","HiMtchBrkt")
  call SaveUserMaps("n","",":f}","HiMtchBrkt")
  call SaveUserMaps("n","","<c-b>","HiMtchBrkt")
  call SaveUserMaps("n","","<c-d>","HiMtchBrkt")
  call SaveUserMaps("n","","<c-f>","HiMtchBrkt")
  call SaveUserMaps("n","","<c-u>","HiMtchBrkt")
  call SaveUserMaps("n","","<down>","HiMtchBrkt")
  call SaveUserMaps("n","","<PageDown>","HiMtchBrkt")
  call SaveUserMaps("n","","<end>","HiMtchBrkt")
  call SaveUserMaps("n","","<home>","HiMtchBrkt")
  call SaveUserMaps("n","","<left>","HiMtchBrkt")
  call SaveUserMaps("n","","<right>","HiMtchBrkt")
  call SaveUserMaps("n","","<space>","HiMtchBrkt")
  call SaveUserMaps("n","","<up>","HiMtchBrkt")
  call SaveUserMaps("n","","<PageUp>","HiMtchBrkt")
  call SaveUserMaps("n","","webWEBjklh$0%;,nN","HiMtchBrkt")
  call SaveUserMaps("o","","<down>","HiMtchBrkt")
  call SaveUserMaps("o","","<end>","HiMtchBrkt")
  call SaveUserMaps("o","","<home>","HiMtchBrkt")
  call SaveUserMaps("o","","<left>","HiMtchBrkt")
  call SaveUserMaps("o","","<right>","HiMtchBrkt")
  call SaveUserMaps("o","","<up>","HiMtchBrkt")
  if has("gui_running") && has("mouse")
   call SaveUserMaps("n","","<leftmouse>","HiMtchBrkt")
   call SaveUserMaps("o","","<leftmouse>","HiMtchBrkt")
  endif
  if v:version > 602 || v:version == 602 && has("patch405")
   call SaveUserMaps("n","","0","HiMtchBrkt")
  endif
 
  " indicate in HiMtchBrkt mode
  if &cmdheight >= 2
   echo "[HiMtchBrkt]"
  endif
 
  " Install HiMtchBrkt maps
  if has("gui_running")
   call HMBMapper("<down>"    , "<down>"    , "<down>")
   call HMBMapper("<up>"      , "<up>"      , "<up>")
   call HMBMapper("<right>"   , "<right>"   , "<right>")
   call HMBMapper("<left>"    , "<left>"    , "<left>")
   call HMBMapper("<home>"    , "<home>"    , "<home>")
   call HMBMapper("<end>"     , "<end>"     , "<end>")
   call HMBMapper("<space>"   , "<space>"   , "")
   call HMBMapper("<PageUp>"  , "<PageUp>"  , "<PageUp>")
   call HMBMapper("<PageDown>", "<PageDown>", "<PageDown>")
  else
   call HMBMapper("<down>"    , "j"    , "<c-o>j"    )
   call HMBMapper("<up>"      , "k"    , "<c-o>k"    )
   call HMBMapper("<right>"   , "l"    , "<c-o>l"    )
   call HMBMapper("<left>"    , "h"    , "<c-o>h"    )
   call HMBMapper("<home>"    , "0"    , "<c-o>0"    )
   call HMBMapper("<end>"     , "$"    , "<c-o>$"    )
   call HMBMapper("<space>"   , "l"    , ""          )
   call HMBMapper("<PageUp>"  , "<c-b>", "<c-o><c-b>")
   call HMBMapper("<PageDown>", "<c-f>", "<c-o><c-f>")
  endif
  if has("gui_running") && has ("mouse")
   call HMBMapper("<leftmouse>","<leftmouse>","<leftmouse>")
  endif
  if v:version > 602 || v:version == 602 && has("patch405")
   call HMBMapper('0'    , '0'    , '')
  endif
  call HMBMapper('b'    , 'b'    , '')
  call HMBMapper('B'    , 'B'    , '')
  call HMBMapper('e'    , 'e'    , '')
  call HMBMapper('E'    , 'E'    , '')
  call HMBMapper('h'    , 'h'    , '')
  call HMBMapper('j'    , 'j'    , '')
  call HMBMapper('k'    , 'k'    , '')
  call HMBMapper('l'    , 'l'    , '')
  call HMBMapper('n'    , 'n'    , '')
  call HMBMapper('N'    , 'N'    , '')
  call HMBMapper('$'    , '$'    , '')
  call HMBMapper('%'    , '%'    , '')
  call HMBMapper('w'    , 'w'    , '')
  call HMBMapper('W'    , 'W'    , '')
  call HMBMapper("<c-f>", "<c-f>", "")
  call HMBMapper("<c-b>", "<c-b>", "")
  call HMBMapper("<c-d>", "<c-d>", "")
  call HMBMapper("<c-u>", "<c-u>", "")
  call HMBMapper('f('   , 'f('   , '')
  call HMBMapper('f)'   , 'f)'   , '')
  call HMBMapper('f{'   , 'f{'   , '')
  call HMBMapper('f}'   , 'f}'   , '')
  call HMBMapper('f['   , 'f['   , '')
  call HMBMapper('f]'   , 'f]'   , '')
  call HMBMapper('F('   , 'F('   , '')
  call HMBMapper('F)'   , 'F)'   , '')
  call HMBMapper('F{'   , 'F{'   , '')
  call HMBMapper('F}'   , 'F}'   , '')
  call HMBMapper('F['   , 'F['   , '')
  call HMBMapper('F]'   , 'F]'   , '')
  if exists("mapleader")
   if mapleader != ';'
   	call HMBMapper(';',';','')
   endif
   if mapleader != ','
   	call HMBMapper(',',',','')
   endif
  else
   	call HMBMapper(';',';','')
   	call HMBMapper(',',',','')
  endif
 
  " use CursorHold event to do a belated highlighing of matching bracket
  " to handle motions not directly handled above
  if !exists("g:himtchbrkt_nocursorhold")
   " keep and set options
   let g:himtchbrkt_utkeep= &ut
   if exists("g:himtchbrkt_ut")
   	let &ut= g:himtchbrkt_ut
   else
   	" I'd like to set ut even faster, but unfortunately that clears
	" status-line messages before people have a chance to read them
    set ut=2000
   endif
   augroup HMBEvent
    au!
    au CursorHold * if getline(line(".")) != "" | silent call s:HiMatchBracket() | endif
   augroup END
  endif
 
  " Insert stop  HiMtchBrkt into menu
  " Delete start HiMtchBrkt from menu
  if has("gui_running") && has("menu")
   exe 'unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start'
   exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop<tab><Leader>[s	<Leader>[s'
  endif
 
"  call Dret("HMBStart")
endfun

" ---------------------------------------------------------------------
" HMBStop: turn  HiMtchBrkt mode off: restore motion key maps to prior {{{1
" settings (if any), restore visual beeps, restore CursorHold update timer.
fun! <SID>HMBStop()
"  call Dfunc("HMBStop()")
  if !exists("g:dohimtchbrkt")
   if &cmdheight >= 2
    echo "[HiMtchBrkt off]"
   endif
"   call Dret("HMBStop")
   return
  endif
  unlet g:dohimtchbrkt
  match none
 
  " remove cursorhold event for highlighting matching bracket
  if !exists("g:himtchbrkt_nocursorhold")
   augroup HMBEvent
    au!
   augroup END
  endif
 
  if &cmdheight >= 2
   echo "[HiMtchBrkt off]"
  endif
 
  " restore user map(s), if any
  call RestoreUserMaps("HiMtchBrkt")
  let &ww= s:wwkeep
 
  " Insert start HiMtchBrkt into menu
  " Delete stop  HiMtchBrkt from menu
  if has("gui_running") && has("menu")
   exe 'unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop'
   exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[s	<Leader>[i'
  endif
"  call Dret("HMBStop")
endfun

" ---------------------------------------------------------------------
" HiMatchBracket: this routine actually performs the highlighting of {{{1
" the matching bracket.
fun! <SID>HiMatchBracket()
"  call Dfunc("HiMatchBracket()")

  " save
  let regdq            = @"
  let regunnamed       = @@
  let sokeep           = &so
  let solkeep          = &sol
  let t_vbkeep         = &t_vb
  let vbkeep           = &vb
  silent! let regpaste = @*

  " turn beep/visual flash off
  set nosol vb t_vb= so=0

  let mps= substitute(&mps,'\(.\).','\1','g')
  norm! vy
  let swp= SaveWinPosn(0)

"  call Decho("HiMatchBracket: stridx(mps<".mps.">,@0<".@0.">)=".stridx(mps,@0))
  if stridx(mps,@0) != -1
   let curline  = line('.')
   let curcol   = virtcol('.')
   keepj norm! H
   let hline    = line('.')
   if hline != curline
   	call RestoreWinPosn(swp)
   endif
   keepj norm! %
   let mtchline = line('.')
   let mtchcol  = virtcol('.')
   call RestoreWinPosn(swp)
   exe 'match Search /\%'.mtchline.'l\%'.mtchcol.'v/'
"   call Decho("cur[".curline.",".curcol."] hline=".hline." mtch[".mtchline.",".mtchcol."]")
  else
   match none
  endif
 
  " restore
  let @"         = regdq
  let @@         = regunnamed
  let &sol       = solkeep
  let &so        = sokeep
  let &t_vb      = t_vbkeep
  let &vb        = vbkeep
  silent! let @* = regpaste

"  call Dret("HiMatchBracket")
endfun

" ---------------------------------------------------------------------
" HMBMapper: {{{1
fun! HMBMapper(lhs,nrhs,irhs)
"  call Dfunc("HMBMapper(.lhs<".a:lhs."> nrhs<".a:nrhs."> irhs<".a:irhs.">)")

  " overload normal mode mapping
  let rhs= maparg(a:lhs,"n")
"  call Decho("rhs<".rhs.">")
  if rhs == "" | let rhs= a:nrhs | endif
  exe "nno <silent> ".a:lhs." ".rhs.":silent call <SID>HiMatchBracket()<CR>"
"  call Decho("exe nno <silent> ".a:lhs." ".rhs.":silent call <SID>HiMatchBracket()<CR>")

  if a:irhs != ""
  " overload insert mode mapping
   let rhs= maparg(a:lhs,"i")
"   call Decho("rhs<".rhs.">")
   if rhs == "" | let rhs= a:irhs | endif
   exe "ino <silent> ".a:lhs." ".rhs."<c-o>:silent call <SID>HiMatchBracket()<CR>"
"   call Decho("exe ino <silent> ".a:lhs." ".rhs."<c-o>:silent call <SID>HiMatchBracket()<CR>")
  endif
"  call Dret("HMBMapper")
endfun

" ---------------------------------------------------------------------
"  Insure cecutil has been loaded: {{{1

if exists("g:HiMtchBrktOn") && g:HiMtchBrktOn != 0
 if !exists("*SaveUserMaps")
  " due to loading order, <plugin/cecutil.vim> may not have loaded yet.
  " attempt to force a load now.
  silent! runtime plugin/cecutil.vim
 endif
 silent HMBstart
endif

let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  vim: ts=4 fdm=marker
