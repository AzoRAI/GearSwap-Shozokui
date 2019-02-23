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
  state.CastingMode:options('Normal', 'FreeNuke', 'MP')
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
    head="Ea Hat",
    body="Mallquis Saio +1",
    hands="Shrieker's Cuffs",
    legs="Assid. Pants +1",
    feet="Mallquis Clogs +1",
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
end

function ja_sets()
end

function spell_sets()
  sets.precast.FC = {
    ammo="Impatiens",
    head={ name="Merlinic Hood", augments={'"Fast Cast"+5','INT+3','"Mag.Atk.Bns."+10',}},
    body="Zendik Robe",
    hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+5',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Merlinic Crackows", augments={'"Fast Cast"+6','CHR+5','Mag. Acc.+12',}},
    neck="Stoicheion Medal",
    waist="Witful Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Taranus's Cape", augments={'INT+4','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}},
  }


  sets.midcast['Elemental Magic'] = {
    ammo="Pemphredo Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet="Jhakri Pigaches +2",
    neck="Mizu. Kubikazari",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Barkaro. Earring",
    left_ring="Locus Ring",
    right_ring="Mujin Band",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Damage taken-4%',}},
  }

  sets.midcast['Elemental Magic'].MP = set_combine(sets.midcast['Elemental Magic'], { body="Spaekona's Coat +2", legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+19','Magic burst dmg.+10%','MND+1','"Mag.Atk.Bns."+15',}}, })

  sets.midcast['Elemental Magic'].FreeNuke = {
    ammo="Pemphredo Tathlum",
    head="Ea Hat",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+6%',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet="Jhakri Pigaches +2",
    neck="Mizu. Kubikazari",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Barkaro. Earring",
    left_ring="Shiva Ring",
    right_ring="Vertigo Ring",
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
end

-- </editor-fold>
