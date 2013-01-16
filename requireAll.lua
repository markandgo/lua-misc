-- LOVE only
local lfs = love.filesystem

local requireAll = function(dir,parentTable)
	parentTable     = parentTable or {}
	local filelist  = lfs.enumerate(dir)
	for i = 1,#filelist do
		local filepath = dir .. '/' .. filelist[i]
		if lfs.isFile(filepath) then
			local moduleName = filepath:match'(%a+)%.lua$'
			if moduleName then
				parentTable[moduleName] = require(dir .. '/' .. moduleName)
			end
		elseif lfs.isDirectory(filepath) then
			local folder = filelist[i]
			parentTable[folder] = {}
			requireAll(filepath,parentTable)
		end
	end
	return parentTable
end

return requireAll