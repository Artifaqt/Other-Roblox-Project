-- PlayerOrbit.lua
-- Because some players apparently want to look at themselves in orbit like they’re the center of the universe.

local PlayerOrbit = {}

-- Roblox services, because we love overengineering
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variables, because keeping track of this mess is mandatory
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local orbiting = false -- Are we in orbit mode? Let’s track it for fun.
local orbitSpeed = 2 -- Default speed for orbiting. Why 2? Don’t ask.
local orbitDistance = 10 -- How far the orbit is from the player. Personal space matters.
local angle = 0 -- Start angle. Math is hard.

-- Function to enable orbit, because players need to feel like satellites
function PlayerOrbit.enable()
    if orbiting then
        warn("[PlayerOrbit] Orbit already enabled! Stop spamming the function.")
        return
    end

    orbiting = true
    print("[PlayerOrbit] Enabled. Time to spin in circles!")

    -- Hook into RenderStepped for the orbit effect, because why not stress the game loop even more?
    local connection
    connection = RunService.RenderStepped:Connect(function(deltaTime)
        if not orbiting then
            connection:Disconnect()
            return
        end

        -- Increment angle based on orbit speed and time
        angle = (angle + orbitSpeed * deltaTime) % (2 * math.pi)

        -- Calculate orbit position. Yep, it’s basic trigonometry. Thanks, high school.
        local orbitX = math.cos(angle) * orbitDistance
        local orbitZ = math.sin(angle) * orbitDistance

        -- Apply position. Why does this work? Magic.
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(orbitX, 0, orbitZ))
    end)
end

-- Function to disable orbit, because even satellites need a break
function PlayerOrbit.disable()
    if not orbiting then
        warn("[PlayerOrbit] Orbit isn’t even enabled! What are you trying to disable?")
        return
    end

    orbiting = false
    print("[PlayerOrbit] Disabled. Back to standing still like a normal person.")
end

-- Function to set orbit speed, because apparently spinning too slow is a problem
function PlayerOrbit.setSpeed(speed)
    orbitSpeed = speed
    print("[PlayerOrbit] Speed set to:", speed)
end

-- Function to set orbit distance, because we can’t assume players are fine with our default numbers
function PlayerOrbit.setDistance(distance)
    orbitDistance = distance
    print("[PlayerOrbit] Distance set to:", distance)
end

-- Function to toggle orbit, because toggling is trendy
function PlayerOrbit.toggle()
    if orbiting then
        PlayerOrbit.disable()
    else
        PlayerOrbit.enable()
    end
end

return PlayerOrbit
