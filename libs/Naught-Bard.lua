
function init_include()
  -- Set up a new "Song Mode" for singing full length songs vs Dummy songs
  state.SongMode = M{['description']='Song Mode'}
  state.SongMode:options('Normal', 'Dummy')

  info.CustomTimers = {}

  if not info.GhornLevel then
    info.GhornLevel = 75
  end
  if not info.HarpLevel then
    info.HarpLevel = 85
  end
  if not info.MythicDaggerLevel then
    info.MythicDaggerLevel = 75
  end

  -- Setup Ghorn,Daurdabla,Carn levels
  info.Ghorn = {}
  info.Ghorn[75] = 0.2
  info.Ghorn[80] = 0.2
  info.Ghorn[85] = 0.2
  info.Ghorn[90] = 0.3
  info.Ghorn[95] = 0.3
  info.Ghorn[99] = 0.4
  info.Harp = {}
  info.Harp[85] = 0
  info.Harp[90] = 0.25
  info.Harp[95] = 0.3
  info.Harp[99] = 0.3
  info.Dagger = {}
  info.Dagger[75] = 0.1
  info.Dagger[80] = 0.2
  info.Dagger[85] = 0.3
  info.Dagger[90] = 0.4
  info.Dagger[95] = 0.4
  info.Dagger[99] = 0.5

  info.GhornDuration = function()
    return info.Ghorn[info.GhornLevel]
  end

  info.HarpDuration = function()
    return info.Harp[info.HarpLevel]
  end

  info.MythicDaggerDuration = function()
    return info.Dagger[info.MythicDaggerLevel]
  end

  info.DurationGear = {
    -- Weapons
    {name="Legato Dagger", value=0.05},
    {name="Kali", value=0.05},
    {name="Carnwenhan", value=info.Dagger[info.MythicDaggerLevel]},

    -- Instruments
    {name="Gjallarhorn", value=info.Ghorn[info.GhornLevel]},
    {name="Daurdabla", value=info.Harp[info.HarpLevel]},
    {name="Marsyas", value=0.5},

    -- Gear
    {name="Aoidos' Hngrln. +1", value=0.05},
    {name="Aoidos' Hngrln. +2", value=0.1},
    {name="Fili Hongreline", value=0.11},
    {name="Fili Hongreline +1", value=0.12},
    {name="Mdk. Shalwar +1", value=0.1},
    {name="Inyanga Shalwar", value=0.12},
    {name="Inyanga Shalwar +1", value=0.15},
    {name="Inyanga Shalwar +2", value=0.17},
    {name="Brioso Slippers", value=0.1},
    {name="Brioso Slippers +1", value=0.11},
    {name="Brioso Slippers +2", value=0.13},
    {name="Brioso Slippers +3", value=0.15},

    -- Accessories
    {name="Moonbow Whistle", value=0.2},
    {name="Moonbow Whistle +1", value=0.3},
    {name="Brioso Whistle", value=0.1},
    {name="Aoidos' Matinee", value=0.1}
  }

  info.SongDurationGear = {}
  info.SongDurationGear['Paeon'] = {
    {name="Brioso Roundlet", value=0.1},
    {name="Brioso Roundlet +1", value=0.1},
    {name="Brioso Roundlet +2", value=0.1},
    {name="Brioso Roundlet +3", value=0.2}
  }
  info.SongDurationGear['Madrigal'] = {
    {name="Fili Calot", value=0.1},
    {name="Fili Calot +1", value=0.1},
    {name="Aoidos' Calot +2", value=0.1},
    {name="Intarabus's Cape", value=0.1},

  }
  info.SongDurationGear['Minuet'] = {
    {name="Fili Hongreline +1", value=0.1},
    {name="Fili Hongreline", value=0.1},
    {name=-"Aoidos' Hngrln. +2", value=0.1},

  }
  info.SongDurationGear['March'] = {
    {name="Fili Manchettes", value=0.1},
    {name="Fili Manchettes +1", value=0.1},
    {name="Ad. Mnchtte. +2", value=0.1}
  }
  info.SongDurationGear['Ballad'] = {
    {name="Aoidos' Rhing. +2", value=0.1},
    {name="Fili Rhingrave", value=0.1},
    {name="Fili Rhingrave +1", value=0.1}
  }
  info.SongDurationGear['Sentinel\'s Scherzo'] = {
    {name="Fili Cothurnes", value=0.1},
    {name="Fili Cothurnes +1", value=0.1},
    {name="Aoidos' Cothrn. +2", value=0.1}
  }
