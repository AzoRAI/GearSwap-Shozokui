--[[

Copyright 2018, Joshua Tyree

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]

-- <editor-fold> Initialization

function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')

  -- Grab the Naught includes
  include('Naught-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  -- Track traditional Bard Buffs
  state.Buff.Pianissimo = buffactive['Pianissimo'] or false
  state.Buff.Marcato = buffactive['Marcato'] or false
  state.Buff.Troubadour = buffactive['Troubadour'] or false
  state.Buff.Nightingale = buffactive['Nightingale'] or false
  state.Buff.ClarionCall = buffactive['Clarion Call'] or false
  state.Buff.SoulVoice = buffactive['Soul Voice'] or false
end

function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = true

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 1

  -- Default Macro Book [Book, Page]
  info.MacroBook = {1, 2}

  -- Set up Gear Options
  info.ExtraSongs = 1
  gear.DummyInstrument = 'Terpander'
  gear.MainDagger = {name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10'}}
  gear.SubDagger = {name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10'}}

  -- Idle Modes
  --  Normal: Normal Idle Gear (Should be DT set)
  --  Move: Move Speed Gear
  state.IdleMode:options('Normal', 'Move')


  -- Offense Modes
  --  Normal: Normal TP Mode
  --  Acc: High Accuracy TP Mode
  state.OffenseMode:options('Normal', 'Acc')

  -- Hybrid Modes
  --  Normal: Normal Engaged Gear
  --  PDT: Use -DT Gear while engaged
  state.HybridMode:options('Normal', 'PDT')

  -- Casting Modes
  --  Normal: Cast in Normal Gear
  state.CastingMode:options('Normal', 'Resistant')
end

function user_keybinds()
  -- Remove default keybinds
  clear_default_binds()

  -- Swap Song Modes
  bind_key('`', 'gs c set SongMode Dummy; input /ma "Army\'s Paeon" <me>;')
  bind_key('f9', 'gs c cycle OffenseMode')
  bind_key('f10', 'gs c cycle CastingMode')
  bind_key('f11', 'gs c cycle HybridMode')
  bind_key('f12', 'gs c cycle IdleMode')
  bind_key('0', 'input /equip range "Marsyas"; input /echo [Marsyas Equipped]')
end

function user_unbind()
  unbind('`')
  unbind('f9')
  unbind('f10')
  unbind('f11')
  unbind('f12')
end

function echo_modes()
  gs_echo("  Song Mode (`): "..state.SongMode.value)
  gs_echo("  Idle Mode (F9): "..state.IdleMode.value)
  gs_echo("  Offense Mode (F10): "..state.OffenseMode.value)
  gs_echo("  Hybrid Mode (F11): "..state.HybridMode.value)
  gs_echo("  Casting Mode (F12): "..state.CastingMode.value)
end

-- </editor-fold> Initialization


-- <editor-fold> Gear Sets
-- NOTE: I use this methodology of setting up functions because it provides
-- much-needed separation of specific sets / functions. You could just as
-- well define everything in init_gear_sets, this is my code style though.

function idle_sets()
  sets.idle = {
    -- Main, Sub, Ammo
    main="Terra's Staff", sub="Achaq Grip", range="Gjallarhorn",

    -- Main Slots
    head="Aya. Zucchetto +1", body="Ayanmo Corazza +1", hands="Aya. Manopolas +1", legs="Aya. Cosciales +1", feet="Aya. Gambieras +1",

    -- Accessories
    neck="Loricate Torque", left_ear="Etiolation Earring", right_ear="Infused Earring",
    waist="Witful Belt", left_ring="Ayanmo Ring", right_ring="Gelatinous Ring", back="Solemnity Cape",
  }

  sets.idle.Move = {feet="Aoidos' Cothurnes +1"}
end

function dt_sets()
  sets.defense.PDT = {}
end

function tp_sets()
  sets.engaged = {}
end

function ws_sets()
  sets.precast.WS = {}
end

function ja_sets()
end

function spell_sets()
  -- TODO: Song-specific buff items

  -- Fast Cast
  sets.precast.FC = {
    -- Main Slots
    head="Welkin Crown", body="Sha'ir Manteel", legs="Aya. Cosciales +1",
    -- Accessories
    left_ear="Etiolation Earring", waist="Witful Belt", back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+9','"Fast Cast"+10',}},
  }

  -- Buffs
  sets.midcast['SongBuff'] = {
    range="Gjallarhorn",
    head="Brioso Roundlet",
    body="Fili Hongreline",
    hands="Brioso Cuffs",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +2",
    neck="Moonbow Whistle",
    waist="Harfner's Sash",
    left_ear="Etiolation Earring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+9','"Fast Cast"+10',}},
  }

  -- Debuffs
  sets.midcast['SongDebuff'] = {
    range="Gjallarhorn",
    head="Aya. Zucchetto +1",
    body="Fili Hongreline",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +2",
    neck="Deceiver's Torque",
    waist="Harfner's Sash",
    left_ear="Hermetic Earring",
    right_ear="Etiolation Earring",
    left_ring="Ayanmo Ring",
    right_ring="Arvina Ringlet +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+9','"Fast Cast"+10',}},
  }
  sets.midcast['SongDebuffResistant'] = set_combine(sets.midcast.SongDebuff, {body="Brioso Justau. +2",})

  -- Fast Recast
  sets.midcast['SongRecast'] = set_combine(sets.precast.FC, {
    legs="Aoidos' Rhingrave"
  })

  sets.midcast['Honor March'] = set_combine(sets.midcast['SongBuff'], {range="Marsyas"})

  -- Extra Songs
  sets.midcast['Dummy'] = {
    -- Main, Sub, Ranged
    main="Marin staff", sub="Achaq grip", range=gear.DummyInstrument,
    -- Main Slots
    head="Welkin Crown", body="Sha'ir Manteel", legs="Aya. Cosciales +1",
    -- Accessories
    left_ear="Etiolation Earring", waist="Witful Belt", back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+9','"Fast Cast"+10',}},
  }
end


function init_gear_sets()
  idle_sets()
  dt_sets()
  spell_sets()
  ja_sets()
  tp_sets()
  ws_sets()
  dt_sets()
end
-- function


-- </editor-fold> Gear Sets


-- <editor-fold> Core Customizations

--
-- Allows you to customize the name of the set in the spell map
-- Ex. sets.midcast.FastRecast for non-potency/accuracy things
-- like Paralyna, Cursna, etc
--
function job_get_spell_map(spell, default_map)
  return default_map
end



-- </editor-fold> Core Customizations


-- <editor-fold> Job Events

--
-- Callback for when player is about to cast spell
--
function job_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'BardSong' then
    -- If you're targeting a player and casting a buff
    -- make sure to cast Pianissimo first
    if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and not state.Buff.Pianissimo then
      local spell_recasts = windower.ffxi.get_spell_recasts()
      if spell_recasts[spell.recast_id] < 2 then
        ja_before_spell("Pianissimo", spell)
        eventArgs.cancel = true
        return
      end
    end

  end
end

function job_midcast(spell, action, spellMap, eventArts)
  if spell.action_type == 'Magic' and spell.type == 'BardSong' then
    local cls = get_song_map(spell)
    if cls and sets.midcast[cls] then
      if info.SubJob == 'NIN' then
        equip(set_combine(sets.midcast[cls], {main=gear.MainDagger, sub=gear.SubDagger}))
      else
        equip(sets.midcast[cls])
      end
    end
  end
end

function job_post_midcast(spell, action, spellMap, eventArts)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  if spell.type == 'BardSong' and not spell.interrupted then
    if state.SongMode.value == 'Dummy' then
      gs_echo("Song Mode reset to \"Normal\"")
      state.SongMode:reset()
    end
  end
end

--
-- Callback for player status change
--
function job_state_change(new, old)

end

--
-- Callback for when any states change for the job
--
function job_state_change(state, old, new)
end

--
-- Callback for when you change your sub job
--
function job_sub_change(old, new)
end

-- </editor-fold> Job Events
