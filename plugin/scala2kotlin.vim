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

command	ScalaConvert		    :call scala2kotlin#Convert()
command	ScalaConvertBDDTest	    :call scala2kotlin#Convert_BDD_Test()
command	ScalaConvertFunctionName    :call scala2kotlin#Convert_Function_Name()
command	ScalaConvertFunctionTest    :call scala2kotlin#Convert_Function_Test()
command	ScalaConvertLogging	    :call scala2kotlin#Logging()
command ScalaNumInteger		    :.substitute /\v(".{-}") (.{-}) (".{-}")/ℤ (\1).\2(ℤ (\3))/


50amenu Plugin.Convert.Scala\ Convert<tab>ScalaConvert				    :ScalaConvert<CR>
50amenu Plugin.Convert.Scala\ Convert\ Logging<tab>ScalaConvertLogging		    :ScalaConvertLogging<CR>
50amenu Plugin.Convert.Scala\ Convert\ Function\ Name<tab>ScalaConvertFunctionName  :ScalaConvertFunctionName<CR>
50amenu Plugin.Convert.Scala\ Convert\ Function\ Test<tab>ScalaConvertFunctionTest  :ScalaConvertFunctionTest<CR>
50amenu Plugin.Convert.Scala\ Convert\ BDD\ Test<tab>ScalaConvertBDDTest	    :ScalaConvertBDDTest<CR>

" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set nospell spelllang=en_bg :
