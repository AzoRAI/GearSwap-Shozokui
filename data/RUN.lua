
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
  state.Buff.AM3 = buffactive['Aftermath: Lv. 3']
  state.Buff.LastResort = buffactive['Last Resort']
  state.Buff.Battuta = buffactive['Battuta']
  state.Buff.Valiance = buffactive['Valiance']
  state.Buff.OneForAll = buffactive['Magic Shield']
  state.Buff.Vallation = buffactive['Vallation']
  state.Buff.Liement = buffactive['Liement']
  state.Buff.Pflug = buffactive['Pflug']
  state.Buff.Swordplay = buffactive['Swordplay']

  -- Magic Buffs
  state.Buff.Temper = buffactive['Temper']
  state.Buff.Phalanx = buffactive['Phalanx']
  state.Buff.Crusade = buffactive['Crusade']
end

function user_setup()
  -- Don't blink when using
  -- info.UseBlinkMeNot = true

  -- If using lockstyles, set to equipset to use
  -- info.LockstyleSet = 7

  -- Default Macro Book [Book, Page]
  -- info.MacroBook = {1, 2}




  -- Idle Modes
  --  Normal: Normal Idle Gear (Should be Refresh set)
  --  PDT: Defense Gear
  state.IdleMode:options('Normal', 'DT')


  state.CombatMode = M{['description'] = 'Combat Mode'}
  state.CombatMode:options('Tank', 'DPS')
  state.CombatForm.value = 'Tank'


  -- Handle what Weapon is being used
  state.Weapon = M{['description'] = 'Weapon'}
  state.Weapon:options('Epeolatry', 'Lionheart')
  state.CombatWeapon.value = 'Epeolatry'

  -- Offense Modes
  --  Normal: Normal TP Mode
  --  Acc: High Accuracy TP Mode
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')

  -- Hybrid Modes
  --  Normal:
  --  PDT: Use -DT Gear while engaged
  state.HybridMode:options('Normal', 'DT')

  -- Weaponskill Modes
  --  Normal: Uncapped Attack
  --  AttackCapped: Capped attack
  --  Accuracy: Full Accuracy mode
  state.WeaponskillMode:options('Normal', 'AttackCapped', 'Accuracy')

  -- Casting Modes
  --  Normal: Cast in Normal Gear
  --  SIRD: Spell Interruption Rate
  state.CastingMode:options('Normal', 'SIRD')


  -- Set Defaults to Tank Mode
  state.OffenseMode.value = "Tank"
  state.HybridMode.value = "DT"
end

function user_keybinds()
  bind_key('f9', 'gs c cycle OffenseMode')
  bind_key('f10', 'gs c cycle HybridMode')
  bind_key('f11', 'gs c cycle IdleMode')
end

function user_unbind()
  unbind('f9')
  unbind('f10')
  unbind('f11')
  unbind('f12')
end

function user_spell_maps()
  info.SpellMaps = {}

  info.SpellMaps.PhysicalSpells = S {
		'Bludgeon', 'Body Slam', 'Feather Storm', 'Mandibular Bite', 'Queasyshroom',
		'Power Attack', 'Screwdriver', 'Sickle Slash', 'Smite of Rage',
		'Terror Touch', 'Battle Dance', 'Claw Cyclone', 'Foot Kick', 'Grand Slam',
		'Sprout Smack', 'Helldive', 'Jet Stream', 'Pinecone Bomb', 'Wild Oats', 'Uppercut'
	}

	info.SpellMaps.BlueMagic_Buffs = S {
		'Refueling',
	}

	info.SpellMaps.BlueMagic_Healing = S {
		'Healing Breeze', 'Pollen', 'Wild Carrot'
	}

	info.SpellMaps.BlueMagic_Enmity = S {
		'Blank Gaze', 'Jettatura', 'Geist Wall', 'Sheep Song', 'Soporific', 'Cocoon', 'Stinking Gas'
	}

	info.SpellMaps.RUNMagic_Enmity = S {
		'Flash', 'Stun'
	}
end

-- </editor-fold>


-- <editor-fold> Gear Sets

