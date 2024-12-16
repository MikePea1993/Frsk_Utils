local function showAsciiArt()
    local art = [[
 ________                    __              __    __  ________  ______  __       
|        \                  |  \            |  \  |  \|        \|      \|  \      
| $$$$$$$$______    _______ | $$   __       | $$  | $$ \$$$$$$$$ \$$$$$$| $$      
| $$__   /      \  /       \| $$  /  \      | $$  | $$   | $$     | $$  | $$      
| $$  \ |  $$$$$$\|  $$$$$$$| $$_/  $$      | $$  | $$   | $$     | $$  | $$      
| $$$$$ | $$   \$$ \$$    \ | $$   $$       | $$  | $$   | $$     | $$  | $$      
| $$    | $$       _\$$$$$$\| $$$$$$\       | $$__/ $$   | $$    _| $$_ | $$_____ 
| $$    | $$      |       $$| $$  \$$\       \$$    $$   | $$   |   $$ \| $$     \
 \$$     \$$       \$$$$$$$  \$$   \$$        \$$$$$$     \$$    \$$$$$$ \$$$$$$$$

                          Utility Script v1.0
                       Created by FRSK Development
    ]]

    -- Print each line with color for better visibility
    -- Using color code 1 for red (instead of 2 for green)
    local lines = stringsplit(art, "\n")
    for _, line in ipairs(lines) do
        print("^1" .. line .. "^7")
    end
end

-- Helper function to split string into lines
function stringsplit(str, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

-- Show ASCII art when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        showAsciiArt()
    end
end)