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
"   Convert logging TAG
"
function! scala2kotlin#Logging()
    1
    /^package\>/ mark s
    /vim: set/   mark e

    's,'e substitute /classOf\s\=\[\(.\{-}\)]\.getName/\1::class.qualifiedName/e
    's,'e substitute /classOf\s\=<\(.\{-}\)>\.getName/\1::class.qualifiedName/e
    's,'e substitute /::class.qualifiedName/::class.java.getName()/
    's,'e substitute /\.getLogManager$/\.getLogManager ()/e
    's,'e substitute /Init_Logger ()/companion object\r{\rinit\r{\rnet.sourceforge.uiq3.test.Init_Logger()\r}\r}/
    return   
endfunction scala2kotlin#Logging()

""
"   Convert test runner.
"
function! s:Runner()
    's,'e substitute !// @org.junit.runner.RunWith (classOf\s\=<org.scalatest.junit.JUnitRunner>)!@org.junit.jupiter.api.TestInstance(org.junit.jupiter.api.TestInstance.Lifecycle.PER_CLASS)!
    return   
endfunction s:Runner()

function! s:Tagged_Scenario(Name, Tags)
    let l:Retval = "@org.junit.jupiter.api.Test\r"

    for l:Tag in a:Tags->split(",")
	let l:Retval = l:Retval . '@org.junit.jupiter.api.Tag("' . l:Tag->trim() . '")' . "\r"
    endfor

    let l:Retval = l:Retval . "fun `Scenario " . a:Name . "` ()"

    return l:Retval
endfunction "Tagged_Scenario

""
"   Replace buisniess drivend development tests
"
function! scala2kotlin#Convert_BDD_Test()
    1
    /^package\>/ mark s
    /vim: set/   mark e

    global /org.scalatest.featurespec.AnyFeatureSpec/ delete
    global /org.scalatest.GivenWhenThen/ delete
    global /org.scalatest.matchers.should.Matchers/ delete
    global /org.scalatest.matchers.should.Matchers/ delete
    global /test.Numeric_Utilities/ delete


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

    call scala2kotlin#Logging()
    call s:Runner()

    " convert Scenarios to functions
    "
    's,'e substitute /Scenario ("\(.\{-}\)")/@org.junit.jupiter.api.Test\r    fun `Scenario \1` ()/e
    's,'e substitute /Scenario ("\(.\{-}\)",\(.\{-}\))/\= s:Tagged_Scenario(submatch(1),submatch(2)) /e
    's,'e substitute /Feature ("\(.\{-}\)")/@org.junit.jupiter.api.Nested\r    inner class `Feature \1`/e


    " convert assertions
    "
    's,'e substitute /\<\(.\{-}\)\> should not be null/assertThat(\1, `is`(notNullValue()))/e
    's,'e substitute /^\(.*\) should equal \(.*\)$/assertThat(\1, equalTo (\2))/e
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

    call scala2kotlin#Logging()
    call s:Runner()

    ""
    " convert Tests to functions
    "
    's,'e substitute /test ("\(.\{-}\)")/@org.junit.jupiter.api.Test\r    fun `Test \1` ()/e
    's,'e substitute /\<\(.\{-}\)\> should not be null/assertThat(\1, Is (notNullValue()))/e
    's,'e substitute /^\(.*\) should equal \(.*\)$/assertThat(\1, equalTo (\2))/e


    "" 
    " make convesions explicit.
    "
    's,'e substitute !(\(".\{-}"\) \([-+*/]\) \(".\{-}"\))!ℝ (\1) \2 ℝ (\3)!e
   
    return
endfunction "scala2kotlin#Convert_Function_Test


