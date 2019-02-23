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
  state.Buff.Hasso = buffactive['Hasso'] or false
  state.Buff.Seigan = buffactive['Seigan'] or false
  state.Buff.FlyHigh = buffactive['Fly High'] or false
  state.Buff.SamRoll = buffactive['Samurai Roll'] or false
  state.Buff.SpiritSurge = buffactive['Spirit Surge'] or false
  state.Buff.AM3 = buffactive['Aftermath: Lv.3'] or false
  state.Buff.AM2 = buffactive['Aftermath: Lv.2'] or false
  state.Buff.AM = buffactive['Aftermath: Lv.1'] or false
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

  -- Jump Mode
  --  Normal: Jump, High Jump
  --  Spirit: Spirit Jump, Soul Jump (Only available when Wyvern is out)
  -- (automatically switches if wyvern is dead)
  state.JumpMode = M{['description'] = 'Jump Mode'}
  state.JumpMode:options('Normal', 'Spirit')

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
  state.HybridMode:options('Normal', 'PDT', 'WyvernDT')

  -- Update Default Shield State
  update_melee_groups()
  update_combat_weapon()
end

function user_keybinds()
  -- Remove default keybinds
  clear_default_binds()
  bind_key('`', 'gs c cycle JumpMode')
  bind_key('f9', 'gs c cycle OffenseMode')
  bind_key('f10', 'gs c cycle HybridMode')
  bind_key('f12', 'gs c cycle WeaponskillMode')
end

function user_unbind()
  unbind('`')
  unbind('f9')
  unbind('f10')
  unbind('f12')
end

-- </editor-fold>


-- <editor-fold> Gear Sets

function idle_sets()
  -- Only need 1 idle set because you can cap PDT and wyvern hp/dt in one set
  sets.idle = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands="Sulev. Gauntlets +2",
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
    neck="Dgn. Collar +2",
    waist="Flume Belt",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }
end

function tp_sets()
  -- Standard TP Set (Not weapon specific, see REMA specific sets below)
  sets.engaged = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands="Sulev. Gauntlets +2",
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet="Flam. Gambieras +2",
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Genmei Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }

  sets.engaged.Acc = {
    hands="Flam. Manopolas +2",
    neck="Drg. Collar +2",
    left_ear="Telos Earring",
    left_ring="Flamma Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
  }

  -- DT Hybrid Set
  sets.engaged.PDT = set_combine(sets.engaged, {
    hands="Sulev. Gauntlets +2",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
  })

  sets.engaged.PDT.Acc = {}

  -- WyvernDT Hybrid Set
  sets.engaged.WyvernDT = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands="Sulev. Gauntlets +2",
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
    neck="Dgn. Collar +2",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }

  sets.engaged.WyvernDT.Acc = set_combine(sets.engaged.WyvernDT, {})

  tp_sets_trishula()
  tp_sets_gungnir()
  tp_sets_ryunohige()
  tp_sets_rhongomiant()
end

function tp_sets_trishula()
  sets.engaged.Trishula = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands={ name="Acro Gauntlets", augments={'Accuracy+20','"Store TP"+5','DEX+10',}},
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet="Flam. Gambieras +2",
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }
  sets.engaged.Trishula.Acc = {
    hands="Flam. Manopolas +2",
    neck="Drg. Collar +2",
    left_ear="Telos Earring",
    left_ring="Flamma Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
  }
  sets.engaged.Trishula.PDT = set_combine(sets.engaged.Trishula, {
    hands="Sulev. Gauntlets +2",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
  })
  sets.engaged.Trishula.WyvernDT = set_combine(sets.engaged.Trishula, {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands="Sulev. Gauntlets +2",
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
    neck="Dgn. Collar +2",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  })
end

function tp_sets_gungnir()
  sets.engaged.Gungnir = {}
  sets.engaged.Gungnir.Acc = {}
end

function tp_sets_ryunohige()
  sets.engaged.Ryunohige = {}
  sets.engaged.Ryunohige.Acc = {}
  sets.engaged.Ryunohige.AM3 = {}
  sets.engaged.Ryunohige.AM3.Acc = {}
end

function tp_sets_rhongomiant()
  sets.engaged.Rhongomiant = {}
  sets.engaged.Rhongomiant.Acc = {}
  sets.engaged.Rhongomiant.AM3 = {}
  sets.engaged.Rhongomiant.AM3.Acc = {}
end

function ja_sets()
  -- DRG JA sets
  sets.precast.JA.Jump = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands="Vis. Fng. Gaunt. +2",
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet="Vishap Greaves +2",
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
  }
  sets.precast.JA.HighJump = set_combine(sets.precast.JA.Jump, {})
  sets.precast.JA.SpiritJump = set_combine(sets.precast.JA.Jump, {})
  sets.precast.JA.SoulJump = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Vishap Mail +3",
    hands={ name="Acro Gauntlets", augments={'Accuracy+20','"Store TP"+5','DEX+10',}},
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet="Vishap Greaves +2",
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
  }

  sets.precast.JA.Angon = {
    ammo="Angon", hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect'}}
  }

  sets.precast.JA.SpiritLink = {
    head="Vishap Armet +2",
    hands="Peltast's Vambraces +1",
    feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
  }

  -- Pet Breath Sets
  sets.midcast.Pet["Restoring Breath"] = {head="Ptero. Armet +3"}
  sets.midcast.Pet["Smiting Breath"] = {head="Ptero. Armet +3"}
