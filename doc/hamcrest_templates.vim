"-------------------------------------------------------------------------------
"  Description: Convert Scala to Koltin
"   Maintainer: Martin Krischik «krischik@users.sourceforge.net»
"       Author: Martin Krischik «krischik@users.sourceforge.net»
"    Copyright: Copyright © 2023 Martin Krischik
" Name Of File: doc/scala2kotlin.vim
"      Version: 1.4
"	 Usage: Use as copy paste templates. 
"      History: 10.11.2023 MK Initial Release
"		12.11.2023 MK more illegal characters corrected
"       	22.11.2023 MK Fixes and additional conversions. Project logo.
"       	27.11.2023 MK Description
"       	20.12.2023 MK ScalaScript to KotlinScript converter
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
. substitute /an\s\=<\(.\{-}\)>\s\=should be thrownBy \(.\{-}\)$/assertThrows(\1::class.java, { \2 }) 
. substitute /an\s\=\[\(.\{-}\)]\s\=should be thrownBy \(.\{-}\)$/assertThrows(\1::class.java, { \2 }) 


. substitute /\<\(.\{-}\)\> synchronized/synchronized(\1)/e

% substitute !\Vjava.io.File("src/test/\(\.\{-}\)",\s\=\(net.sourceforge.uiq3.fa2.Files.\.\{-}\).Java_Filename)!\2.As_Absolute_Path("\1")!
% substitute !\Vjava.io.File("src/test/\(\.\{-}\)",\s\=\(net.sourceforge.uiq3.fa6.Files.\.\{-}\).Binary_Filename)!\2.Binary_As_Absolute_Path()!
% substitute !\Vjava.io.File("src/test/\(\.\{-}\)",\s\=\(net.sourceforge.uiq3.fa6.Files.\.\{-}\).Text_Filename)!\2.Text_As_Absolute_Path()!
% substitute !\Vjava.io.File("src/test/FX-603P/T603-0.af")!net.sourceforge.uiq3.fa6.Files.Calculator_0.Binary_As_Absolute_Path()!
% substitute !\Vjava.io.File("src/test/FX-603P/T603-T.af")!net.sourceforge.uiq3.fa6.Files.Tape.Binary_As_Absolute_Path()!
% substitute !\Vjava.io.File("src/test/FX-603P/T603-T.at")!net.sourceforge.uiq3.fa6.Files.Tape.Text_As_Absolute_Path()!
% substitute !\Vjava.io.File("src/test/FX-603P/T603-P.at")!net.sourceforge.uiq3.fa6.Files.Printer.Text_As_Absolute_Path()!
% substitute !\Vjava.io.File("src/test/FX-603P/Token.pt")!net.sourceforge.uiq3.fa6.Files.Printer.Text_As_Absolute_Path()!
% substitute !\Vjava.io.File("src/test/FX-603P/Count.pt")!net.sourceforge.uiq3.fa6.Files.Printer.Text_As_Absolute_Path()!

%s/Display_Text (0)/Display_Text [0]/
%s/Form.Display_Text (\(.\{-}\))/Form.Display_Text [\1]/
%s/Form.Indicators (\(.\{-}\))/Form.Indicators [\1]/

global /=$/ join

/::/,/Nil)/ ScalaConvertListLitereal

" use when `with` statements have been accidentally been removed. Normal source has no , with spaces on both sides.
"
% substitute / , / with /gc


% substitute /\sui\./ net.sourceforge.uiq3.fx603p.ui./g
% substitute /\sfx603p\./ net.sourceforge.uiq3.fx603p./g
% substitute /\sfa6\./ net.sourceforge.uiq3.fa6./g

" Replace log with Info
"
% substitute /logger.log\s\=(\s\=java.util.logging.Level.FINE, "\(.\{-}\)",/Info ("\1" + /
% substitute /logger.log\s\=(\s\=logging.Level.FINE, "\(.\{-}\)",/Info ("\1" + /


" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set spell spelllang=en_gb :
