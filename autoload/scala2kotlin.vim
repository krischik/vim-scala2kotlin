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
"
"
function! scala2kotlin#Convert_BDD_Test()
    1
    /^package\>/ mark s
    /vim: set/   mark e


    " Add common test libraries.
    "
    's append
import net.sourceforge.uiq3.test.And
import net.sourceforge.uiq3.test.Feature
import net.sourceforge.uiq3.test.Given;
import net.sourceforge.uiq3.test.Info;
import net.sourceforge.uiq3.test.Then
import net.sourceforge.uiq3.test.When;
import org.hamcrest.core.Is.`is` as Is
import org.hamcrest.core.IsNull.notNullValue
import org.hamcrest.core.IsNull.nullValue
import org.hamcrest.core.IsEqual.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.jupiter.api.Test
.

   " Convert logging TAG
   "
   's,'e substitute /classOf<\(.\{-}\)>\.getName/\1::class.qualifiedName/e
   's,'e substitute /\.getLogManager$/\.getLogManager ()/e

   " Convert test runner.
   "
   's,'e substitute !// @org.junit.runner.RunWith (classOf<org.scalatest.junit.JUnitRunner>)!@org.junit.jupiter.api.TestInstance(org.junit.jupiter.api.TestInstance.Lifecycle.PER_CLASS)!


   ""
   " convert Scenarios to functions
   "
   's,'e substitute /Scenario ("\(.\{-}\)")/@org.junit.jupiter.api.Test\r    fun `Scenario \1` ()/
   's,'e substitute /\<\(.\{-}\)\> should not be null/assertThat(\1, `is`(notNullValue()))/
endfunction "scala2kotlin#Convert_BDD_Test

""
"
"
function! scala2kotlin#Convert_Function_Test()
    1
    /^package\>/ mark s
    /vim: set/   mark e

    global /extends org.scalatest.funsuite.AnyFunSuite/ delete
    global /org.scalatest.matchers.should.Matchers/ delete
    global /org.scalatest.funsuite.AnyFunSuite/ delete
    global /test.Numeric_Utilities/ delete

    " Add common test libraries.
    "
    's append
import org.hamcrest.core.Is.`is` as Is
import org.hamcrest.core.IsNull.notNullValue
import org.hamcrest.core.IsEqual.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.jupiter.api.Test
.

   " Convert logging TAG
   "
   's,'e substitute /classOf<\(.\{-}\)>\.getName/\1::class.qualifiedName/e
   's,'e substitute /\.getLogManager$/\.getLogManager ()/e
   's,'e substitute /Init_Logger ()/companion object\r{\rinit\r{\rnet.sourceforge.uiq3.test.Init_Logger()\r}\r}/

   " Convert test runner.
   "
   's,'e substitute !// @org.junit.runner.RunWith (classOf<org.scalatest.junit.JUnitRunner>)!@org.junit.jupiter.api.TestInstance(org.junit.jupiter.api.TestInstance.Lifecycle.PER_CLASS)!


   ""
   " convert Scenarios to functions
   "
   's,'e substitute /test ("\(.\{-}\)")/@org.junit.jupiter.api.Test\r    fun `Test \1` ()/e
   's,'e substitute /\<\(.\{-}\)\> should not be null/assertThat(\1, Is (notNullValue()))/e
   's,'e substitute /^\(.*\) should equal \(.*\)$/assertThat(\1, equalTo (\2))/e
endfunction "scala2kotlin#Convert_Function_Test

""
"
"
function! scala2kotlin#Convert ()
    1
    /^package\>/ mark s
    /vim: set/   mark e

    set filetype=kotlin

    's,'e substitute /\v<extends>/:/e
    's,'e substitute /\v<def>/fun/e
    's,'e substitute /\v<BigInt>/BigInteger/e
    's,'e substitute /\v<trait>/interface/e
    's,'e substitute /\V[/</e
    's,'e substitute /\V]/>/e
    's,'e substitute / = {/ {/e
    's,'e substitute /\v<new>/ /e
    's,'e substitute /\<Future\s\=</CompletableFuture </e
    's,'e substitute /\<Promise\s\=</CompletableFuture </e
    's,'e substitute /\<Array\s\=<Byte>(/ ByteArray(/e
    's,'e substitute /\<Array\s\=<Char>(/ CharArray(/e
    's,'e substitute /\v<with>/,/e
    's,'e substitute /\v<match>/when/e
    's,'e substitute /case class/data class/e
    's,'e substitute /case _/else/e
    's,'e substitute /case //e
    's,'e substitute /=>/->/e
    's,'e substitute /.asInstanceOf</ as ") /e
    's,'e substitute /\v<final>//e
    's,'e substitute /fun this(/constructor(/e
    's,'e substitute /\<Seq\s\=</List </e
    's,'e substitute /\<IndexedSeq\s\=</List </e
    's,'e substitute /<:/:/e
    's,'e substitute /\V@inline\>/inline/e

    global /scala.language.implicitConversions/ delete

    'e,$  substitute /filetype=scala/filetype=kotlin/
endfunction "scala2kotlin#Convert

" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set nospell spelllang=en_bg :
