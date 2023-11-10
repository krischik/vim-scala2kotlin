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

""
"   Converts most of PMWiki syntax to markdown. Currently only the three types
"   of tables need to be concerted seperatly.
"
function! scala2kotlin#Convert ()
    % substitute /extends/:/
    % substitute / def / fun /
    % substitute /BigInt(/BigInteger(/
    % substitute /trait/interface/
    % substitute /[/</
    % substitute /]/>/
    % substitute / = {/ {/
    % substitute / new / /
    % substitute / Future</ CompletableFuture</
    % substitute / Promise</ CompletableFuture</
    % substitute / Array<Byte>(/ ByteArray(/
    % substitute / Array<Char>(/ CharArray(/
    % substitute /with/,/
    % substitute /match/when/
    % substitute /case class/data class/
    % substitute /case _/else/
    % substitute /case //
    % substitute /=>/->/
    % substitute /.asInstanceOf</ as ") //manually fix >
    % substitute /final //
    % substitute /fun this(/constructor(/
    % substitute / Seq</ List</
    % substitute / IndexedSeq</ List</
    % substitute /<:/:/
endfunction "pm2md#Convert_Simple_Table

" vim: set textwidth=78 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding= fileformat=unix foldmethod=marker :
" vim: set nospell spelllang=en_bg :
