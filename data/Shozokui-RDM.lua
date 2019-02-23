-- <editor-fold> Initialization

function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')

  -- Grab the Naught includes
  include('Naught-Include.lua')
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

  -- SCH Buffs
  state.Buff.LightArts = buffactive['Light Arts'] or false
  state.Buff.Sublimation = buffactive['Sublimation'] or false
  state.Buff.Storms = buffactive['Aurorastorm'] or false

  -- RDM Buffs
  state.Buff.Composure = buffactive['Composure'] or false
  state.Buff.Refresh = buffactive['Refresh'] or false
  state.Buff.Stoneskin = buffactive['Stoneskin'] or false
  state.Buff.Blink = buffactive['Blink'] or false
  state.Buff.Aquaveil = buffactive['Aquaveil'] or false
  state.Buff.Haste = buffactive['Haste'] or false
  state.Buff.Reraise = buffactive['Reraise'] or false
  state.Buff.ShockSpikes = buffactive['Shock Spikes'] or false
  state.Buff.Enthunder = buffactive['Enthunder II'] or false
  state.Buff.Temper = buffactive['Multi Strikes'] or false
  state.Buff.Saboteur = buffactive['Saboteur'] or false

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
  state.HybridMode:options('Normal', 'Melee', 'PDT')

  -- Casting Modes
  --  Normal: Cast in Normal Gear
  --  Weather: Merge in weather geark
  --  MB: Use magic burst gear
  state.CastingMode:options('Normal', 'Resistant', 'Weather', 'MB')
end

function user_keybinds()
  bind_key('f9', 'gs c set CastingMode Normal')
  bind_key('^f9', 'gs c set CastingMode MB')
  bind_key('f10', 'gs c set CastingMode Resistant')
  bind_key('f11', 'gs c set CastingMode Weather')
  bind_key('f12', 'gs c cycle IdleMode')
  bind_key('^f12', 'gs c cycle HybridMode')
end

function user_unbind()
  unbind('f9')
  unbind('f10')
  unbind('f11')
end

-- </editor-fold>


-- <editor-fold> Gear Sets

function idle_sets()
  -- Regen/Refresh
  sets.idle = {
    main="Pukulatmuj", sub="Ammurapi Shield", ammo="Regal Gem",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Jhakri Robe +2", hands="Shrieker's Cuffs",
    legs="Carmine Cuisses +1", feet="Hippo. Socks +1",
    neck="Bathy Choker", waist="Fucho-no-Obi",
    left_ear="Infused Earring", right_ear="Dawn Earring",
    left_ring="Sheltered Ring", right_ring="Paguroidea Ring",
    back="Solemnity Cape",
  }

  -- PDT
  sets.idle.PDT = set_combine(sets.idle, {
    sub="Genbu's Shield",
    head="Aya. Zucchetto +1", neck="Loricate Torque +1",
    body="Ayanmo Corazza +2", hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2", feet="Aya. Gambieras +1",
    waist="Flume Belt",
    left_ear="Genmei Earring", right_ear="Ethereal Earring",
    left_ring="Vocane Ring", right_ring="Defending Ring",
  })
end

function ja_sets()
end

