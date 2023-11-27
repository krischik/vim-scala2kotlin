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

### `ScalaConvert`

```vim
function scala2kotlin#Convert()
```

The `ScalaConvert` performs the main conversion part. It converts syntax, data type and some common methods.

### `ScalaConvertFunctionTest`

```vim
function scala2kotlin#Convert_Function_Test()
```

The `ScalaConvertFunctionTest` converts unit test using the `org.scalatest.funsuite.AnyFunSuite` unit test framework.
Each function test is converted into method using the back tick notation for the function name

### `ScalaConvertBDDTest`

```vim
function scala2kotlin#Convert_BDD_Test()
```

The `ScalaConvertBDDTest` converts unit test using the `org.scalatest.featurespec.AnyFeatureSpec` and
`org.scalatest.GivenWhenThen` unit test framework. Each feature is converted into a nested class and each scenario is
converted into a method. Again using the back tick notation.

### `ScalaReplaceIllegalCharacters`

```vim
function scala2kotlin#Replace_Illegal_Method_Character()
```

Even with `…` notation there are few characters which are either forbidden or problematic on windows. The
`ScalaReplaceIllegalCharacters` command replaces them with Unicode look alike which are not problematic.

### `ScalaConvertListLitereal` 

```vim
function scala2kotlin#List_Litereal()
```

Scala lists use `::` and `:::` as concatenate command and `Nil` to represent literals of lists. The command replaces the
literal with a call to the `listOf` method. Select the literal to convert before calling the command.

### `ScalaConvertMultiImport` 

```vim
function scala2kotlin#Multi_Import()
```

Scala allows multiple imports with one import statement using `{…}` notation. This command will replace them with
separate imports. Select the import to convert before calling the command.

<!-- vim: set textwidth=120 wrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab : -->
<!-- vim: set filetype=markdown fileencoding=utf-8 fileformat=unix foldmethod=marker : -->
<!-- vim: set spell spelllang=en : -->
