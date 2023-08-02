local notify = require("notify")
local M = {}

M.load_project_config = function()
	local project_config = vim.fn.getcwd() .. "/.nvim.lua"
	local ok, project_module = pcall(dofile, project_config)

	if ok then
		return project_module
	else
		return nil
	end
end

return M
