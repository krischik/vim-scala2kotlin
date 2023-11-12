"-------------------------------------------------------------------------------
"  Description: Convert Scala to Koltin
"  Description: Convert PMWiki to Markdown
"   Maintainer: Martin Krischik «krischik@users.sourceforge.net»
"       Author: Martin Krischik «krischik@users.sourceforge.net»
"    Copyright: Copyright © 2023 Martin Krischik
" Name Of File: autoload/scala2kotlin.vim
"      Version: 1.0
"	 Usage: copy to autoloa directory
"      History: 10.11.2023 MK Initial Release
"-------------------------------------------------------------------------------

" One line copy/paste helper for aid converting hamcrest unit tests.

. substitute !(\(".\{-}"\) \(.\{-}\) \(".\{-}"\))!ℝ (\1).\2 (ℝ (\3))!
. substitute !(\(".\{-}"\) \(.\{-}\) \(".\{-}"\))!ℝ (\1).\2 (ℚ (\3))!
. substitute !(\(".\{-}"\) \(.\{-}\) \(".\{-}"\))!ℚ (\1).\2 (ℚ (\3))!
. substitute !(\(".\{-}"\) \(.\{-}\) \(.\{-}\))!ℚ (\1).\2 (\3)!
. substitute !\(".\{-}"\)\.\(.\{-}\),!ℝ (\1).\2(),!
. substitute !\(".\{-}"\)\.\(.\{-}\),!ℤ (\1).\2(),!
. substitute !\(".\{-}"\)\.\(.\{-}\),!ℚ (\1).\2(),!
. substitute/".\{-}"/ℤ (\0)/
. substitute/".\{-}"/ℚ (\0)/
. substitute /equalTo("\([-+.0-9e]*\)")/equalTo(ℝ("\1"))/
. substitute /equalTo("\([-+0-9e]*\)")/equalTo(ℤ("\1"))/
. substitute !equalTo("\([-+0-9/ ]*\)")!equalTo(ℚ("\1"))!
. substitute /equalTo(("\([-+.0-9e]*\)"))/equalTo(ℝ("\1"))/
. substitute /equalTo(("\([-+0-9]*\)"))/equalTo(ℤ("\1"))/
. substitute !equalTo(("\([-+0-9/ ]*\)"))!equalTo(ℚ("\1"))!
. 
. substitute / \(.\{-}\) should be ('\(\k\{-}\))/assertThat(\1, hasProperty("\2", equalTo(true)))/
. substitute / \(.\{-}\) should not be '\(\k\{-}\)/assertThat(\1, hasProperty("\2", %equalTo(false)))/

" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set nospell spelllang=en_bg :
