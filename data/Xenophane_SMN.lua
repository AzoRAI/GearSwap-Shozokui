-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- PetDT: Sacrifice refresh to reduce avatar's damage taken. WARNING: Selenian Cap drops you below 119, use with caution!
-- DD: When melee mode is on and you're engaged, uses TP gear. Otherwise, avatar melee gear.
-- Favor: Uses Beckoner's Horn +1 and max smn skill to boost the favor effect.
-- Zendik: Favor build with the Zendik Robe added in, for Shiva's Favor in manaburn parties. (Shut up, it sounded like a good idea at the time)

-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > DT > PetDT)
-- F10 - Toggles MeleeMode (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP

-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c ForceIlvl - I have this set up to override a few specific slots where I normally use non-ilvl pieces.

function get_sets()
	include('organizer-lib')
	send_command('bind f9 gs c ToggleIdle')
	send_command('bind f10 gs c MeleeMode')

	-- Set your merits here. This is used in deciding between Enticer's Pants or Apogee Slacks +1.
	-- To change in-game, "/console gs c MeteorStrike3" will change Meteor Strike to 3/5 merits.
	MeteorStrike = 1
	HeavenlyStrike = 1
	WindBlade = 1
	Geocrush = 1
	Thunderstorm = 5
	GrandFall = 1

	StartLockStyle = '12'
	IdleMode = 'Refresh'
	AccMode = false
	ImpactDebuff = false
	MeleeMode = false
	ForceIlvl = false
	Test = 0

	-- ===================================================================================================================
	--		Sets
	-- ===================================================================================================================

	MerlinicHood = {}
	MerlinicHood.FC = { name="Merlinic Hood", augments={'Attack+12','"Fast Cast"+7','MND+5',}}
	
	MerlinicDastanas = {}
	MerlinicDastanas.FC = { name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+25','"Fast Cast"+7','CHR+4','Mag. Acc.+10',} }
	MerlinicDastanas.BP = { name="Merlinic Dastanas",augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Blood Pact Dmg.+7','Pet: DEX+10','Pet: "Mag.Atk.Bns."+1',}}

	MerlinicCrackows = {}
	MerlinicCrackows.FC = { name="Merlinic Crackows", augments={'"Fast Cast"+7','MND+1','"Mag.Atk.Bns."+3',} }
	
	ApogeeCrown = {}
	ApogeeCrown.BP = { name="Apogee Crown", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}}
	
	ApogeeSlacks = {}
	ApogeeSlacks.BP = { name="Apogee Slacks", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}}
	
	ApogeePumps = {}
	ApogeePumps.BP = { name="Apogee Pumps", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}}

	Grioavolr = {}
	Grioavolr.MAB = { name="Grioavolr", augments={'Blood Pact Dmg.+7','Pet: "Mag.Atk.Bns."+25','DMG:+5',}}
	
	Campestres = {}
	Campestres.BP = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}}
	
	-- Base Damage Taken Set - Mainly used when IdleMode is "DT"
	sets.DT_Base = {
		main="Nirvana",
		sub="Alber Strap",
		head="Convoker's Horn +3",
		neck="Loricate Torque +1",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		body="Udug Jacket",
		hands="Asteria Mitts +1",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Moonlight Cape",
		waist="Regal Belt",
		legs="Assiduity Pants +1",
		feet={ name="Merlinic Crackows", augments={'DEX+10','Phys. dmg. taken -2%','"Refresh"+2','Accuracy+3 Attack+3',}}
	}

	sets.precast = {}

	-- Fast Cast
	sets.precast.FC = {
		main={ name="Grioavolr", augments={'"Fast Cast"+6','INT+2','"Mag.Atk.Bns."+17',}}, -- +10
		sub="Clerisy Strap +1", -- +3
		head=MerlinicHood.FC, -- +15
		neck="Voltsurge Torque", -- +4
		ear1="Loquacious Earring", -- +2
		ear2="Etiolation Earring", -- +1
		hands=MerlinicDastanas.FC, --7
		body="Inyanga Jubbah +1", -- +14
		ring1="Kishar Ring", -- +4
		ring2="Prolix Ring", --5/(3)
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},
		waist="Witful Belt", -- +3
		legs="Psycloth Lappas", --7
		feet=MerlinicCrackows.FC --7
	}

    sets.midcast = {}

	-- BP Timer Gear
    sets.midcast.BP = {
		--main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','System: 2 ID: 153 Val: 3',}},
		--sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		neck="Caller's Pendant",
		ear1="Andoaa Earring",
		ear2="Summoning Earring",
		body="Convoker's doublet +2",
		hands="Glyphic Bracer's +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
		waist="Kobo Obi",
		legs="Baayami Slops +1",
		feet="Apogee pumps +1"
	}

    sets.midcast.Siphon = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','System: 2 ID: 153 Val: 3',}},
		sub="Vox Grip",
		ammo="Esper Stone +1",
		head="Baayami Hat +1",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Smn. Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
		waist="Kobo Obi",
		legs="Baayami Slops +1",
		feet="Beck. Pigaches +1"
	}

	sets.midcast.SiphonZodiac = set_combine(sets.midcast.Siphon, { ring1="Zodiac Ring" })

	sets.midcast.Summon = set_combine(sets.DT_Base, {
		body="Baayami Robe +1"
	})

	sets.midcast.Cure = {
		main="Nirvana",
		sub="Oneiros Grip",
		ammo="Sancus Sachet +1",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		neck="Nodens Gorget",
		ear1="Mendi. Earring",
		ear2="Novia Earring",
		body="Witching Robe",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ring1="Lebeche Ring",
		ring2="Haoma's Ring",
		back="Tempered Cape +1",
		waist="Witful Belt",
		legs="Assiduity Pants +1",
		feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}
	}

	sets.midcast.Cursna = set_combine(sets.precast.FC, {
		neck="Debilis Medallion",
		ear1="Healing Earring",
		ear2="Beatific Earring",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		back="Tempered Cape +1",
		waist="Bishop's Sash"
	})
	
	sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {
		main="Nirvana",
		ear1="Novia Earring"
	})

	sets.midcast.Enfeeble = {
		main={ name="Gada", augments={'"Fast Cast"+2','MND+13','Mag. Acc.+20','"Mag.Atk.Bns."+14',}},
		sub="Ammurapi Shield",
		head="Inyanga Tiara +2",
		neck="Erra Pendant",
		ear1="Dignitary's Earring",
		ear2="Gwati Earring",
		body="Inyanga Jubbah +1",
		hands="Inyanga Dastanas +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Aurist's Cloak +1",
		waist="Luminary Sash",
		legs="Inyanga Shalwar +2",
		feet="Skaoi Boots"
	}

	sets.midcast.Enhancing = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','DEX+1','Mag. Acc.+5','"Mag.Atk.Bns."+18','DMG:+4',}},
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'Pet: "Mag.Atk.Bns."+19','"Elemental Siphon"+25','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Augmenting Earring",
		body={ name="Telchine Chas.", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Merciful Cape",
		waist="Olympus Sash",
		legs={ name="Telchine Braconi", augments={'"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'"Conserve MP"+3','Enh. Mag. eff. dur. +9',}}
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {
		neck="Nodens Gorget",
		ear2="Earthcry Earring",
		waist="Siegel Sash",
		legs="Shedir Seraweels"
	})

	sets.midcast.Nuke = {
		main={ name="Grioavolr", augments={'"Fast Cast"+6','INT+2','"Mag.Atk.Bns."+17',}},
		sub="Niobid Strap",
		head="Inyanga Tiara +2",
		neck="Eddy Necklace",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		body="Witching Robe",
		hands="Inyanga Dastanas +2",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		waist="Eschan Stone",
		legs="Lengo Pants",
		feet={ name="Merlinic Crackows", augments={'DEX+10','Phys. dmg. taken -2%','"Refresh"+2','Accuracy+3 Attack+3',}}
	}

    sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {
		waist="Gishdubar Sash"
	})

	sets.midcast["Mana Cede"] = { hands="Beckoner's Bracers +1" }

    sets.midcast["Astral Flow"] = { head="Glyphic Horn +1" }

	sets.midcast["Garland of Bliss"] = set_combine(sets.midcast.Nuke, {
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2"
	})

	sets.midcast["Shattersoul"] = {
		head="Convoker's Horn +3",
		neck="Fotia Gorget",
		ear1="Zennaroi Earring",
		ear2="Telos Earring",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +2",
		ring1="Rajas Ring",
		ring2="Varar Ring +1 +1",
		back={ name="Campestres's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs={ name="Telchine Braconi", augments={'Accuracy+17','Weapon Skill Acc.+14','Weapon skill damage +3%',}},
		feet="Convoker's Pigaches +3"
	}

	sets.midcast["Cataclysm"] = sets.midcast.Nuke

	sets.pet_midcast = {}

	-- Main physical pact set (Volt Strike, Pred Claws, etc.)
	sets.pet_midcast.Physical_BP = {
		main="Gridarvor",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head={ name="Helios Band", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
		neck="Shulmanu Collar",
		ear1="Lugalbanda Earring",
		ear2="Gelos Earring",
		body="Convoker's Doublet +3",
		hands=MerlinicDastanas.BP,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
		back=Campestres.BP,
		waist="Incarnation Sash",
		legs="Apogee Slacks +1",
		feet="Apogee pumps +1"
	}

	sets.pet_midcast.Physical_BP_AM3 = set_combine(sets.pet_midcast.Physical_BP, {
		head=ApogeeCrown.BP,
		feet="Apogee pumps +1"
	})

	-- Physical pacts which benefit more from TP than Pet:DA (like single-hit BP)
	sets.pet_midcast.Physical_BP_TP = set_combine(sets.pet_midcast.Physical_BP, {
		head=ApogeeCrown.BP,
		waist="Regal Belt",
		legs="Enticer's Pants",
		feet="Apogee pumps +1"
	})

	-- Used for all physical pacts when AccMode is true
	sets.pet_midcast.Physical_BP_Acc = set_combine(sets.pet_midcast.Physical_BP, {
		head=ApogeeCrown.BP,
		--ear2="Enmerkar Earring",
		hands=MerlinicDastanas.BP
		--feet="Convoker's Pigaches +3"
	})

	-- Base magic pact set
	sets.pet_midcast.Magic_BP_Base = {
		main=Grioavolr.MAB,
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head=ApogeeCrown.BP,
		neck="Adad Amulet",
		ear1="Lugalbanda Earring",
		ear2="Gelos Earring",
		body="Convoker's Doublet",
		hands=MerlinicDastanas.BP,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},
		waist="Incarnation Sash",
		feet="Apogee pumps +1"
	}
	
	-- Some magic pacts benefit more from TP than others.
	-- Note: This set will only be used on merit pacts if you have less than 4 merits.
	--       Make sure to update your merit values at the top of this Lua.
	sets.pet_midcast.Magic_BP_TP = set_combine(sets.pet_midcast.Magic_BP_Base, {
		legs="Enticer's Pants"
	})

	-- NoTP set used when you don't need Enticer's
	sets.pet_midcast.Magic_BP_NoTP = set_combine(sets.pet_midcast.Magic_BP_Base, {
		legs=ApogeeSlacks.BP
	})

	sets.pet_midcast.Magic_BP_TP_Acc = set_combine(sets.pet_midcast.Magic_BP_TP, {
		head={ name="Merlinic Hood", augments={'Pet: Mag. Acc.+21 Pet: "Mag.Atk.Bns."+21','Blood Pact Dmg.+7','Pet: INT+6','Pet: "Mag.Atk.Bns."+11',}},
		body="Convoker's Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+29','Blood Pact Dmg.+10','Pet: INT+7','Pet: "Mag.Atk.Bns."+10',}}
	})

	sets.pet_midcast.Magic_BP_NoTP_Acc = set_combine(sets.pet_midcast.Magic_BP_NoTP, {
		head={ name="Merlinic Hood", augments={'Pet: Mag. Acc.+21 Pet: "Mag.Atk.Bns."+21','Blood Pact Dmg.+7','Pet: INT+6','Pet: "Mag.Atk.Bns."+11',}},
		body="Convoker's Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+29','Blood Pact Dmg.+10','Pet: INT+7','Pet: "Mag.Atk.Bns."+10',}}
	})

	sets.pet_midcast.FlamingCrush = {
		main="Gridarvor",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head="Apogee Crown",
		neck="Adad Amulet",
		ear1="Lugalbanda Earring",
		ear2="Gelos Earring",
		body="Convoker's Doublet +3",
		hands=MerlinicDastanas.BP,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
		back=Campestres.BP,
		waist="Incarnation Sash",
		legs="Apogee Slacks +1",
		feet="Apogee Pumps"
	}

	sets.pet_midcast.FlamingCrush_Acc = set_combine(sets.pet_midcast.FlamingCrush, {
		--ear2="Enmerkar Earring",
		body="Convoker's Doublet +3",
		hands=MerlinicDastanas.BP,
		--feet="Convoker's Pigaches +3"
	})

	-- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
	sets.pet_midcast.MagicAcc_BP = {
		main="Nirvana",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		neck="Incanter's Torque",
		ear1="Lugalbanda Earring",
		ear2="Enmerkar Earring",
		body="Convoker's Doublet +3",
		hands="Apogee Mitts +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},
		waist="Regal Belt",
		legs="Convoker's Spats +3",
		feet="Convoker's Pigaches +3"
	}

	sets.pet_midcast.Debuff_Rage = sets.pet_midcast.MagicAcc_BP

	sets.pet_midcast.SummoningMagic = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','System: 2 ID: 153 Val: 3',}},
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Baayami Hat +1",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Smn. Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
		waist="Kobo Obi",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1"
	}

	sets.pet_midcast.Buff = sets.pet_midcast.SummoningMagic

	sets.pet_midcast.Buff_Healing = set_combine(sets.pet_midcast.SummoningMagic, {
		main="Nirvana",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		body="Apogee Dalmatica +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		feet={ name="Apogee pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	})

	-- This set is used for certain blood pacts when ImpactDebuff mode is ON. (/console gs c ImpactDebuff)
	-- These pacts are normally used as nukes, but they're also strong debuffs which are enhanced by smn skill.
	sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {
		main="Nirvana",
		head="Convoker's Horn +3",
		ear1="Lugalbanda Earring",
		ear2="Enmerkar Earring"
	})

	sets.aftercast = {}

	-- Idle set with no avatar out.
	sets.aftercast.Idle = {
		main="Contemplator +1",
		sub="Oneiros Grip",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		neck="Loricate Torque +1",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
		body="Apogee Dalmatica",
		hands="Asteria Mitts +1",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Moonlight Cape",
		waist="Incarnation Sash",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters"
	}
	
	sets.aftercast.Idle_Ilvl = set_combine(sets.aftercast.Idle, {
		feet="Baayami Sabot"
	})
	
	sets.aftercast.DT = sets.DT_Base

	-- Many idle sets inherit from this set.
	-- Put common items here so you don't have to repeat them over and over.
	sets.aftercast.Perp_Base = {
		main="Nirvana",
		sub="Oneiros Grip",
		ammo="Sancus Sachet +1",
		head="Beckoner's horn +1",
		neck="Caller's Pendant",
		ear1="Moonshade Earring",
		ear2="Evans Earring",
		body="Apogee Dalmatica",
		hands="Asteria Mitts +1",
		ring1="Varar Ring +1",
		ring2="Evoker's Ring",
		back=Campestres.BP,
		waist="Isa Belt",
		legs="Assiduity Pants +1",
		feet="Apogee pumps +1"
	}

	-- Avatar Melee set. Equipped when IdleMode is "DD" and MeleeMode is OFF.
	sets.aftercast.Perp_DD = set_combine(sets.aftercast.Perp_Base, {
		ear2="Rimeice Earring",
		body="Glyphic Doublet +1",
		hands={ name="Helios Gloves", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+8','Pet: Haste+6',}},
		waist="Klouskap Sash",
		feet={ name="Helios Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+8','Pet: Haste+6',}}
	})

	-- Refresh set with avatar out. Equipped when IdleMode is "Refresh".
	sets.aftercast.Perp_Refresh = set_combine(sets.aftercast.Perp_Base, {
		body="Apogee Dalmatica"
	})

	sets.aftercast.Perp_RefreshSub50 = set_combine(sets.aftercast.Perp_Refresh, {
		waist="Fucho-no-obi"
	})
	
	sets.aftercast.Perp_Favor = set_combine(sets.aftercast.Perp_Refresh, {
		head="Beckoner's Horn +1",
		ear2="Enmerkar Earring",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1"
	})

	sets.aftercast.Perp_Zendik = set_combine(sets.aftercast.Perp_Refresh, {
		body="Zendik Robe"
	})

	-- TP set. Equipped when IdleMode is "DD" and MeleeMode is ON.
	sets.aftercast.Perp_Melee = set_combine(sets.aftercast.Perp_Refresh, {
		head="Convoker's Horn +3",
		neck="Shulmanu Collar",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		body="Tali'ah Manteel +2",
		hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+3','Accuracy+12','"Store TP"+7','Accuracy+7 Attack+7',}},
		ring1="Rajas Ring",
		ring2="Petrov Ring",
		back={ name="Campestres's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		waist="Incarnation Sash",
		legs="Convoker's Spats +3",
		feet="Convoker's Pigaches +3"
	})

	-- Pet:DT build. Equipped when IdleMode is "PetDT".
	sets.aftercast.Avatar_DT = {
		main="Nirvana",
		sub="Oneiros Grip",
		ammo="Sancus Sachet +1",
		head="Selenian Cap",
		neck="Empath Necklace",
		ear1="Enmerkar Earring",
		ear2="Handler's Earring +1",
		body="Apogee Dalmatica +1",
		hands="Artsieq Cuffs",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		waist="Isa Belt",
		legs="Assiduity Pants +1",
		feet={ name="Telchine Pigaches", augments={'Pet: DEF+14','Pet: "Regen"+3','Pet: Damage taken -3%',}}
	}

	sets.aftercast.Avatar_DT_Ilvl = set_combine(sets.aftercast.Avatar_DT, {
		head="Glyphic Horn +1",
		legs="Tali'ah Seraweels +2"
	})

	-- DT build with avatar out. Equipped when IdleMode is "DT".
	sets.aftercast.Perp_DT = set_combine(sets.DT_Base, {
		ear2="Evans Earring",
		waist="Lucidity Sash"
	})

	sets.aftercast.Spirit = {
		main="Nirvana",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Evans Earring",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
		waist="Lucidity Sash",
		legs="Glyphic Spats +1",
		feet="Baayami Sabots +1"
	}

	-- ===================================================================================================================
	--		End of Sets
	-- ===================================================================================================================

	Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
	Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall'}
	Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}

	Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark'}
	Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
	Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
	Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive'}

	AvatarList = S{'Shiva','Ramuh','Garuda','Leviathan','Diabolos','Titan','Fenrir','Ifrit','Carbuncle','Fire Spirit','Air Spirit','Ice Spirit','Thunder Spirit','Light Spirit','Dark Spirit','Earth Spirit','Water Spirit','Cait Sith','Alexander','Odin','Atomos'}
	TownIdle = S{"windurst woods","windurst waters","windurst walls","port windurst","bastok markets","bastok mines","port bastok","southern san d'oria","northern san d'oria","port san d'oria","upper jeuno","lower jeuno","port jeuno","ru'lude gardens","norg","kazham","tavnazian safehold","rabao","selbina","mhaura","aht urhgan whitegate","al zahbi","nashmau","western adoulin","eastern adoulin"}
	Salvage = S{"Bhaflau Remnants","Zhayolm Remnants","Arrapago Remnants","Silver Sea Remnants"}

	-- Select initial macro set and set lockstyle
	-- This section likely requires changes or removal if you aren't Pergatory
	if pet.isvalid then
		if pet.name=='Fenrir' then
			send_command('input /macro book 6;wait .1;input /macro set 2;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Ifrit' then
			send_command('input /macro book 6;wait .1;input /macro set 3;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Titan' then
			send_command('input /macro book 6;wait .1;input /macro set 4;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Leviathan' then
			send_command('input /macro book 6;wait .1;input /macro set 5;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Garuda' then
			send_command('input /macro book 6;wait .1;input /macro set 6;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Shiva' then
			send_command('input /macro book 6;wait .1;input /macro set 7;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Ramuh' then
			send_command('input /macro book 6;wait .1;input /macro set 8;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Diabolos' then
			send_command('input /macro book 6;wait .1;input /macro set 9;wait 3;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Cait Sith' then
			send_command('input /macro book 6;wait .1;input /macro set 2;wait 3;input /lockstyleset '..StartLockStyle)
		end
	else
		send_command('input /macro book 6;wait .1;input /macro set 1;wait 3;input /lockstyleset '..StartLockStyle)
			add_to_chat (21, 'Loaded Summoner Gearswap')
			add_to_chat (55, 'You are on '..('SMN '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
	end
	-- End macro set / lockstyle section
end

function pet_change(pet,gain)
    idle()
end

function precast(spell)
    if pet_midaction() or spell.type=="Item" then
		return
	end
	-- Spell fast cast
    if spell.action_type=="Magic" then
		if spell.name=="Stoneskin" then
			equip(sets.precast.FC,{waist="Siegel Sash"})
		else
			equip(sets.precast.FC)
		end
    end
end

function midcast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
	-- BP Timer gear needs to swap here
	if (spell.type=="BloodPactWard" or spell.type=="BloodPactRage") and not buffactive["Astral Conduit"] then
		equip(sets.midcast.BP)
	-- Spell Midcast & Potency Stuff
    elseif sets.midcast[spell.english] then
        equip(sets.midcast[spell.english])
	elseif spell.name=="Elemental Siphon" then
		if pet.element=="Light" or pet.element=="Dark" then
			equip(sets.midcast.Siphon)
		else
			equip(sets.midcast.SiphonZodiac)
		end
	elseif spell.type=="SummonerPact" then
		equip(sets.midcast.Summon)
	elseif spell.type=="WhiteMagic" then
		if string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
			equip(sets.midcast.Cure)
		elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
			equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
		elseif spell.skill=="Enfeebling Magic" then
			equip(sets.midcast.Enfeeble)
		elseif spell.skill=="Enhancing Magic" then
			if spell.name=="Stoneskin" then
				equip(sets.midcast.Stoneskin)
				if buffactive["Stoneskin"] then
					windower.send_command('wait 1;cancel 37;')
				end
			elseif spell.name=="Sneak" and buffactive["Sneak"] and spell.target.type=="SELF" then
				windower.send_command('cancel 71;')
			else
				equip(sets.midcast.Enhancing)
			end
		else
			idle()
		end
	elseif spell.type=="BlackMagic" then
		if spell.skill=="Elemental Magic" then
			equip(sets.midcast.Nuke)
		end
	elseif spell.type=="Ninjutsu" then
		if spell.name=="Utsusemi: Ichi" then
			if buffactive["Copy Image"] then
				windower.send_command('wait 1;cancel 66;')
			end
		end
	elseif spell.action_type=="Magic" then
		equip(sets.midcast.EnmityRecast)
    else
        idle()
    end
end

function aftercast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
    if spell and (not spell.type or not string.find(spell.type,"BloodPact") and not AvatarList:contains(spell.name) or spell.interrupted) then
        idle()
    end
end

function status_change(new,old)
	if new=="Idle" then
        idle()
	end
end

function buff_change(name,gain)
    if name=="Quickening" then
        idle()
    end
end

function pet_midcast(spell)
    if spell.name=="Perfect Defense" then
        equip(sets.midcast.SummoningMagic)
    elseif spell.type=="BloodPactWard" then
        if Debuff_BPs:contains(spell.name) then
            equip(sets.pet_midcast.MagicAcc_BP)
		elseif Buff_BPs_Healing:contains(spell.name) then
			equip(sets.pet_midcast.Buff_Healing)
        else
            equip(sets.pet_midcast.Buff)
        end
    elseif spell.type=="BloodPactRage" then
        if spell.name=="Flaming Crush" then
			if AccMode then
				equip(sets.pet_midcast.FlamingCrush_Acc)
			else
				equip(sets.pet_midcast.FlamingCrush)
			end
		elseif ImpactDebuff and (spell.name=="Impact" or spell.name=="Conflag Strike") then
			equip(sets.pet_midcast.Impact)
        elseif Magic_BPs_TP:contains(spell.name) or string.find(spell.name," II") or string.find(spell.name," IV") then
			if AccMode then
				equip(sets.pet_midcast.Magic_BP_TP_Acc)
			else
                equip(sets.pet_midcast.Magic_BP_TP)
			end
        elseif Magic_BPs_NoTP:contains(spell.name) then
			if AccMode then
				equip(sets.pet_midcast.Magic_BP_NoTP_Acc)
			else
                equip(sets.pet_midcast.Magic_BP_NoTP)
			end
		elseif Merit_BPs:contains(spell.name) then
			if AccMode then
				equip(sets.pet_midcast.Magic_BP_TP_Acc)
			elseif spell.name=="Meteor Strike" and MeteorStrike>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Geocrush" and Geocrush>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Grand Fall" and GrandFall>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Wind Blade" and WindBlade>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Heavenly Strike" and HeavenlyStrike>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Thunderstorm" and Thunderstorm>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			else
				equip(sets.pet_midcast.Magic_BP_TP)
			end
		elseif Debuff_Rage_BPs:contains(spell.name) then
			equip(sets.pet_midcast.Debuff_Rage)
        else
			if AccMode then
				equip(sets.pet_midcast.Physical_BP_Acc)
			elseif Physical_BPs_TP:contains(spell.name) then
				equip(sets.pet_midcast.Physical_BP_TP)
			elseif buffactive["Aftermath: Lv.3"] then
				equip(sets.pet_midcast.Physical_BP_AM3)
			else
				equip(sets.pet_midcast.Physical_BP)
			end
        end
    end
end

function pet_aftercast(spell)
    idle()
end

function self_command(command)
	IdleModeCommands = S{'DD','Refresh','DT','Favor','PetDT','Zendik'}
	is_valid = false

	if IdleModeCommands:contains(command) then
		IdleMode = command
		is_valid = true
	elseif command:lower()=="accmode" then
		AccMode = AccMode==false
		is_valid = true
		send_command('console_echo "AccMode: '..tostring(AccMode)..'"')
	elseif command:lower()=="impactmode" then
		ImpactDebuff = ImpactDebuff==false
		is_valid = true
		send_command('console_echo "Impact Debuff: '..tostring(ImpactDebuff)..'"')
	elseif command:lower()=="forceilvl" then
		ForceIlvl = ForceIlvl==false
		is_valid = true
		send_command('console_echo "Force iLVL: '..tostring(ForceIlvl)..'"')
	elseif command:lower()=="meleemode" then
		if MeleeMode then
			MeleeMode = false
			enable("main","sub")
			send_command('console_echo "Melee Mode: false"')
		else
			MeleeMode = true
			equip({main="Nirvana",sub="Elan Strap +1"})
			disable("main","sub")
			send_command('console_echo "Melee Mode: true"')
		end
		is_valid = true
	elseif command=="ToggleIdle" then
		is_valid = true
		if IdleMode=="Refresh" then
			IdleMode = "DT"
		elseif IdleMode=="DT" then
			IdleMode = "PetDT"
		else
			IdleMode = "Refresh"
		end
		send_command('console_echo "Perp Mode: ['..IdleMode..']"')
	elseif command:lower()=="lowhp" then
		-- Use for "Cure 500 HP" objectives in Omen
		equip({head="Apogee Crown +1",body="Apogee Dalmatica +1",legs="Apogee Slacks +1",feet="Apogee pumps +1",back="Campestres's Cape"})
		return
	elseif string.sub(command:lower(),1,12)=="meteorstrike" then
		MeteorStrike = string.sub(command,13,13)
		send_command('console_echo "Meteor Strike: '..MeteorStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,8)=="geocrush" then
		Geocrush = string.sub(command,9,9)
		send_command('console_echo "Geocrush: '..Geocrush..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="grandfall" then
		GrandFall = string.sub(command,10,10)
		send_command('console_echo "Grand Fall: '..GrandFall..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="windblade" then
		WindBlade = +string.sub(command,10,10)
		send_command('console_echo "Wind Blade: '..WindBlade..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,14)=="heavenlystrike" then
		HeavenlyStrike = string.sub(command,15,15)
		send_command('console_echo "Heavenly Strike: '..HeavenlyStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,12)=="thunderstorm" then
		Thunderstorm = string.sub(command,13,13)
		send_command('console_echo "Thunderstorm: '..Thunderstorm..'/5"')
		is_valid = true
	elseif command=="TestMode" then
		Test = Test + 1
		if Test==3 then
			Test = 0
		end
		is_valid = true
		send_command('console_echo "Test Mode: '..tostring(Test)..'"')
	end

	if not is_valid then
		send_command('console_echo "gs c {Refresh|DT|DD|PetDT|Favor} {AccMode} {ImpactMode} {MeleeMode}"')
	end
	idle()
end

function idle()
	--if TownIdle:contains(world.area:lower()) then
	--	return
	--end
    if pet.isvalid then
		if IdleMode=='DT' then
			equip(sets.aftercast.Perp_DT)
		elseif string.find(pet.name,'Spirit') then
            equip(sets.aftercast.Spirit)
		elseif IdleMode=='PetDT' then
			if ForceIlvl then
				equip(sets.aftercast.Avatar_DT_Ilvl)
			else
				equip(sets.aftercast.Avatar_DT)
			end
        elseif IdleMode=='Refresh' then
			if player.mpp < 50 then
				equip(sets.aftercast.Perp_RefreshSub50)
			else
				equip(sets.aftercast.Perp_Refresh)
			end
		elseif IdleMode=='Favor' then
			equip(sets.aftercast.Perp_Favor)
		elseif IdleMode=='Zendik' then
			equip(sets.aftercast.Perp_Zendik)
		elseif MeleeMode then
			equip(sets.aftercast.Perp_Melee)
        elseif IdleMode=='DD' then
            equip(sets.aftercast.Perp_DD)
        end
		-- Gaiters if Fleet Wind is up
		if buffactive['Quickening'] and IdleMode~='DT' and not ForceIlvl then
			equip({feet="Herald's Gaiters"})
		end
	else
		if IdleMode=='DT' then
			equip(sets.aftercast.DT)
		elseif MeleeMode and IdleMode=='DD' then
			equip(sets.aftercast.Perp_Melee)
		elseif ForceIlvl then
			equip(sets.aftercast.Idle_Ilvl)
		else
			equip(sets.aftercast.Idle)
		end
    end
	-- Balrahn's Ring
	--if Salvage:contains(world.area) then
	--	equip({ring2="Balrahn's Ring"})
	--end
	-- Maquette Ring
	--if world.area=='Maquette Abdhaljs-Legion' and not IdleMode=='DT' then
	--	equip({ring2="Maquette Ring"})
	--end
end