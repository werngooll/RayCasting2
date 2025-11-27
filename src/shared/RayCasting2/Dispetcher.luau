local Dispetcher = {}

function Dispetcher.onWarn(...:any) -- TODO: WARN IN CONSOLE
	if type(...) == "string" then
		warn("[RayCasting2-WARN]:", ...)
	else
		Dispetcher.onError("c_error", `not registered type`)
	end
end

function Dispetcher.onError(_type: string, ...:any) -- TODO: ERROR IN CONSOLE
	if type(_type) == "string" then
		if _type == "nil" then -- NIL ERROR
			return error("[RayCasting2-ERROR]: "..                                                       
				`{ string.format("%s", ...) }`,
				25
			)
		elseif _type == "error" then -- CLASSIC ERROR
			return error("[RayCasting2-ERROR]: "..                                                     
				`{ ... }`,
				25
			)
		elseif _type == "c_error" then -- CRITICAL ERROR TODO: CRITICAL ERROR IN CONSOLE
			return error("[RayCasting2-CRITICAL-ERROR]: "..                                                     
				`{...}`,
				5
			)
		end
	else -- NOT REGISTERED TYPE TODO: CRITICAL ERROR IN CONSOLE
		return error("[RayCasting2-CRITICAL-ERROR]: "..                                            
			`[type] = {type(...)} `..
			`[source] = {...}`,
			5
		)
	end 
end

return Dispetcher
