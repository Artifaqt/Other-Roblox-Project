-- Noclip.lua
-- Enables noclip for the LocalPlayer, because walking through walls is apparently the new meta.

local Noclip = {}

-- Services, because you can’t do anything in Roblox without consulting their APIs
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Assume LocalPlayer exists, but let’s prepare for Roblox shenanigans anyway
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Noclip state, because toggling it on and off wasn’t confusing enough already
local noclipEnabled = false
local connection = nil

-- Function to enable noclip, because why play the game normally?
function Noclip.enable()
    if noclipEnabled then
        warn("[Noclip] Already enabled! Congratulations, you tried to enable noclip twice.")
        return
    end

    noclipEnabled = true
    print("[Noclip] Enabled. Walls fear you now.")

    -- Connect RenderStepped to handle collisions, or lack thereof
    connection = RunService.RenderStepped:Connect(function()
        if noclipEnabled and Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- Function to disable noclip, because eventually reality has to set in
function Noclip.disable()
    if not noclipEnabled then
        warn("[Noclip] Already disabled! Did you think it was disabled twice?")
        return
    end

    noclipEnabled = false
    print("[Noclip] Disabled. Welcome back to the real world.")

    -- Disconnect the RenderStepped connection, because performance is a thing
    if connection then
        connection:Disconnect()
        connection = nil
    end

    -- Restore collisions for the character
    if Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Function to toggle noclip, because apparently on/off wasn’t simple enough
function Noclip.toggle()
    if noclipEnabled then
        Noclip.disable()
    else
        Noclip.enable()
    end
end

return Noclip
