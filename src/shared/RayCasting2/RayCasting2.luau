--!native

--[[
    @Version 1.0.5
]]

local RayCasting2 = {}
RayCasting2.__index = RayCasting2

local RunService = game:GetService("RunService")
local Dispetcher = require(script.Parent.Dispetcher) -- TODO: CONSOLE LOGS

local function __GET_RAY_INFO_(INFO: _ray_info_) -- TODO: GET INFO
	return INFO.Origin, INFO.Direction
end

type result_ = { [string]: any } -- result type

type _Params_ = { -- params type
	Filter_Type: RaycastParams,
	Filter_Descendants_Instances: {}
}

type _ray_info_ = { -- ray info type
	Origin: Vector3, 
	Direction: Vector3,
	
	__index: {
		__Params: {
			Filter_Type: RaycastParams,
			FilterDescendantsInstances:  RaycastParams
		},
		__isLive: boolean
	}
}

local function __NEW_RAY_(INFO: _ray_info_)
	local origin, direction = __GET_RAY_INFO_(INFO)
	
	local _PARAMS_NEW_ = RaycastParams.new() -- TODO: ADD PARAMS
	
	local _PARAMS_INFO_ = INFO.__index.__Params :: _Params_ -- TODO: GET INFO

	if _PARAMS_INFO_.Filter_Type == nil or not _PARAMS_INFO_.Filter_Descendants_Instances then
		local rayResult = workspace:Raycast(origin, direction)
		return rayResult
	end
	
	_PARAMS_NEW_.FilterType = _PARAMS_INFO_.Filter_Type
	_PARAMS_NEW_.FilterDescendantsInstances = _PARAMS_INFO_.Filter_Descendants_Instances

	local rayResult = workspace:Raycast(origin, direction, _PARAMS_NEW_)
	
	return rayResult
end

function RayCasting2.new(...: { any })
	if ... == nil then
		Dispetcher.onError("nil", nil)
	end
	
	if type(...) :: _ray_info_ then
		local TABLE__ = ... :: _ray_info_
		
		if not TABLE__.Origin and TABLE__.Direction then
			Dispetcher.onError("error", `not registered argument.`)
		elseif type(TABLE__.Origin) == not "Vector3" and type(TABLE__.Direction) == not "Vector3" then
			Dispetcher.onError("error", `not registered type. [{type(TABLE__.Origin) or type(TABLE__.Direction)}]`)
		end
		
		return setmetatable({  -- [ meta__ ] [ TODO: `props` ]
			Origin = TABLE__.Origin,
			Direction = TABLE__.Direction,
			
			__index = {
				__Params = {
					Filter_Type = TABLE__.FilterType,
					FilterDescendantsInstances = TABLE__.FilterDescendantsInstances
				},
				__isLive = true
			}
		}, RayCasting2)
	else
		Dispetcher.onError("error", ...)
	end
end

function RayCasting2:HeartBeat(CallBack: (Result: { result_ }, RaycastInfo: { _ray_info_ }) -> (), info)
	if self.__index.__isLive == false then
		return false -- TODO: `is not live`
	end 
	
	if CallBack == nil then
		Dispetcher.onError("error", `not registered argument "{`CallBack`}".`)
	else
		local self = self :: _ray_info_
		local Result = __NEW_RAY_(self) :: result_
		
		RunService.Heartbeat:Connect(function(deltatime: number)
			if Result then
				CallBack(Result, __GET_RAY_INFO_(self))
			else
				return nil
			end
		end)
	end
end

function RayCasting2:find(result: RaycastResult, Name: string?) : BasePart?
	if result == nil then
		Dispetcher.onError("nil")
	else
		if type(Name) == "string" then
			local PART_ = result.Instance :: BasePart?
			
			for _, part__ in pairs(workspace:GetDescendants()) do
				if part__.Name == Name then
					return part__
				else
					continue
				end
			end
		else
			Dispetcher.onError("error", `not registered type. [{type(Name)}]`)
		end
	end
end

function RayCasting2:useInfo(...: { _ray_info_ })
	local TABLE_ = ... :: _ray_info_
	
	if ... == nil or not TABLE_.Origin and TABLE_.Direction then
		Dispetcher.onError("nil")
	else
		return ...
	end
end

--[=[
	@class [useUpdate]
	TODO: use update ray.
]=]

function RayCasting2:useUpdate(...: { _ray_info_ })
	if ... == nil then
		Dispetcher.onError("nil")
	else
		local self = self :: _ray_info_
		local TABLE__ = ... :: _ray_info_
		
		self.Direction = TABLE__.Direction
		self.Origin = TABLE__.Origin
		self.__index.__isLive = true
	end
end

--[=[
	@class [Disconnect]
	TODO: Disconnect the ray.
	
	@Storage: `Disconnect`
	                        {  __isLive = false  }
]=]

function RayCasting2:Disconnect()
	if not self.__index then
		Dispetcher.onError("nil")
	end
	
	self.__index.__isLive = false
end

--[=[
	@class [Subscribe]
	TODO: Subscribe to the ray.
]=]

function RayCasting2:Connect(CallBack: (Result: { result_ }) -> ())	
	if self.__index.__isLive == false then
		return false
	end 
	
	if not self.Origin and self.Direction or self.Origin == nil and self.Direction == nil then
		Dispetcher.onError("error", `not registered argument.`)
	else
		if CallBack == nil or not CallBack then
			Dispetcher.onError("error", `not registered argument.`)
		else
			local Result = __NEW_RAY_(self) :: result_
			
			if Result then
				CallBack(Result, __GET_RAY_INFO_(self))
			else
				CallBack({}, nil)
			end
		end
	end
end

type RayCasting2 = typeof(RayCasting2)

return RayCasting2 :: RayCasting2
