-- HelperFunctions.lua
-- A collection of reusable utility functions, because why reinvent the wheel?

local HelperFunctions = {}

-- Reset all Motor6D joints in a character, because sometimes you need to start fresh
function HelperFunctions.resetJoints(character)
    for _, descendant in pairs(character:GetDescendants()) do
        if descendant:IsA("Motor6D") or descendant:IsA("Weld") then
            descendant:Destroy()
        end
    end
    print("[HelperFunctions] Joints reset.")
end

-- Backup the CFrame of all parts in a character, because players change their minds
function HelperFunctions.backupRig(character)
    local backup = {}
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            backup[part.Name] = part.CFrame
        end
    end
    return backup
end

-- Create a Motor6D joint, because Roblox won’t do it for you
function HelperFunctions.createMotor6D(name, part0, part1)
    local motor = Instance.new("Motor6D")
    motor.Name = name
    motor.Part0 = part0
    motor.Part1 = part1
    motor.Parent = part0
    return motor
end

-- Safely find the Humanoid in a character, because who knows what Roblox is doing
function HelperFunctions.findHumanoid(character)
    return character:FindFirstChildWhichIsA("Humanoid")
end

-- Calculate a new position based on a direction and distance, because math exists
function HelperFunctions.calculateNewPosition(startPosition, direction, distance)
    return startPosition + (direction.Unit * distance)
end

-- Calculate orbit position using trigonometry, because we’re not savages
function HelperFunctions.calculateOrbitPosition(center, angle, distance)
    local x = math.cos(angle) * distance
    local z = math.sin(angle) * distance
    return center + Vector3.new(x, 0, z)
end

return HelperFunctions
