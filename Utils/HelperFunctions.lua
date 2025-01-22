-- HelperFunctions.lua
-- A collection of reusable utility functions because nobody wants to rewrite this mess.

local HelperFunctions = {}

-- Reset all Motor6D joints
function HelperFunctions.resetJoints(character)
    for _, descendant in pairs(character:GetDescendants()) do
        if descendant:IsA("Motor6D") or descendant:IsA("Weld") then
            descendant:Destroy()
        end
    end
    print("[HelperFunctions] Joints reset.")
end

-- Backup the CFrame of all parts
function HelperFunctions.backupRig(character)
    local backup = {}
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            backup[part.Name] = part.CFrame
        end
    end
    print("[HelperFunctions] Rig backup complete.")
    return backup
end

-- Create a Motor6D joint
function HelperFunctions.createMotor6D(name, part0, part1)
    if not (part0 and part1) then
        error("[HelperFunctions] Cannot create Motor6D: Missing parts.")
    end

    local motor = Instance.new("Motor6D")
    motor.Name = name
    motor.Part0 = part0
    motor.Part1 = part1
    motor.Parent = part0
    print("[HelperFunctions] Created Motor6D:", name)
    return motor
end

return HelperFunctions
