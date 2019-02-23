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
  state.Buff.Enlight = buffactive['Enlight'] or false
  state.Buff.Crusade = buffactive['Crusade'] or false
  state.Buff.Phalanx = buffactive['Phalanx'] or false
  state.Buff.Reprisal = buffactive['Reprisal'] or false
  state.Buff.Sentinel = buffactive['Sentinel'] or false
  state.Buff.Cover = buffactive['Cover'] or false
  state.Buff.Doom = buffactive['Doom'] or false

  blue_magic_maps = {}

  -- Enmity Spells
  blue_magic_maps.Enmity = S{'Jettatura', 'Blank Gaze', 'Sheep Song', 'Geist Wall', 'Screwdriver'}
  blue_magic_maps.Healing = S{'Wild Carrot', 'Healing Breeze', 'Pollen'}
  blue_magic_maps.FastRecast = S{'Cocoon'}
  blue_magic_maps.Skill = S{}
end

function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = false

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 3

  -- Default Macro Book [Book, Page]
  info.MacroBook = {3, 1}

  -- Main Sword
  -- info.Sword = "Sequence"
  info.Sword = "Brilliance"
  -- info.Sword = "Burtgang"

  -- Idle Modes
  --  Normal: Default -50% DT, MEVA
  --  HP: Max HP Set
  --  Refresh: Latent Refresh set
  --  Regen: Latent Regen set
  state.IdleMode:options('Normal', 'HP', 'Refresh', 'Regen')

  -- Offisive Modes
  --  Normal: Normal accuracy
  --  Acc: High Accuracy for TP Gear
  state.OffenseMode:options('Normal', 'Acc')

  -- HybridModes (Engaged, Use PDT?)
  --  Normal: Engaged, -50% DT, MEVA, etc
  --  TP: Equip TP gear
  --  MEVA: Pure MEVA
  --  HP: Max HP gear
  state.HybridMode:options('Normal', 'TP', 'MEVA', 'HP')

  -- Important: HPLock mode disables the ability to drop 1k HP with fastcast gear
  state.CastingMode:options('HPLock', 'Normal', 'SIRD')

  -- Define your Shields
  state.Shields = M{['description']='Shield Mode'}
  state.Shields:options('Ochain', 'Aegis')
  -- state.Shields:options('Ochain, 'Priwen', 'Aegis', 'Srivasta')

  -- Update Default Shield State
  update_combat_form()
end

function user_keybinds()
  -- Remove default keybinds
  bind_key('`', 'gs c cycle Shields')
  bind_key('f9', 'gs c cycle CastingMode')
  bind_key('f10', 'gs c cycle HybridMode')
  bind_key('f12', 'gs c cycle IdleMode')
  bind_key('!`', 'gs c requip')
end

function user_unbind()
  unbind('`')
  unbind('f9')
  unbind('f10')
  unbind('f12')
  unbind('!`')
end

-- </editor-fold>


-- <editor-fold> Gear Sets

function idle_sets()
  sets.idle = {
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Thureous Earring",
    right_ear="Ethereal Earring",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  sets.idle.HP = {
    ammo="Charitoni Sling",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +2",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Dualism Collar +1",
    waist="Oneiros Belt",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",
  }

  sets.idle.Regen = set_combine(sets.idle, {
    hands="Volte Moufles",
    neck="Bathy Choker",
    left_ear="Infused Earring",
    right_ear="Dawn Earring",
    left_ring="Sheltered Ring",
    right_ring="Paguroidea Ring"
  })

  -- Shield Defines
  sets.idle.Ochain = {sub="Ochain"}
  sets.idle.Aegis = {sub="Aegis"}
  sets.idle.Srivasta = {sub="Srivasta"}
  sets.idle.Priwen = {sub="Priwen"}
end

function tp_sets()
  -- Melee / Full DT / PDT Mode
  sets.engaged = {
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Thureous Earring",
    right_ear="Ethereal Earring",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  sets.engaged.Acc = {
    ammo="Ginsen",
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Decimus Torque",
    waist="Kentarch Belt +1",
    left_ear="Genmei Earring",
    right_ear="Telos Earring",
    left_ring="Flamma Ring",
    right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  -- Magic Evasion Sets
  sets.engaged.MEVA = set_combine(sets.engaged, {})

  -- Max HP Set
  sets.engaged.HP = set_combine(sets.engaged, {
    neck="Dualism Collar +1",
    waist="Oneiros Belt",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"
  })

  -- Melee / Build TP Mode
  sets.engaged.TP = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Flamma Ring",
    right_ring="Rajas Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  sets.engaged.TP.Acc = set_combine(sets.engaged.TP, { })

  -- Basic Shield Defines
  -- -- Ochain
  sets.engaged.Ochain = {sub="Ochain"}
  sets.engaged.HP.Ochain = set_combine(sets.engaged.HP, sets.engaged.Ochain)
  sets.engaged.MEVA.Ochain = set_combine(sets.engaged.MEVA, sets.engaged.Ochain)
  sets.engaged.TP.Ochain = set_combine(sets.engaged.TP, sets.engaged.Ochain)
  sets.engaged.TP.Acc.Ochain = set_combine(sets.engaged.TP.Acc, sets.engaged.Ochain)
  -- -- Aegis
  sets.engaged.Aegis = {sub="Aegis"}
  sets.engaged.HP.Aegis = set_combine(sets.engaged.HP, sets.engaged.Aegis)
  sets.engaged.MEVA.Aegis = set_combine(sets.engaged.MEVA, sets.engaged.Aegis)
  sets.engaged.TP.Aegis = set_combine{sets.engaged.TP, sets.engaged.Aegis}
  sets.engaged.TP.Acc.Aegis = set_combine(sets.engaged.TP.Acc, sets.engaged.Aegis)
  -- -- Srivasta
  sets.engaged.Srivasta = {sub="Srivasta"}
  sets.engaged.HP.Srivasta = set_combine(sets.engaged.HP, sets.engaged.Srivasta)
  sets.engaged.MEVA.Srivasta = set_combine(sets.engaged.MEVA, sets.engaged.Srivasta)
  sets.engaged.TP.Srivasta = set_combine{sets.engaged.TP, sets.engaged.Srivasta}
  sets.engaged.TP.Acc.Srivasta = set_combine(sets.engaged.TP.Acc, sets.engaged.Srivasta)
  -- -- Priwen
  sets.engaged.Priwen = {sub="Priwen"}
  sets.engaged.HP.Priwen = set_combine(sets.engaged.HP, sets.engaged.Priwen)
  sets.engaged.MEVA.Priwen = set_combine(sets.engaged.MEVA, sets.engaged.Priwen)
  sets.engaged.TP.Priwen = set_combine{sets.engaged.TP, sets.engaged.Priwen}
  sets.engaged.TP.Acc.Priwen = set_combine(sets.engaged.TP.Acc, sets.engaged.Priwen)
end

function ja_sets()
  local EnmityBase = {
    ammo="Charitoni Sling",
    head="Loess Barbuta +1",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Yorium Gauntlets", augments={'Enmity+9',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Moonbeam Necklace",
    waist="Creed Baudrier",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Apeile Ring",
    right_ring="Apeile Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  local HPLockEnmity = {
    ammo="Charitoni Sling",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Moonbeam Necklace",
    waist="Creed Baudrier",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Apeile Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  -- JAMode: Normal
  -- sets.precast.JA["Defender"] = EnmityBase
  -- sets.precast.JA["Sentinel"] = EnmityBase
  -- sets.precast.JA["Rampart"] = EnmityBase
  -- sets.precast.JA["Palisade"] = EnmityBase
  -- sets.precast.JA["Fealty"] = EnmityBase
  -- sets.precast.JA["Invincible"] = EnmityBase
  -- sets.precast.JA["Warcry"] = EnmityBase
  -- sets.precast.JA["Holy Circle"] = EnmityBase


  -- JAMode: HPLock
  sets.precast.JA["Defender"] = HPLockEnmity
  sets.precast.JA["Sentinel"] = HPLockEnmity
  sets.precast.JA["Rampart"] = HPLockEnmity
  sets.precast.JA["Palisade"] = HPLockEnmity
  sets.precast.JA["Fealty"] = HPLockEnmity
  sets.precast.JA["Invincible"] = HPLockEnmity
  sets.precast.JA["Warcry"] = HPLockEnmity
  sets.precast.JA["Holy Circle"] = HPLockEnmity
end

function spell_sets()
  sets.midcast.SIRD = {
    ammo="Staunch Tathlum",
    head="Souv. Schaller +1",
    ear1="Knightly Earring",
    hands="Eschite Gauntlets",
    legs="Founder's Hose",
    feet="Odyssean Greaves"
  }

  --- INFO: Normal Cast Sets

  -- Fast Cast Sets
  sets.precast.FC = {
    ammo="Incantor Stone",
    head={ name="Cizin Helm +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Mag.Def.Bns."+1',}},
    body={ name="Odyss. Chestplate", augments={'"Fast Cast"+5',}},
    hands={ name="Odyssean Gauntlets", augments={'"Fast Cast"+4','CHR+6',}},
    legs={ name="Odyssean Cuisses", augments={'Mag. Acc.+23','"Fast Cast"+4','CHR+8',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+4','"Fast Cast"+5','AGI+4','Mag. Acc.+15',}},
    waist="Siegel Sash",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
  }

  -- Fast Cast Goal - 71%
  -- sets.precast.FC = {
  --   ammo="Incantor Stone",
  --   head="Carmine Mask +1",
  --   neck="Orunmila's Torque",
  --   ear1="Loquac. Earring",
  --   ear2="Etiolation Earring",
  --   body="Rev. Surcoat +3",
  --   hands="Leyline Gloves",
  --   ring1="Prolix Ring",
  --   ring2="Kishar Ring",
  --   back="Rudianos's Mantle",
  --   waist="Siegel Sash",
  --   legs="Enif Cosciales",
  --   feet="Odyssean Greaves"
  -- }

  -- Healing Magic
  sets.midcast.Cure = {
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+4','"Fast Cast"+5','AGI+4','Mag. Acc.+15',}},
    neck="Phalaina Locket",
    waist="Oneiros Belt",
    left_ear="Nourish. Earring +1",
    right_ear="Mendi. Earring",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Solemnity Cape",
  }

  -- Basic Enhancing Magic Set
  sets.midcast.EnhancingMagic = {}

  -- Specific Enhancing Magic Spells
  sets.midcast.Enlight = {
    ammo="Charitoni Sling",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +2",
    hands={ name="Eschite Gauntlets", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Incanter's Torque",
    waist="Oneiros Belt",
    left_ear="Divine Earring",
    right_ear="Beatific Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Moonbeam Cape",
  }

  sets.midcast.Phalanx = {
    ammo="Charitoni Sling",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Yorium Cuirass", augments={'Phalanx +3',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Yorium Cuisses", augments={'Phalanx +3',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Moonbeam Cape",
  }

  sets.midcast.Reprisal = {
    ammo="Charitoni Sling",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +2",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Dualism Collar +1",
    waist="Oneiros Belt",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",
  }

  sets.midcast.Flash = {
    ammo="Charitoni Sling",
    head={ name="Cizin Helm +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Mag.Def.Bns."+1',}},
    body="Rev. Surcoat +2",
    hands={ name="Yorium Gauntlets", augments={'Enmity+9',}},
    legs={ name="Odyssean Cuisses", augments={'Mag. Acc.+23','"Fast Cast"+4','CHR+8',}},
    feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Moonbeam Necklace",
    waist="Creed Baudrier",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Apeile Ring",
    right_ring="Apeile Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  -- Blue Magic
  sets.midcast['Blue Magic'] = {}
  sets.midcast['Blue Magic'].Healing = sets.midcast.Cure
  sets.midcast['Blue Magic'].Enmity = sets.midcast.Flash
  sets.midcast['Blue Magic'].FastRecast = sets.precast.FC
  sets.midcast['Blue Magic'].Skill = sets.midcast.EnhancingMagic

  --- INFO: HPLock Sets

  -- Fast Cast Sets
  sets.precast.FC.HPLock = {
    ammo="Incantor Stone",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +2",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+4','"Fast Cast"+5','AGI+4','Mag. Acc.+15',}},
    neck="Loricate Torque +1",
    waist="Siegel Sash",
    left_ear="Odnowa Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back="Moonbeam Cape",
  }

  -- Healing Magic
  sets.midcast.Cure.HPLock = {
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Loricate Torque +1",
    waist="Oneiros Belt",
    left_ear="Nourish. Earring +1",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
  }

  -- Basic Enhancing Magic Set
  sets.midcast.EnhancingMagic.HPLock = {}

  -- Specific Enhancing Magic Spells
  sets.midcast.Enlight.HPLock = {
    ammo="Charitoni Sling",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +2",
    hands={ name="Eschite Gauntlets", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Incanter's Torque",
    waist="Oneiros Belt",
    left_ear="Divine Earring",
    right_ear="Beatific Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Moonbeam Cape",
  }

  sets.midcast.Phalanx.HPLock = {
    ammo="Charitoni Sling",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Yorium Cuirass", augments={'Phalanx +3',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Yorium Cuisses", augments={'Phalanx +3',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Moonbeam Cape",
  }

  sets.midcast.Flash.HPLock = {
    ammo="Charitoni Sling",
    head={ name="Cizin Helm +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Mag.Def.Bns."+1',}},
    body="Rev. Surcoat +2",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Moonbeam Necklace",
    waist="Creed Baudrier",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Apeile Ring",
    right_ring="Apeile Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
  }

  -- Blue Magic
  sets.midcast['Blue Magic'].Healing.HPLock = sets.midcast.Cure.HPLock
  sets.midcast['Blue Magic'].Enmity.HPLock = sets.midcast.Flash.HPLock
  sets.midcast['Blue Magic'].FastRecast.HPLock = sets.precast.FC.HPLock
  sets.midcast['Blue Magic'].Skill.HPLock = sets.midcast.EnhancingMagic.HPLock

  --- INFO: SIRD Cast Sets
  sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, sets.midcast.SIRD)
  sets.midcast.Enlight.SIRD = set_combine(sets.midcast.Enlight, sets.midcast.SIRD)
  sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx, {
    ammo="Staunch Tathlum",
    neck="Dualism Collar +1",
    head="Souv. Schaller +1",
    ear1="Knightly Earring",
    ear2="Odnowa Earring +1",
    hands="Eschite Gauntlets",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"
  })
  sets.midcast['Blue Magic'].Healing.SIRD = set_combine(sets.midcast['Blue Magic'].Healing, sets.midcast.SIRD)
  sets.midcast['Blue Magic'].Enmity.SIRD = set_combine(sets.midcast['Blue Magic'].Enmity, sets.midcast.SIRD)
  sets.midcast['Blue Magic'].FastRecast = set_combine(sets.midcast['Blue Magic'].FastRecast, sets.midcast.SIRD)
  sets.midcast['Blue Magic'].Skill = set_combine(sets.midcast['Blue Magic'].Skill, sets.midcast.SIRD)
end

function buff_sets()
  sets.buff = {}
  sets.buff.Doom = {

  }
end

function ws_sets()
  sets.precast.WS['Chant du Cygne'] = {}
  sets.precast.WS['Savage Blade'] = {
    ammo="Staunch Tathlum",
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands={ name="Valorous Mitts", augments={'Accuracy+17 Attack+17','Weapon skill damage +4%','Attack+8',}},
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Sanctity Necklace",
    waist="Grunfeld Rope",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Shukuyu Ring",
    back="Bleating Mantle",
  }
  sets.precast.WS['Requiescat'] = {}
  sets.precast.WS['Atonement'] = {}
end

function init_gear_sets()
  idle_sets()
  tp_sets()
  ws_sets()
  ja_sets()
  spell_sets()
  buff_sets()
end

-- </editor-fold>

-- <editor-fold> Events/Hooks

function update_combat_form()
  if player.equipment.sub  == "Aegis" then
    state.CombatForm:set('Aegis')
    state.Shields:set('Aegis')
  elseif player.equipment.sub == "Ochain" then
    state.CombatForm:set('Ochain')
    state.Shields:set('Ochain')
  -- elseif player.equipment.sub == "Priwen" then
  --   state.CombatWeapon:set('Priwen')
  end
end


function customize_idle_set(idleSet)
  set = set_combine(idleSet, sets.idle[state.CombatForm.value])
  if state.Buff.Doom then
    set = set_combine(set, sets.buff.Doom)
  end
  return set
end

function customize_melee_set(meleeSet)
  if state.Buff.Doom then
    return set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function job_state_change(stateField, newValue, oldValue)
  if stateField == 'Shield Mode' then
    state.CombatForm:set(newValue)
  end
end

function job_self_command(cmdParams, eventArgs)

  if cmdParams[1] == "requip" then
    gs_echo("Re-equipping Gear")
    if player.in_combat then
      if player.status:contains("Engaged") then
        if state.HybridMode.value == "TP" then
          if state.OffenseMode.value == "Acc" then
            equip(sets.engaged.TP.Acc)
          else
            equip(sets.engaged.TP)
          end
        elseif state.HybridMode.value == "MEVA" then
          equip(sets.engaged.MEVA)
        elseif state.HybridMode.value == "HP" then
          equip(sets.engaged.HP)
        else
          if state.OffenseMode.value == "Acc" then
            equip(sets.engaged.Acc)
          else
            equip(sets.engaged)
          end
        end
      else
        if state.IdleMode.value == "HP" then
          equip(sets.idle.HP)
        else
          equip(sets.idle)
        end
      end
    else
      if state.IdleMode.value == "HP" then
        equip(sets.idle.HP)
      else
        equip(sets.idle)
      end
    end

    equip({ main=info.Sword, sub=state.Shields.value })
    engage_lockstyle(false)
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
    if spell.skill == 'Blue Magic' then
      for category,spell_list in pairs(blue_magic_maps) do
        if spell_list:contains(spell.english) then
          return category
        end
      end
    elseif spell.en:contains("Enlight") then
      return "Enlight"
    elseif spell.en:contains("Reprisal") then
      return "Reprisal"
    elseif spell.en:contains("Phalanx") then
      return "Phalanx"
    elseif spell.en:contains("Cure") then
      return "Cure"
    end
  end

  return default_map
end

-- </editor-fold>
