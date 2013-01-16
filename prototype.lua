-- simple prototyping based on the http://lua-users.org/wiki/InheritanceTutorial

--[[ 
SYNTAX:
obj = require 'prototype'
obj.init(child,...)
obj:spawn(...) | obj(...)
obj:isSpawnOf(otherObj)
obj:clone()
obj:parent()
--]]
----------------------------------
local __call = function(self,...) return self:spawn(...) end
local p      = {type = 'prototype'}
setmetatable(p,{__call = __call})

p.spawn = function(self,...)
	local child = {}
	if rawget(self,'init') then self.init(child,...) end
	child.__index = self; child.__call = __call
	return setmetatable(child,child)
end

p.isSpawnOf = function(self,parent)
	return obj.__index == parent
end

p.parent = function(self)
	return obj.__index
end
----------------------------------
-- deep copy including metatable
local function deepcopy(obj,lookup_table)
	lookup_table = lookup_table or {}
	if type(obj) ~= 'table' then
		return obj
	elseif lookup_table[obj] then
		return lookup_table[obj]
	end
	local t = {}
	lookup_table[obj] = t
	for i,v in pairs(obj) do
		t[deepcopy(i,lookup_table)] = deepcopy(v,lookup_table)
	end	
	return setmetatable(t,deepcopy(getmetatable(obj)))
end

-- DANGEROUS IF DEEP SUBTABLES
p.clone = function(self)
	return deepcopy(self)
end
----------------------------------
return p