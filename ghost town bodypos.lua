coroutine.wrap(function()
  local Players = game:GetService("Players")
  local LocalPlayer = Players.LocalPlayer
  local mouse = LocalPlayer:GetMouse()
  
  local char = LocalPlayer.Character
  local hrp = char.HumanoidRootPart
  local t = LocalPlayer:GetMouse().Target
  
  local pos = hrp.CFrame
  
  local e = game.ReplicatedStorage:FindFirstChild("OPEN_INVENTORY", true)
  
  mouse.KeyDown:Connect(function(key)
      if key ~= "g" then return end
      e:FireServer(hrp.CFrame + hrp.CFrame.LookVector*5 - Vector3.new(0, 2.5, 0))
  end)

  coroutine.wrap(function()
    while task.wait() do
        char.Humanoid.WalkSpeed = 50
        char.Humanoid.JumpPower = 100
    end
  end)()

  hrp.CFrame += Vector3.new(0, 50, 0)

  local position1 = pos.Position -- Starting position

  local position2 = Vector3.new(-200, 150, -21000 * 6.5) -- Target position
  
  -- Time to complete the movement
  local moveDuration = 30 -- Seconds
  
  -- Function to smoothly drag the character
  local function dragCharacter()
      local character = char
      local humanoidRootPart = hrp
  
      -- Create a BodyPosition
      local bodyPosition = Instance.new("BodyPosition")
      bodyPosition.MaxForce = Vector3.new(1e6,1e6,1e6) -- Large enough to overcome any forces
      bodyPosition.P = 321312 -- Power of the force
      bodyPosition.D = 5000 -- Damping
      bodyPosition.Position = position1
      bodyPosition.Parent = humanoidRootPart
  
      -- Smoothly interpolate position over time
      for i = 0, 1, moveDuration*100 do
          bodyPosition.Position = position1:Lerp(position2, i)
          task.wait()
      end
  
      -- Ensure the final position is accurate
      bodyPosition.Position = position2
      hrp.Anchored = true
      hrp.Velocity = Vector3.new(0,0,0)
  
      -- Cleanup afterw reaching the target
      task.wait(0.05)
      bodyPosition:Destroy()
  
      hrp.Anchored = false
  end
  
  -- Trigger the function to drag the character
  dragCharacter()
  -- local p1 = workspace:FindFirstChild("Meshes/untitle3_Cube.037 (1)", true).CFrame + Vector3.new(0, 10, 0)
  -- hrp.CFrame = p1 + p1.LookVector*140 + p1.RightVector*65
  -- hrp.CFrame -= Vector3.new(0, 25, 0)
  -- hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector*15
  -- task.wait(0.5)
  -- e:FireServer(hrp.CFrame + hrp.CFrame.LookVector*5 - Vector3.new(0, 2.5, 0))
end)()