function spell_sets()
  sets.Buff = {}

  -- General FastCast
  sets.precast.FC = {
    ammo="Impatiens",
    head="Atro. Chapeau +1",
    body={ name="Vitiation Tabard", augments={'Enhances "Chainspell" effect',}},
    legs="Aya. Cosciales +2", feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Conserve MP"+1','INT+6','"Mag.Atk.Bns."+11',}},
    left_ear="Etiolation Earring", right_ear="Loquac. Earring",
    right_ear="Loquac. Earring", left_ring="Prolix Ring",
    waist="Witful Belt", back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
  }
  -- Fast Recast
  sets.midcast.FastRecast = sets.precast.FC

  ---- Curing
  sets.midcast.Cure = {
    ammo="Regal Gem",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Chironic Doublet",
    hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
    legs="Atrophy Tights +2",
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Phalaina Locket",
    waist="Bishop's Sash",
    left_ear="Mendi. Earring",
    right_ear="Augment. Earring",
    left_ring="Lebeche Ring",
    right_ring="Sirona's Ring",
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
  sets.midcast.MagicAccuracy = {
    main="Sequence",
    sub="Ammurapi Shield",
    ammo="Regal Gem",
    head="Jhakri Coronal +1",
    body="Jhakri Robe +2",
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Cure" spellcasting time -2%','MND+3','Mag. Acc.+13','"Mag.Atk.Bns."+4',}},
    legs="Aya. Cosciales +2",
    feet="Jhakri Pigaches +2",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Enfeebling Earring",
    left_ring="Kishar Ring",
    right_ring="Vertigo Ring",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
  }
  sets.midcast.EnfeeblingMagic = {
    main={ name="Grioavolr", augments={'"Fast Cast"+6','INT+8','Mag. Acc.+27','"Mag.Atk.Bns."+16',}},
    sub="Enki Strap",
    ammo="Regal Gem",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +2",
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Cure" spellcasting time -2%','MND+3','Mag. Acc.+13','"Mag.Atk.Bns."+4',}},
    legs="Aya. Cosciales +2",
    feet={ name="Vitiation Boots +1", augments={'Enhances "Paralyze II" effect',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Enfeebling Earring",
    left_ring="Vertigo Ring",
    right_ring="Fenrir Ring",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
  }
  sets.midcast.EnfeeblingMagic.Resistant = set_combine(sets.midcast.EnfeeblingMagic, {
    head="Jhakri Coronal +2",
    feet="Jhakri Pigaches +2",
  })
  sets.midcast['Dia III'] = set_combine(sets.midcast.EnfeeblingMagic, {head="Vitiation Chapeau +1"})
  sets.midcast['Slow II'] = set_combine(sets.midcast.EnfeeblingMagic, {head="Vitiation Chapeau +1"})
  sets.midcast['Bio III'] = set_combine(sets.midcast.EnfeeblingMagic, {legs="Vitiation Tights"})
  sets.midcast['Paralyze II'] = set_combine(sets.midcast.EnfeeblingMagic, {feet="Vitiation boots +1"})
  sets.midcast['Stun'] = sets.midcast.MagicAccuracy

  sets.midcast.DarkMagic = {
    right_ring="Evanescence Ring",
  }
  sets.midcast.ElementalMagic = {
    main={ name="Grioavolr", augments={'"Fast Cast"+6','INT+8','Mag. Acc.+27','"Mag.Atk.Bns."+16',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+18','Magic burst dmg.+10%','CHR+3','Mag. Acc.+11',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic Damage +14','VIT+6','Mag. Acc.+10','"Mag.Atk.Bns."+13',}},
    hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+9%','CHR+1','"Mag.Atk.Bns."+11',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Mag. crit. hit dmg. +10%','Mag. Acc.+11',}},
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+7%','CHR+1','Mag. Acc.+12',}},
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Friomisi Earring",
    right_ear="Loquac. Earring",
    left_ring="Locus Ring",
    right_ring="Vertigo Ring",
    back="Twilight Cape",
  }

  sets.midcast.Sleepga = sets.midcast.EnfeeblingMagic.Resistant

  ---- Enhancing Magic
  sets.midcast.Enhancing = {
    main="Pukulatmuj", sub="Ammurapi Shield", ammo="Regal Gem",
    head="Befouled Crown", neck="Incanter's Torque",
    body={ name="Vitiation Tabard", augments={'Enhances "Chainspell" effect',}}, hands="Atrophy Gloves +2",
    legs="Atrophy Tights +2", feet="Leth. Houseaux",
    waist="Olympus Sash", left_ear="Augment. Earring",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
  }
  sets.midcast.Refresh = set_combine(sets.midcast.Enhancing, {
    body="Atrophy Tabard +2",
  })
  sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {
    neck="Nodens Gorget",
    right_ear="Earthcry Earring",
    waist="Siegel Sash",
    back="Perimede Cape"
  })
  sets.midcast.BarSpells = set_combine(sets.midcast.Enhancing, {})
  sets.midcast.EnSpells = set_combine(sets.midcast.Enhancing, {})
  sets.midcast.GainSpells = set_combine(sets.midcast.Enhancing, {})
  sets.midcast.EnhancingPotency = {}
  sets.midcast.EnhancingDuration = set_combine(sets.midcast.Enhancing, {})
  sets.midcast.EnhancingComposure = set_combine(sets.midcast.Enhancing, {})
end


function tp_sets()
  sets.engaged = {
    ammo="Ginsen",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Ainia Collar",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','"Store TP"+10','Damage taken-5%',}},
  }
end

function ws_sets()
  sets.precast.WS['Chant du Cygne'] = {
    ammo="Jukukik Feather",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Atrophy Gloves +2",
    legs="Jhakri Slops +1",
    feet="Thereoid Greaves",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Bleating Mantle",
  }

  sets.precast.WS['Aeolian Edge'] = {
    ammo="Pemphredo Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet="Jhakri Pigaches +2",
    neck="Mizu. Kubikazari",
    waist="Aswang Sash",
    left_ear="Friomisi Earring",
    right_ear="Digni. Earring",
    left_ring="Shiva Ring",
    right_ring="Vertigo Ring",
    back="Seshaw Cape",
  }
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

function job_precast(spell)
end

function job_post_midcast(spell, action, spellMap, eventArgs)

end

function job_get_spell_map(spell, default_spell_map)
  map = default_spell_map

  if spell.action_type == "Magic" then
    if info.Debuffs[spell.english] then
      map = "EnfeeblingMagic"
    elseif spell:contains("Sleep") then
      map = "Sleepga"
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
  end
end

-- </editor-fold>
