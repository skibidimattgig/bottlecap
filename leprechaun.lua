local player = game.Players.LocalPlayer
local char = player.Character
local hrp = char.HumanoidRootPart

local mouse = player:GetMouse()

local map = workspace.Map
local buildings = map.Buildings

---
--loadstring(game:HttpGet(("https://raw.githubusercontent.com/skibidimattgig/bottlecap/refs/heads/main/fogremover.lua"),true))()

_G.Fullbright = false

if not _G.Fullbright then
    loadstring(game:HttpGet(("https://raw.githubusercontent.com/skibidimattgig/bottlecap/refs/heads/main/fogremover.lua"),true))()
    _G.Fullbright = true
end

---
local start1 = 7755
local start2 = 8231

local start = start2

-- Figures out if it's the desert or plains map via the burger in the attic
if workspace:FindFirstChild("Burger") then
    start = start1
end

local function convert(pos)
    local meters = (start-pos.Z)/6
    return math.round(meters)
end
---

local function chatPos(msg, pos)
    game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(
        "-------------- \n\n"..

        msg..convert(pos).." m"

        .."\n\n--------------"
    )
end

_G.d = 90
-- raycast positioning

local function checkRaycast()
    local raycast = Workspace:Raycast(hrp.Position+hrp.CFrame.LookVector*_G.d-10, Vector3.new(0,-300,0))
    if raycast then
        return true
    end
    return false
end


local con 

local road = map.Roads
local roadPos = hrp.Position.X
road.DescendantAdded:Connect(function(v)
    if v.Name ~= "Road" then return end
    if not v:IsA("BasePart") then return end
    task.wait(1)
    roadPos = v.Position.X
end)

local function stop()
        if not con then return end

        hrp.Anchored = false

        con:Disconnect()
end
local function start()
 if con then return end
        -- sets up raycast positioning con
        hrp.Anchored = true
        local yLevel = hrp.Position.Y+200
        hrp.CFrame = CFrame.new(Vector3.new(hrp.Position.X, yLevel, hrp.Position.Z))

        local waiting = false

        con = game.RunService.RenderStepped:Connect(function()
            if not checkRaycast() then
                if not waiting then
                    waiting = true

                    hrp.Anchored = false
                    task.delay(0.15, function()
                        hrp.Anchored = true
                    end)
                end
                return 
            end
            waiting = false

            hrp.CFrame = CFrame.new(Vector3.new(roadPos, yLevel, hrp.Position.Z-_G.d))
        end)
end


_G.flykey = _G.flykey or "v"

_G.stopkey = _G.stopkey or "b"

 mouse.KeyDown:Connect(function(key)
        if key == _G.flykey then
           start()
        elseif key == _G.stopkey then
            stop()
        end
    end)
    player.Chatted:Connect(function(msg)
        if msg == "start" then
            start()
        elseif msg == "stop" then
            stop()
        end
    end)

-- Waits for clover sacrifice to be added

local name = "CloverSacrifice"
local name2 = "TheTreeOfFortune"

local cloverSacrifice = buildings:FindFirstChild(name)
local tree = buildings:FindFirstChild(name2)

local found = {}

local function printSacrifice(v, naem)
    if table.find(found, v) then return end

    if not table.find(found, v) then
        table.insert(found, v)
    end

    local posPart = v:FindFirstChildOfClass("Part", true)
    chatPos(naem.." found at ", posPart.Position)

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 1
    highlight.FillTransparency = 0.7
    highlight.Adornee = v
    highlight.Parent = v

   pcall(function()
     if _G.travel then
        hrp.CFrame = CFrame.new(posPart.Position+Vector3.new(0,10,0))

    stop()
    end
        end)
    
end


if cloverSacrifice then
    printSacrifice(cloverSacrifice, name)
end
if tree then
    printSacrifice(tree, name2)
end
--
buildings.ChildAdded:Connect(function(child)
    if child.Name == name then

    printSacrifice(child, name)
        elseif child.Name == name2 then

    printSacrifice(child, name2)
        end

end)
