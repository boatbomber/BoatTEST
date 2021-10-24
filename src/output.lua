local function output(
	options: { [string]: any },
	results: { [any]: any },
	passed: number,
	failed: number,
	skipped: number
)
	local content = {
		"\n == Test Results ==",
		string.format(" %d Passed, %d Failed, %d Skipped\n", passed, failed, skipped),
	}

	for dirName, files in pairs(results) do
		table.insert(content, "  📂 " .. dirName)

		for fileName, tests in pairs(files) do
			table.insert(content, "    🧪 " .. fileName)

			local failures = {}
			local skips = {}
			local passes = {}

			for testName, result in pairs(tests) do
				local marker = "🔴"
				local msg = ""
				local tab = failures

				if result.skipped then
					tab = skips
					marker = "🟡"
				elseif result.success then
					tab = passes
					marker = "🟢"
				end

				if result.msg then
					msg = " - " .. string.gsub(result.msg, "^%s*[%w%.]-:%d-:%s*", "")
				end

				table.insert(tab, "      " .. marker .. " " .. testName .. msg)
			end

			-- This gives the most relevant results first,
			-- rather than just the order that pairs decided to do
			for _, o in ipairs(failures) do
				table.insert(content, o)
			end
			if not options.onlyShowFailures then
				for _, o in ipairs(passes) do
					table.insert(content, o)
				end
				for _, o in ipairs(skips) do
					table.insert(content, o)
				end
			end
		end
	end

	table.insert(content, "")
	print(table.concat(content, "\n"))
end

return output
