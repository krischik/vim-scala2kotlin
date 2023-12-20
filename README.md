# Scala to Kotlin Converter

![Scala to Kotlin Converter](Pictures/Project_logo.png)

Convert Scala source code to Kotlin source code. Optimized for unit test.

## Installation

If you can use the usual git based package manager ([dein](https://github.com/Shougo/dein.vim),
(vim-plug)[https://github.com/junegunn/vim-plug] etc) to install the converter. But you can also just load the converter
into your current session:

```vim
:source …/autoload/scala2kotlin.vim<CR>"
:source …/plugin/scala2kotlin.vim<CR>"
```

This is especially useful if converting Scala to Kotlin is a one off effort and you don't want to use the converter all
the time.

## Usage

Note that Scala has a very extensive syntax with many quirks. It's not possible to create an one size fits all
conversion. As such the conversion is done in steps.

### ScalaConvert

```vim
function scala2kotlin#Convert()
```

The `ScalaConvert` performs the main conversion part. It converts syntax, data type and some common methods.

### ScalaConvertScript

```vim
function scala2kotlin#ConvertScript()
```

The `ScalaConvertScript` performs the main conversion part for ScalaScript. It converts syntax, data type and some
common methods.

### ScalaConvertFunctionTest

```vim
function scala2kotlin#Convert_Function_Test()
```

The `ScalaConvertFunctionTest` converts unit test using the `org.scalatest.funsuite.AnyFunSuite` unit test framework.
Each function test is converted into method using the back tick notation for the function name. Call `ScalaConvert'
first.

### ScalaConvertBDDTest

```vim
function scala2kotlin#Convert_BDD_Test()
```

The `ScalaConvertBDDTest` converts unit test using the `org.scalatest.featurespec.AnyFeatureSpec` and
`org.scalatest.GivenWhenThen` unit test framework. Each feature is converted into a nested class and each scenario is
converted into a method. Again using the back tick notation. Call `ScalaConvert'
first.

### ScalaReplaceIllegalCharacters

```vim
function scala2kotlin#Replace_Illegal_Method_Character()
```

Even with `…` notation there are few characters which are either forbidden or problematic on windows. The
`ScalaReplaceIllegalCharacters` command replaces them with Unicode look alike which are not problematic.

### ScalaConvertListLitereal

```vim
function scala2kotlin#List_Litereal()
```

Scala lists use `::` and `:::` as concatenate command and `Nil` to represent literals of lists. The command replaces the
literal with a call to the `listOf` method. Select the literal to convert before calling the command.

### ScalaConvertMultiImport

```vim
function scala2kotlin#Multi_Import()
```

Scala allows multiple imports with one import statement using `{…}` notation. This command will replace them with
separate imports. Select the import to convert before calling the command.

# Other converter.

## [How I ported 10K lines of Scala to Kotlin in one week?!](https://medium.com/hackernoon/how-i-ported-10k-lines-of-scala-to-kotlin-in-one-week-c645732d3c1)

Kotlin Script I used as the base for my converter. While I use KotlinScript was well VimScript is so much more powerful
when it comes to transforming text.

## [Scala to Kotlin Converter](https://plugins.jetbrains.com/plugin/11103-scala-to-kotlin-converter/versions)

Not compatible with «IntelliJ IDEA 2023.2.5» or «Android Studio 2022.3.1» and as such not very useful. You would
need to install a very old IDEA to use it.

## [CodeConvert](https://www.codeconvert.ai/scala-to-kotlin-converter)

Commercial online converter. Won't convert Scala based DSL which includes most unit and instrumentations tests. For
larger projects you will have to pay eventually.

<!-- vim: set textwidth=120 wrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab : -->
<!-- vim: set filetype=markdown fileencoding=utf-8 fileformat=unix foldmethod=marker : -->
<!-- vim: set spell spelllang=en : -->
