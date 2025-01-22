function Reanimate.init(player, helperFunctions)
    print("[Debug] Initializing Reanimate...")

    -- Assign HelperFunctions
    HelperFunctions = helperFunctions
    if not HelperFunctions then
        error("[Reanimate] HelperFunctions is nil. Ensure it is passed correctly.")
    end

    -- Get Character and Humanoid
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        error("[Reanimate] Humanoid not found in character.")
    end

    print("[Debug] Character and Humanoid found.")
    print("[Debug] Rig type:", humanoid.RigType)

    -- Backup original rig
    originalRigState = HelperFunctions.backupRig(character)
    print("[Debug] Original rig state backed up.")

    -- Reanimate based on rig type
    if humanoid.RigType == Enum.HumanoidRigType.R6 then
        reanimateR6(character)
    elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
        reanimateR15(character)
    else
        error("[Reanimate] Unknown rig type.")
    end
end
