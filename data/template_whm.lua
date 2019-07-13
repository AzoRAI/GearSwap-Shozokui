-- ---
-- White Mage
-- Author: Shozokui
-- Server: Bahamut
-- Linkshell: Dreadnaught
-- ---

inspect = require('inspect')

function get_sets()
  mote_include_version = 2
  include('Mote-Include.lua')
end

function job_setup()
  -- Track Standard White Mage Buffs
  state.Buff.Reraise = buffactive['Reraise'] or false
  state.Buff.Solace = buffactive['Afllatus Solace'] or false
  state.Buff.Misery = buffactive['Afflatus Misery'] or false
  state.Buff.Aurorastorm = buffactive['Aurorastorm'] or false
  state.Buff.Sublimation = buffactive['Sublimation'] or false
  state.Buff.Haste = buffactive['Haste'] or false

  -- Define Typical Spell Maps
  state.BarSpellMap = {
    'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater',
    'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera',
    'Barsleep', 'Barpoison', 'Barparalyze', 'Barblind', 'Barsilence', 'Barpetrify', 'Barvirus', 'Baramnesia',
    'Barsleepra', 'Barpoisonra', 'Barparalyzra', 'Barblindra', 'Barsilencera', 'Barpetra', 'Barvira', 'Baramnesra'
  }
  state.CureWeather = "Aurorastorm"
end

function user_setup()
  -- IdleMode
  --  Normal: Resist+ Effects like (Resist Silence, Resist Paralyze, etc)
  --  Refresh: Idle in a full refresh set
  --  PDT: Idle in a full PDT set
  state.IdleMode:options('Normal', 'Refresh', 'PDT')

  -- CastingMode
  --  Normal: Used for when you do NOT have the effects of weather
  --  Weather: Used while under the effects of Weather
  state.CastingMode:options('Normal', 'Weather')

  -- Weather Casting Gear
  gear.ElementalStaff = "Chatoyant Staff"
end


