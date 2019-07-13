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
  info.LockstyleSet = 2

  -- Default Macro Book [Book, Page]
  info.MacroBook = {1, 2}

  -- Set up Gear Options
  info.ExtraSongs = 1
  gear.DummyInstrument = 'Daurdabla'
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

  -- Swap Song Modes
  bind_key('`', 'gs c set SongMode Dummy; input /ma "Army\'s Paeon" <me>;')
  bind_key('f9', 'gs c cycle SongMode')
  bind_key('f10', 'gs c cycle CastingMode')
  bind_key('f11', 'gs c cycle HybridMode')
  bind_key('f12', 'gs c cycle IdleMode')
end

function user_unbind()
  unbind('`')
  unbind('f9')
  unbind('f10')
  unbind('f11')
  unbind('f12')
  unbind('0')
  unbind(']')
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
    main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +1",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Earthcry Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back="Solemnity Cape",
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
  sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}
  sets.precast.JA['Nightingale'] = {feet="Bihu Slippers +3"}
  sets.precast.JA['Troubador'] = {body="Bihu Jstcorps +1"}
end

function spell_sets()
  -- TODO: Song-specific buff items

  -- Fast Cast
  sets.precast.FC = {
    head="Nahtirah Hat",
    body="Zendik Robe",
    hands="Gende. Gages +1",
    legs="Aya. Cosciales +1",
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Aoidos' Matinee",
    waist="Witful Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Prolix Ring",
    back="Swith Cape +1",
  }

  sets.precast.FC["Honor March"] = set_combine(sets.precast.FC, {range="Marsyas"})
  -- sets.precast['Honor March'] = {range="Marsyas"}

  -- Buffs
  sets.midcast['SongBuff'] = {
    range="Gjallarhorn",
    head="Brioso Roundlet +2",
    body="Fili Hongreline +1",
    hands="Brioso Cuffs +2",
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Hermetic Earring",
    right_ear="Gwati Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+5','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+4','"Fast Cast"+10',}},
  }



  -- Debuffs
  sets.midcast['SongDebuff'] = {
    range="Gjallarhorn",
    head="Brioso Roundlet +2",
    body="Fili Hongreline +1",
    hands="Brioso Cuffs +2",
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Hermetic Earring",
    right_ear="Gwati Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+5','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+4','"Fast Cast"+10',}},
  }
  sets.midcast['SongDebuffResistant'] = set_combine(sets.midcast.SongDebuff, {body="Brioso Justau. +2",})

  sets.midcast['Magic Finale'] = sets.midcast['SongDebuffResistant']

  sets.midcast['Silence'] = sets.midcast['SongDebuff']

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

  sets.midcast["Army's Paeon"] = sets.midcast['Dummy']

  sets.midcast.Cure = {
    main="Chatoyant Staff",
    sub="Achaq Grip",
    range="Gjallarhorn",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Chironic Doublet", augments={'"Resist Silence"+8','"Fast Cast"+1','INT+1 MND+1 CHR+1','Accuracy+15 Attack+15','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    hands="Inyan. Dastanas +2",
    legs="Aya. Cosciales +1",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Mendi. Earring",
    right_ear="Etiolation Earring",
    left_ring="Sirona's Ring",
    right_ring="Gelatinous Ring",
    back="Solemnity Cape",
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