""
"   Even with `…` there are two characters which are forbidden. Replace with
"   unitcode variants.
"
function! scala2kotlin#Convert_Function_Name()
   global /\<fun\> `/ substitute /\V./․/g
   global /\<fun\> `/ substitute !\V/!⁄!g
   global /\<fun\> `/ substitute /\V"/“/g
endfunction "scala2kotlin#Convert_Function_Name

""
"
"
function! scala2kotlin#Convert ()
    1
    /^package\>/ mark s
    /vim: set/   mark e

    's,'e substitute /\v<extends>/:/e
    's,'e substitute /\v<def>/fun/e
    's,'e substitute /\v<BigInt>/BigInteger/e
    's,'e substitute /\v<BigInt>/BigInteger/e
    's,'e substitute /\v<trait>/interface/e
    's,'e substitute /\V[/</e
    's,'e substitute /\V]/>/e
    's,'e substitute / = {/ {/e
    "}}
    's,'e substitute /\v<new>/ /e
    's,'e substitute /\<Future\s\=</CompletableFuture </e
    's,'e substitute /\<Promise\s\=</CompletableFuture </e
    's,'e substitute /\<Array\s\=<Boolean>/BooleanArray/e
    's,'e substitute /\<Array\s\=\[Boolean]/BooleanArray/e
    's,'e substitute /\<Array\s\=\[Short]/ShortArray/e
    's,'e substitute /\<Array\s\=<Short>/ShortArray/e
    's,'e substitute /\<Array\s\=<Byte>/ByteArray/e
    's,'e substitute /\<Array\s\=<Char>/CharArray/e
    's,'e substitute /\v<with>/,/e
    's,'e substitute /\v<match>/when/e
    's,'e substitute /case class/data class/e
    's,'e substitute /case _/else/e
    's,'e substitute /case //e
    's,'e substitute /=>/->/e
    's,'e substitute /.asInstanceOf</ as ") /e
    's,'e substitute /\v<final>//e
    's,'e substitute /\<Seq\s\=</List </e
    's,'e substitute /\<IndexedSeq\s\=</List </e
    's,'e substitute /<:/:/e
    's,'e substitute /\V@inline\>/inline/e
    's,'e substitute /\<getClass\>/javaClass/e
    's,'e substitute /classOf\s\=<\(\k\{-}\)>/\1::class.java/e
    's,'e substitute /classOf\s\=[\(\k\{-}\)]/\1::class.java/e
    's,'e substitute /private\s\=<\i\{-}>/private/e

    " converrt potential constucters
    "
    's,'e substitute /fun this\s\=(/constructor(/e
    's,'e substitute /fun apply\s\=(/constructor(/e
    "))))

    's,'e substitute /this wait/(this as Object).wait/e
    's,'e substitute /this synchronized/synchronized(this)/e

    " merge multi line package declatations
    "
    's,'s+1 substitute /package \(.*\)\npackage \(.*\)/package \1.\2/e

    " I use Retval for all return values which makes stuff a little easier
    "
    's,'e substitute /^\s*Retval$/return Retval/e

    " Change catch from try catch.
    "
    's,'e substitute /\c\(exception\): \(.\{-}\) ->/catch (\1: \2)/e

    " raw strings.
    "
    's,'e substitute /raw"\(.\{-}\)"/"""\1"""/

    " Array to string
    "
    's,'e substitute /\Vdeep.toString ()/contentToString ()/

    " Obsosolete stuff
    "
    global /scala.language.implicitConversions/ delete
    global !// @formatter:off!			delete
    global !// @formatter:on!			delete

    " change filetype 
    "
    'e,$  substitute /filetype=scala/filetype=kotlin/
    set filetype=kotlin
endfunction "scala2kotlin#Convert

""
"   Convert a list literal. 
"
function! scala2kotlin#List_Litereal () range
    "	Replace :: with ,
    "
    execute a:firstline . "," . a:lastline " substitute /::/,/ge"

    " remove Nil
    execute a:lastline . ' substitute /\\(,\\|\\)\\s\\=Nil/)/e'

    "  begin list with listOf (
    "
    execute a:firstline
    insert
listOf (
.
endfunction ")scala2kotlin#List_Litereal

" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set nospell spelllang=en_bg :
