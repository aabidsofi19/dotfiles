
local M = {}

M.null_ls_sources = function (null_ls)
    local linters =  null_ls.builtins.diagnostics
    local formatters = null_ls.builtins.formatting

    return {
        formatters.stylua ,
        linters.stylua,
    }
end

return M
