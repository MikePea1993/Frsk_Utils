local currentVersion = "1.0.0"
local resourceName = "frsk_utils"
local githubUser = "MikePea1993" -- Change this to your GitHub username
local githubRepo = "Frsk_Utils" -- Change this to your repo name
local githubAPI = ("https://api.github.com/repos/%s/%s/releases/latest"):format(githubUser, githubRepo)

-- Function to compare semantic versions
local function compareVersions(current, latest)
    -- Remove 'v' prefix if it exists
    current = current:gsub("^v", "")
    latest = latest:gsub("^v", "")
    
    -- Split versions into parts
    local current_parts = {}
    local latest_parts = {}
    
    for part in current:gmatch("%d+") do
        table.insert(current_parts, tonumber(part))
    end
    
    for part in latest:gmatch("%d+") do
        table.insert(latest_parts, tonumber(part))
    end
    
    -- Compare each part
    for i = 1, math.max(#current_parts, #latest_parts) do
        local current_part = current_parts[i] or 0
        local latest_part = latest_parts[i] or 0
        
        if latest_part > current_part then
            return true -- Update available
        elseif current_part > latest_part then
            return false -- Current version is newer
        end
    end
    
    return false -- Versions are equal
end

-- Function to get the latest version from GitHub
local function checkVersion()
    PerformHttpRequest(githubAPI, function(err, text, headers)
        if err ~= 200 then
            print("^1[FRSK-UTILS] Failed to check for updates. Error: " .. tostring(err) .. "^7")
            return
        end

        local data = json.decode(text)
        if not data then 
            print("^1[FRSK-UTILS] Failed to parse GitHub response.^7")
            return 
        end

        -- Get latest version from GitHub release tag
        local latestVersion = data.tag_name
        local updateAvailable = compareVersions(currentVersion, latestVersion)

        if updateAvailable then
            print([[^8
╔════════════════════════════════════════════════════════════╗
║                   FRSK-UTILS UPDATE ALERT                   ║
╠════════════════════════════════════════════════════════════╣^7]])
            print("^8║^7 Current Version: ^1" .. currentVersion .. "^7")
            print("^8║^7 Latest Version: ^2" .. latestVersion .. "^7")
            print("^8║^7 Download: ^5" .. data.html_url .. "^7")
            
            -- Print release notes if available
            if data.body then
                print("^8║^7 Release Notes:")
                for line in data.body:gmatch("[^\r\n]+") do
                    print("^8║^7 " .. line)
                end
            end
            
            print([[^8╚════════════════════════════════════════════════════════════╝^7]])
        else
            print("^2[FRSK-UTILS] You are running the latest version!^7")
        end
    end, 'GET', '', {['User-Agent'] = 'FRSK-Utils Version Checker'})
end

-- Check for updates when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        Citizen.Wait(1000) -- Wait a second after startup
        checkVersion()
    end
end)

-- Export the current version
exports('getCurrentVersion', function()
    return currentVersion
end)