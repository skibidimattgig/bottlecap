-- garou autokill

local player = game.Players.LocalPlayer
local con
local uis = game:GetService("UserInputService")
local pos2 = CFrame.new(438, 500, -376)

local function doFunc()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char.HumanoidRootPart
    con = uis.InputBegan:Connect(function(key, gpe)
        if gpe then return end
        if key.KeyCode ~= Enum.KeyCode.Two and key.KeyCode ~= Enum.KeyCode.One then return end
		
	task.wait(1.85)
        local stop = false
        local players = workspace.Live:GetChildren()

        local closePlayer = false
        for _, v in players do
            if v == char then continue end
            if (v.Head.Position - char.Head.Position).Magnitude < 5 then
                closePlayer = true
            end
        end
        if not closePlayer then return end
       	local pos = hrp.CFrame
		char:PivotTo(pos2)
        task.wait(0.5)
		hrp.Anchored = true
		task.wait(.85)
		hrp.Anchored = false
        task.wait(0.2)
		char:PivotTo(pos)
    end)
    local con2
    con2 = char.Humanoid.Died:Connect(function()
        con2:Disconnect()
        con:Disconnect()
    end)

    mouse = game.Players.LocalPlayer:GetMouse()
    tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Tp tool(Equip to Click TP)"
    tool.Activated:connect(function()
    local pos = mouse.Hit+Vector3.new(0,2.5,0)
    pos = CFrame.new(pos.X,pos.Y,pos.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end
doFunc()
--player.CharacterAdded:Connect(doFunc)
