-- <editor-fold> Initialization

function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')

  -- Grab the Naught includes
  include('Naught-Include.lua')
end

function job_setup()
  info.Debuffs = S{
    'Burn', 'Frost', 'Choke', 'Rasp', 'Shock', 'Drown',
    'Poison', 'Poison II', 'Poisonga', 'Sleep', 'Sleepga', 'Sleep II', 'Sleepga II',
    'Blind', 'Break', 'Breakga', 'Bind', 'Dispel'
  }

  -- Track Buffs
  state.Buff.DarkArts = buffactive['Dark Arts'] or false
  state.Buff.LightArts = buffactive['Light Arts'] or false
  state.Buff.Sublimation = buffactive['Sublimation'] or false
  state.Buff.Haste = buffactive['Haste'] or false
  state.Buff.Reraise = buffactive['Reraise'] or false
end

function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = false

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 10

  -- Default Macro Book [Book, Page]
  info.MacroBook = {1, 2}


  -- Idle Modes
  --  Normal: Normal Idle Gear (Should be PDT)
  --  Refresh: Refresh/Regen gear
  state.IdleMode:options('Normal', 'Refresh')

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
  state.CastingMode:options('Normal', 'Spaekona', 'OccultAcumen', 'FreeNuke')
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
    ammo="Staunch Tathlum",
    head="Mallquis Chapeau +1",
    body="Mallquis Saio +2",
    hands="Shrieker's Cuffs",
    legs="Assid. Pants +1",
    feet="Mallquis Clogs +2",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Ethereal Earring",
    right_ear="Genmei Earring",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
  }

  sets.idle.Refresh = {
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Shrieker's Cuffs",
    legs="Assid. Pants +1",
    feet="Hippo. Socks +1",
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Ethereal Earring",
    right_ear="Genmei Earring",
    left_ring="Sheltered Ring",
    right_ring="Paguroidea Ring",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
  }

  sets.idle.Town = {
    ammo="Pemphredo Tathlum",
    head="Ea Hat +1",
    body="Ea Houppe. +1",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs="Ea Slops +1",
    feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    neck="Src. Stole +2",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Regal Earring",
    left_ring="Mujin Band",
    right_ring="Shiva Ring +1",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
  }
end

function ja_sets()
end

function spell_sets()
  -- 75% Fast Cast
  sets.precast.FC = {
    ammo="Impatiens",
    head={ name="Merlinic Hood", augments={'"Fast Cast"+5','INT+3','"Mag.Atk.Bns."+10',}},
    body="Zendik Robe",
    hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+5',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Merlinic Crackows", augments={'"Fast Cast"+6','CHR+5','Mag. Acc.+12',}},
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Prolix Ring",
    back={ name="Taranus's Cape", augments={'INT+4','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}},
  }
  sets.precast.FastRecast = sets.precast.FC
  sets.precast.Impact = {body="Twlight Cloak"}

  -- Main Debuff / MACC Gear

  sets.midcast.Debuff = {
    ammo="Pemphredo Tathlum",
    head="Ea Hat +1",
    body="Ea Houppe. +1",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs="Ea Slops +1",
    feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    neck="Src. Stole +2",
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Mallquis Ring",
    right_ring="Vertigo Ring",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
  }

  -- Aspir

  sets.midcast.Aspir = {
    ammo="Pemphredo Tathlum",
    body="Shango Robe",
    feet={ name="Merlinic Crackows", augments={'"Fast Cast"+6','CHR+5','Mag. Acc.+12',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Regal Earring",
    right_ear="Barkaro. Earring",
    left_ring="Stikini Ring",
    right_ring="Evanescence Ring",
    back={ name="Taranus's Cape", augments={'INT+4','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}},
  }



  -- Max MAB MBD/MBDII
  -- INT: 288
  -- MACC: 239
  -- MAB: 356
  -- MBD: 39
  -- MBD II: 35
  sets.midcast.ElementalMagic = {
    ammo="Pemphredo Tathlum",
    head="Ea Hat +1",
    body="Ea Houppe. +1",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs="Ea Slops +1",
    feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Regal Earring",
    left_ring="Mujin Band",
    right_ring="Shiva Ring +1",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
  }

  -- Spaekona Casting Mode
  sets.midcast.ElementalMagic.Spaekona = set_combine(sets.midcast.ElementalMagic, { body="Spaekona's Coat +2" })

  -- Occult Accumen Casting Mode
  sets.midcast.ElementalMagic.OccultAcumen = {
    neck="Lissome Necklace",
    waist="Oneiros Rope",
    left_ear="Dedition Earring",
    right_ear="Telos Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
  }

  -- Free Nuke Set
  sets.midcast.ElementalMagic.FreeNuke = {
    ammo="Pemphredo Tathlum",
    head="Ea Hat +1",
    body="Ea Houppe. +1",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    neck="Saevus Pendant +1",
    waist="Refoccilation Stone",
    left_ear="Friomisi Earring",
    right_ear="Barkaro. Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
  }
end

function init_gear_sets()
  idle_sets()
  ja_sets()
  spell_sets()
end

-- </editor-fold>


-- <editor-fold> Events/Hooks

function job_precast(spell)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_get_spell_map(spell, default_map)
  map = default_map
  if info.Debuffs:contains(spell.en) then
    map = "Debuff"
  elseif spell.en:contains("Aspir") then
    map = "Aspir"
  elseif spell.en:contains("Impact") then
    map = "Impact"
  elseif spell.skill == "Elemental Magic" then
    map = "ElementalMagic"
  end
  return map
end

-- </editor-fold>