function augmented_gear()
  CarmineMask = {}
	CarmineMask.MND = { name = "Carmine Mask +1", augments = { 'Accuracy+12','DEX+12','MND+20', } }
	CarmineMask.FC = { name = "Carmine Mask +1", augments = { 'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4', } }
  gear.CarmineMask = CarmineMask

	HerculeanHelm = {}
	HerculeanHelm.Nuke = { name = "Herculean Helm", augments = { 'Mag. Acc.+18 "Mag.Atk.Bns."+18', '"Fast Cast"+1', 'INT+9', 'Mag. Acc.+9', '"Mag.Atk.Bns."+12', } }
	HerculeanHelm.DT = { name = "Herculean Helm", augments = { 'Attack+12', 'Phys. dmg. taken -4%', 'STR+9', 'Accuracy+8', } }
	HerculeanHelm.Refesh = { name = "Herculean Helm", augments = { 'Weapon skill damage +2%','Pet: Accuracy+11 Pet: Rng. Acc.+11','"Refresh"+2', } }
	HerculeanHelm.WSD = { name = "Herculean Helm", augments = { 'Attack+18','Weapon skill damage +4%','STR+10','Accuracy+12', } }
	HerculeanHelm.WSDAcc = { name = "Herculean Helm", augments = { 'Accuracy+23 Attack+23','Weapon skill damage +3%','STR+3','Accuracy+13','Attack+11', } }
	HerculeanHelm.Reso =  { name="Herculean Helm", augments = {'Accuracy+27','"Triple Atk."+3','STR+3',} }
  gear.HerculeanHelm = HerculeanHelm

	TaeonHead = {}
	TaeonHead.SIR = { name="Taeon Chapeau", augments = {'Spell interruption rate down -9%',} }
  gear.TaeonHead = TaeonHead


	HerculeanVest = {}
	HerculeanVest.WSD = { name="Herculean Vest", augments = {'Accuracy+25','Weapon skill damage +4%','STR+8',}}
	HerculeanVest.Phalanx = { name="Herculean Vest", augments={'Spell interruption rate down -2%','"Store TP"+4','Phalanx +2',}}
  gear.HerculeanVest = HerculeanVest

	AdhemarBody = {}
	AdhemarBody.TP = { name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemarBody.FC = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}
  gear.AdhemarBody = AdhemarBody

	TaeonBody = {}
	TaeonBody.FC = { name="Taeon Tabard", augments={'Accuracy+23','"Fast Cast"+5','HP+36',} }
	TaeonBody.SIR = { name="Taeon Tabard", augments = {'Spell interruption rate down -8%','STR+7 VIT+7'} }
  gear.TaeonBody = TaeonBody

	AdhemarWrist = {}
	AdhemarWrist.TP = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',} }
	AdhemarWrist.RA = { name="Adhemar Wrist. +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}}
  gear.AdhemarWrist = AdhemarWrist

	HerculeanGloves = {}
	HerculeanGloves.WSD = { name = "Herculean Gloves", augments = { 'Accuracy+21 Attack+21', 'Weapon skill damage +4%', 'Accuracy+9', 'Attack+10', } }
	HerculeanGloves.DT = { name = "Herculean Gloves", augments = { 'Accuracy+13', 'Damage taken-3%', 'AGI+1', 'Attack+5', } }
	HerculeanGloves.HighAcc = { name = "Herculean Gloves", augments = { 'Accuracy+23 Attack+23', '"Triple Atk."+2', 'DEX+15', 'Accuracy+11', 'Attack+13', } }
	HerculeanGloves.Refresh = { name = "Herculean Gloves", augments = { 'Spell interruption rate down -1%','"Repair" potency +4%','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+16 "Mag.Atk.Bns."+16', } }
	HerculeanGloves.Crit = { name = "Herculean Gloves", augments = { 'Attack+23', 'Crit. hit damage +4%', 'DEX+8', 'Accuracy+11', } }
	HerculeanGloves.Reso = { name="Herculean Gloves", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','STR+9','Accuracy+1','Attack+9',}}
	HerculeanGloves.Phalanx = { name="Herculean Gloves", augments={'VIT+1','INT+7','Phalanx +4','Accuracy+14 Attack+14','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	HerculeanGloves.QA = { name="Herculean Gloves", augments={'Pet: STR+13','Pet: Haste+4','Quadruple Attack +3','Accuracy+10 Attack+10',}}
  gear.HerculeanGloves = HerculeanGloves

	HerculeanLegs = {}
	HerculeanLegs.DT = { name = "Herculean Trousers", augments = { 'Accuracy+22', 'Damage taken-2%', 'VIT+6', } }
	HerculeanLegs.WSD = { name = "Herculean Trousers", augments={'Weapon skill damage +4%','STR+11','Accuracy+14',}}
	HerculeanLegs.Magic = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +4%','STR+4','Mag. Acc.+15', } }
	HerculeanLegs.Reso = { name="Herculean Trousers", augments={'Attack+21','"Triple Atk."+2','STR+6','Accuracy+13', } }
	HerculeanLegs.TH = { name = "Herculean Trousers", augments = { 'INT+5','MND+6','"Treasure Hunter"+1','Mag. Acc.+17 "Mag.Atk.Bns."+17', } }
	HerculeanLegs.Phalanx = { name="Herculean Trousers", augments={'AGI+1','Phys. dmg. taken -2%','Phalanx +3','Accuracy+15 Attack+15',}}
  gear.HerculeanLegs = HerculeanLegs

	LustFeet = {}
	LustFeet.STRDEX = { name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}}
	LustFeet.STRDA = { name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}
  gear.LustFeet = LustFeet

	HerculeanFeet = {}
	HerculeanFeet.QA = { name = "Herculean Boots", augments = { 'AGI+4', '"Dbl.Atk."+2', 'Quadruple Attack +3', 'Accuracy+4 Attack+4', } }
	HerculeanFeet.TA = { name = "Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4',} }
	HerculeanFeet.DT = { name = "Herculean Boots", augments = { 'Accuracy+23', 'Damage taken -3%' } }
	HerculeanFeet.Idle = { name = "Herculean Boots", augments = { 'Crit. hit damage +1%','STR+10','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+17 "Mag.Atk.Bns."+17', } }
	HerculeanFeet.CritDmg = { name = "Herculean Boots", augments = { 'Accuracy+28', 'Crit. hit damage +5%', 'DEX+9', } }
	HerculeanFeet.WSD = { name = "Herculean Boots", augments = { 'Attack+22', 'Weapon skill damage +4%', 'Accuracy+15', } }
	HerculeanFeet.DW = { name = "Herculean Boots", augments = { 'Accuracy+3 Attack+3','"Dual Wield"+4','AGI+3','Accuracy+14' } }
	HerculeanFeet.Phalanx = { name="Herculean Boots", augments={'Pet: Phys. dmg. taken -2%','DEX+9','Phalanx +1','Accuracy+8 Attack+8',}}
	HerculeanFeet.TH = { name="Herculean Boots", augments = { 'Phys. dmg. taken -2%','Pet: Phys. dmg. taken -2%','"Treasure Hunter"+2','Accuracy+16 Attack+16','Mag. Acc.+18 "Mag.Atk.Bns."+18', } }
	HerculeanFeet.QA = { name="Herculean Boots", augments={'"Store TP"+3','Accuracy+7','Quadruple Attack +3','Accuracy+15 Attack+15',}}
  gear.HerculeanFeet = HerculeanFeet

	Ogma = {}
	Ogma.TP = { name="Ogma's cape", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10', 'Phys. dmg. taken-10%' } }
	Ogma.Tank = { name="Ogma's cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10', 'Phys. dmg. taken-10%',}} -- 10% PDT
	Ogma.WSD = { name = "Ogma's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%', 'Phys. dmg. taken-10%' } }
	Ogma.Reso = { name="Ogma's cape", augments={ 'STR+20','Accuracy+20 Attack+20','STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } }
	Ogma.FC = { name = "Ogma's Cape", augments = { 'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10', } }
  gear.Ogma = Ogma
end

function idle_sets()
  sets.idle = {
    ammo = "Homiliary",
		head = "Turms Cap +1",
		neck = "Futhark Torque +2",
		ear1 = "Ethereal Earring",
		ear2 = "Odnowa Earring +1",
		body = "Runeist's Coat +3",
		hands = gear.HerculeanGloves.Refresh,
		ring1 = "Sheltered ring",
		ring2 = "Karieyh Ring +1",
		back = "Moonbeam Cape",
		waist = "Flume Belt +1",
		legs = "Carmine Cuisses +1",
		feet = gear.HerculeanFeet.Idle
  }

  sets.idle.DT = {
    ammo = "Staunch Tathlum +1",
		head = "Futhark Bandeau +3",
		neck = "Futhark Torque +2",
		ear1 = "Ethereal Earring",
		ear2 = "Odnowa Earring +1",
		body = "Futhark Coat +3",
		hands = gear.HerculeanGloves.Refresh,
		ring1 = "Defending ring",
		ring2 = "Moonlight Ring",
		back = "Moonbeam Cape",
		waist = "Flume Belt +1",
		legs = "Carmine Cuisses +1",
		feet = "Erilaz Greaves +1"
  }

  sets.idle.Town = {
    ammo = "Staunch Tathlum +1",
		head = "Futhark Bandeau +3",
		neck = "Futhark Torque +2",
		ear1 = "Ethereal Earring",
		ear2 = "Odnowa Earring +1",
		body = "Runeist's Coat +3",
		hands = "Turms Mittens +1",
		ring1 = "Defending ring",
		ring2 = "Moonlight Ring",
		back = gear.Ogma.Tank,
		waist = "Flume Belt +1",
		legs = "Erilaz Leg Guards +1",
		feet = "Turms Leggings +1",
  }
end

function defense_sets()

  sets.defense.PDT = {}

  sets.defense.MDT = {}

  sets.defense.MEVA = {}

end

function tp_sets()
  --[[
    Base Set Table Defines
    Mode Order: CombatForm > CombatWeapon > Offense Mode > Hybrid Mode > Custom Melee Groups
  --]]
  sets.engaged = {}
  sets.engaged.Tank = {}
  sets.engaged.DPS = {}


  --[[
    Tanking / Epeolatry
    Mode Order: CombatForm > CombatWeapon > Offense Mode > Hybrid Mode > Custom Melee Groups
  --]]

  -- HybridMode: Normal
  sets.engaged.Tank.Epeolatry = {}
  sets.engaged.Tank.Epeolatry.LowAcc = {}
  sets.engaged.Tank.Epeolatry.MidAcc = {}
  sets.engaged.Tank.Epeolatry.HighAcc = {}
  -- HybridMode: DT
  sets.engaged.Tank.Epeolatry.DT = {}
  sets.engaged.Tank.Epeolatry.LowAcc.DT = {}
  sets.engaged.Tank.Epeolatry.MidAcc.DT = {}
  sets.engaged.Tank.Epeolatry.HighAcc.DT = {}

  -- HybridMode: Normal with AM3
  sets.engaged.Tank.Epeolatry.AM3 = {}
  sets.engaged.Tank.Epeolatry.LowAcc.AM3 = {}
  sets.engaged.Tank.Epeolatry.MidAcc.AM3 = {}
  sets.engaged.Tank.Epeolatry.HighAcc.AM3 = {}

  -- HybridMode: DT with AM3
  sets.engaged.Tank.Epeolatry.DT.AM3 = {}
  sets.engaged.Tank.Epeolatry.LowAcc.DT.AM3 = {}
  sets.engaged.Tank.Epeolatry.MidAcc.DT.AM3 = {}
  sets.engaged.Tank.Epeolatry.HighAcc.DT.AM3 = {}

  --[[
    Tanking / Lionheart
    Mode Order: CombatForm > CombatWeapon > Offense Mode > Hybrid Mode > Custom Melee Groups
  --]]

  -- HybridMode: Normal
  sets.engaged.Tank.Lionheart = {}
  sets.engaged.Tank.Lionheart.LowAcc = {}
  sets.engaged.Tank.Lionheart.MidAcc = {}
  sets.engaged.Tank.Lionheart.HighAcc = {}
  -- HybridMode: DT
  sets.engaged.Tank.Lionheart.DT = {}
  sets.engaged.Tank.Lionheart.LowAcc.DT = {}
  sets.engaged.Tank.Lionheart.MidAcc.DT = {}
  sets.engaged.Tank.Lionheart.HighAcc.DT = {}


  --[[
    DPS / Epeolatry
    Mode Order: CombatForm > CombatWeapon > Offense Mode > Hybrid Mode > Custom Melee Groups
  --]]

  -- HybridMode: Normal
  sets.engaged.DPS.Epeolatry = {}
  sets.engaged.DPS.Epeolatry.LowAcc = {}
  sets.engaged.DPS.Epeolatry.MidAcc = {}
  sets.engaged.DPS.Epeolatry.HighAcc = {}

  -- HybridMode: Normal, Capped Haste
  sets.engaged.DPS.Epeolatry.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.LowAcc.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.MidAcc.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.HighAcc.CappedHaste = {}

  -- HybridMode: DT
  sets.engaged.DPS.Epeolatry.DT = {}
  sets.engaged.DPS.Epeolatry.LowAcc.DT = {}
  sets.engaged.DPS.Epeolatry.MidAcc.DT = {}
  sets.engaged.DPS.Epeolatry.HighAcc.DT = {}

  -- HybridMode: DT, Capped Haste
  sets.engaged.DPS.Epeolatry.DT.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.DT.LowAcc.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.DT.MidAcc.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.DT.HighAcc.CappedHaste = {}

  -- HybridMode: Normal with AM3
  sets.engaged.DPS.Epeolatry.AM3 = {}
  sets.engaged.DPS.Epeolatry.LowAcc.AM3 = {}
  sets.engaged.DPS.Epeolatry.MidAcc.AM3 = {}
  sets.engaged.DPS.Epeolatry.HighAcc.AM3 = {}

  -- HybridMode: Normal with AM3 and Capped Haste
  sets.engaged.DPS.Epeolatry.AM3.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.LowAcc.AM3.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.MidAcc.AM3.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.HighAcc.AM3.CappedHaste = {}

  -- HybridMode: DT with AM3
  sets.engaged.DPS.Epeolatry.DT.AM3 = {}
  sets.engaged.DPS.Epeolatry.LowAcc.DT.AM3 = {}
  sets.engaged.DPS.Epeolatry.MidAcc.DT.AM3 = {}
  sets.engaged.DPS.Epeolatry.HighAcc.DT.AM3 = {}

  -- HybridMode: DT with AM3 and Capped Hasted
  sets.engaged.DPS.Epeolatry.DT.AM3.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.LowAcc.DT.AM3.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.MidAcc.DT.AM3.CappedHaste = {}
  sets.engaged.DPS.Epeolatry.HighAcc.DT.AM3.CappedHaste = {}

  --[[
    DPS / Lionheart
    Mode Order: CombatForm > CombatWeapon > Offense Mode > Hybrid Mode > Custom Melee Groups
  --]]

  -- @TODO: Don't use Lionheart!!!!!

  -- HybridMode: Normal
  -- sets.engaged.DPS.Lionheart = {}
  -- sets.engaged.DPS.Lionheart.LowAcc = {}
  -- sets.engaged.DPS.Lionheart.MidAcc = {}
  -- sets.engaged.DPS.Lionheart.HighAcc = {}
  -- HybridMode: DT
  -- sets.engaged.DPS.Lionheart.DT = {}
  -- sets.engaged.DPS.Lionheart.LowAcc.DT = {}
  -- sets.engaged.DPS.Lionheart.MidAcc.DT = {}
  -- sets.engaged.DPS.Lionheart.HighAcc.DT = {}
end

function ws_sets()
  sets.precast.WS = {}

  --[[
    Weaponskill: Dimidiation
  --]]
  sets.precast.WS.Dimidiation = {
    ammo="Knobkierrie",
		head="Lustratio Cap +1",
		neck="Caro Necklace",
		ear1="Mache Earring +1",
		ear2="Sherida Earring",
		body=gear.AdhemarBody.TP,
		hands="Meghanada Gloves +2",
		-- ring1="Regal Ring",
		-- ring2="Niqmaddu Ring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back=gear.Ogma.WSD,
		waist="Grunfeld Rope",
		legs="Lustratio Subligar +1",
		feet=gear.LustFeet.STRDEX
  }
  sets.precast.WS.Dimidiation.AttackCapped = {
    ammo="Knobkierrie",
		head="Lustratio Cap +1",
		neck="Fotia Gorget",
		ear1="Mache Earring +1",
		ear2="Sherida Earring",
		body=gear.AdhemarBody.TP,
		hands="Meghanada Gloves +2",
		ring1="Epona's Ring",
		ring2="Niqmaddu Ring",
		back=gear.Ogma.WSD,
		waist="Fotia Belt",
		legs="Lustratio Subligar +1",
		feet=gear.LustFeet.STRDEX
  }
  sets.precast.WS.Dimidiation.Accuracy = {
    ammo="Seething Bomblet +1",
		head=gear.HerculeanHelm.WSDAcc,
		neck="Fotia Gorget",
		ear1="Moonshade earring",
		ear2="Mache Earring +1",
		body=gear.AdhemarBody.TP,
		hands="Meghanada Gloves +2",
		ring1="Epona's Ring",
		ring2="Niqmaddu Ring",
		back=gear.Ogma.WSD,
		waist="Grunfeld Rope",
		legs="Meghanada Chausses +2",
		feet=gear.HerculeanFeet.QA
  }

  --[[
    Weaponskill: Resolution
  --]]
  sets.precast.WS.Resolution = {
    ammo = "Seething Bomblet +1",
		head = "Lustratio Cap +1",
		neck = "Fotia Gorget",
		ear1 = "Mache Earring +1",
		ear2 = "Sherida Earring",
		body = gear.AdhemarBody.TP,
		hands = gear.HerculeanGloves.Reso,
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = gear.Ogma.Reso,
		waist = "Fotia Belt",
		legs = "Meghanada Chausses +2",
		feet = gear.LustFeet.STRDEX
  }
  sets.precast.WS.Resolution.AttackCapped = {
    ammo = "Knobkierrie",
		head = "Lustratio Cap +1",
		neck = "Fotia Gorget",
		ear1 = "Mache Earring +1",
		ear2 = "Sherida Earring",
		body = "Lustratio Harness +1",
		hands = gear.HerculeanGloves.Reso,
		ring1 = "Epona's Ring",
		ring2 = "Niqmaddu Ring",
		back = gear.Ogma.Reso,
		waist = "Fotia Belt",
		legs = "Samnuha Tights",
		feet = gear.LustFeet.STRDEX
  }
  sets.precast.WS.Resolution.Accuracy = {
    ammo = "Seething Bomblet +1",
		head = gear.HerculeanHelm.Reso,
		neck = "Fotia Gorget",
		ear1 = "Mache Earring +1",
		ear2 = "Sherida Earring",
		body = gear.AdhemarBody.TP,
		hands = gear.AdhemarWrist.TP,
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = gear.Ogma.Reso,
		waist = "Fotia Belt",
		legs = "Meghanada Chausses +2",
		feet = gear.HerculeanFeet.QA
  }
end

function enmity_set()
  sets.Enmity = {
    ammo = "Aqreqaq Bomblet",
		head = "Halitus Helm",
		neck = "Futhark Torque +2",
		ear1 = "Trux Earring",
		ear2 = "Cryptic Earring",
		body = "Emet Harness +1",
		hands = "Kurys Gloves",
		ring1 = "Supershear Ring",
		ring2 = "Eihwaz Ring",
		back = gear.Ogma.Tank,
		waist = "Kasiri Belt",
		legs = "Erilaz Leg Guards +1",
		feet = "Ahosi Leggings"
  }
end

function ja_sets()
  sets.precast.JA = sets.Enmity

  --[[
  Job Ability: Lunge
  --]]
  sets.precast.JA.Lunge = {
    ammo = "Pemphredo Tathlum",
		head = gear.HerculeanHelm.Nuke,
		neck = "Baetyl Pendant",
		ear1 = "Friomisi Earring",
		ear2 = "Hecate's Earring",
		body = "Samnuha Coat",
		hands = "Leyline Gloves",
		ring1 = "Acumen Ring",
		ring2 = "Shiva Ring +1",
		back = "Evasionist's Cape",
		waist = "Eschan Stone",
		legs = gear.HerculeanLegs.Magic,
		feet = "Adhemar Gamashes +1"
  }

  --[[
  Job Ability: Elemental Sforzo
  --]]
  sets.precast.JA.ElementalSforzo = set_combine(sets.Enmity, { body = "Futhark Coat +3" })

  --[[
  Job Ability: Swordplay
  --]]
  sets.precast.JA.Swordplay = set_combine(sets.Enmity, { hands = "Futhark Mitons +1" })

  --[[
  Job Ability: Vallation
  --]]
  sets.precast.JA.Vallation = set_combine(sets.Enmity, {
    body = "Runeist's Coat +3",
		legs = "Futhark Trousers +1",
		back = "Ogma's Cape"
  })

  --[[
  Job Ability: Pflug
  --]]
  sets.precast.JA.Pflug = set_combine(sets.Enmity, { feet = "Runeist's Boots +3" })

  --[[
  Job Ability: Valikance
  --]]
  sets.precast.JA.Valiance = set_combine(sets.Enmity, {
    body = "Runeist's Coat +3",
		legs = "Futhark Trousers +1",
		back = Ogma.Tank
  })

  --[[
  Job Ability: Vivacious Pulse
  --]]
  sets.precast.JA.VivaciousPulse = set_combine(sets.Enmity, {
    head = "Erilaz Galea +1",
		neck = "Incanter's Torque",
		ring2 = "Stikini Ring",
		legs = "Runeist's Trousers +3"
  })

  --[[
  Job Ability: Gambit
  --]]
  sets.precast.JA.Gambit = set_combine(sets.Enmity, {
    hands = "Runeist's Mitons +3"
  })

  --[[
  Job Ability: Battuta
  --]]
  sets.precast.JA.Battuta = set_combine(sets.Enmity, {
    head = "Futhark Bandeau +3"
  })

  --[[
  Job Ability: Rayke
  --]]
  sets.precast.JA.Rayke = set_combine(sets.Enmity, {
    feet = "Futhark Boots +1"
  })

  --[[
  Job Ability: Liement
  --]]
  sets.precast.JA.Liement = set_combine(sets.Enmity, {
    body = "Futhark Coat +3"
  })

  --[[
  Job Ability: One for All
  --]]
  sets.precast.JA.OneForAll = set_combine(sets.Enmity, {
    ammo = "Falcon Eye",
		head = "Halitus Helm",
		neck = "Sanctity Necklace",
		ear1 = "Trux Earring",
		ear2 = "Cryptic Earring",
		body = "Runeist's Coat +3",
		hands = "Runeist's Mitons +3",
		ring1 = "Regal Ring",
		ring2 = "Ilabrat Ring",
		back = "Moonbeam Cape",
		waist = "Kasiri Belt",
		legs = "Erilaz Leg Guards +1",
		Feet = "Carmine Greaves +1"
  })
end

function spell_sets()
  --[[
    Fast Cast Set
  --]]
  sets.precast.FC = {
    ammo = "Sapience Orb", --2
		head = "Runeist's Bandeau +3", --14
		neck = "Voltsurge Torque", --4
		ear1 = "Etiolation Earring", --1
		ear2 = "Loquacious Earring", --2
		body = gear.AdhemarBody.FC, --10
		hands = "Leyline Gloves", --7
		ring1="Kishar Ring", -- +4
		ring2="Prolix Ring", --2
		back = gear.Ogma.FC, --10
		waist = "Kasiri Belt",
		legs = "Ayanmo Cosciales +2", --6
		feet = "Carmine Greaves +1" ---8
  }

  --[[
    Base Magic Type sets
  ]]

  sets.EnhancingSkill = {}
  sets.EnhancingDuration = {}


end

function utility_sets()
  sets.utility = {}

  sets.utility.Doom = {
    ring1 = "Purity Ring",
		ring2 = "Saida Ring",
		waist = "Gishdubar Sash"
  }

  sets.utility.Charm = {
    ammo = "Staunch Tathlum +1",
		head = "Meghanada Visor +2",
		neck = "Futhark Torque +2",
		ear1 = "Genmei Earring",
		ear2 = "Hearty Earring",
		body = "Ashera Harness", --Just for the Orc Ambuscade
		--body = "Runeist's Coat +3",
		hands = "Erilaz Gauntlets +1",
		ring1 = "Defending Ring",
		ring2 = "Wuji Ring",
		back = "Solemnity Cape",
		waist = "Flume Belt +1",
		legs = "Runeist's Trousers +3",
		feet = "Erilaz Greaves +1"
  }
end

function init_gear_sets()
  augmented_gear()
  enmity_set()
  idle_sets()
  defense_sets()
  tp_sets()
  ws_sets()
  ja_sets()
  spell_sets()
end

-- </editor-fold>

-- <editor-fold> Events/Hooks

function job_precast(spell, action, spellMap, eventArgs)
end

function job_get_spell_map(spell, default_map)
end


-- </editor-fold>
