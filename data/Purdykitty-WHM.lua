

-- <editor-fold> Initialization

function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')

  -- Grab the Naught includes
  include('Naught-Include.lua')
end

function job_setup()
  -- Track Buffs
  state.Buff.LightArts = buffactive['Light Arts'] or false
  state.Buff.Sublimation = buffactive['Sublimation'] or false
  state.Buff.Solace = buffactive['Afflatus Solace'] or false
  state.Buff.Misery = buffactive['Afflatus Misery'] or false
  state.Buff.Storms = buffactive['Aurorastorm'] or false
  state.Buff.Haste = buffactive['Haste'] or false
  state.Buff.Caress = buffactive['Divine Caress'] or false
  state.Buff.Reraise = buffactive['Reraise'] or false


  -- Gear for Weather Casting
  gear.Weather = {
    main="Chatoyant Staff",
    sub="Enki strap",
    waist="Hachirin-no-Obi",
    back="Twilight Cape"
  }
end

function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = true

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 7

  -- Default Macro Book [Book, Page]
  info.MacroBook = {1, 2}


  -- Idle Modes
  --  Normal: Normal Idle Gear (Should be Refresh set)
  --  PDT: Defense Gear
  state.IdleMode:options('Normal', 'PDT', 'MEVA')

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
  --  Weather: Merge in weather gear
  state.CastingMode:options('Normal', 'Weather', 'Resistant')
end

function user_keybinds()
  -- Remove default keybinds
  bind_key('f9', 'gs c cycle CastingMode')
  bind_key('f12', 'gs c cycle IdleMode')
end

function user_unbind()
  unbind('f9')
  unbind('f12')
end

-- </editor-fold>


-- <editor-fold> Gear Sets

function idle_sets()
  sets.idle = {
    main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Staunch Tathlum",
    head="Inyanga Tiara +2",
    body="Theo. Briault +3",
    hands="Aya. Manopolas +2",
    legs="Assid. Pants +1",
    feet="Herald's Gaiters",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Hearty Earring",
    left_ring="Vocane Ring",
    right_ring="Gelatinous Ring +1",
    back="Solemnity Cape",
  }

  sets.idle.PDT = set_combine(sets.idle, {
    main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Staunch Tathlum",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +1",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Hearty Earring",
    left_ring="Vocane Ring",
    right_ring="Gelatinous Ring +1",
    back="Solemnity Cape",
  })
end

function engaged_sets()
  sets.engaged = {
    ammo="Hasty Pinion +1",
    head="Aya. Zucchetto +2",
    body={ name="Piety Briault +3", augments={'Enhances "Benediction" effect',}},
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet={ name="Piety Duckbills +3", augments={'Enhances "Protectra V" effect',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Ilabrat Ring",
    right_ring="Rajas Ring",
    back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }

  sets.engaged.DW = set_combine(sets.engaged, {
    main={ name="Yagrush", augments={'DMG:+1',}},
    sub="Sindri",
  })
end

function ja_sets()
  sets.precast.JA = {}
end

function spell_sets()
  sets.precast.FC = {
    ammo="Impatiens",
    head="Nahtirah Hat",
    body="Zendik Robe",
    hands="Gende. Gages +1",
    legs="Kaykaus Tights",
    feet="Regal Pumps +1",
    neck="Loricate Torque +1",
    waist="Channeler's Stone",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back="Swith Cape +1",
  }

  -- TODO: Fill in Status Removal Gear
  sets.midcast.StatusRemoval = set_combine(sets.precast.FC, {
    main="Yagrush",
  })
  sets.midcast['Erase'] = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})
  sets.midcast.Esuna = sets.midcast.StatusRemoval
  -- TODO: Fill in Divine Caress Gear
  sets.midcast.StatusRemovalCaress = {}

  -- TODO: Fill in more Cursna Gear
  sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval,  {
    main="Yagrush",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +3",
    legs="Th. Pant. +3",
    feet="Gende. Galosh. +1",
    back={ name="Alaunus's Cape", augments={'MP+60','Eva.+4 /Mag. Eva.+4','"Cure" potency +6%',}},
    neck="Debilis Medallion",
    waist="Bishop's Sash",
    left_ring="Haoma's Ring",
    right_ring="Haoma's Ring",
  })


  -- Default Cure Sets
  sets.midcast.Cure = {
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}}, sub="Sors Shield",
    head={ name="Kaykaus Mitra", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
    body="Theo. Briault +3",
    hands="Theophany Mitts +3",
    legs="Ebers Pant. +1",
    feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
    neck="Cleric's Torque",
    left_ear="Glorious Earring",
    right_ear="Mendi. Earring",
    left_ring="Lebeche Ring",
    right_ring="Stikini Ring",
    back={ name="Alaunus's Cape", augments={'MP+60','Eva.+4 /Mag. Eva.+4','"Cure" potency +6%',}},
  }
  sets.midcast.Cure.Weather = set_combine(sets.midcast.Cure, gear.Weather)

  -- Cure Sets for Afflatus Solace for Cure Skins
  sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {body="Ebers Bliaud +1"})
  sets.midcast.CureSolace.Weather = set_combine(sets.midcast.CureSolace, gear.Weather)

  -- Cure Sets for Misery
  sets.midcast.CureMisery = set_combine(sets.midcast.Cure, {})
  sets.midcast.CureMisery.Weather = set_combine(sets.midcast.CureMisery, gear.Weather)

  -- Curaga Sets
  sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
    left_right="Aquasoul Ring"
  })
  sets.midcast.Curaga.Weather = set_combine(sets.midcast.Curaga, gear.Weather)

  sets.midcast.BarSpells = {
    head="Ebers Cap +1",
    body="Ebers Bliaud +1",
    hands="Ebers Mitts",
    legs={ name="Piety Pantaln. +1", augments={'Enhances "Shellra V" effect',}},
    feet={ name="Piety Duckbills +3", augments={'Enhances "Protectra V" effect',}},
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
  }

  sets.midcast["Silence"] = {
    main="Grioavolr",
    sub="Enki Strap",
    ammo="Hydrocera",
    head="Theophany Cap +3",
    body="Theo. Briault +3",
    hands="Theophany Mitts +3",
    legs="Th. Pant. +3",
    feet="Theo. Duckbills +3",
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Hermetic Earring",
    right_ear="Gwati Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Solemnity Cape",
  }
end

function init_gear_sets()
  idle_sets()
  engaged_sets()
  ja_sets()
  spell_sets()
end

-- </editor-fold>

-- <editor-fold> Events/Hooks

function update_combat_form()
  state.CombatForm:reset()

  if player.sub == "NIN" then
    state.CombatForm:set("DW")
  end
end


function job_precast(spell, action, spellMap, eventArgs)
  if spell.english == "Paralyna" and buffactive.Paralyzed then
    -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
    eventArgs.handled = true
  end
end

function job_get_spell_map(spell, default_map)
  if spell.action_type == 'Magic' then
    if default_map == "Cure" and state.Buff.Solace then
      return "CureSolace"
    elseif default_map == "Cure" and state.Buff.Misery then
      return "CureMisery"
    elseif default_map == "Cure" then
      return "Cure"
    elseif spell.en:contains("Bar") then
      return "BarSpells"
    end
  end

  return default_map
end

-- </editor-fold>
