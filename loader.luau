--[[
    ==============================================================
    ☁️ AUTONOMOUS CLOUD ENGINE LOADER
    Repository: NegYaRialnyOG/jjdjasdjiII
    Branch: main
    ==============================================================
    Requirements:
    - Game Settings -> Security -> Allow HTTP Requests: ENABLED
]]

local HttpService = game:GetService("HttpService")

local BUNDLE_URL = "https://raw.githubusercontent.com/NegYaRialnyOG/jjdjasdjiII/main/bundle.luau"

local function loadMasterEngine()
    print("----------------------------------------------------------------")
    print("🚀 [CloudLoader] Initializing Autonomous Cloud System...")
    print("🌐 [CloudLoader] Fetching: " .. BUNDLE_URL)
    
    local cacheBuster = "?t=" .. os.time()
    local fetchUrl = BUNDLE_URL .. cacheBuster
    
    local success, response = pcall(function()
        return HttpService:GetAsync(fetchUrl)
    end)
    
    if success and response and #response > 500 then
        local sizeKb = math.floor(#response / 1024)
        print("✅ [CloudLoader] Bundle successfully received (" .. sizeKb .. " KB)")
        print("⚙️ [CloudLoader] Compiling Luau engine...")
        
        local executable, compileErr = loadstring(response)
        if executable then
            print("🌟 [CloudLoader] Launching 507 game systems & dynamic assets...")
            local runSuccess, runErr = pcall(function()
                task.spawn(executable)
            end)
            if not runSuccess then
                warn("❌ [CloudLoader] Runtime error: " .. tostring(runErr))
            end
        else
            warn("❌ [CloudLoader] Compilation error: " .. tostring(compileErr))
        end
    else
        warn("❌ [CloudLoader] CRITICAL: Failed to download bundle from GitHub.")
        warn("Details: " .. tostring(response))
        warn("👉 Make sure 'Allow HTTP Requests' is ENABLED in Game Settings > Security.")
    end
    print("----------------------------------------------------------------")
end

task.defer(loadMasterEngine)
