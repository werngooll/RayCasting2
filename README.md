# RayCasting2

---

# 📚 Reference
---

# ***useInfo( { <ins>info</ins> } )***

__useInfo is a check for information for raycast.__

```
local RayCasting2 = require(path.to.RayCasting2)

local info = RayCasting2:useInfo({ Origin = workspace.Part1.Position, Direction = workspace.Part2.Position, FilterType = Enum.RaycastFilterType.Exclude, FilterDescendantsInstances = { workspace.Part3 }})
```

# ***new(  <ins> info </ins>  )***

__new are the create new ray.__

```
local RayCasting2 = require(path.to.RayCasting2)

local info = RayCasting2:useInfo({ Origin = workspace.Part1.Position, Direction = workspace.Part2.Position, FilterType = Enum.RaycastFilterType.Exclude, FilterDescendantsInstances = { workspace.Part3 }})

local new = RayCasting2.new( info )
```

# ***useUpdate( { <ins>info</ins> } )***

__useUpdate is updating information about the ray.__

```
local function update(info)
	return new:useUpdate( info )
end
```

# ***Connect(CallBack)***

__Connect to ray.__

```
new:Connect(function(Result)
    print(Result)	
end)
```

# ***HeartBeat(CallBack)***

__HeartBeat is a connection to the ray every millisecond.__

```
new:HeartBeat(function(Result)
	print(Result)
end)
```

# ***Wait()***

__Wait is the return of a result from a ray.__

```
local result = new:Wait() :: RaycastResult
print(result.Instance.Name)
```

# ***Disconnect()***

__Disconnect is turning off the ray.__

>[!WARNING]
>***If you use this command, the ray will be turned off.***
>

```
new:Disconnect()
```

# ***FindFirstChildOfClass(Type, result)***

__FindFirstChildOfClass is a search for an object from a class.__ 

```
new:FindFirstChildOfClass("Part", result)
```

# ***find(result, Name)***

__find is a search for an object from name.__

```
local Part = new:find(result, "Part1")
```

---

# 🚀 Examples

### ***Destroy result part.***

```
new:Connect(function(Result: RaycastResult)
	local Object = Result.Instance
	
	if Object then
		Object:Destroy()
	end
end)
```

---

