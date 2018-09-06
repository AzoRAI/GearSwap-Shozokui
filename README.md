# GearSwap Files
## Shozokui - Bahamut

#### Overview

Included here are several of my current GearSwap files. They all depend on GearSwap Kinematics and an extension library developed for these files called `Naught`.

Naught includes features such as:
* Automatic Default Macro Book Selection
* Special Message Colors by way of `gs_echo()` function
* Sub Job tracking. Keeps track through SJ changes
* User Keybinds functions `user_keybinds()` and `user_unbind()`
* Helper fuctions for binding keys `bind_key(key, command, ctrl?, alt?)` and `unbind(key)`
* Automatic Lockstyle
* Automatic BlinkMeNot
* Helpers for using a JA before spell or other ability `ja_before_spell(ja, spell)`

###### Warning: You cannot use these GearSwap files located in `data/` without the `Naught` Library.

##### Recommended Text Editor and Plugins

For best/most efficient results, use Atom text editor with the lua-language and  custom-folds plugins installed.

##### Naught Library Installation

Copy the files located in `libs/` to your `Windower4/addons/GearSwap/libs/` folder.

After Copying the files, include the library in your `get_sets()` delcaration.

```lua
function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')

  -- Load and initialize Naught extensions
  include('Naught-Include.lua')
end
```

##### Macro Books

Enable automatic macro selection by setting the info parameter for the book and page to set.

```lua
function user_setup()
  -- Load Book 1, Page 2
  info.MacroBook = {1,2}
end
```

##### Lockstyle Set

Enable automatic lockstyle sets by setting the info parameter.

```lua
function user_setup()
  -- Load equipset 1 for Lock Style
  info.LockstyleSet = 1
end
```

##### BlinkMeNot

Enable automatic BlinkMeNot by first installing the `DressUp` addon, then enabling it via info parameters.

```lua
function user_setup()
  info.UseBlinkMeNot = true
end
```

##### Keybinds
You can specify file-specific keybinds by defining the following methods:
```lua
function user_keybinds()
  -- Remove default keybinds
  -- TODO: Uncomment if you don't want default F9-F12 keybinds
  -- Need to do this if you wish to re-assign the bind
  -- clear_default_binds()

  -- Swap Song Modes
  bind_key('`', 'gs c set SongMode Dummy; input /ma "Army\'s Paeon" <me>;')

  -- Example: Enable CTRL Modifier so it's CTRL + `
  -- bind_key('`', 'gs c set SongMode Dummy; input /ma "Army\'s Paeon" <me>;', true)

  -- Example: Enable ALT Modifier so it's ALT + `
  -- bind_key('`', 'gs c set SongMode Dummy; input /ma "Army\'s Paeon" <me>;', false, true)
end

function user_unbind()
  unbind('`')
end
```
