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
    sub="Clerisy strap",
    waist="Hachirin-no-Obi",
    back="Twilight Cape"
  }
end

function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = true

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 1

  -- Default Macro Book [Book, Page]
  info.MacroBook = {1, 2}


  -- Idle Modes
  --  Normal: Normal Idle Gear (Should be Refresh set)
  --  PDT: Defense Gear
  state.IdleMode:options('Normal', 'PDT')

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
  clear_default_binds()
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
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}}, sub="Sors Shield",
    sub="Genbu's Shield",
    ammo="Clarus Stone",
    head="Befouled Crown",
    body="Ebers Bliaud +1",
    hands="Shrieker's Cuffs",
    legs="Assid. Pants +1",
    feet="Hippo. Socks +1",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",

  }
  sets.idle.PDT = set_combine(sets.idle, {
    head="Aya. Zucchetto +1",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +1",
  })
end

function ja_sets()
  sets.precast.JA = {}
end

function spell_sets()
  sets.precast.FC = {
    ammo="Impatients",
    body="Inyanga Jubbah +2",
    legs="Aya. Cosciales +2", feet="Regal Pumps +1",
    waist="Witful Belt",
    left_ear="Etiolation Earring", right_ear="Loquac. Earring",
    left_ring="Prolix Ring", back="Swith Cape"
  }

  -- TODO: Fill in Status Removal Gear
  sets.midcast.StatusRemoval = set_combine(sets.precast.FC, {
    main="Yagrush",
  })
  sets.midcast.Esuna = sets.midcast.StatusRemoval
  -- TODO: Fill in Divine Caress Gear
  sets.midcast.StatusRemovalCaress = {}

  -- TODO: Fill in more Cursna Gear
  sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval,  {
    hands={ name="Fanatic Gloves", augments={'MP+20','Healing magic skill +6','"Conserve MP"+2',}},
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Cure" potency +10%',}},
  })


  -- Default Cure Sets
  sets.midcast.Cure = {
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}}, sub="Sors Shield",
    neck="Phalaina Locket", ammo="Hydrocera",
    head="Ebers Cap +1",
    body="Theo. Briault +2", hands="Theophany Mitts +3",
    legs="Ebers Pantaloons +1", feet="Kaykaus Boots",
    left_ear="Mendi. Earring", right_ear="Nourish. Earring +1",
    left_ring="Sirona's Ring", right_ring="Lebeche Ring",
    waist="Luminary Sash",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Cure" potency +10%',}},
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
end

function init_gear_sets()
  idle_sets()
  ja_sets()
  spell_sets()
end

-- </editor-fold>

-- <editor-fold> Events/Hooks

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
    end
  end

  return default_map
end

-- </editor-fold>