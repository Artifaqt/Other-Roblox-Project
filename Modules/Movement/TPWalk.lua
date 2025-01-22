-- TPWalk.lua
-- Because walking isn’t good enough, and we need to cheat physics by teleporting.

local TPWalk = {}

-- Services, because Roblox loves API overkill
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- LocalPlayer and basic sanity checks, because apparently, we can’t assume Roblox will handle it
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- State variables for TP walking, because why not complicate our lives?
local tpEnabled = false -- Is teleport walk enabled? Of course it is. Or maybe not.
local tpDistance = 10 -- How far each teleport step should be. Arbitrary default value.

-- Function to enable TP walk, because normal walking is for noobs
function TPWalk.enable()
    if tpEnabled then
        warn("[TPWalk] Already enabled! Stop toggling this like it’s a light switch.")
        return
    end

    tpEnabled = true
    print("[TPWalk] Enabled. Time to annoy everyone by teleporting everywhere.")

    -- Listen for player input to handle teleportation
    TPWalk.listenForInput()
end

-- Function to disable TP walk, because eventually, reality sets in
function TPWalk.disable()
    if not tpEnabled then
        warn("[TPWalk] Already disabled! Are you bored or just pressing random buttons?")
        return
    end

    tpEnabled = false
    print("[TPWalk] Disabled. Back to boring old walking.")
end

-- Function to listen for input, because how else will the player teleport?
function TPWalk.listenForInput()
    UserInputService.InputBegan:Connect(function(input)
        if not tpEnabled then return end -- If TP walk isn’t enabled, why are we here?

        if input.UserInputType == Enum.UserInputType.Keyboard then
            local direction = nil

            -- Map input keys to teleport directions. Basic WASD stuff. Groundbreaking.
            if input.KeyCode == Enum.KeyCode.W then
                direction = Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then
                direction = Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then
                direction = Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                direction = Vector3.new(1, 0, 0)
            end

            if direction then
                -- Calculate the new position. It’s math, not magic.
                local newPosition = HumanoidRootPart.Position + (direction.Unit * tpDistance)

                -- Teleport the player by setting their position. What could go wrong?
                HumanoidRootPart.CFrame = CFrame.new(newPosition)
                print("[TPWalk] Teleported to:", newPosition)
            end
        end
    end)
end

-- Function to set teleport distance, because players always want to customize everything
function TPWalk.setDistance(distance)
    tpDistance = distance
    print("[TPWalk] Distance set to:", distance)
end

-- Function to toggle TP walk, because toggling is trendy
function TPWalk.toggle()
    if tpEnabled then
        TPWalk.disable()
    else
        TPWalk.enable()
    end
end

return TPWalk
