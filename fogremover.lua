coroutine.wrap(function()
    local Lighting = game:GetService("Lighting")

    -- Function to apply lighting settings
    local function applyLightingSettings()
        Lighting.FogEnd = 1000000
        Lighting.FogStart = 1000000
        Lighting.Brightness = 2
        Lighting.ClockTime = 12
        Lighting.ExposureCompensation = 0
    
        -- Remove unwanted effects
        for _, effect in ipairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") or effect:IsA("Atmosphere") then
                effect:Destroy()
            end
        end
    end
    
    -- Apply settings initially
    applyLightingSettings()
    
    -- Loop to maintain settings without lag
    task.spawn(function()
        while true do
            applyLightingSettings()
            task.wait() -- Adjust this if necessary
        end
    end)
  end)()
