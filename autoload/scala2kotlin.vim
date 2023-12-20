"-------------------------------------------------------------------------------
"  Description: Convert Scala to Koltin
"   Maintainer: Martin Krischik «krischik@users.sourceforge.net»
"       Author: Martin Krischik «krischik@users.sourceforge.net»
"    Copyright: Copyright © 2023 Martin Krischik
" Name Of File: autoload/scala2kotlin.vim
"      Version: 1.4
"	 Usage: copy to autoload directory
"      History: 10.11.2023 MK Initial Release
"		12.11.2023 MK more illegal characters corrected
"       	22.11.2023 MK Fixes and additional conversions. Project logo.
"       	27.11.2023 MK Description
"       	20.12.2023 MK ScalaScript to KotlinScript converter
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
    's,'e substitute /::class.qualifiedName/::class.java.getName()/e
    's,'e substitute /\.getLogManager$/\.getLogManager ()/e
    's,'e substitute /Init_Logger ()/companion object\r{\rinit\r{\rnet.sourceforge.uiq3.test.Init_Logger()\r}\r}/
    's,'e g /\V[lL]ogger.log (\$/ join
    ")
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
endfunction "s:Tagged_Scenario

function! s:Expand_Import(Package, Imports)
    let l:Retval = ""

    for l:Import in a:Imports->split(",")
	let l:Retval = l:Retval . "import " . a:Package . "." . l:Import->trim() . "\r"
    endfor

    return l:Retval
endfunction "s:Expand_Import

function! s:Convert ()
    's,'e substitute /\v<extends>/:/e
    's,'e substitute /\v<def>/fun/e
    's,'e substitute /\v<BigInt>/BigInteger/e
    's,'e substitute /\v<BigInt>/BigInteger/e
    's,'e substitute /\v<trait>/interface/e
"   's,'e substitute /\V[/</e
"   's,'e substitute /\V]/>/e
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

    " convert for
    "
    's,'e substitute /for (\(.\{-}\) <- \(.\{-}\) to \(.\{-}\))/ for (\1 in \2 .. \3)/e

    " convert potential constructors
    "
    's,'e substitute /fun this\s\=(/constructor(/e
    's,'e substitute /fun apply\s\=(/constructor(/e
    "))))

    's,'e substitute /this wait/(this as Object).wait/e
    's,'e substitute /this synchronized/synchronized(this)/e

    " merge multi line package declamations
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
    's,'e substitute /raw"\(.\{-}\)"/"""\1"""/e

    " Array to string
    "
    's,'e substitute /\Vdeep.toString ()/contentToString ()/e

    " don't replace the with in the whole files as it is used in strings and comments as well
    "
    's,/class/+5 substitute /\v<with>/,/e
endfunction "s:Convert

""
"   The `ScalaConvertBDDTest` converts unit test using the `org.scalatest.featurespec.AnyFeatureSpec` and
"   `org.scalatest.GivenWhenThen` unit test framework. Each feature is converted into a nested class and each scenario
"   is converted into a method. Again using the back tick notation.
"
function! scala2kotlin#Convert_BDD_Test()
    call scala2kotlin#Convert ()

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
.

    " convert Scenarios to functions
    "
    's,'e substitute /Scenario ("\(.\{-}\)")/@org.junit.jupiter.api.Test\r    fun `Scenario \1` ()/e
    's,'e substitute /Scenario ("\(.\{-}\)",\(.\{-}\))/\= s:Tagged_Scenario(submatch(1),submatch(2)) /e
    's,'e substitute /Feature ("\(.\{-}\)")/@org.junit.jupiter.api.Nested\r    inner class `Feature \1`/e


    " convert assertions
    "
    's,'e substitute /\<\(.\{-}\)\> should not be null/assertThat(\1, `is`(notNullValue()))/e
    's,'e substitute /^\(.*\) should equal \(.*\)$/assertThat(\1, equalTo \2)/e

    call scala2kotlin#Logging()
    call scala2kotlin#Replace_Illegal_Method_Character()
    call s:Runner()
    return
endfunction "scala2kotlin#Convert_BDD_Test

""
"   The `ScalaConvertFunctionTest` converts unit test using the `org.scalatest.funsuite.AnyFunSuite` unit test
"   framework. Each function test is converted into method using the back tick notation for the function name. 
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
    's,'e substitute /\(.\{-}\) should have length \(.\{-}\)/assertThat(\1, aFileWithSize(\2));

    "" 
    " make convesions explicit.
    "
    's,'e substitute !(\(".\{-}"\) \([-+*/]\) \(".\{-}"\))!ℝ (\1) \2 ℝ (\3)!e
   
    return
endfunction "scala2kotlin#Convert_Function_Test


""
"   Even with `…` there are two characters which are forbidden. Replace with
"   Unicode variants.
"
function! scala2kotlin#Replace_Illegal_Method_Character()
   global /\<fun\> `/ substitute /\V./․/ge
   global /\<fun\> `/ substitute /\V;/¦/ge
   global /\<fun\> `/ substitute !\V/!⁄!ge
   global /\<fun\> `/ substitute /\V"/“/ge
   global /\<fun\> `/ substitute /\V:/¦/ge
   global /\<fun\> `/ substitute /\V*/×/ge
   global /\<fun\> `/ substitute /\V>/≫/ge
   global /\<fun\> `/ substitute /\V</≪/ge
   global /\<fun\> `/ substitute /\V?/¿/ge
   global /\<fun\> `/ substitute /\V[/⟦/ge
   global /\<fun\> `/ substitute /\V]/⟧/ge

   global /\<class\> `/ substitute /\V./․/ge
   global /\<class\> `/ substitute !\V/!⁄!ge
   global /\<class\> `/ substitute /\V"/“/ge
   global /\<class\> `/ substitute /\V:/¦/ge
   global /\<class\> `/ substitute /\V*/×/ge
   global /\<class\> `/ substitute /\V>/≫/ge
   global /\<class\> `/ substitute /\V</≪/ge
   global /\<class\> `/ substitute /\V?/¿/ge
endfunction "scala2kotlin#Replace_Illegal_Method_Character

""
" The `ScalaConvert` performs the main conversion part. It converts syntax, data type and some common methods.
"
function! scala2kotlin#Convert ()
    1
    /^package\>/ mark s
    /vim: set/   mark e

    call s:Convert ()

    " remove obsolete stuff
    "
    global !// @formatter:off!			delete
    global !// @formatter:on!			delete
    global /scala.language.implicitConversions/ delete
    global /scala.language.postfixOps/		delete

    " change file type 
    "
    'e,$  substitute /filetype=scala/filetype=kotlin/e
    set filetype=kotlin
endfunction "scala2kotlin#Convert

""
" The `ScalaConvert` performs the main conversion part for Scal. It converts syntax, data type and some common methods.
"
function! scala2kotlin#ConvertScript ()
    1
    /^import\>/ mark s
    /vim: set/  mark e

    call s:Convert ()

    's,'e substitute /\[Scala]/[Kotlin]/
    global /import scala.sys.process._/	delete
 
    " change file type 
    "
    'e,$  substitute /filetype=scala/filetype=kotlin/e
    'e,$  substitute /fileformat=dos/fileformat=unix/e
    set filetype=kotlin fileformat=unix
endfunction "scala2kotlin#ConvertScript

""
"   Scala lists use `::` and `:::` as concatenate command and `Nil` to represent literals of lists. The command replaces
"   the literal with a call to the `listOf` method. Select the literal to convert before calling the command.
"
function! scala2kotlin#List_Litereal () range
    execute  a:firstline . " mark s"
    execute  a:lastline  . " mark e"

    "	Replace :: with ,
    "
    's,'e  substitute /:::/+ listOf (/ge
    's,'e  substitute /::/,/ge
    ")

    if a:firstline == a:lastline
	" remove Nil
	"
	. substitute /,\s*Nil/)/e
	"  begin list with listOf (
	"
	. substitute /(/(listOf(/e
	")))
    else
	" remove Nil
	"
	execute a:lastline . ' substitute /\(,\|\)\s\=Nil/)/e'
	execute a:lastline . '-1 substitute /,$//e'

	"  begin list with listOf (
	"
	execute a:firstline
	insert
	    listOf (
.
	")
    endif
endfunction "scala2kotlin#List_Litereal

""
"   Scala allows multiple imports with one import statement using `{…}` notation. This command will replace them with
"   separate imports. Select the import to convert before calling the command.
"
function! scala2kotlin#Multi_Import () range
    execute  a:firstline . " mark s"
    execute  a:lastline  . " mark e"

    "	join selected lines 
    "
    's,'e join

    . substitute /import \(.\{-}\).{\(.\{-}\)}/\= s:Expand_Import (submatch(1),submatch(2)) / 
endfunction "scala2kotlin#Multi_Import

""
"   Scala allows multiple imports with one import statement using `{…}` notation. This command will replace them with
"   separate imports. Select the import to convert before calling the command.
"
function! scala2kotlin#Lamda () range
    execute  a:firstline . " mark s"
    execute  a:lastline  . " mark e"

    "	join selected lines 
    "
    's,'s substitute /() ->/{/
    's,'e substitute /.*\zs,/},/

endfunction "scala2kotlin#Lamda

""
"   Converts calls to logger to Info calls
"
function! scala2kotlin#Log_To_Info () range
    execute  a:firstline . " mark s"
    execute  a:lastline  . " mark e"

    "	join selected lines 
    "
    's,'e join

    . substitute /logger.log\s\=(\s\=logging.Level.FINE, \(".\{-}"\), \(.\{-}\))/Info (\1 + \2)/
    . substitute /{0}//e
endfunction "scala2kotlin#Log_To_Info

""
"   surrounds info calls for features with init()
"
function! scala2kotlin#Feature_Info () range
    execute  a:firstline . "mark s"
    execute  a:lastline  . "mark e"

    if a:firstline == a:lastline
	. substitute /info (\(".\{-}"\))/init {\rInfo (\1)\r}/
    else
	's,'s	substitute /info ("/init {\rInfo ("""/
	's+2,'e substitute /^\s*info ("//
	's,'e-1 substitute /")$//
	'e,'e	substitute /")$/""")\r}/
    endif
endfunction "scala2kotlin#Feature_Info

" vim: set textwidth=120 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
" vim: set filetype=vim fileencoding=utf8 fileformat=unix foldmethod=marker :
" vim: set spell spelllang=en_gb :
