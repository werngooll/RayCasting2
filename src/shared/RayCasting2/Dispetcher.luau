local Dispetcher = {}

function Dispetcher.onWarn(...:any)
	warn("[RayCasting2-WARN]:", ...)
end

function Dispetcher.onError(_type: string, ...:any)
	if type(_type) == "string" then
		if _type == "nil" then
			return error("[RayCasting2-ERROR]: "..                                                       
				`{nil}`,
				5
			)
		elseif _type == "error" then
			return error("[RayCasting2-ERROR]: "..                                                     
				`[type] = {type(...)} `..
				`[source] = { if type(...) == "table" then table.unpack(...) else ... }`,
				5
			)
		elseif _type == "c_error" then
			return error("[RayCasting2-CRITICAL-ERROR]: "..                                                     
				`{...}`,
				5
			)
		end
	else
		return error("[RayCasting2-CRITICAL-ERROR]: "..                                                      
			`[type] = {type(...)} `..
			`[source] = {...}`,
			5
		)
	end 
end

return Dispetcher
