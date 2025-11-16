local RayCasting2 = {}
RayCasting2.__index = RayCasting2

local Dispetcher = require(script.Dispetcher)

type _ray_info_ = {
	Origin: Vector3, 
	Direction: Vector3,
	__is_live: boolean
}

local function __ray(INFO: _ray_info_)
	local origin = INFO.Origin
	local direction = INFO.Direction
	
	local rayResult = workspace:Raycast(origin, direction)
	
	return rayResult
end

function RayCasting2.new(...: { any })
	if ... == nil then
		Dispetcher.onError("nil", nil)
	end
	
	if type(...) :: _ray_info_ then
		local TABLE__ = ... :: _ray_info_
		
		return setmetatable({ 
			Origin = TABLE__.Origin,
			Direction = TABLE__.Direction,
			__is_live = true
		}, RayCasting2)
	else
		Dispetcher.onError("error", ...)
	end
end

function RayCasting2:useUpdate(...: { any })
	if ... == nil then
		Dispetcher.onError("nil", nil)
	else
		local self = self :: _ray_info_
		local TABLE__ = ... :: _ray_info_
		
		self.Direction = TABLE__.Direction
		self.Origin = TABLE__.Origin
		self.__is_live = true
	end
end

function RayCasting2:Unsubscribe()
	self.__is_live = false
end

function RayCasting2:Subscribe(CallBack: RBXScriptSignal)
	local Origin = self.Origin
	local Direction = self.Direction
	
	if self.__is_live == false then
		return false
	end
	
	if not Origin and Direction or Origin == nil and Direction == nil then
		Dispetcher.onError("error", self)
	else
		if CallBack == nil or not CallBack then
			Dispetcher.onError("nil", nil)
		else
			local Result = __ray(self)
			
			if Result then
				CallBack(Result)
			else
				return false
			end
		end
	end
end

type RayCasting2 = typeof(RayCasting2)

return RayCasting2 :: RayCasting2
