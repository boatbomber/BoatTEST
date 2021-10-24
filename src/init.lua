-- Lazy load entry point for BoatTEST

return setmetatable({}, {
	-- Lazy loader
	__index = function(t, key)
		local cached = rawget(t, key)
		if cached then
			return cached
		end

		local module = script:FindFirstChild(key)
		if not module then
			return nil
		end

		local value = require(module)
		rawset(t, key, value)

		return value
	end,

	-- Write protection
	__newindex = function()
		error("BoatTEST is read-only")
	end,
})
