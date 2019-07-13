-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  
-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('organizer-lib')
end

function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
	add_to_chat (21, 'Loaded Warrior Gearswap')
	add_to_chat (55, 'You are on '..('WAR '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
end

function binds_on_load()
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind f10 gs c cycle WeaponSkillMode')
    send_command('bind f11 gs c cycle HybridMode')
    send_command('bind f12 gs c mainweapon')
    send_command('bind !f9 gs c cycle IdleMode')
    send_command('bind !f10 gs c cycle RangedMode')
    send_command('bind !f12 gs c redproc')

	-- Dual Box Commands --
	send_command('bind numpad0 send Asklepios gs c fullcircle')
	send_command('bind !numpad1 send Asklepios gs c fury')
	send_command('bind !numpad2 send Asklepios gs c barrier')
	send_command('bind !numpad3 send Asklepios gs c dynad')
	send_command('bind !numpad4 send Asklepios gs c attunement')
end
 
function job_setup()
    state.mainweapon = M{['description'] = 'Main Weapon'}
    state.mainweapon:options('Chango', 'Montante', 'Ragnarok', 'Axe')
	state.redproc = M{['description'] = 'Proc Weapon'}
	state.redproc:options('Dagger', 'Sword', 'GreatSword', 'Scythe', 'Polearm', 'Katana', 'GreatKatana', 'Club', 'Staff')
end
 
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal','PDT')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
 
    GreatSwordWeapons = S{
	'Montante +1', 
	'Ragnarok'
	}
	
	GreatAxeWeapons = S{
	'Chango'
	}
	
	DualWieldWeapons = S{
	'Kaja Axe',
	'Kaja Sword'
	}
	
	RedProcWeapons = S{
	'Qutrub knife', 
	'Blizzard Brand', 
	'Claymore', 
	'Lost Sickle', 
	"Tzee Xicu's Blade",
	'Warp Cudgel', 
	'Lamia Staff'
	}
	
	RedProcGKT = S{
	'Zanmato'
	}
	
	RedProcKatana = S{
	'Trainee Burin'
	}
	
	moonshade_WS = S{"Resolution", "Torcleaver", "Savage Blade"}
                 
    update_combat_form()
    set_macros(1,9)
	set_style(35) 
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end
	
	send_command('unbind !numlock')
    send_command('unbind !numpad/')
    send_command('unbind !numpad*')
    send_command('unbind !numpad-')
	send_command('unbind !numpad1')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')
    send_command('unbind numpad0')
	send_command('unbind numpad1')
    send_command('unbind numpad2')
    send_command('unbind numpad3')
    send_command('unbind numpad4')
    send_command('unbind numpad5')
    send_command('unbind numpad6')
    send_command('unbind numpad7')
    send_command('unbind numpad8')
    send_command('unbind numpad9')
end

sets.mainweapon = {}
	sets.mainweapon.Chango = {
        main="Chango",
		sub="Utu Grip"
    }
	sets.mainweapon.Montante = {
        main="Montante +1",
		sub="Utu Grip"
    }
	sets.mainweapon.Ragnarok = {
        main="Ragnarok",
		sub="Utu Grip"
    }
	sets.mainweapon.Axe = {
        main="Kaja Axe",
		sub="Digirbalag"
    }

sets.redproc = {}
	sets.redproc.Dagger = {
        main="Qutrub knife"
    } 
	sets.redproc.Sword = {
        main="Blizzard Brand"
    }
	sets.redproc.GreatSword = {
        main="Claymore"
    } 
	sets.redproc.Scythe = {
        main="Lost Sickle"
    } 
	sets.redproc.Polearm = {
        main="Tzee Xicu's Blade"
    } 
	sets.redproc.Katana = {
        main="Trainee Burin"
    } 
	sets.redproc.GreatKatana = {
        main="Zanmato"
    } 
	sets.redproc.Club = {
        main="Warp Cudgel"
    }
	sets.redproc.Staff = {
        main="Lamia Staff"
    } 
	

function init_gear_sets()
	
	Cichol = {}
	Cichol.Acc = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Cichol.Reso = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Cichol.VitWSD = { name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Cichol.StrWSD = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
	OdysseanHands = {}
	OdysseanHands.WSD = { name="Odyssean Gauntlets", augments={'Attack+6','Weapon skill damage +3%','VIT+14','Accuracy+3',}}
	-- Idle Sets --
    sets.idle = {
        ammo="Staunch Tathlum +1",
		head="Valorous Mask",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +2",
		feet="Hermes' Sandals",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
        ear1="Odnowa Earring +1", 
		ear2="Genmei Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring",
		back=Cichol.Acc ,
    }
	
 
    sets.idle.PDT = {
        ammo="Staunch Tathlum",
        head="Sulevia's Mask +1", 
		body="Sulevia's Platemail +1",
        back="Xucau Mantle", 
		neck="Loricate Torque +1",
        hands="Sulevia's Gauntlets +1", 
		waist="Flume Belt +1",
        legs="Sulevia's Cuisses +1", 
		feet="Hermes' Sandals",
        ring1="Defending Ring", 
		ring2={ name="Dark Ring", augments={'Phys. dmg. taken -5%','Magic dmg. taken -5%',}},
        ear1="Odnowa Earring +1", 
		ear2="Genmei Earring"
	}
 
    sets.idle.Town = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Hermes' Sandals",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
    }
	
	-- Casting --
	sets.precast.FC = {
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Mag. Acc.+19','"Fast Cast"+6','AGI+6','"Mag.Atk.Bns."+3',}},
		body={ name="Odyss. Chestplate", augments={'Mag. Acc.+14','"Fast Cast"+5','"Mag.Atk.Bns."+6',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Arjuna Breeches",
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+4','Mag. Acc.+8',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Weather. Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
	}

	-- Engaged Sets --
	sets.engaged = {}
	sets.engaged.Montante = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	}   
 
    sets.engaged.Montante.MidAcc = set_combine(sets.engaged.Montante, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	})

    sets.engaged.Montante.HighAcc =  set_combine(sets.engaged.Montante, {
		ammo="Seething Bomblet +1",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	})
	
	sets.engaged.Montante.PDT =  set_combine(sets.engaged.Montante, {
		ammo="Staunch Tathlum +1",
		head="Sulevia's Mask +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back=Cichol.Acc,
	})
	
	sets.engaged.Montante.MidAcc.PDT = sets.engaged.Montante.PDT
	sets.engaged.Montante.HighAcc.PDT = sets.engaged.Montante.PDT
	
	sets.engaged.Chango = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	} 
	
    sets.engaged.Chango.MidAcc = set_combine(sets.engaged.Chango, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	})

    sets.engaged.Chango.HighAcc =  set_combine(sets.engaged.Chango, {
		ammo="Seething Bomblet +1",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	})

	sets.engaged.Chango.PDT =  set_combine(sets.engaged.Chango, {
		ammo="Staunch Tathlum +1",
		head="Sulevia's Mask +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back=Cichol.Acc,
	})
	
	sets.engaged.Chango.MidAcc.PDT = sets.engaged.Chango.PDT
	sets.engaged.Chango.HighAcc.PDT = sets.engaged.Chango.PDT
	
	sets.engaged.DW = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Emicho Gauntlets +1",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	}   
 
    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Emicho Gauntlets +1",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	})

    sets.engaged.DW.HighAcc =  set_combine(sets.engaged.DW, {
		ammo="Seething Bomblet +1",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Emicho Gauntlets +1",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	})
	
	sets.engaged.DW.PDT =  set_combine(sets.engaged.DW, {
		ammo="Staunch Tathlum +1",
		head="Sulevia's Mask +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Emicho Gauntlets +1",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back=Cichol.Acc,
	})
	
	sets.engaged.DW.MidAcc.PDT = sets.engaged.DW.PDT
	sets.engaged.DW.HighAcc.PDT = sets.engaged.DW.PDT
	
	
	-- RedProc Sets --
	sets.engaged.RedProc = set_combine(sets.engaged.Montante, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+30','"Dbl.Atk."+5','Attack+6',}},
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Acc,
	})
	
	sets.engaged.GKT = set_combine(sets.engaged.Montante, {
		head="Kengo hachimaki",
		neck="Agelast torque"
	})
	
	sets.engaged.Katana = set_combine(sets.engaged.Montante, {
		neck="Yarak torque",
		left_ear="Trux Earring"
	})
    
	-- Weaponskill Sets --
    sets.precast.WS = {
		ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",
		body={ name="Argosy Hauberk +1", augments={'STR+12','Attack+20','"Store TP"+6',}},
		hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Reso
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {}
	)
	
	sets.precast.WS['Resolution'] = {
		ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		legs="Argosy Breeches +1",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.Reso,
    }
	
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3"
	})
	
	sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS, {
	})
	
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS['Resolution'], {}
	)
	
    sets.precast.WS['Decimation'].Acc = set_combine(sets.precast.WS['Decimation'], {
		legs="Pumm. Cuisses +3"
	})
	
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS['Resolution'], {}
	)
	
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS['Resolution'].Acc, {}
	)
	
	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS['Resolution'], {}
	)
	
    sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS['Resolution'].Acc, {}
	)
	
	sets.precast.WS['Upheaval'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands=OdysseanHands.WSD,
		legs="Pumm. Cuisses +3",
		feet="Sulev. Leggings +2",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.VitWSD,
    }
	
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS['Upheaval'], {}
	)
	
	sets.precast.WS['Upheaval'].MS = set_combine(sets.precast.WS['Upheaval'], {}
	)
	
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS['Upheaval'], {
		hands="Argosy Mufflers +1",
		back=Cichol.StrWSD,
	})
	
	sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS['Upheaval'], {}
	)
	
	sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS['Upheaval'], {}
    )
	
    sets.precast.WS['Mistral Axe'].Acc = set_combine(sets.precast.WS['Upheaval'].Acc, {}
	)
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Upheaval'], {}
    )
	
    sets.precast.WS['Mistral Axe'].Acc = set_combine(sets.precast.WS['Upheaval'].Acc, {}
	)
	
	sets.precast.WS['Full Break'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="War. Beads +2",
		waist="Fotia Belt",
		left_ear="Digni. Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.StrWSD,
	})
	
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS['Full Break'], {}
	)
	
	sets.precast.WS['Shield Break'] = set_combine(sets.precast.WS['Full Break'], {}
	)
	
	sets.precast.WS['Weapon Break'] = set_combine(sets.precast.WS['Full Break'], {}
	)
	
	-- Proc Sets --
	sets.precast.WS['Tachi: Koki'] = {
		head="Kengo hachimaki",
		neck="Agelast torque"
	}
	
	sets.precast.WS['Blade: Ei'] = {
		neck="Yarak torque",
		left_ear="Trux Earring"
	}
	
	-- Job Ability Sets --
	sets.precast.JA['Berserk'] = {feet="Agoge Calligae +3", body="Pummeler's Lorica +3", back="Cichol's Mantle"}
    sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +3",head="Pummeler's Mask +2"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1"}
    sets.precast.JA['Retaliation'] = {feet="Boii Calligae +1",hands="Pummeler's Mufflers +1"}
    sets.precast.JA['Restraint'] = {hands="Boii Mufflers +1"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +3"}
    sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +1"}
	sets.precast.JA['Tomahawk'] = set_combine(sets.precast.JA, {ammo="Thr. Tomahawk",feet="Agoge Calligae +3"})
    sets.precast.JA['Provoke'] = {
        head="Pummeler's Mask +1", 
		body="Souveran Cuirass",
        back="Reiki Cloak", 
		neck="Unmoving Collar +1",
        hands="Pummeler's Mufflers +1", 
		waist="Trance Belt",
        legs="Odyssean Cuisses", 
		feet="Souveran Schuhs",
        Ring1="Petrov Ring", 
		Ring2="Apeile Ring",
        ear1="Enchanter Earring +1", 
		ear2="Gwati Earring"
    }
	
	sets.MS = {}

end

function job_precast(spell, action, spellMap, eventArgs)
	if player.tp >= 1000 and player.target and player.target.type == 'MONSTER' and player.target.distance > (3.2 + player.target.model_size) and spell.type == 'WeaponSkill' then
		cancel_spell()
			add_to_chat(3, spell.name..' Canceled: [Out of Range]')
			send_command('gs c update')
			return
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
end

function job_state_change(field, new_value, old_value)
end

function display_current_job_state(eventArgs)
local msg = 'Melee'
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
end

function requip_gear(eventArgs)
	if player.equipment.main == 'empty' and player.equipment.sub == 'empty' then
		enable('main','sub')
        equip(sets.mainweapon[state.mainweapon.value])	
        disable('main','sub')
	end
end

function job_update(cmdParams, eventArgs)
    update_combat_form()
end

function update_combat_form()
    if  GreatSwordWeapons:contains(player.equipment.main) then
        state.CombatForm:set('Montante')
	elseif  
		GreatAxeWeapons:contains(player.equipment.main) then
        state.CombatForm:set('Chango')
	elseif
		DualWieldWeapons:contains(player.equipment.main) then
        state.CombatForm:set('DW')
    elseif 
		RedProcWeapons:contains(player.equipment.main) then
        state.CombatForm:set('RedProc')
    elseif 
		RedProcGKT:contains(player.equipment.main) then
        state.CombatForm:set('GKT')
    elseif 
		RedProcKatana:contains(player.equipment.main) then
        state.CombatForm:set('Katana')
    else
        state.CombatForm:reset()
    end
end
 
function job_self_command(cmdParams, eventArgs)
    command = cmdParams[1]:lower()
	if command == 'mainweapon' then
        enable('main','sub')
        mainswap=1
        send_command('gs c cycle mainweapon')
		send_command('gs c update')
    end
	if command == 'redproc' then
        enable('main','sub')
        redprocswap=1
        send_command('gs c cycle redproc')
		send_command('gs c update')
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if player.tp < 2250 and spell.type == 'WeaponSkill' and player.equipment.main == "Chango" then
		equip({left_ear="Moonshade Earring"})
	elseif player.tp < 2750 and spell.type == 'WeaponSkill' then
		equip({left_ear="Moonshade Earring"})
	end
    if (world.time >= (17*60) or world.time < (7*60)) and spell.type == 'WeaponSkill' and player.tp > 2950 then
        equip({left_ear="Lugra Earring +1"})
    end
    if buffactive['Mighty Strikes'] then 
		if sets.precast.WS[spell] then
			equipSet = sets.precast.WS[spell]
			equipSet = set_combine(equipSet,sets.MS)
			equip(equipSet)
		else
			equipSet = sets.precast.WS
			equipSet = set_combine(equipSet,sets.MS)
			equip(equipSet)
		end
	end
end
 
function customize_idle_set(idleSet)
    if mainswap == 1 then
        mainswap=0
        enable('main', 'sub')
        equip(sets.mainweapon[state.mainweapon.value])
        disable('main','sub')
    end
	if redprocswap == 1 then
        redprocswap=0
        enable('main','sub')
        equip(sets.redproc[state.redproc.value])
        disable('main','sub')
    end
    if state.Buff.Doom or state.Buff.Curse then
        return set_combine(idleSet, sets.Doom)
    else
        return idleSet
    end
end
 
function customize_melee_set(meleeSet)
    if mainswap == 1 then
        mainswap=0
        enable('main','sub')
        equip(sets.mainweapon[state.mainweapon.value])	
        disable('main','sub')
    end
	if redprocswap == 1 then
        redprocswap=0
        enable('main','sub')
        equip(sets.redproc[state.redproc.value])
        disable('main','sub')
    end
    if state.Buff.Aftermath then
        return set_combine(meleeSet, sets.Aftermath)
    end
    if state.Buff.Doom then
        return set_combine(meleeSet, sets.Doom)
    end
    if state.Buff.Curse then
        return set_combine(meleeSet, sets.Curse)
    else
        return meleeSet
    end
end