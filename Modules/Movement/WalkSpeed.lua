-- WalkSpeed.lua
-- Adjusts the walking speed of the LocalPlayer, because apparently the default speed isn’t good enough.

local WalkSpeed = {}

-- Services, because Roblox API documentation is our second home
local Players = game:GetService("Players")

-- LocalPlayer setup, because Roblox makes you babysit everything
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Default walk speed, because someone might want to reset it
local defaultSpeed = Humanoid.WalkSpeed

-- Function to set walking speed, because "running" was apparently too mainstream
function WalkSpeed.set(speed)
    if not Humanoid then
        warn("[WalkSpeed] Humanoid not found. Did your character forget to exist?")
        return
    end

    Humanoid.WalkSpeed = speed
    print("[WalkSpeed] Set to:", speed)
end

-- Function to reset walking speed, because someone always regrets their choices
function WalkSpeed.reset()
    if not Humanoid then
        warn("[WalkSpeed] Humanoid not found. Seriously, where did your character go?")
        return
    end

    Humanoid.WalkSpeed = defaultSpeed
    print("[WalkSpeed] Reset to default:", defaultSpeed)
end

-- Function to get the current walking speed, because curiosity is a thing
function WalkSpeed.get()
    if not Humanoid then
        warn("[WalkSpeed] Humanoid not found. Are you even trying?")
        return nil
    end

    return Humanoid.WalkSpeed
end

return WalkSpeed
