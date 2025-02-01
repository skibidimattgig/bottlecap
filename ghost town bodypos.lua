local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local char = LocalPlayer.Character
local hrp = char.HumanoidRootPart
local t = LocalPlayer:GetMouse().Target

local pos = hrp.CFrame


local part = Instance.new("Part", workspace)
part.Anchored = true
part.Size = Vector3.new(1000, 50, 1000)
coroutine.wrap(function()
repeat
part.Position = Vector3.new(hrp.Position.X, 500, hrp.Position.Z)
task.wait()
until false
end)()

hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 55, 0))

hrp.CFrame += Vector3.new(0, 200, 0)
local position1 = pos.Position -- Starting position
local position2 = Vector3.new(-300, 800, -21500*6.5) -- Target position

-- Time to complete the movement
local moveDuration = 42.5 -- Seconds

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
