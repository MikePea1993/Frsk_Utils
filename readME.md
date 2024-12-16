# FRSK Utils

A utility script for RedM that provides a dynamic prompt creation system.

## Features

- Easy-to-use prompt creation system
- Support for multiple prompts with different keys and actions
- NUI-based prompt display
- Event-based prompt activation handling

## Installation

1. Copy the `frsk_utils` folder to your resources directory
2. Add `ensure frsk_utils` to your server.cfg
3. Make sure to load this resource before any resources that depend on it

## Usage

### Creating a Prompt

```lua
exports.frsk_utils:CreatePrompt(name, key, text, group, action)
```

- `name`: Unique identifier for the prompt
- `key`: Key to press (must be defined in Config.Keys)
- `text`: Text to display on the prompt
- `group`: Optional prompt group
- `action`: Action identifier for when prompt is activated

### Showing/Hiding Prompts

```lua
exports.frsk_utils:ShowPrompt(name)
exports.frsk_utils:HidePrompt(name)
```

### Removing Prompts

```lua
exports.frsk_utils:RemovePrompt(name)
```

### Handling Prompt Activation

```lua
AddEventHandler('frsk_utils:promptActivated', function(name, action)
    -- Handle prompt activation
end)
```

## Example

```lua
-- Create a prompt
exports.frsk_utils:CreatePrompt('interaction', 'G', 'USE', nil, 'INTERACT')

-- Show prompt when player is near interaction point
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        local dist = #(coords - vector3(0.0, 0.0, 0.0))

        if dist < 2.0 then
            exports.frsk_utils:ShowPrompt('interaction')
        else
            exports.frsk_utils:HidePrompt('interaction')
        end
    end
end)

-- Handle prompt activation
AddEventHandler('frsk_utils:promptActivated', function(name, action)
    if action == 'INTERACT' then
        -- Do something when prompt is activated
    end
end)
```
