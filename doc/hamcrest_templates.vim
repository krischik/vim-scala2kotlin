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


. substitute /for (\(.\{-}\) <- \(.\{-}\) to \(.\{-}\))/for (\1 in \2 .. \3)/

. substitute / \(.\{-}\) should be (\(.\{-}\))/assertThat(\1, equalTo(\2))/
. substitute / \(.\{-}\) should fullyMatch regex (\(.\{-}\))/assertThat(\1, matchesPattern(\2))/
. substitute /assertThat(\s*\(.\{-}\).javaClass, equalTo (\(.\{-}\)::class.java))/assertThat(\1, instanceOf(\2::class.java))/
. substitute /an <\(.\{-}\)> should be thrownBy \(.\{-}\)$/assertThrows<\1>({ \2 }) 


. substitute /\<\(.\{-}\)\> synchronized/synchronized(\1)/e

. substitute /info (\(".\{-}"\))/init {\rInfo (\1)\r}/

% substitute !\Vjava.io.File("src/test/\(\.\{-}\)",\s\=\(net.sourceforge.uiq3.fa2.Files.\.\{-}\).Java_Filename)!\2.As_Absolute_Path("\1")

. substitute /logger.log\s\=(logging.Level.FINE, \(".\{-}"\), \(.\{-}\))/Info (\1 + \2)/

%s/Display_Text (0)/Display_Text [0]/
%s/Form.Indicators (\(".\{-}"\))/Form.Indicators [\1]/

global /=$/ join

/::/,/Nil)/ ScalaConvertListLitereal

" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set nospell spelllang=en_bg :
