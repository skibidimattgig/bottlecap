local things = game
local rs = game.ReplicatedStorage
local n = rs.Network
local e = n.TakeBottleCap

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local char = player.Character
local hrp = char.HumanoidRootPart

local mouse = player:GetMouse()

while player do 
    for _, v in workspace:GetChildren() do
        if not string.find(v.Name, "Pile") and not v.Name == "BottleCap" then continue end
        if not v:FindFirstChild("BottleCap", true) then return end

        for _, b in v:GetDescendants() do
            if b.Name ~= "BottleCap" then continue end
            e:FireServer(b)
        end
    end
task.wait(0.325)
end
