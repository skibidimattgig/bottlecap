coroutine.wrap(function()
  local Players = game:GetService("Players")
  local LocalPlayer = Players.LocalPlayer
  local mouse = LocalPlayer:GetMouse()
  
  local char = LocalPlayer.Character
  local hrp = char.HumanoidRootPart
  local t = LocalPlayer:GetMouse().Target
  
  local pos = hrp.CFrame
  
  local e = game.ReplicatedStorage:FindFirstChild("OPEN_INVENTORY", true)
  local e2 = game.ReplicatedStorage:FindFirstChild("UseRedEnvelope", true)
    
  coroutine.wrap(function()
    repeat
          for _, v in workspace:GetChildren() do
            if v.Name ~= "RedEnvelopeHolder" then continue end
            e2:FireServer(v)
          end
          task.wait()
    until false
  end)()
  
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

  char:PivotTo(CFrame.new(0, 50, 0))
  hrp.CFrame += Vector3.new(0, 50, 0)

  local position1 = pos.Position -- Starting position

  local position2 = Vector3.new(-200, 150, -9100) -- Target position
  local position3 = Vector3.new(-200, 750, -46000) -- Target position
  -- Time to complete the movement
  local moveDuration = 2 -- Seconds
  local moveDuration2 = 12 -- Seconds
  -- Function to smoothly drag the character
  local function dragCharacter(v)
      local character = char
      local humanoidRootPart = hrp
  
      -- Create a BodyPosition
      local bodyPosition = Instance.new("BodyPosition")
      bodyPosition.MaxForce = Vector3.new(1e6,1e6,1e6) -- Large enough to overcome any forces
      bodyPosition.P = 321312 -- Power of the force
      bodyPosition.D = 5000 -- Damping
       bodyPosition.Position = position1
      if v == true then bodyPosition.Position = position2 end 
     
      bodyPosition.Parent = humanoidRootPart
          local md = moveDuration
          if v == true then md = moveDuration2 end
      -- Smoothly interpolate position over time
      for i = 0, 1, task.wait() / md do
          local pos = position2
          if v == true then pos = position3 end
        
          bodyPosition.Position = position1:Lerp(pos, i)
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
  local p1 = workspace:FindFirstChild("Meshes/untitle3_Cube.037 (1)", true).CFrame + Vector3.new(0, 10, 0)
  hrp.CFrame = p1 + p1.LookVector*140 + p1.RightVector*65
  hrp.CFrame -= Vector3.new(0, 25, 0)
  hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector*15
  task.wait(0.65)
  e:FireServer(hrp.CFrame + hrp.CFrame.LookVector*5 - Vector3.new(0, 2.5, 0))

  local key = ""
  mouse.KeyDown:Connect(function(key2)
        if key2 ~= "b" then return end

        key = "a"
    end)
    
      repeat task.wait() until key ~= ""
        
  hrp.CFrame += Vector3.new(0, 500, 0)
      dragCharacter(true)
      
      local p1 = workspace:FindFirstChild("Dragon", true).CFrame + Vector3.new(0, 25, 0)
      hrp.CFrame = p1 + p1.LookVector*-200 + p1.RightVector*-500
  end)()
