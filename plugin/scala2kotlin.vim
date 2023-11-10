"-------------------------------------------------------------------------------
"  Description: Convert Scala to Koltin 
"   Maintainer: Martin Krischik «krischik@users.sourceforge.net»
"       Author: Martin Krischik «krischik@users.sourceforge.net»
"    Copyright: Copyright © 2023 Martin Krischik
" Name Of File: autoload/scala2kotlin.vim
"      Version: 1.0
"	 Usage: copy to autoloa directory
"      History: 10.11.2023 MK Initial Release
"-------------------------------------------------------------------------------

command	ScalaConvert :call scala2kotlin#Convert()

50amenu Plugin.Convert.Scala\ Convert<tab>ScalaConvert :ScalaConvert<CR>

" vim: set textwidth=78 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding= fileformat=unix foldmethod=marker :
" vim: set nospell spelllang=en_bg :
