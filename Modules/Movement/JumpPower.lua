-- JumpPower.lua
-- Adjusts the jump power of the LocalPlayer, because apparently jumping normally is too boring.

local JumpPower = {}

-- Services, because everything needs to be an API for some reason
local Players = game:GetService("Players")

-- Assume LocalPlayer exists, but let's double-check just in case the universe decides to implode
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Default jump power, because Roblox thinks 50 is the gold standard
local defaultJumpPower = 50
local currentJumpPower = defaultJumpPower

-- Function to set jump power, because jumping like a normal person isn't enough
function JumpPower.set(power)
    if not Humanoid then
        warn("[JumpPower] Humanoid not found! Are you trying to break reality?")
        return
    end

    currentJumpPower = power
    Humanoid.JumpPower = currentJumpPower
    print("[JumpPower] Set to:", currentJumpPower)
end

-- Function to reset jump power, because sometimes you just want to go back to being average
function JumpPower.reset()
    if not Humanoid then
        warn("[JumpPower] Humanoid not found! Resetting is impossible, just like my dreams.")
        return
    end

    currentJumpPower = defaultJumpPower
    Humanoid.JumpPower = currentJumpPower
    print("[JumpPower] Reset to default:", defaultJumpPower)
end

-- Function to get the current jump power, because why not add more useless features?
function JumpPower.get()
    return currentJumpPower
end

return JumpPower
