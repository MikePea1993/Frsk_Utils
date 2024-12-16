# FRSK Utils

A utility script for RedM that provides dynamic prompt creation and notification systems.

## Features

- Easy-to-use prompt creation system
- Modern notification system
- Automatic update checker via GitHub releases
- Clean, modern UI design
- Event-based prompt activation handling

## Installation

1. Copy the `frsk_utils` folder to your resources directory
2. Add `ensure frsk_utils` to your server.cfg
3. Make sure to load this resource before any resources that depend on it

## Usage

### Prompt System

#### Creating a Prompt

```lua
exports["frsk_utils"]:CreatePrompt(name, key, text, group, action)
```

Parameters:

- `name`: Unique identifier for the prompt
- `key`: Key to press (must be defined in Config.Keys)
- `text`: Text to display on the prompt
- `group`: Optional prompt group
- `action`: Action identifier for when prompt is activated

#### Showing/Hiding Prompts

```lua
exports["frsk_utils"]:ShowPrompt(name)
exports["frsk_utils"]:HidePrompt(name)
```

#### Removing Prompts

```lua
exports["frsk_utils"]:RemovePrompt(name)
```

#### Handling Prompt Activation

```lua
AddEventHandler('frsk_utils:promptActivated', function(name, action)
    -- Handle prompt activation
end)
```

### Notification System

#### Showing Notifications

```lua
exports["frsk_utils"]:ShowNotification(message, type, duration)
```

Parameters:

- `message`: Text to display in the notification
- `type`: (Optional) Type of notification (default: 'info')
- `duration`: (Optional) How long to show the notification in ms (default: 5000)

## Example Usage

### Basic Prompt Example

```lua
-- Create a prompt
exports["frsk_utils"]:CreatePrompt('interaction', 'G', 'USE', nil, 'INTERACT')

-- Show prompt when player is near interaction point
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        local dist = #(coords - vector3(0.0, 0.0, 0.0))

        if dist < 2.0 then
            exports["frsk_utils"]:ShowPrompt('interaction')
        else
            exports["frsk_utils"]:HidePrompt('interaction')
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

### Basic Notification Example

```lua
-- Show a simple notification
exports["frsk_utils"]:ShowNotification('Hello World!')

-- Show a notification with custom duration (7 seconds)
exports["frsk_utils"]:ShowNotification('Custom duration notification', nil, 7000)

-- Show multiple notifications
exports["frsk_utils"]:ShowNotification('First notification')
Citizen.SetTimeout(2000, function()
    exports["frsk_utils"]:ShowNotification('Second notification')
end)
```

## Adding to Your Resource

1. Add the dependency to your fxmanifest.lua:

```lua
dependencies {
    'frsk_utils'
}
```

2. Use the exports in your scripts as shown in the examples above

## Update System

- The script automatically checks for updates when started
- Updates are checked against the latest GitHub release
- Server owners will be notified in the console if an update is available

## Support

If you need help or want to report bugs, join our Discord: [Your Discord Link]

## License

This project is licensed under [Your License Choice]

## Credits

Created by FRSK Development
