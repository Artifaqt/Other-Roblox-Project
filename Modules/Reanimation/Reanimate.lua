-- Reanimate.lua
-- The heart of reanimation. It rebuilds your character rig because otherwise Roblox says "No funny business allowed"

local Reanimate = {}

-- Load HelperFunctions because I really dont wanna write the exact same functions like 10000000 times
local HelperFunctions

-- States vars so we can manage things and stuff
local originalRigState = {} -- just a backup of the original rig
local currentRigType = nil -- tracks if your currently a R6 or R15

-- Helper function to reanimate R6 rig
local function reanimateR6(character)
    local torso = character:findFirstChild("Torso")
    local head = character:findFirstChild("Head")
    local leftArm = character:findFirstChild("Left Arm")
    local rightArm = character:findFirstChild("Right Arm")
    local leftLeg = character:findFirstChild("Left Leg")
    local rightLeg = character:findFirstChild("Right Leg")

    if not torso or not head or not leftArm or not rightArm or not leftLeg or not rightLeg then
        warn("[Reanimate] Missing R6 parts. Roblox wtf is going on man thats not normal.")
        return
    end

    -- Recreate Motor6D joints
    HelperFunctions.createMotor6D("Neck", torso, head)
    HelperFunctions.createMotor6D("Left Shoulder", torso, leftArm)
    HelperFunctions.createMotor6D("Right Shoulder", torso, rightArm)
    HelperFunctions.createMotor6D("Left Hip", torso, leftLeg)
    HelperFunctions.createMotor6D("Right Hip", torso, rightLeg)

    print("[Reanimate] R6 Reanimation complete.")
end

-- Helper function to reanime R15 rig
local function reanimateR15(character)
    local upperTorso = character:FindFirstChild("UpperTorso")
    local head = character:FindFirstChild("Head")
    local leftUpperArm = character:FindFirstChild("LeftUpperArm")
    local rightUpperArm = character:FindFirstChild("RighUpperArm")
    local leftUpperLeg = character:FindFirstChild("LeftUpperLeg")
    local rightUpperLeg = character:FindFirstChild("RightUpperLeg")

    if not upperTorso or not head or not leftUpperArm or not rightUpperArm or not leftUpperLeg or not rightUpperLeg then
        warn("[Reanimate] Missing R15 parts. Fix ur fkn rig")
        return
    end

    -- Recreate Motor6D joints
    HelperFunctions.createMotor6D("Neck", upperTorso, head)
    HelperFunctions.createMotor6D("Left Shoulder", upperTorso, leftUpperArm)
    HelperFunctions.createMotor6D("Right Shoulder", upperTorso, rightUpperArm)
    HelperFunctions.createMotor6D("Left Hip", upperTorso, leftUpperLeg)
    HelperFunctions.createMotor6D("Right Hip", upperTorso, rightUpperLeg)

    print("[Reanimate] R15 reanimation complete.")
end