end

function ws_sets()
  -- Stardiver
  sets.precast.WS.Stardiver = {
    ammo="Knobkierrie",
    head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }
  sets.precast.WS.Stardiver.AtkCapped = set_combine(sets.precast.WS.Stardiver, {
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    feet="Flam. Gambieras +2"
  })

  -- Camlann's Torment
  sets.precast.WS.CamlannsTorment = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +3%','STR+6','Attack+14',}},
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
    legs="Vishap Brais +3",
    feet="Sulev. Leggings +2",
    neck="Dgn. Collar +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
  }

  -- Sonic Thrust
  sets.precast.WS.SonicThrust = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +3%','STR+6','Attack+14',}},
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
    legs="Vishap Brais +3",
    feet="Sulev. Leggings +2",
    neck="Dgn. Collar +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
  }

  -- Geirskogul (Yeah, right lol)
  sets.precast.WS.Geirskogul = {}

  -- Drakesbane
  sets.precast.WS.Drakesbane = {
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands="Flam. Manopolas +2",
    legs="Sulev. Cuisses +2",
    feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
    neck="Dgn. Collar +2",
    waist="Ioskeha Belt",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }
  sets.precast.WS.Drakesbane.AtkCapped = set_combine(sets.precast.WS.Drakesbane, {})

  -- Impulse Drive
  sets.precast.WS.ImpulseDrive = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +3%','STR+6','Attack+14',}},
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
    legs="Vishap Brais +3",
    feet="Sulev. Leggings +2",
    neck="Dgn. Collar +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
  }

  -- Wheeling Thrust
  sets.precast.WS.WheelingThrust = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +3%','STR+6','Attack+14',}},
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
    legs="Vishap Brais +3",
    feet="Sulev. Leggings +2",
    neck="Dgn. Collar +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
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
  classes.CustomMeleeGroups:clear()

  if state.Buff.SamRoll then
    classes.CustomMeleeGroups:append('SAMRoll')
  end

  if state.Buff.AM3 then
    classes.CustomMeleeGroups:append('AM3')
  elseif state.Buff.AM2 or state.Buff.AM then
    classes.CustomMeleeGroups:append('AM')
  end
end

function update_combat_weapon()
  state.CombatWeapon:reset()
  if player.equipment.main == "Trishula" then
    state.CombatWeapon:set("Trishula")
  elseif player.equipment.main == "Gungnir" then
    state.CombatWeapon:set("Gungnir")
  elseif player.equipment.main == "Rhongomiant" then
    state.CombatWeapon:set("Rhongomiant")
  elseif player.equipment.main == "Ryunohige" then
    state.CombatWeapon:set("Ryunohige")
  end
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
  if spell.en == "Angon" then
    send_command("input /equip ammo 'Angon'")
  end
end

function job_get_spell_map(spell, default_map)
  if spell.en == "Jump" then
    return "Jump"
  elseif spell.en == "High Jump" then
    return "HighJump"
  elseif spell.en == "Spirit Jump" then
    return "SpiritJump"
  elseif spell.en == "Soul Jump" then
    return "SoulJump"
  elseif spell.en == "Spirit Link" then
    return "SpiritLink"
  elseif spell.en:contains("Camlann") then
    return "CamlannsTorment"
  elseif spell.en:contains("Stardiver") then
    return "Stardiver"
  elseif spell.en:contains("Drakes") then
    return "Drakesbane"
  elseif spell.en:contains("Impulse Dr") then
    return "ImpulseDrive"
  elseif spell.en:contains("Geirsko") then
    return "Geirskogul"
  elseif spell.en == "Sonic Thrust" then
    return "SonicThrust"
  end
  return default_map
end


function adjust_jump_mode()
  if pet.isvalid == false and state.JumpMode.value == "Spirit" then
    send_command("gs c set JumpMode Normal")
    windower.add_to_chat(67, "Player has no valid Pet")
  end
end


function job_pretarget(spell, action, spellMap, eventArgs)
  -- When you don't have a pet, you want to use normal jumps instead of spirit jumps
  adjust_jump_mode()

  local contains = function(arr, item)
    for i=1,#arr do
      if arr[i] == item then
        return true
      end
    end
    return false
  end

  local index_of = function(arr, item)
    for i,v in ipairs(arr) do
      if v == item then
        return i
      end
    end
    return -1
  end

  jmps = {'Jump', 'Spirit Jump', 'High Jump', 'Soul Jump'}
  jmp_map = {
    Normal={'Jump', 'High Jump'},
    Spirit={'Spirit Jump', 'Soul Jump'}
  }
  mode_inverse = {
    Normal='Spirit',
    Spirit='Normal'
  }

  if contains(jmps, spell.english) then -- It's a jump spell
    if contains(jmp_map[state.JumpMode.value], spell.english) == false then -- It's not for this set
      inverse_mode = mode_inverse[state.JumpMode.value]
      inverse_map = jmp_map[inverse_mode]
      inverse_idx = index_of(inverse_map, spell.english)
      jmp = jmp_map[state.JumpMode.value][inverse_idx]

      cancel_spell()
      send_command(jmp)
    end
  end
end

-- </editor-fold>
