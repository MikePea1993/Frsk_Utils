local prompts = {}
local promptActive = false

-- Create a new prompt
function CreatePrompt(name, key, text, group, action)
    if prompts[name] then
        return false, "Prompt already exists"
    end

    if not Config.Keys[key] then
        return false, "Invalid key"
    end

    local prompt = Citizen.InvokeNative(0x04F97DE45A519419)
    Citizen.InvokeNative(0xB5352B7494A08258, prompt, Config.Keys[key])
    
    -- Set prompt text
    local str = CreateVarString(10, "LITERAL_STRING", text)
    Citizen.InvokeNative(0x5DD02A8318420DD7, prompt, str)
    
    -- If group is provided, add prompt to group
    if group then
        Citizen.InvokeNative(0x2F11D3A254169EA4, prompt, group, 0)
    end

    prompts[name] = {
        prompt = prompt,
        key = key,
        text = text,
        group = group,
        action = action,
        active = false
    }

    return true, prompt
end

-- Remove a prompt
function RemovePrompt(name)
    if not prompts[name] then
        return false, "Prompt doesn't exist"
    end

    if prompts[name].prompt then
        Citizen.InvokeNative(0x00EDE88D4D13CF59, prompts[name].prompt)
    end

    prompts[name] = nil
    return true
end

-- Show a prompt
function ShowPrompt(name)
    if not prompts[name] then
        return false, "Prompt doesn't exist"
    end

    -- Show the NUI prompt
    SendNUIMessage({
        type = "showPrompt",
        location = prompts[name].action,
        key = prompts[name].key,
        buttonText = prompts[name].text
    })

    prompts[name].active = true
    return true
end

-- Hide a prompt
function HidePrompt(name)
    if not prompts[name] then
        return false, "Prompt doesn't exist"
    end

    -- Hide the NUI prompt
    SendNUIMessage({
        type = "hidePrompt"
    })

    prompts[name].active = false
    return true
end

-- Show a notification
function ShowNotification(message, notifType, duration)
    SendNUIMessage({
        type = 'showNotification',
        message = message,
        notifType = notifType or 'info',
        duration = duration or 5000
    })
end

-- Check if a prompt was activated
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for name, promptData in pairs(prompts) do
            if promptData.active then
                if Citizen.InvokeNative(0xE0F65F0640EF0617, promptData.prompt) then
                    -- Trigger event when prompt is activated
                    TriggerEvent('frsk_utils:promptActivated', name, promptData.action)
                end
            end
        end
    end
end)

-- Cleanup function for resource stop/restart
local function CleanupPrompts()
    for name, _ in pairs(prompts) do
        RemovePrompt(name)
    end
    SendNUIMessage({
        type = "hidePrompt"
    })
end

-- Resource cleanup
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        CleanupPrompts()
    end
end)

-- Export the functions
exports('CreatePrompt', CreatePrompt)
exports('RemovePrompt', RemovePrompt)
exports('ShowPrompt', ShowPrompt)
exports('HidePrompt', HidePrompt)
exports('ShowNotification', ShowNotification)