function init_gear_sets()
  -- Idle Sets
  sets.idle = {
    ammo="Amar Cluster", neck="Loricate Torque +1",
    left_ear="Genmei Earring", right_ear="Ethereal Earring",

    head="Ebers Cap +1",
    body="Ebers Bliaud +1",
    hands="Shrieker's Cuffs",
    legs="Assid. Pants +1",
    feet="Hippo. Socks +1",

    waist="Fucho-no-Obi", left_ring="Vocane Ring", right_ring="Defending Ring",
    back="Solemnity Cape",
  }

  sets.idle.Refresh = set_combine(sets.idle, {
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
    sub="Ammurapi Shield",
    head="Befouled Crown",
    body="Theo. Briault +2",
    waist="Fucho-no-obi"
  })

  sets.idle.PDT = set_combine(sets.idle, {
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
    sub="Genbu's Shield", neck="Loricate Torque +1", left_ear="Genmei Earring",

    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",

    left_ear="Genmei Earring", left_ring="Vocane Ring", right_ring="Defending Ring",
    back="Solemnity Cape"
  })

  -- Precast Sets
  --  Fast Cast/Quick Cast always gets calculated in Precast
  --  WHM Fast Cast caps at 80%
  --  Cure-specific precast is for using -CCT
  sets.precast.FC = { -- 38 FC Raw
    ammo="Impatiens", left_ear="Etiolation Earring", right_ear="Loquac. Earring",

    body="Inyanga Jubbah +2",
    legs="Aya. Cosciales +2",
    feet="Regal Pumps +1",

    waist="Witful Belt", left_ring="Prolix Ring", back="Swith Cape",
  }
  sets.precast.FC.Weather = set_combine(sets.precast.FC, { main="Gioavolr", sub="Clerisy Strap" })
  sets.precast.Cure = set_combine(sets.precast.FC, {
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    hands={ name="Kaykaus Cuffs", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
  })
  sets.precast.Curaga = set_combine(sets.precast.Cure, {})

  -- Midcast Sets
  --  FastRecast is used for spells that are not affected by potency, but you want to lower the cooldown of that spell for repeated casting
  --  A Cursna+ set is really important here, different betwee (No Effect) 10 times, or single successful removal
  --  StatusCure is an extenion of FastRecast so that you can further enhance status cures with JSE.
  sets.midcast.FastRecast = set_combine(sets.precast.FC, {}) -- If I had more haste gear, I'd use it here
  sets.midcast.BarPotency = {}
  sets.midcast.EnhancingPotency = {
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}}, sub="Ammurapi Shield",
    neck="Incanter's Torque",

  }
  sets.midcast.EnhancingDuration = {}
  sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
    neck="Incanter's torque",
    waist="Siegel sash", left_ear="Earthcry earring"
  })
  sets.midcast.Protect = set_combine(sets.midcast.EnhancingPotency, {

  })
  sets.midcast.Regen = {}
  sets.midcast.Cursna = set_combine(sets.precast.FC, {
    neck="Malison Medallion",

    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Ebers Bliaud +1",
    hands={ name="Fanatic Gloves", augments={'MP+20','Healing magic skill +6','"Conserve MP"+2',}},
    legs="Ebers Pant. +1",
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},

    left_ring="Haoma's Ring", right_ring="Haoma's Ring", waist="Bishop's Sash",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Cure" potency +10%',}},
  })
  sets.midcast.StatusRemoval = set_coombine(sets.precast.FC, {})

  -- Cure Potency Sets
  --  These are the big boys, .midcast.Cure is used for Single-Target cure spells, 50% Cure Potency, 10% Cure Potency II, Conserve MP+
  --  .midcast.Cure.Weather should include ElementalObi, Twilight Cloak, Chatoyant Staff, etc
  --  .midcast.Curaga, MND > Cure Potency/Cure Potency II > Conserve MP
  --  .midcast.Curaga.Weather - Same as above, but you use Chatoyant Staff, Twilight Cloak, and Elemental Obi
  sets.midcast.Cure = {
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
    sub="Ammurapi Shield", ammo="Hydrocera",

    head="Ebers Cap +1",
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +3",
    legs="Ebers Pant. +1",
    feet={ name="Kaykaus Boots", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},

    neck="Phalaina Locket", left_ear="Mendi. Earring", right_ear="Nourish. Earring +1",
    left_ring="Sirona's Ring", right_ring="Aquasoul Ring",
    waist="Bishop's sash",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Cure" potency +10%',}},
  }
  sets.midcast.Cure.Weather = set_combine(sets.midcast.Cure, { main=gear.ElementalStaff, sub="Enki Strap", waist=gear.ElementalObi, })

  sets.midcast.Curaga = {
    main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
    sub="Ammurapi Shield", ammo="Hydrocera",

    head="Ebers Cap +1",
    body="Theo. Briault +2",
    hands="Theophany Mitts +3",
    legs="Ebers Pant. +1",
    feet={ name="Kaykaus Boots", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},

    neck="Phalaina Locket", left_ear="Mendi. Earring", right_ear="Nourish. Earring +1",
    left_ring="Vertigo Ring", right_ring="Aquasoul Ring",
    waist="Bishop's sash",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+5','"Cure" potency +10%',}},
  }
  sets.midcast.Curaga.Weather = set_combine(sets.midcast.Curaga, { main=gear.ElementalStaff, sub="Enki Strap", waist=gear.ElementalObi, })


  -- Job Ability Sets
  --  Use the following format for include gear that augments specific job abilities
  -- sets.precast.JA['JA Name'] = { slot="gear" }
end



function table_contains(t, searchval)
  for i,x in pairs(t) do
    if x == searchval then
      return true
    end
  end
  return false
end


function job_get_spell_map(spell, default_spell_map)
  if spell.action_type == 'Magic' then
    if spell.skill == "Enhancing Magic" then
      if spell.english == "Stoneskin" then -- Stoneskin-specific buffs
        return "Stoneskin"
      elseif default_spell_map == "BarElement" or table_contains(state.BarSpellMap, spell.english) then -- Bar Spell Potency
        return "BarPotency"
      else -- By default, return EnhancingDuration set
        return "EnhancingDuration"
      end
    end
  end

  return default_spell_map
end




function job_status_change(new_status, old_status)
end

-- function party_buff_change(member, buff, gained, buff_data)
--   windower.add_to_chat(67, inspect(member))
--   windower.add_to_chat(67, inspect(buff))
--   windower.add_to_chat(67, inspect(buff_data))
-- end

function job_buff_change(buff, gained)

  -- If Aurorastorm has changed from On/Off then change casting modes to match
  if buff == state.CureWeather then
    if gained and state.CastingMode.value == "Normal" then
      send_command("gs c set CastingMode Weather")
    elseif gained == false and  state.CastingMode.value == "Weather" then
      send_command("gs c set CastingMode Normal")
    end
  end

end
