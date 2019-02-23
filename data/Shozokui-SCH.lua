-- <editor-fold> Initialization

function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')

  -- Grab the Naught includes
  include('Naught-Include.lua')

  -- Load default attack Hotbar
  -- load_hotbar_for_element_mode(state.ElementalMode.value)
end

function job_setup()
  info.BarSpells = S{
    'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater',
    'Barsleep', 'Barpoison', 'Barparalyze', 'Barsilence', 'Barblind', 'Barpetrify', 'Barvirus', 'Baramnesia',
    'Barsleepra', 'Barpoisonra', 'Barparalyzra', 'Barsilencera', 'Barblindra', 'Barpetra', 'Barvira', 'Baramnesra'
  }
  info.NaSpells = S{'Paralyna', 'Poisona', 'Blindna', 'Silena', 'Viruna', 'Cursna'}
  info.Debuffs = S{
    'Dia', 'Dia II', 'Dia III', 'Diaga', 'Slow', 'Slow II', 'Slow III',
    'Paralyze', 'Paralyze II', 'Silence', 'Addle', 'Addle II', 'Poison', 'Poison II',
    'Sleep', 'Sleep II', 'Blind', 'Blind II', 'Break', 'Bind', 'Dispel',
    'Gravity', 'Gravity II', 'Distract', 'Distract II', 'Distract III',
    'Frazzle', 'Frazzle II', 'Frazzle III'
  }
  info.MaxAccDebuffs = S{'Frazzle', 'Frazzle II', 'Frazzle III', 'Blind', 'Blind II', 'Sleep', 'Sleep II'}

  info.Weathers = {
    ["Thunder"]="Thunderstorm",
    ["Blizzard"]="Hailstorm",
    ["Fire"]="Firestorm",
    ["Aero"]="Windstorm",
    ["Stone"]="Sandstorm",
    ["Water"]="Rainstorm",
    ["Dark"]="Voidstorm",
    ["Light"]="Aurorastorm"
  }

  -- SCH Buffs
  state.Buff.LightArts = buffactive['Light Arts'] or false
  state.Buff.Sublimation = buffactive['Sublimation'] or false
  -- state.Buff.Storms = buffactive['Aurorastorm'] or false

  -- RDM Buffs
  state.Buff.Composure = buffactive['Composure'] or false
  state.Buff.Refresh = buffactive['Refresh'] or false
  state.Buff.Stoneskin = buffactive['Stoneskin'] or false
  state.Buff.Blink = buffactive['Blink'] or false
  state.Buff.Aquaveil = buffactive['Aquaveil'] or false
  state.Buff.Haste = buffactive['Haste'] or false
  state.Buff.Reraise = buffactive['Reraise'] or false

  -- Gear for Weather Casting
  gear.Weather = {
    -- main="Chatoyant Staff",
    -- sub="Enki Strap",
    waist="Hachirin-no-Obi",
    back="Twilight Cape"
  }
end


function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = false

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 8

  -- Default Macro Book [Page, BOok]
  info.MacroBook = {1, 14}


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
  state.HybridMode:options('Normal', 'PDT', 'MEVA')

  -- Casting Modes
  --  Normal: Cast in Normal Gear
  --  Weather: Merge in weather geark
  --  MB: Use magic burst gear
  state.CastingMode:options('Normal', 'Resistant', 'Weather', 'MB')

  -- Elemental Mode
  --  Which nukes to set
  state.ElementalMode = M{['desecription'] = 'Elemental Casting Mode'}
  state.ElementalMode:options('Thunder', 'Blizzard', 'Fire', 'Aero', 'Stone', 'Water')
end

function user_keybinds()
  clear_default_binds()
  bind_key('`', 'gs c cycle ElementalMode')
  bind_key('f9', 'gs c set CastingMode Normal')
  bind_key('^f9', 'gs c set CastingMode MB')
  bind_key('f10', 'gs c set CastingMode Resistant')
  bind_key('f11', 'gs c set CastingMode Weather')
  bind_key('f12', 'gs c cycle IdleMode')
  bind_key('^f12', 'gs c cycle HybridMode')
end

function user_unbind()
  unbind('`')
  unbind('f9')
  unbind('^f9')
  unbind('f10')
  unbind('f11')
  unbind('f12')
  unbind('^f12')
end

-- </editor-fold>


-- <editor-fold> Gear Sets

