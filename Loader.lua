-- Loader.lua
-- Dynamically loads and initializes modules for the LocalPlayer

-- Helper function to load a module from a URL
local function loadModule(url)
    local success, module = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then
        return module
    else
        warn("Failed to load module from URL: " .. url)
        return nil
    end
end

-- URLs for the modules
local moduleURLs = {
    -- R6/R15 Reanimation
    Reanimation = "https://example.com/Reanimate.lua",
    HeadGrab = "https://example.com/HeadGrab.lua",
    Freeze = "https://example.com/Freeze.lua",
    PlayerCopying = "https://example.com/PlayerCopying.lua",
    CharacterStretch = "https://example.com/CharacterStretch.lua",
    Invisibility = "https://example.com/Invisibility.lua",

    -- Animations
    R6Helicopter = "https://example.com/R6Helicopter.lua",
    R6Creeper = "https://example.com/R6Creeper.lua",
    R6StarGlitcher = "https://example.com/R6StarGlitcher.lua",
    R6Xester = "https://example.com/R6Xester.lua",
    R15Creature = "https://example.com/R15Creature.lua",
    CustomAnimations = "https://example.com/CustomAnimations.lua",

    -- Movement
    WalkSpeed = "https://example.com/WalkSpeed.lua",
    Flight = "https://example.com/Flight.lua",
    TPWalk = "https://example.com/TPWalk.lua",
    PlayerOrbit = "https://example.com/PlayerOrbit.lua",
    Noclip = "https://example.com/Noclip.lua",
    JumpPower = "https://example.com/JumpPower.lua",

    -- Extra Features
    SizeModifier = "https://example.com/SizeModifier.lua",
    AntiReset = "https://example.com/AntiReset.lua",

    -- Shader System
    ShaderController = "https://example.com/Shaders/ShaderController.lua",
    MotionBlur = "https://example.com/Shaders/MotionBlur.lua",
    Rainbow = "https://example.com/Shaders/Rainbow.lua",

    -- UI
    UI = "https://example.com/UI/MainUI.lua" -- Add other UI modules if needed
}

-- Load all modules into a table
local modules = {}
for name, url in pairs(moduleURLs) do
    print("Loading module:", name)
    modules[name] = loadModule(url)
end

-- Initialize modules for the LocalPlayer
local function initializeModulesForLocalPlayer()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then
        warn("LocalPlayer not found!")
        return
    end

    print("Initializing modules for LocalPlayer:", localPlayer.Name)

    for name, module in pairs(modules) do
        if module and module.init then
            local success, err = pcall(function()
                module.init(localPlayer)
            end)
            if success then
                print("Initialized module:", name)
            else
                warn("Failed to initialize module '" .. name .. "': " .. tostring(err))
            end
        else
            warn("Module '" .. name .. "' is missing or does not have an init function.")
        end
    end
end

-- Load and Initialize Shader UI
local function initializeShaderUI()
    local ShaderUI = modules.ShaderUI
    if ShaderUI and ShaderUI.init then
        ShaderUI.init()
        print("Shader UI initialized.")
    else
        warn("Shader UI module is missing or does not have an init function.")
    end
end

-- Load and Initialize Main UI
local function initializeMainUI()
    local MainUI = modules.MainUI
    if MainUI and MainUI.init then
        MainUI.init()
        print("Main UI initialized.")
    else
        warn("Main UI module is missing or does not have an init function.")
    end
end

-- Call the initialization functions
initializeModulesForLocalPlayer()
initializeShaderUI()
initializeMainUI()

-- Optional: Return a table for potential further use
return {
    modules = modules,
    initializeModulesForLocalPlayer = initializeModulesForLocalPlayer
}
