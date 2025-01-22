-- Main.lua
-- Loads and executes the Loader.lua script

-- Helper function to load and execute the Loader
local function loadLoader()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://example.com/Loader.lua"))()
    end)

    if success then
        print("Loader successfully executed.")
    else
        warn("Failed to execute Loader.lua: " .. tostring(result))
    end
end

-- Call the loader
loadLoader()
