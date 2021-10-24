local output = require(script.Parent.output)

local function run(options)
	local directories = options.directories or {}
	local includeDescendants = options.includeDescendants
	local verbose = options.verbose
	local function log(...)
		if verbose then
			print(...)
		end
	end

	local results = {}
	local passed, failed, skipped = 0, 0, 0

	for dirKey, dir in pairs(directories) do
		local dirName = tonumber(dirKey) and dir:GetFullName() or dirKey
		results[dirName] = {}

		log("Crawling directory '" .. dirName .. "'")

		local files
		if includeDescendants then
			files = dir:GetDescendants()
		else
			files = dir:GetChildren()
		end

		for _, file in ipairs(files) do
			if file.ClassName == "ModuleScript" and string.match(file.Name, "%.spec") then
				results[dirName][file.Name] = {}

				log("  Found .spec file '" .. file.Name .. "'")

				local descTests = require(file)
				for testName, test in pairs(descTests) do
					log("    Running '" .. testName .. "'")

					local skippedTest = false
					local success, msg = pcall(test, function(reason: string)
						skippedTest = true
						error(reason, 2)
					end)

					if skippedTest then
						log("      test skipped")
						skipped += 1
					elseif success then
						log("      test passed")
						passed += 1
					else
						log("      test failed")
						failed += 1
					end

					results[dirName][file.Name][testName] = { success = success, skipped = skippedTest, msg = msg }
				end
			end
		end
	end

	log("Test run complete, outputting results")

	output(results, passed, failed, skipped)

	if failed > 0 then
		error("Testing completed with failures", 2)
	end
end

return run
