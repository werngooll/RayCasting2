--!native

--[[
    @Version 1.0.6
]]

local RayCasting2 = {}
RayCasting2.__index = RayCasting2

local Packages = game.ReplicatedStorage:WaitForChild("Packages")

local RunService = game:GetService("RunService")
local charm = require(Packages.charm)
local React = require(Packages.Roact.React)
local Dispetcher = require(script.Parent.Dispetcher) -- TODO: CONSOLE LOGS

export type _Params_ = { -- params type
	Filter_Type: RaycastParams,
	Filter_Descendants_Instances: {}
}

export type result_ = { [string]: any }

export type _ray_info_ = { -- ray info type
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

local _ray_info_ = { -- ray info type
	Origin = nil,
	Direction = nil,

	__index = {
		__Params =  {
			Filter_Type = nil,
			FilterDescendantsInstances = nil
		},
		__isLive = nil
	}
}

local function __GET_RAY_INFO_(INFO: _ray_info_) -- TODO: GET INFO
	return INFO.Origin, INFO.Direction
end

local function FindFirstChildOfClass(Type: string, ray: RaycastResult)
	if Type == nil then
		Dispetcher.onError(`nil`)
	else
		local _Type = Type
		local object = if ray.Instance.ClassName == Type then ray.Instance else nil
		
		if object then
			return object
		end
	end
end

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

--[=[
    Connects the raycast.
    
    
 
    @params: CallBack
    @return: RaycastResult
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    local Raycast = Raycasting2.new(array)
    
    Raycast:HeartBeat(function(Result)
    end)
    ```
]=]
function RayCasting2:HeartBeat(CallBack: (Result: { result_ }) -> (), info)
	if self.__index.__isLive == false then
		return nil
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

--[=[
    Disconnects the raycast.
    
    
    
    @params: nil
    @return: nil
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    local Raycast = Raycasting2.new(array)
    
    Raycast:Disconnect()
    ```
]=]
function RayCasting2:Disconnect()
	if self == nil then
		return Dispetcher.onError(`nil`,
			`nil`
		)
	end
	
	Dispetcher.onWarn(`Ray Disconnected. `)
	self.__index.__isLive = false
end

--[=[
    Finds a child of the specified class.
    
    
    
    @params: Type: string, result: RaycastResult
    @return: Instance
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    local Raycast = Raycasting2.new(array)
    
    local Part = Raycast:FindFirstChildOfClass("Part", result)
    ```
]=]
function RayCasting2:FindFirstChildOfClass(Type: string, result: RaycastResult)
	if result == nil or not result then
		return Dispetcher.onWarn(`nil`)
	else
		return FindFirstChildOfClass(Type, result)
	end
end

--[=[
    Waits for the raycast to hit something.
    
    
    
    @return: RaycastResult
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    local Raycast = Raycasting2.new(array)
    
    local Result = Raycast:Wait()
    ```
]=]
function RayCasting2:Wait()
	if self.__index.__isLive == false then
		return nil
	end 

	if not self.Origin and self.Direction or self.Origin == nil and self.Direction == nil then
		Dispetcher.onError("error", `not registered argument.`)
	else
		local Result = __NEW_RAY_(self) :: result_

		if Result then
			return Result
		else
			return nil
		end
	end	
end

--[=[
    Connects the raycast to the callback.
    
    
    
    @params: CallBack
    @return: RaycastResult
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    local Raycast = Raycasting2.new(array)
    
    Raycast:Connect(function(Result)
        print(Result)
    end)
    ```
]=]
function RayCasting2:Connect(CallBack: (Result: { result_ }) -> ())
	if self.__index.__isLive == false then
		return nil
	end 

	if not self.Origin and self.Direction or self.Origin == nil and self.Direction == nil then
		Dispetcher.onError("error", `not registered argument.`)
	else
		if CallBack == nil or not CallBack then
			Dispetcher.onError("error", `not registered argument.`)
		else
			local Result = __NEW_RAY_(self) :: result_

			if Result then
				CallBack(Result)
			else
				CallBack({})
			end
		end
	end
end

--[=[
    Creates a new raycast.
    
    
    
    @Params: array
    @return: Raycast
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    
    local Raycast = Raycasting2.new(array)
    ```
]=]
function RayCasting2.new(Array)
	if Array == nil then
		Dispetcher.onError("nil", nil)
	end

	if type(Array) :: _ray_info_ then
		if not Array.Origin and Array.Direction then
			Dispetcher.onError("error", `not registered argument.`)
		elseif type(Array.Origin) == not "Vector3" and type(Array.Direction) == not "Vector3" then
			Dispetcher.onError("error", `not registered type. [{type(Array.Origin) or type(Array.Direction)}]`)
		end

		return setmetatable({  -- [ meta__ ] [ TODO: `props` ]
			Origin = Array.Origin,
			Direction = Array.Direction,

			__index = {
				__Params = {
					Filter_Type = Array.FilterType,
					FilterDescendantsInstances = Array.FilterDescendantsInstances
				},
				__isLive = true
			}
		}, RayCasting2)
	else
		Dispetcher.onError("error", Array)
	end
end

--[=[
    Finds the part with the name.
    
    
    
    @params: RaycastResult, string
    @return: BasePart?
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    local Raycast = Raycasting2.new(array)
    
    Raycast:find(result, "BasePart")
    ```
]=]
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

--[=[
    Returns the result of the raycast.
    
    
    
    @class: hooks
    @params: Direction
    @params: Origin
    @params: Filter_Type
    @params: FilterDescendantsInstances
    @params: __isLive
    @return: array
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    
    local array = Raycasting2:useInfo( any )
    ```
]=]
function RayCasting2:useInfo(Direction, Origin, Filter_Type, FilterDescendantsInstances, __isLive)
	if not Origin and Direction then
		Dispetcher.onError("nil")
	else
		return {
			Direction = Direction,
			Origin = Origin,
			Filter_Type = Filter_Type,
			FilterDescendantsInstances = FilterDescendantsInstances,
			__isLive = __isLive
		}
	end
end

--[=[
    Updates the raycast.
    
    
    
    @class: hooks
    @params: array
    @return: nil
    
    ```lua
    local Raycasting2 = require(path.to.RayCasting2)
    local array = Raycasting2:useInfo({ any })
    local Raycast = Raycasting2.new(array)
    
    Raycast:useUpdate(array)
    ```
]=]
function RayCasting2:useUpdate(Array: { _ray_info_ })
	if Array == nil then
		Dispetcher.onError("nil")
	else
		self.Direction = Array.Direction
		self.Origin = Array.Origin
		
		self.__index.__isLive = true
	end
end
export type RayCasting2 = typeof(RayCasting2)
return RayCasting2 :: RayCasting2
