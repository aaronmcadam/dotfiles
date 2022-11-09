local neotest_status_ok, neotest = pcall(require, "neotest")
if not neotest_status_ok then
	return
end

neotest.setup({
	adapters = {
		require("neotest-jest"),
	},
	output = {
		enabled = true,
		open_on_run = "short",
	},
})
