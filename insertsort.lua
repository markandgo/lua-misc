local compDefault = function(a,b) return a <= b end

-- forward pass sort
return function(t,comp)
	comp = comp or compDefault
	for i = 2,#t do
		for j = i-1,1,-1 do
			local k = j+1
			if comp(t[j],t[k],j,k) then break end
			t[j],t[k] = t[k],t[j]
		end
	end
end