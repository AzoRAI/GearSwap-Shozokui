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
  bind_key('f9', 'gs c cycle OffenseMode')
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

function idle_sets()
end

function dt_sets()

  sets.defense.CappedPDT = {
    ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
    body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
    hands="Turms Mittens",
    legs="Eri. Leg Guards +1",
    feet="Turms Leggings",
    neck="Futhark Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Accuracy+10','Enmity+10','Parrying rate+5%',}},
  }

  sets.defense.CappedPDTMEVA = {

  }

  sets.defense.CappedPDTOffense = {
    
  }

  sets.defense.FullDT = {
    ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
    body="Runeist's Coat +2",
    hands="Turms Mittens",
    legs="Eri. Leg Guards +1",
    feet="Turms Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Accuracy+10','Enmity+10','Parrying rate+5%',}},
  }

  sets.defense.MEVA = {
    main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
    sub="Utu Grip",
    ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
    body="Runeist's Coat +2",
    hands="Turms Mittens",
    legs="Rune. Trousers +1",
    feet="Turms Leggings",
    neck="Warder's Charm +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Accuracy+10','Enmity+10','Parrying rate+5%',}},
  }

  sets.defense.StatusResist = {

  }

  sets.defense.Hybrid = {
    ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
    body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
    hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
    legs="Meg. Chausses +1",
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Futhark Torque +1",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Damage taken-5%',}},
  }
end

function tp_sets()
end

function ws_sets()
end

function ja_sets()
end

function spell_sets()
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
end

function job_midcast(spell, action, spellMap, eventArts)
end

function job_post_midcast(spell, action, spellMap, eventArts)
end

function job_aftercast(spell, action, spellMap, eventArgs)
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
