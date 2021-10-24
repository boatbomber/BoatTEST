local function thisValue(v: any)
	local query = setmetatable({
		_value = v,
		_never = false,
	}, {
		__index = function(self, key)
			if key == "never" then
				rawset(self, "_never", not rawget(self, "_never"))
			elseif key == "exists" or key == "exist" then
				return function()
					local value = rawget(self, "_value")
					local never = rawget(self, "_never")

					local result = value ~= nil
					if never then
						result = not result
					end
					assert(
						result,
						string.format("Expected value%s to exist, got '%s'", never and " never" or "", tostring(value))
					)
				end
			elseif key == "equal" or key == "equals" then
				return function(expectedValue: any)
					local value = rawget(self, "_value")
					local never = rawget(self, "_never")

					local result = value == expectedValue
					if never then
						result = not result
					end
					assert(
						result,
						string.format(
							"Expected value%s to be '%s', got '%s'",
							never and " never" or "",
							expectedValue,
							tostring(value)
						)
					)
				end
			elseif key == "isA" then
				return function(expectedType: string)
					local value = rawget(self, "_value")
					local never = rawget(self, "_never")

					local receivedType = typeof(value)

					local result = receivedType == expectedType
					if never then
						result = not result
					end
					assert(
						result,
						string.format(
							"Expected value%s to be a '%s', got a '%s'",
							never and " never" or "",
							expectedType,
							receivedType
						)
					)
				end
			elseif key == "fail" or key == "fails" or key == "throw" or key == "throws" then
				return function()
					local value = rawget(self, "_value")
					local never = rawget(self, "_never")

					local result, err = pcall(value)
					result = not result

					if never then
						result = not result
					end
					assert(result, string.format("Expected value%s to error", never and " never" or ""))
				end
			elseif key == "matches" or key == "match" then
				return function(pattern: string)
					local value = rawget(self, "_value")
					local never = rawget(self, "_never")

					local result = string.match(value, pattern) ~= nil
					if never then
						result = not result
					end
					assert(
						result,
						string.format(
							"Expected value%s '%s' to match '%s'",
							never and " never" or "",
							tostring(value),
							pattern
						)
					)
				end

				-- TODO: Implement more assertion functions
				--elseif key == "contains" then
				--elseif key == "containsOnly" then
				--elseif key == "nears" or key == "nearly" then
			end

			return self
		end,
	})

	return query
end

return thisValue
