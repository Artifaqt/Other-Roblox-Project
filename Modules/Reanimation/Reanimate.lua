-- Reanimate.lua
-- The heart of reanimation. It rebuilds your character rig because otherwise Roblox says "No funny business allowed"

local Reanimate = {}

-- Load HelperFunctions because I really don’t wanna write the exact same functions like 10000000 times
local HelperFunctions

-- State vars so we can manage things and stuff
local originalRigState = {} -- Just a backup of the original rig
local currentRigType = nil -- Tracks if you're currently R6 or R15

-- Helper function to reanimate R6 rig
local function reanimateR6(character)
    local torso = character:FindFirstChild("Torso")
    local head = character:FindFirstChild("Head")
    local leftArm = character:FindFirstChild("Left Arm")
    local rightArm = character:FindFirstChild("Right Arm")
    local leftLeg = character:FindFirstChild("Left Leg")
    local rightLeg = character:FindFirstChild("Right Leg")

    if not torso or not head or not leftArm or not rightArm or not leftLeg or not rightLeg then
        warn("[Reanimate] Missing R6 parts. Roblox wtf is going on man, that's not normal.")
        return
    end

    -- Recreate Motor6D joints
    HelperFunctions.createMotor6D("Neck", torso, head)
    HelperFunctions.createMotor6D("Left Shoulder", torso, leftArm)
    HelperFunctions.createMotor6D("Right Shoulder", torso, rightArm)
    HelperFunctions.createMotor6D("Left Hip", torso, leftLeg)
    HelperFunctions.createMotor6D("Right Hip", torso, rightLeg)

    print("[Reanimate] R6 Reanimation complete.")
    currentRigType = Enum.HumanoidRigType.R6
end

-- Helper function to reanimate R15 rig
local function reanimateR15(character)
    local upperTorso = character:FindFirstChild("UpperTorso")
    local head = character:FindFirstChild("Head")
    local leftUpperArm = character:FindFirstChild("LeftUpperArm")
    local rightUpperArm = character:FindFirstChild("RightUpperArm")
    local leftUpperLeg = character:FindFirstChild("LeftUpperLeg")
    local rightUpperLeg = character:FindFirstChild("RightUpperLeg")

    if not upperTorso or not head or not leftUpperArm or not rightUpperArm or not leftUpperLeg or not rightUpperLeg then
        warn("[Reanimate] Missing R15 parts. Fix your fkn rig.")
        return
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

-- Initialize Reanimate with the LocalPlayer and HelperFunctions
function Reanimate.init(player, helperFunctions)
    HelperFunctions = helperFunctions -- Assign HelperFunctions dynamically

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        error("[Reanimate] Humanoid not found. Something's seriously broken.")
    end

    originalRigState = HelperFunctions.backupRig(character) -- Backup original rig state

    -- Determine current rig type and reanimate
    if humanoid.RigType == Enum.HumanoidRigType.R6 then
        reanimateR6(character)
    elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
        reanimateR15(character)
    else
        warn("[Reanimate] Unknown rig type.")
    end
end

-- Function to reset rig to original state
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
