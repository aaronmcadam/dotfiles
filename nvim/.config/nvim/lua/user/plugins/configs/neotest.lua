local path = require("mason-core.path")

local neotest_status_ok, neotest = pcall(require, "neotest")
if not neotest_status_ok then
	return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local dap_vscode_js_status_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not dap_vscode_js_status_ok then
	return
end

dapui.setup()

-- We need to wait for execution to stop at the first breakpoint before showing the UI to give the source maps time to generate.
-- If we don't, the UI will close because the source maps haven't generated in time.
dap.listeners.after.event_breakpoint["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap_vscode_js.setup({
	adapters = { "pwa-node" },
	debugger_path = path.concat({ vim.fn.stdpath("data"), "mason", "packages", "js-debug-adapter" }),
})

neotest.setup({
	adapters = {
		require("neotest-jest"),
	},
	output = {
		enabled = true,
		open_on_run = "short",
	},
})