function idle_sets()
  -- Normal Idle/Refresh
  sets.idle = {
    main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    sub="Enki Strap",
    ammo="Impatiens",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Shrieker's Cuffs",
    legs="Assid. Pants +1",
    feet="Hippo. Socks +1",
    neck="Bathy Choker", waist="Fucho-no-Obi",
    left_ear="Infused Earring", right_ear="Dawn Earring",
    left_ring="Sheltered Ring", right_ring="Paguroidea Ring",
    back="Solemnity Cape",
  }

  -- PDT

  sets.idle.PDT = {
    main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    sub="Enki Strap",
    ammo="Amar Cluster",
    head="Mallquis Chapeau +1",
    body="Mallquis Saio +1",
    hands="Shrieker's Cuffs",
    legs="Assid. Pants +1",
    feet="Mallquis Clogs +1",
    neck="Loricate Torque +1", waist="Fucho-no-Obi",
    left_ear="Genmei Earring", right_ear="Ethereal Earring",
    left_ring="Defending Ring", right_ring="Vocane Ring",
    back="Moonbeam Cape",
  }

  -- MEVA (Finish this set?)
  sets.idle.MEVA = set_combine(sets.idle.PDT, {
    back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Damage taken-5%',}},
  })
end

function ja_sets()
end

function spell_sets()
  sets.Buff = {}

  -- General FastCast
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
    back="Swith Cape",
  }
  -- Fast Recast
  sets.midcast.FastRecast = sets.precast.FC

  ---- Curing
  sets.midcast.Cure = {
    ammo="Impatiens",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Vanya Robe",
    hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
    legs="Gyve Trousers",
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Incanter's Torque",
    waist="Bishop's Sash",
    left_ear="Mendi. Earring",
    right_ear="Loquac. Earring",
    left_ring="Haoma's Ring",
    right_ring="Lebeche Ring",
    back="Solemnity Cape",
  }
  sets.midcast.Cure.Weather = set_combine(sets.midcast.Cure, gear.Weather)
  sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
  sets.midcast.Curaga.Weather = set_combine(sets.midcast.Curaga, gear.Weather)

  ---- Status Cures
  sets.midcast.StatusRemoval = sets.midcast.FastRecast
  sets.midcast.Cursna = {
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Vitiation Tabard", augments={'Enhances "Chainspell" effect',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Debilis Medallion",
    waist="Bishop's Sash",
    left_ring="Haoma's Ring",
    right_ring="Haoma's Ring",
    back="Oretan. Cape +1"
  }

  ---- Enfeebling Magic
  sets.Buff.Saboteur = {}
  -- sets.midcast.MagicAccuracy = {
  --   main="Sequence",
  --   sub="Ammurapi Shield",
  --   ammo="Regal Gem",
  --   head="Jhakri Coronal +1",
  --   body="Jhakri Robe +2",
  --   hands={ name="Chironic Gloves", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Cure" spellcasting time -2%','MND+3','Mag. Acc.+13','"Mag.Atk.Bns."+4',}},
  --   legs="Aya. Cosciales +2",
  --   feet="Jhakri Pigaches +2",
  --   neck="Erra Pendant",
  --   waist="Luminary Sash",
  --   left_ear="Digni. Earring",
  --   right_ear="Enfeebling Earring",
  --   left_ring="Kishar Ring",
  --   right_ring="Vertigo Ring",
  --   back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
  -- }
  -- sets.midcast.EnfeeblingMagic = {
  --   main={ name="Grioavolr", augments={'"Fast Cast"+6','INT+8','Mag. Acc.+27','"Mag.Atk.Bns."+16',}},
  --   sub="Enki Strap",
  --   ammo="Regal Gem",
  --   head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
  --   body="Atrophy Tabard +2",
  --   hands={ name="Chironic Gloves", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Cure" spellcasting time -2%','MND+3','Mag. Acc.+13','"Mag.Atk.Bns."+4',}},
  --   legs="Aya. Cosciales +2",
  --   feet={ name="Vitiation Boots +1", augments={'Enhances "Paralyze II" effect',}},
  --   neck="Incanter's Torque",
  --   waist="Luminary Sash",
  --   left_ear="Digni. Earring",
  --   right_ear="Enfeebling Earring",
  --   left_ring="Vertigo Ring",
  --   right_ring="Fenrir Ring",
  --   back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
  -- }
  -- sets.midcast.EnfeeblingMagic.Resistant = set_combine(sets.midcast.EnfeeblingMagic, {
  --   head="Jhakri Coronal +1",
  --   feet="Jhakri Pigaches +2",
  -- })
  -- sets.midcast['Dia III'] = set_combine(sets.midcast.EnfeeblingMagic, {head="Vitiation Chapeau +1"})
  -- sets.midcast['Slow II'] = set_combine(sets.midcast.EnfeeblingMagic, {head="Vitiation Chapeau +1"})
  -- sets.midcast['Bio III'] = set_combine(sets.midcast.EnfeeblingMagic, {legs="Vitiation Tights"})
  -- sets.midcast['Paralyze II'] = set_combine(sets.midcast.EnfeeblingMagic, {feet="Vitiation boots +1"})
  -- sets.midcast['Stun'] = sets.midcast.MagicAccuracy

  sets.midcast.DarkMagic = {
    right_ring="Evanescence Ring",
  }

  sets.midcast.ElementalMagic = {
    main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet="Jhakri Pigaches +2",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Vertigo Ring",
    right_ring="Shiva Ring",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
  }
  sets.midcast.ElementalMagic.Resistant = set_combine(sets.midcast.ElementalMagic, {})
  sets.midcast.ElementalMagic.MB = {
    main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+18','Magic burst dmg.+10%','CHR+3','Mag. Acc.+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+6%',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet="Jhakri Pigaches +2",
    neck="Mizu. Kubikazari",
    waist="Eschan Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Locus Ring",
    right_ring="Mujin Band",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
  }
  sets.midcast.Helix = sets.midcast.ElementalMagic
  sets.midcast.Helix.MB = sets.midcast.ElementalMagic.MB

  ---- Enhancing Magic
  sets.midcast.Enhancing = {
    main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','VIT+1','Mag. Acc.+11','"Mag.Atk.Bns."+1',}},
    sub="Ammurapi Shield",
    ammo="Impatiens",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +6',}},
    body="Zendik Robe",
    hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
    legs="Assid. Pants +1",
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Augment. Earring",
    right_ear="Earthcry Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Perimede Cape",
  }
  sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {
    neck="Nodens Gorget",
    right_ear="Earthcry Earring",
    waist="Siegel Sash",
    back="Perimede Cape"
  })
  sets.midcast.BarSpells = set_combine(sets.midcast.Enhancing, {})
  sets.midcast.EnhancingPotency = {}
  sets.midcast.EnhancingDuration = set_combine(sets.midcast.Enhancing, {})
  sets.midcast.EnhancingComposure = set_combine(sets.midcast.Enhancing, {})
end


function tp_sets()
end

function ws_sets()
end

function init_gear_sets()
  idle_sets()
  ja_sets()
  spell_sets()
  tp_sets()
  ws_sets()
end

-- </editor-fold>


-- <editor-fold> Events/Hooks

function job_precast(spell, action, spellMap, eventArgs)
  -- local dark_strats = S{'Parsimony', 'Addendum: Black', 'Alacrity', 'Ebullience', 'Manifestation', 'Immanence'}
  -- local light_strats = S{'Penury', 'Celerity', 'Rapture', 'Accession', 'Addendum: White', 'Perpetuance'}
  --
  --
  -- if dark_strats[spell.english] and state.Buff.DarkArts == false then
  --   gs_echo("Need dark arts")
  --   local spell_recasts = windower.ffxi.get_spell_recasts()
  --   if spell_recasts[spell.recast_id] < 2 then
  --     ja_before_spell("Dark Arts", spell)
  --     eventArgs.cancel = true
  --     return
  --   end
  -- elseif light_strats[spell.english] and state.Buff.LightArts == false then
  --   local spell_recasts = windower.ffxi.get_spell_recasts()
  --   if spell_recasts[spell.recast_id] < 2 then
  --     ja_before_spell("Light Arts", spell)
  --     eventArgs.cancel = true
  --     return
  --   end
  -- end
end

function job_post_midcast(spell, action, spellMap, eventArgs)

end

function job_get_spell_map(spell, default_spell_map)
  map = default_spell_map

  if spell.action_type == "Magic" then
    if info.Debuffs[spell.english] then
      map = "EnfeeblingMagic"
    elseif spell.english:startswith('Refresh') then
      map = "Refresh"
    elseif spell.english:startswith('En') then
      map = "EnSpells"
    elseif spell.english:startswith('Gain') then
      map = "GainSpells"
    elseif spell.skill == 'Elemental Magic' then
      map = "ElementalMagic"
    elseif spell.skill == 'Dark Magic' then
      map = "DarkMagic"
    elseif spell.skill == 'Enhancing Magic' then
      if spell.target.type == 'PLAYER' and state.Buff.Composure then
        map = "EnhancingComposure"
      else
        map = "EnhancingDuration"
      end
    end
  end

  return map
end

function job_state_change(stateField, newValue, oldValue)
  if stateField == 'Hybrid Mode' then
    if newValue == "Melee" or newValue == "PDT" then
      disable('main', 'sub')
    else
      enable('main', 'sub')
    end
  elseif stateField == "ElementalMode" then
    load_hotbar_for_element_mode(newValue)
  end
end

-- </editor-fold>


-- <editor-fold> Hotbar Integration

function load_hotbar_for_element_mode(mode)
  local fragment = "fragment_"..mode..".txt"
  send_command("exec "..fragment)
end

-- </editor-fold>
