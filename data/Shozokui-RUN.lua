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
  state.Buff.Temper = buffactive['Temper']
  state.Buff.Phalanx = buffactive['Phalanx']
  state.Buff.Stoneskin = buffactive['Stoneskin']
  state.Buff.Blink = buffactive['Blink']
end

function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = false

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 3

  -- Default Macro Book [Book, Page]
  info.MacroBook = {3, 1}


  -- Idle Modes
  --  Normal: Default -50% DT, MEVA
  --  HP: Max HP Set
  --  Refresh: Latent Refresh set
  --  Regen: Latent Regen set
  state.IdleMode:options('Normal')

  -- Offisive Modes
  --  Normal: Normal accuracy
  --  Acc: High Accuracy for TP Gear
  state.OffenseMode:options('Normal', 'Acc')

  -- Weaponskill MOdes
  --  Normal: Uncapped Attack
  --  AtkCapped: Fully capped attack
  state.WeaponskillMode:options('Normal', 'AtkCapped')

  -- HybridModes (Engaged, Use PDT?)
  --  Normal: TP Set
  --  PDT: -DT set
  --  WyvernDT: Wyvern Damage Taken set
  state.HybridMode:options('Normal', 'PDT')

  -- Update Default Shield State
  update_melee_groups()
  update_combat_weapon()
end

function user_keybinds()
  -- Remove default keybinds
  bind_key('f9', 'gs c cycle OffenseMode')
  bind_key('f10', 'gs c cycle HybridMode')
  bind_key('f12', 'gs c cycle WeaponskillMode')
end

function user_unbind()
  unbind('f9')
  unbind('f10')
  unbind('f12')
end

-- </editor-fold>


-- <editor-fold> Gear Sets

function idle_sets()
  -- Only need 1 idle set because you can cap PDT and wyvern hp/dt in one set
  sets.idle = {
    main="Lionheart",
    sub="Utu Grip",
    ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+4','Attack+4',}},
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }
end

function tp_sets()
  -- Standard TP Set (Not weapon specific, see REMA specific sets below)
  sets.engaged = {
    main="Lionheart",
    sub="Utu Grip",
    ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+4','Attack+4',}},
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }

  sets.engaged.Acc = set_combine(sets.engaged, {})

  -- DT Hybrid Set
  sets.engaged.PDT = set_combine(sets.engaged, { })
end

function ja_sets()
end

function ws_sets()
  sets.precast.WS.Resolution = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+18','"Triple Atk."+4','STR+9','Attack+7',}},
    feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+4','Attack+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }
end


function init_gear_sets()
  idle_sets()
  tp_sets()
  ja_sets()
  ws_sets()
end

-- </editor-fold>

-- <editor-fold> Events/Hooks

function update_melee_groups()
end

function update_combat_weapon()
end

function customize_idle_set(idleSet)
  return idleSet
end

function customize_melee_set(meleeSet)
  return meleeSet
end

function job_state_change(stateField, newValue, oldValue)
end

function job_self_command(cmdParams, eventArgs)
end

function job_precast(spell, action, spellMap, eventArgs)
end

function job_get_spell_map(spell, default_map)
  if spell.en:contains("Resolution") then
    return "Resolution"
  elseif spell.en:contains("Flash") then
    return "Flash"
  end
  return default_map
end


function job_pretarget(spell, action, spellMap, eventArgs)
end

-- </editor-fold>
