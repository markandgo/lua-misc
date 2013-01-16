-- v1.0
local ceil = math.ceil

local initRayData = function(cell_width,i,f)
	local d       = f-i
	-- index starts at 1
	local cell_i  = ceil(i/cell_width)
	
	local dRatio,Delta,Step,Start
	if d > 0 then 
		Step   = 1 
		Start  = 1 
	else 
		Step   = -1 
		Start  = 0
	end
	-- zero hack for when 0/0
	if d == 0 then
		dRatio = math.huge
		Delta  = 0
	else
		dRatio  = (cell_width*(cell_i+Start)-i)/d
		Delta   = cell_width/d * Step
	end
	
	return dRatio,Delta,Step,cell_i
end

local rayIterate = function(width,height,x,y,x2,y2)
	local minRatio = 0
	local dxRatio,xDelta,xStep,gx = initRayData(width,x,x2)
	local dyRatio,yDelta,yStep,gy = initRayData(height,y,y2)
	return function()
		if minRatio <= 1 then
			if dxRatio < dyRatio then
				minRatio  = dxRatio
				dxRatio   = dxRatio + xDelta
				gx        = gx + xStep
			else
				minRatio  = dyRatio
				dyRatio   = dyRatio + yDelta
				gy        = gy + yStep
			end
			return gx,gy
		end
	end
end

return rayIterate