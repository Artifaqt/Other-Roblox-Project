-- Reanimate.lua
-- The heart of reanimation. It rebuilds your character rig because Roblox doesn't want you having fun.

local Reanimate = {}

-- Load HelperFunctions because nobody likes writing the same code twice
local HelperFunctions

-- Function to patch welds by resetting the character
local function patchWelds(character)
    local player = game.Players.LocalPlayer
    player.Character = nil
    player.Character = character

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp:Destroy()
    end

    print("[Reanimate] Welds patched.")
end

-- Function to create a protected welds part
local function createProtectedWelds(character)
    local protectedWelds = Instance.new("Part", workspace)
    protectedWelds.Name = game.Players.LocalPlayer.Name .. " Protected Welds"
    protectedWelds.Anchored = true
    protectedWelds.CFrame = character:FindFirstChild("Torso") and character.Torso.CFrame or character.UpperTorso.CFrame
    protectedWelds.CanCollide = false
    protectedWelds.Transparency = 1
    protectedWelds.Size = Vector3.new(9e9, 9e9, 9e9)

    print("[Reanimate] Protected welds created.")
    return protectedWelds
end

-- Function to break all joints in the character
local function breakJoints(character)
    character:BreakJoints()
    print("[Reanimate] Joints broken.")
end

-- Function to align accessories to the protected welds
local function alignAccessories(character, protectedWelds)
    for _, accessory in pairs(character:GetChildren()) do
        if accessory:IsA("Accessory") then
            local handle = accessory.Handle

            -- Create attachments and alignment constraints
            local alignPos = Instance.new("AlignPosition", handle)
            local alignOri = Instance.new("AlignOrientation", handle)
            local attachment1 = Instance.new("Attachment", handle)
            local attachment2 = Instance.new("Attachment", protectedWelds)

            alignPos.Attachment0 = attachment1
            alignOri.Attachment0 = attachment1
            alignPos.Attachment1 = attachment2
            alignOri.Attachment1 = attachment2

            alignPos.Responsiveness = 300
            alignPos.MaxForce = 5e9
            alignOri.MaxTorque = 5e9
            alignOri.Responsiveness = 300

            print("[Reanimate] Accessory aligned:", accessory.Name)
        end
    end
end

-- Function to apply netless movement
local function applyNetless(character, protectedWelds)
    game:GetService("RunService").Heartbeat:Connect(function()
        -- Adjust velocity for the protected welds
        protectedWelds.Velocity = Vector3.new(0, 35, 0)

        -- Adjust velocity for character parts and accessories
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Velocity = Vector3.new(0, -32.5, 0)
            elseif part:IsA("Accessory") then
                part.Handle.Velocity = Vector3.new(0, -32.5, 0)
            end
        end
    end)
    print("[Reanimate] Netless velocity applied.")
end

-- Initialization function for reanimation
function Reanimate.init(player, helperFunctions)
    print("[Reanimate] Initializing...")
    HelperFunctions = helperFunctions

    if not HelperFunctions then
        error("[Reanimate] HelperFunctions is nil. Ensure it's passed correctly.")
    end

    local character = player.Character or player.CharacterAdded:Wait()

    -- Step 1: Patch welds and create protected welds
    patchWelds(character)
    local protectedWelds = createProtectedWelds(character)

    -- Step 2: Break joints and align accessories
    breakJoints(character)
    alignAccessories(character, protectedWelds)

    -- Step 3: Apply netless movement
    applyNetless(character, protectedWelds)

    print("[Reanimate] Initialization complete.")
end

-- Function to reset to original state (placeholder if needed)
function Reanimate.resetToOriginal(player)
    print("[Reanimate] Reset to original is not supported in this method.")
end

return Reanimate
