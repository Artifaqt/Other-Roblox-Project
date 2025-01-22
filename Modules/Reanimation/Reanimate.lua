-- Reanimate.lua
-- The heart of reanimation. It rebuilds your character rig because Roblox doesn't like us having fun.

local Reanimate = {}

-- Load HelperFunctions because why reinvent the wheel?
local HelperFunctions

-- State vars for tracking chaos
local originalRigState = {} -- Backup of the original rig
local currentRigType = nil -- Tracks the current rig type (R6 or R15)

-- Helper function to reanimate R6 rigs
local function reanimateR6(character)
    print("[Reanimate] Starting R6 reanimation...")
    local torso = character:FindFirstChild("Torso")
    local head = character:FindFirstChild("Head")
    local leftArm = character:FindFirstChild("Left Arm")
    local rightArm = character:FindFirstChild("Right Arm")
    local leftLeg = character:FindFirstChild("Left Leg")
    local rightLeg = character:FindFirstChild("Right Leg")

    if not (torso and head and leftArm and rightArm and leftLeg and rightLeg) then
        error("[Reanimate] Missing R6 parts. Rig is incomplete.")
    end

    -- Recreate Motor6D joints
    HelperFunctions.createMotor6D("Neck", torso, head)
    HelperFunctions.createMotor6D("Left Shoulder", torso, leftArm)
    HelperFunctions.createMotor6D("Right Shoulder", torso, rightArm)
    HelperFunctions.createMotor6D("Left Hip", torso, leftLeg)
    HelperFunctions.createMotor6D("Right Hip", torso, rightLeg)

    print("[Reanimate] R6 reanimation complete.")
    currentRigType = Enum.HumanoidRigType.R6
end

-- Helper function to reanimate R15 rigs
local function reanimateR15(character)
    print("[Reanimate] Starting R15 reanimation...")
    local upperTorso = character:FindFirstChild("UpperTorso")
    local head = character:FindFirstChild("Head")
    local leftUpperArm = character:FindFirstChild("LeftUpperArm")
    local rightUpperArm = character:FindFirstChild("RightUpperArm")
    local leftUpperLeg = character:FindFirstChild("LeftUpperLeg")
    local rightUpperLeg = character:FindFirstChild("RightUpperLeg")

    if not (upperTorso and head and leftUpperArm and rightUpperArm and leftUpperLeg and rightUpperLeg) then
        error("[Reanimate] Missing R15 parts. Rig is incomplete.")
    end

    -- Recreate Motor6D joints
    HelperFunctions.createMotor6D("Neck", upperTorso, head)
    HelperFunctions.createMotor6D("Left Shoulder", upperTorso, leftUpperArm)
    HelperFunctions.createMotor6D("Right Shoulder", upperTorso, rightUpperArm)
    HelperFunctions.createMotor6D("Left Hip", upperTorso, leftUpperLeg)
    HelperFunctions.createMotor6D("Right Hip", upperTorso, rightUpperLeg)

    print("[Reanimate] R15 reanimation complete.")
    currentRigType = Enum.HumanoidRigType.R15
end

-- Initialize Reanimate
function Reanimate.init(player, helperFunctions)
    print("[Reanimate] Initializing...")
    HelperFunctions = helperFunctions

    if not HelperFunctions then
        error("[Reanimate] HelperFunctions is nil. Ensure it's passed correctly.")
    end

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if not humanoid then
        error("[Reanimate] Humanoid not found.")
    end

    originalRigState = HelperFunctions.backupRig(character)
    print("[Reanimate] Backed up original rig.")

    if humanoid.RigType == Enum.HumanoidRigType.R6 then
        reanimateR6(character)
    elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
        reanimateR15(character)
    else
        error("[Reanimate] Unknown rig type.")
    end
end

-- Reset to original rig state
function Reanimate.resetToOriginal(player)
    local character = player.Character or player.CharacterAdded:Wait()
    for partName, cframe in pairs(originalRigState) do
        local part = character:FindFirstChild(partName)
        if part then
            part.CFrame = cframe
        end
    end
    print("[Reanimate] Rig reset to original state.")
end

-- Switch to R6 rig
function Reanimate.switchToR6(player)
    local character = player.Character or player.CharacterAdded:Wait()
    reanimateR6(character)
end

-- Switch to R15 rig
function Reanimate.switchToR15(player)
    local character = player.Character or player.CharacterAdded:Wait()
    reanimateR15(character)
end

return Reanimate
