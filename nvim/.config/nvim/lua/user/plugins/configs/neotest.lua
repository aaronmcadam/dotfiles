local neotest_status_ok, neotest = pcall(require, "neotest")
if not neotest_status_ok then
	return
end

neotest.setup({
	adapters = {
		require("neotest-jest")({
			jestCommand = "pnpm jest --watch",
			cwd = function(path)
				local cwd = require("neotest-jest.util").find_package_json_ancestor(path)
				return cwd
			end,
		}),
	},
	output = {
		enabled = true,
		open_on_run = "true",
	},
})
