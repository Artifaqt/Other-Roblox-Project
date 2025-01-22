-- Flight.lua
-- Handles flight functionality for the LocalPlayer, because apparently walking isn’t enough for these kids.

local Flight = {}

-- Services, because Roblox loves to make everything an API
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- God forbid we assume the LocalPlayer exists
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Flying state variables, because why not complicate life?
local flying = false
local flightSpeed = 50 -- Who decided this was a good default speed? Probably me.
local flightDirection = Vector3.new(0, 0, 0) -- Direction? Sure, let’s add some vectors to this mess.

-- Function to enable flight, because why would gravity be enough?
function Flight.enable()
    if flying then
        warn("[Flight] Already flying! Yeah, let’s try enabling flight twice, genius.")
        return
    end

    flying = true
    print("[Flight] Enabled. Congrats, you can now defy physics.")

    -- Connect RenderStepped because why not torture the render loop?
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not flying then
            connection:Disconnect()
            return
        end

        -- Apply flight movement, because walking is for losers
        local velocity = flightDirection * flightSpeed
        HumanoidRootPart.Velocity = velocity
    end)

    -- Start listening for input, because apparently flight controls aren’t intuitive
    Flight.listenForInput()
end

-- Function to disable flight, because eventually you need to come back to reality
function Flight.disable()
    if not flying then
        warn("[Flight] Already disabled! Are you trying to break something?")
        return
    end

    flying = false
    print("[Flight] Disabled. Gravity welcomes you back.")

    -- Reset velocity, because Roblox physics will cry otherwise
    HumanoidRootPart.Velocity = Vector3.zero
end

-- Function to listen for input, because players can’t figure out how to fly without a keyboard
function Flight.listenForInput()
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then
                flightDirection = flightDirection + Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then
                flightDirection = flightDirection + Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then
                flightDirection = flightDirection + Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                flightDirection = flightDirection + Vector3.new(1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.Q then -- Ascend, because why not?
                flightDirection = flightDirection + Vector3.new(0, 1, 0)
            elseif input.KeyCode == Enum.KeyCode.E then -- Descend, because falling isn’t dramatic enough
                flightDirection = flightDirection + Vector3.new(0, -1, 0)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then
                flightDirection = flightDirection - Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then
                flightDirection = flightDirection - Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then
                flightDirection = flightDirection - Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                flightDirection = flightDirection - Vector3.new(1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.Q then -- Ascend
                flightDirection = flightDirection - Vector3.new(0, 1, 0)
            elseif input.KeyCode == Enum.KeyCode.E then -- Descend
                flightDirection = flightDirection - Vector3.new(0, -1, 0)
            end
        end
    end)
end

-- Function to set flight speed, because players will inevitably complain about it being too slow
function Flight.setSpeed(speed)
    flightSpeed = speed
    print("[Flight] Speed set to:", speed)
end

return Flight
