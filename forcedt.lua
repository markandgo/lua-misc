return function(timestep,maxBuffer)
	local stepBuffer = 0
	timestep  = timestep or 1/60 -- 60 updates per second
	maxBuffer = maxBuffer or 1/10
	assert(maxBuffer >= timestep, 'Max time step must be greater than or equal to desired time step')
	return function(dt,func)
		stepBuffer = stepBuffer + dt
		stepBuffer = stepBuffer > maxBuffer and maxBuffer or stepBuffer
		
		while stepBuffer >= timestep do
			stepBuffer = stepBuffer-timestep
			func(timestep)
		end
	end
end