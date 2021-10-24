local BoatTEST = require(workspace.BoatTEST)
local this = BoatTEST.this

return {
	["undefined variable should never exist"] = function(skip)
		this(_).never.exists()
	end,

	["1+1 should equal 2"] = function(skip)
		this(1+1).will.equal(2)
	end,

	["tests can write full sentences"] = function(skip)
		this(true).you.can.write.anything.as.long.as.it.ends.with.a.valid.assertion.like.exists()
	end,

	["this test will skip"] = function(skip)
		skip("because we are demonstrating the skip feature")

		warn("This line won't run because it is skipped")
	end,

	["no-op will never throw"] = function(skip)
		this(function() end).never.throws()
	end,

	["this test will fail"] = function(skip)
		this("sample string").matches("a pattern that isn't in the value")
	end,

	["Random:NextNumber() should be a number value"] = function(skip)
		local r = Random.new()
		this(r:NextNumber()).isA("number")
	end,
}