end


function find_duration(item)
  local match = nil
  for i,gear in ipairs(info.DurationGear) do
    if gear.name == item then
      match = gear
      break
    end
  end
  return match
end

function find_spell_duration(item, spell)
  local match = nil
  if info.SongDurationGear[spell] == nil then return nil end

  for i,gear in iparis(info.SongDurationGear[spell]) do
    if gear.name == item then
      match = gear
      break
    end
  end
  return match
end

function calc_song_duration(spellName, spellMap)
  local mult = 1
  local gear = nil

  -- Baseline Song Duration Gear
  gear = find_duration(player.equipment.range)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_duration(player.equipment.main)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_duration(player.equipment.sub)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_duration(player.equipment.neck)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_duration(player.equipment.body)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_duration(player.equipment.legs)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_duration(player.equipment.feet)
  if gear ~= nil then mult = mult + gear.value end


  -- Song-Specific duration/potency gear
  gear = find_spell_duration(player.equipment.range, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.main, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.sub, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.head, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.range, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.body, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.hands, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.legs, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.feet, spellName)
  if gear ~= nil then mult = mult + gear.value end
  gear = find_spell_duration(player.equipment.back, spellName)
  if gear ~= nil then mult = mult + gear.value end

  -- Under the effect of Troubadour
  if state.Buff.Troubador then
    mult = mult * 2
  end

  -- Scherzo Duration
  if spellName == "Sentinel's Scherzo" then
    if state.Buff.SoulVoice then
      mult = mult * 2
    elseif state.Buff.Marcato then
      mult = mult * 1.5
    end
  end

  local total = math.floor(mult * 120)
  return total
end

function adjust_timers(spell, spellMap)
  local current_time = os.time()

  -- Eliminate songs that have already expired from our local list.
  local temp_timer_list = {}
  for song_name,expires in pairs(info.CustomTimers) do
    if expires < current_time then
      temp_timer_list[song_name] = true
    end
  end

  for song_name,expires in pairs(temp_timer_list) do
    info.CustomTimers[song_name] = nil
  end

  local dur = calc_song_duration(spell.name, spellMap)
  if info.CustomTimers[spell.name] then
    -- Songs always overwrite themselves now, unless the new song has
    -- less duration than the old one (ie: old one was NT version, new
    -- one has less duration than what's remaining).

    -- If new song will outlast the one in our list, replace it.
    if info.CustomTimers[spell.name] < (current_time + dur) then
      send_command('timers delete "'..spell.name..'"')
      info.CustomTimers[spell.name] = current_time + dur
      send_command('timers create "'..spell.name..'" '..dur..' down')
    end
  else
    -- Figure out how many songs we can maintain.
    local maxsongs = 2
    if player.equipment.range == gear.DummyInstrument then
      maxsongs = maxsongs + info.ExtraSongs
    end
    if buffactive['Clarion Call'] then
      maxsongs = maxsongs + 1
    end
    -- If we have more songs active than is currently apparent, we can still overwrite
    -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
    if maxsongs < table.length(info.CustomTimers) then
      maxsongs = table.length(info.CustomTimers)
    end

    -- Create or update new song timers.
    if table.length(info.CustomTimers) < maxsongs then
      info.CustomTimers[spell.name] = current_time + dur
      send_command('timers create "'..spell.name..'" '..dur..' down')
    else
      local rep,repsong
      for song_name,expires in pairs(info.CustomTimers) do
        if current_time + dur > expires then
          if not rep or rep > expires then
            rep = expires
            repsong = song_name
          end
        end
      end
      if repsong then
        info.CustomTimers[repsong] = nil
        send_command('timers delete "'..repsong..'"')
        info.CustomTimers[spell.name] = current_time + dur
        send_command('timers create "'..spell.name..'" '..dur..' down')
      end
    end
  end
end

function reset_custom_timers()
  for i,v in pairs(info.CustomTimers) do
    send_command('timers delete "'..i..'"')
  end
  info.CustomTimers = {}
end

function get_song_map(spell)
  if spell.en:contains("Ballad") then
    return "SongBuff"
  elseif set.contains(spell.targets, 'Enemy') then
    if state.CastingMode.value == 'Resistant' then
      retun 'SongDebuffResistant'
    else
      return 'SongDebuff'
    end
  elseif state.SongMode.value == 'Dummy' then
    return 'Dummy'
  else
    return 'SongBuff'
  end
end


init_include()
