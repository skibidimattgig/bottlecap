local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local char = LocalPlayer.Character
local hrp = char.HumanoidRootPart
local t = LocalPlayer:GetMouse().Target
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
    local e = game.ReplicatedStorage:FindFirstChild("OPEN_INVENTORY", true)
  mouse.KeyDown:Connect(function(key)
      if key ~= "g" then return end
      e:FireServer(hrp.CFrame + hrp.CFrame.LookVector*5 - Vector3.new(0, 2.5, 0))
  end)

char.Humanoid.WalkSpeed = 1000

local i = false

coroutine.wrap(function()
        local deb = false
        local deb2 = false
        repeat
            for _, v in workspace:GetChildren() do
                if not string.find(string.lower(v.Name), "junk") and not string.find(string.lower(v.Name), "duck") then continue end
                Instance.new("Highlight", v)
                if not deb then
                    local f = Instance.new("Message")
                    f.Text = "junk gun or duck somewhere"
                    f.Parent = workspace
                    print("YOOOO RARE ITEM", game.Players.LocalPlayer.Character.Head.Position)
                    game.Debris:AddItem(f, 10)
                end
                if not deb then deb = true end
            end
        task.wait(.1)
        until false
end)()

mouse.KeyDown:Connect(function(key)
    if key == "t" then
        i = not i
        if i then
            char.Humanoid.WalkSpeed = 50
        else
             char.Humanoid.WalkSpeed = 1000
        end
    end
end)

local pos = hrp.CFrame
loadstring(game:HttpGet("https://raw.githubusercontent.com/skibidimattgig/bottlecap/refs/heads/main/fogremover.lua"))()

local part = Instance.new("Part", workspace)
part.Anchored = true
part.Size = Vector3.new(1000, 50, 1000)
part.Transparency = 0.9
coroutine.wrap(function()
repeat
part.Position = Vector3.new(hrp.Position.X, 1050, hrp.Position.Z)
task.wait()
until false
end)()

hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 55, 0))

hrp.CFrame += Vector3.new(0, 200, 0)
local position1 = pos.Position -- Starting position
local position2 = Vector3.new(200, 900, -142230.890) -- Target position

-- Time to complete the movement
local moveDuration = 46 -- Seconds

-- Function to smoothly drag the character
local function dragCharacter()
    local character = char
    local humanoidRootPart = hrp

    -- Create a BodyPosition
    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(1e6, 1e6, 1e6) -- Large enough to overcome any forces
    bodyPosition.P = 5000 -- Power of the force
    bodyPosition.D = 500 -- Damping
    bodyPosition.Position = position1
    bodyPosition.Parent = humanoidRootPart

    -- Smoothly interpolate position over time
    for i = 0, 1, task.wait() / moveDuration do
        bodyPosition.Position = position1:Lerp(position2, i)
        task.wait()
    end

    -- Ensure the final position is accurate
    bodyPosition.Position = position2
    hrp.Anchored = true
    hrp.Velocity = Vector3.new(0,0,0)

    -- Cleanup after reaching the target
    task.wait(0.05)
    bodyPosition:Destroy()

    hrp.Anchored = false
end

-- Trigger the function to drag the character
dragCharacter()
part:Destroy()
-- local p1 = workspace:FindFirstChild("Meshes/untitle3_Cube.037 (1)", true).CFrame + Vector3.new(0, 10, 0)
-- hrp.CFrame = p1 + p1.LookVector*130 + p1.RightVector*62.5
-- hrp.CFrame -= Vector3.new(0, 20, 0)
