# BoatTEST

Boat's TrulyEasySimpleTesting - A Luau unit testing framework. Inspired by Elttob's FusionCI

## API

```Lua
function BoatTEST.run(config: dictionary)
```

`config.directories`: A table of Instances to search for .spec ModuleScripts within

`config.includeDescendants`: A boolean that defines whether to run all descendant spec files of directories or just the direct children

`config.verbose`: A boolean that defines whether verbose logging is enabled

```Lua
function BoatTEST.this(value: any)
```

Takes in a value, that then gets used in assertions

`.never`
Reverses whatever the assertion is (ie `this(nil).never.exists()` will pass)

`.exists()`, `.exist()`
Asserts that value is non-nil

`.equal(expectedValue)`, `.equal(expectedValue)`
Asserts that value is equal to expectedValue

`.isA(expectedType)`
Asserts that typeof(value) is equal to expectedType

`.fails()`, `.fail()`, `.throws()`, `.throw()`
Asserts that value will error when called

`.matches(pattern)`, `.match(pattern)`
Asserts that string.match(value, pattern) exists

`.literally.anything.you.write.that.isnt.part.of.the.api`
Does nothing at all so that you can write sentences in your tests (ie `this(function() end).will.never.throw()` is valid since .will has no effect)
