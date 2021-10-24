# BoatTEST

Boat's TrulyEasySimpleTesting - A Luau unit testing framework. Inspired by Elttob's FusionCI.

![image](https://user-images.githubusercontent.com/40185666/138577802-788bb760-c40a-4e8a-b810-63775eeebe9a.png)
![image](https://user-images.githubusercontent.com/40185666/138577827-f54eecc3-7e17-4d4e-b8e4-7c88f53a94c0.png)

## API

```Lua
function BoatTEST.run(config: dictionary)
```

`config.directories` -
A table of Instances to search for .spec ModuleScripts within

`config.includeDescendants` -
A boolean that defines whether to run all descendant spec files of directories or just the direct children

`config.onlyShowFailures` -
A boolean that defines whether the output will only include failed tests

`config.verbose` -
A boolean that defines whether verbose logging is enabled

```Lua
function BoatTEST.this(value: any)
```

Takes in a value, that then gets used in assertions

`.never` -
Reverses whatever the assertion is (ie `this(nil).never.exists()` will pass)

`.exists()`, `.exist()` -
Asserts that value is non-nil

`.equal(expectedValue)`, `.equal(expectedValue)` -
Asserts that value is equal to expectedValue

`.isA(expectedType)` -
Asserts that typeof(value) is equal to expectedType

`.fails()`, `.fail()`, `.throws()`, `.throw()` -
Asserts that value will error when called

`.matches(pattern)`, `.match(pattern)` -
Asserts that string.match(value, pattern) exists

`.literally.anything.you.write.that.isnt.part.of.the.api` -
Does nothing at all so that you can write sentences in your tests (ie `this(function() end).will.never.throw()` is valid since .will has no effect)

```Lua
.spec Files
```

A module returns a dictionary of functions that take in the skip callback, like so:

```Lua
local BoatTEST = require(workspace.BoatTEST)
local this = BoatTEST.this

return {
	["this test should pass"] = function(skip)
		this(1+1).equals(2)
	end,

	["this test should skip"] = function(skip)
		skip("because we are demoing the skip feature")

		warn("This line won't run because it is skipped")
	end,

	["this test should fail"] = function(skip)
		this("sample string").equals("a different string")
	end,
}
```
