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
	add_to_chat (21, 'Loaded Samurai Gearswap')
	add_to_chat (55, 'You are on '..('SAM '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
end

function binds_on_load()
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind f10 gs c cycle WeaponSkillMode')
    send_command('bind f11 gs c cycle HybridMode')
    send_command('bind f12 gs c mainweapon')
    send_command('bind !f9 gs c cycle IdleMode')
    send_command('bind !f10 gs c cycle RangedMode')
    send_command('bind !f12 gs c cycle Kiting')
	
	-- Dual Box Commands --
	send_command('bind numpad0 send Asklepios gs c fullcircle')
	send_command('bind !numpad1 send Asklepios gs c fury')
	send_command('bind !numpad2 send Asklepios gs c barrier')
	send_command('bind !numpad3 send Asklepios gs c dynad')
	send_command('bind !numpad4 send Asklepios gs c attunement')
	send_command('bind !numpad5 send Asklepios gs c fury/frailty')
end
 
function job_setup()
    state.mainweapon = M{['description'] = 'Main Weapon'}
    state.mainweapon:options('Masamune', 'Dojikiri')
end
 
function user_setup()	
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'Zanshin')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal','PDT')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
 
    SamWeapons = S{'Masamune', 'Dojikiri Yasutsuna'}
                 
    update_combat_form()
    set_macros(1,2)
	set_style(40) 
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
	sets.mainweapon.Masamune = {
        main="Masamune",
        sub="Utu Grip"
    }
	
	sets.mainweapon.Dojikiri = {
        main="Dojikiri Yasutsuna",
        sub="Utu Grip"
    }


function init_gear_sets()
	
	Smertrios = {}
	Smertrios.Acc = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Smertrios.WSD = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
	ValorousMask = {}
	ValorousMask.WSD = { name="Valorous Mask", augments={'Attack+11','Weapon skill damage +4%','STR+15','Accuracy+6',}}
	
	ValorousMitts = {}
	ValorousMitts.WSD = { name="Valorous Mitts", augments={'Mag. Acc.+1','Weapon skill damage +3%','STR+15','Accuracy+14','Attack+3',}}
	
	ValorousGreaves = {}
	ValorousGreaves.WSD = { name="Valorous Greaves", augments={'Attack+3','Weapon skill damage +4%','STR+12','Accuracy+4',}}
	
	
	-- Idle Sets --
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Wakido kabuto +3",
		body="Wakido domaru +3",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring",
		back=Smertrios.Acc,
    }
 
    sets.idle.PDT = {
		ammo="Staunch Tathlum +1",
		head="Flam. Zucchetto +2",
		body="Wakido domaru +3",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring",
		back=Smertrios.Acc,
	}
 
    sets.idle.Town = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ryuo Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Windbuffet Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Smertrios.Acc,
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
	sets.engaged.Masamune = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ryuo Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Windbuffet Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Smertrios.Acc,
	}
	
	sets.engaged.Masamune.MidAcc = set_combine(sets.engaged.Masamune, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ryuo Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Windbuffet Belt +1",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Smertrios.Acc,
	})
	
	sets.engaged.Masamune.HighAcc = set_combine(sets.engaged.Masamune, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back=Smertrios.Acc,
	})
	
	sets.engaged.Masamune.Zanshin = set_combine(sets.engaged.Masamune, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +1",
		hands="Wakido Kote +3",
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		feet="Flamma gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Flamma Ring",
		back=Smertrios.Acc,
	})
	
	sets.engaged.Masamune.PDT = set_combine(sets.engaged.Masamune, {
		ammo="Staunch Tathlum +1",
		head="Flam. Zucchetto +2",
		body="Wakido domaru +3",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=Smertrios.Acc,
	})
	
	sets.engaged.Masamune.MidAcc.PDT = sets.engaged.Masamune.PDT
	sets.engaged.Masamune.HighAcc.PDT = sets.engaged.Masamune.PDT
	
	sets.precast.WS = {
		ammo="Knobkierrie",
		head=ValorousMask.WSD,
		body="Sakonji domaru +3",
		hands=ValorousMitts.WSD,
		legs="Wakido Haidate +3",
		feet=ValorousGreaves.WSD,
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Brutal Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back=Smertrios.WSD,
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	})
	
	sets.precast.WS.Shoha = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Sakonji domaru +3",
		hands=ValorousMitts.WSD,
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Flamma Ring",
		back=Smertrios.WSD,
	}
	
	sets.precast.WS.Ageha = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Digni. Earring",
		right_ear="Brutal Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Flamma Ring",
		back=Smertrios.WSD,
	}
			
	sets.engaged.Ranged = {
		head="Sakonji Kabuto +3",
		body="Ken. Samue +1",
		hands="Ken. Tekko",
        legs="Wakido Haidate +3",
		--legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate",
		neck="Combatant's Torque",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back=Smertrios.WSD,
	}
	
	sets.engaged.Reraise = set_combine(sets.engaged,{
		body="Twilight Mail",
		head="Twilight Helm"}
	)
	
	--Job Ability Sets--
	sets.precast.WS['Namas Arrow'] = set_combine(sets.ranged, {
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		legs="Wakido Haidate +3",
	})
	
	sets.precast.WS['Apex Arrow'] = sets.precast.WS['Namas Arrow']
	sets.precast.WS["Tachi: Jinpu"] = sets.precast.WS.magic
	sets.precast.WS["Tachi: Goten"] = sets.precast.WS.magic
	sets.precast.WS["Tachi: Koki"] = sets.precast.WS.magic
	sets.precast.WS["Earth Crusher"] = sets.precast.WS.magic
	
	sets.precast.JA.Meditate = set_combine(sets.precast.JA, {
		back="Smertrios's Mantle",
		hands="Sakonji Kote +3",
		head="Wakido Kabuto +3"
	})
	
	sets.precast.JA['Warding Circle'] = set_combine(sets.precast.JA, {head="Wakido Kabuto +3"})
	sets.precast.JA['Sekkanoki'] = set_combine(sets.precast.JA, {})
	sets.precast.JA['Konzen-ittai'] = set_combine(sets.precast.JA, {})
	sets.precast.JA['Blade Bash'] = set_combine(sets.precast.JA, {hands="Sakonji Kote +3"})
	sets.precast.JA['Meikyo Shisui'] = set_combine(sets.precast.JA, {})
	sets.precast.JA['Hasso'] = set_combine(sets.precast.JA, {})
	sets.precast.JA['Sengikori'] = set_combine(sets.precast.JA, {})

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
    if  SamWeapons:contains(player.equipment.main) then
        state.CombatForm:set('Masamune')
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
end
 
moonshade_WS = S{"Resolution", "Torcleaver", "Savage Blade"}
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if world.time >= (17*60) or world.time <= (7*60) then
            equip({ear1="Lugra Earring +1",ear2="Lugra Earring"})
        end
        if moonshade_WS:contains(spell.english) and player.tp<2950 then  
            equip({ear2="Moonshade Earring"})
        end
        if buffactive['Mighty Strikes'] then 
            if sets.precast.WS[spell] then
                equipSet = sets.precast.WS[spell]
                equipSet = set_combine(equipSet,sets.MS_WS)
                equip(equipSet)
            else
                equipSet = sets.precast.WS
                equipSet = set_combine(equipSet,sets.MS_WS)
                equip(equipSet)
            end
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
	requip_gear()
	
    if player.mpp < 51 then
        return set_combine(idleSet, sets.latent_refresh)
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
	requip_gear()

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