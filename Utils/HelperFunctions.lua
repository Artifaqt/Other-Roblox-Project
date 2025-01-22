-- Reanimate.lua
-- The heart of reanimation. It rebuilds your character rig because Roblox doesn’t want you breaking its toys.

local Reanimate = {}

-- Expecting HelperFunctions as a dependency because we refuse to rewrite code
local HelperFunctions

-- State variables, because chaos needs some order
local originalRigState = {} -- Backup of the original rig
local currentRigType = Enum.HumanoidRigType.R6 -- Default rig type. Why R6? Because nostalgia.

-- Function to backup the original rig for those "oops" moments
local function backupRig(character)
    originalRigState = HelperFunctions.backupRig(character)
    print("[Reanimate] Rig backed up.")
end

-- Function to reset joints, because the only way to make it better is to destroy it first
local function resetJoints(character)
    HelperFunctions.resetJoints(character)
end

-- Function to reanimate R6 rigs, because they’re simple and we love simplicity
local function reanimateR6(character)
    print("[Reanimate] Switching to R6 rig...")
    local torso = character:FindFirstChild("Torso")
    local head = character:FindFirstChild("Head")
    local leftArm = character:FindFirstChild("Left Arm")
    local rightArm = character:FindFirstChild("Right Arm")
    local leftLeg = character:FindFirstChild("Left Leg")
    local rightLeg = character:FindFirstChild("Right Leg")

    if not torso or not head or not leftArm or not rightArm or not leftLeg or not rightLeg then
        warn("[Reanimate] Missing R6 parts. Did Roblox eat them?")
        return
    end

    HelperFunctions.createMotor6D("Neck", torso, head)
    HelperFunctions.createMotor6D("Left Shoulder", torso, leftArm)
    HelperFunctions.createMotor6D("Right Shoulder", torso, rightArm)
    HelperFunctions.createMotor6D("Left Hip", torso, leftLeg)
    HelperFunctions.createMotor6D("Right Hip", torso, rightLeg)

    print("[Reanimate] R6 reanimation complete.")
end

-- Function to reanimate R15 rigs, because complexity keeps us awake at night
local function reanimateR15(character)
    print("[Reanimate] Switching to R15 rig...")
    local upperTorso = character:FindFirstChild("UpperTorso")
    local head = character:FindFirstChild("Head")
    local leftUpperArm = character:FindFirstChild("LeftUpperArm")
    local rightUpperArm = character:FindFirstChild("RightUpperArm")
    local leftUpperLeg = character:FindFirstChild("LeftUpperLeg")
    local rightUpperLeg = character:FindFirstChild("RightUpperLeg")

    if not upperTorso or not head or not leftUpperArm or not rightUpperArm or not leftUpperLeg or not rightUpperLeg then
        warn("[Reanimate] Missing R15 parts. Who’s been messing with your rig?")
        return
    end

    HelperFunctions.createMotor6D("Neck", upperTorso, head)
    HelperFunctions.createMotor6D("Left Shoulder", upperTorso, leftUpperArm)
    HelperFunctions.createMotor6D("Right Shoulder", upperTorso, rightUpperArm)
    HelperFunctions.createMotor6D("Left Hip", upperTorso, leftUpperLeg)
    HelperFunctions.createMotor6D("Right Hip", upperTorso, rightUpperLeg)

    print("[Reanimate] R15 reanimation complete.")
end

-- Function to switch rigs, because variety is the spice of life
local function switchRigType(character, newRigType)
    if currentRigType == newRigType then
        warn("[Reanimate] Already using this rig type.")
        return
    end

    resetJoints(character)
    if newRigType == Enum.HumanoidRigType.R6 then
        reanimateR6(character)
    elseif newRigType == Enum.HumanoidRigType.R15 then
        reanimateR15(character)
    else
        warn("[Reanimate] Invalid rig type.")
        return
    end

    currentRigType = newRigType
    print("[Reanimate] Switched to", tostring(newRigType))
end

-- Initialization function, because every script needs a starting point
function Reanimate.init(player, helperFunctions)
    HelperFunctions = helperFunctions -- Inject the dependency because Synapse hates require()
    local character = player.Character or player.CharacterAdded:Wait()

    backupRig(character)
    resetJoints(character)

    -- Default to currentRigType (can be R6 or R15)
    if currentRigType == Enum.HumanoidRigType.R6 then
        reanimateR6(character)
    elseif currentRigType == Enum.HumanoidRigType.R15 then
        reanimateR15(character)
    end

    print("[Reanimate] Initialized with", tostring(currentRigType), "rig.")
end

-- Function to switch to R6
function Reanimate.switchToR6(player)
    local character = player.Character or player.CharacterAdded:Wait()
    switchRigType(character, Enum.HumanoidRigType.R6)
end

-- Function to switch to R15
function Reanimate.switchToR15(player)
    local character = player.Character or player.CharacterAdded:Wait()
    switchRigType(character, Enum.HumanoidRigType.R15)
end

-- Reset rig to original state, because someone always wants an undo button
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

return Reanimate
