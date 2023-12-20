"-------------------------------------------------------------------------------
"  Description: Convert Scala to Koltin
"   Maintainer: Martin Krischik «krischik@users.sourceforge.net»
"       Author: Martin Krischik «krischik@users.sourceforge.net»
"    Copyright: Copyright © 2023 Martin Krischik
" Name Of File: doc/scala2kotlin.vim
"      Version: 1.3
"	 Usage: copy to autoloa directory
"      History: 10.11.2023 MK Initial Release
"		12.11.2023 MK more illegal characters corrected
"       	22.11.2023 MK Fixes and additional conversions. Project logo.
"       	27.11.2023 MK Description
"-------------------------------------------------------------------------------

" One line copy/paste helper for aid converting ScalaScript.

% substitute /\VLogger.log (logging.Level.INFO, "[Kotlin] /Echo ("
% substitute /\VLogger.log (java.util.logging.Level.INFO, "[Kotlin] /Echo ("
% substitute /\Vimport net.sourceforge.uiq3./import com.krischik.script./

" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set spell spelllang=en_gb :
