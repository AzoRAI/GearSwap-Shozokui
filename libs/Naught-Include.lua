
function init_include()
  -- Default Macros
  if info.MacroBook == nil then
    info.MacroBook = {1, 1}
  end

  -- Set up default message color
  info.MessageColor = 50
  info.SubJob = player.sub_job

  -- Handle user-based keybinds
  if user_keybinds then
    user_keybinds()
  end

  -- Track when sub job changes
  windower.raw_register_event('job change', sub_job_change)

  -- Include the bard library
  include('Naught-Bard.lua')

  -- Let the play know what's going on
  echo_status()

  -- Do default lockstyles
  engage_lockstyle(true)
end

function sub_job_change(main_job, main_level, sub_job, sub_level)
  -- Notify file
  if info.SubJob ~= player.sub_job then
    if job_sub_change then
      job_sub_change(info.SubJob, player.sub_job)
    end
  end
  -- Track update
  info.SubJob = player.sub_job
end

function gs_echo(msg)
  add_to_chat(info.MessageColor, msg)
end

function echo_status()
  gs_echo(" ")
  gs_echo("GearSwap Loaded: "..player.name.." ("..player.main_job.."/"..player.sub_job..")")
  if echo_modes then
    echo_modes()
  end
end

function ja_before_spell(ja, spell)
  local ja_cmd = "@input /ja \""..ja.."\" <me>;"
  local wait = "wait 1.5;"
  local spell_cmd = "input /ma \""..spell.name.."\" "..spell.target.name
  send_command(ja_cmd..wait..spell_cmd)
end

function select_macro_book()
  if info.MacroBook ~= nil and info.MacroBook.length > 0 then
    set_macro_page(info.MacroBook[0], info.MacroBook[1])
  end
end

function file_unload()
  -- Unbind keys
  if user_unbind then
    user_unbind()
  end

  disable_blinkmenot()
end

function bind_key(key, command, ctrl, alt)
  local modifier = ""
  if ctrl then
    modifier = "^"
  end

  if alt then
    modifier = "!"
  end

  send_command("bind "..modifier..key.." "..command)
end

function unbind(key)
  send_command('unbind !'..key.."; unbind ^"..key.."; unbind "..key)
end

function clear_default_binds()
  unbind('f9')
  unbind('f10')
  unbind('f11')
  unbind('f12')
end

function engage_lockstyle(wait)
  if info.LockstyleSet ~= nil then
    if wait then
      send_command("wait 5; input /lockstyleset "..info.LockstyleSet.."; input /echo Lockstyle Set #"..info.LockstyleSet.." Engaged")
    else
      send_command("input /lockstyleset "..info.LockstyleSet)
    end

  end

  if info.UseBlinkMeNot == true then
    engage_blinkmenot()
  end
end

function engage_blinkmenot()
  send_command("wait 6; du blinking all always on")
end

function disable_blinkmenot()
  if info.UseBlinkMeNot == true then
    send_command("du blinking all always off")
  end
end

Anchor = {}
Anchor.__index = Anchor
function Anchor:new()
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  -- Begin Anchor Code
  function bit(p)
      return 2 ^ p
  end

  function checkbit(x, p)
    return x % (p + p) >= p
  end

  function clearbit(x, p)
    return checkbit(x, p) and x - p or x
  end

  function string.clearbits(s, p, c)
    if c and c > 1 then
      s = s:clearbits(p + 1, c - 1)
    end
    local b = math.floor(p / 8)
    return s:sub(1, b) .. string.char(clearbit(s:byte(b + 1), bit(p % 8))) .. s:sub(b + 2)
  end

  function string.checkbit(s, p)
    return checkbit(s:byte(math.floor(p / 8) + 1), bit(p % 8))
  end

  -- event callback functions
  o.update = function(id, original, modified, injected, blocked)
    if id == 0x28 then
      local category = math.floor((original:byte(11) % 64) / 4)
      if category == 11 then
        local new = original
        local position = 150
        for target = 1,original:byte(10) do
          new = new:clearbits(position + 60, 3)
          local next_position = position + 123
          if original:checkbit(position + 121) then
            next_position = next_position + 37
          end
          if original:checkbit(position + 122) then
            next_position = next_position + 34
          end
          position = next_position
        end
        return new
      end
    end
  end
  return o
end

if anchor_instance == nil then
  anchor_instance = Anchor:new()
  windower.register_event('incoming chunk', anchor_instance.update)
end
-- End Anchor Code

-- Call setup
init_include()
