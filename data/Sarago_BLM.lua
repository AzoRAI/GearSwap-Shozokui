-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:
        
        Magic Burst            Toggle Magic Burst Mode  [Alt-`]
        Death Mode            Casting and Idle modes that maximize MP pool throughout precast/midcast/idle swaps
        Capacity Pts. Mode    Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle        Automatically locks desired equipset on file load
--]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
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
	add_to_chat (21, 'Loaded Black Mage Gearswap')
	add_to_chat (55, 'You are on '..('BLM '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.CP = M(false, "Capacity Points Mode")
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Spaekona', 'Occult')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')    
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}
    
    -- Additional local binds
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind f10 gs c cycle CastingMode')
	send_command('bind f11 gs c cycle IdleMode')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @d gs c toggle DeathMode')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')

    set_macros(1,8)
    set_style(17)
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @d')
    send_command('unbind @c')
    send_command('unbind @w')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	MerlinicHood = {}
	MerlinicHood.FC = { name="Merlinic Hood", augments={'Attack+12','"Fast Cast"+7','MND+5',}}
	MerlinicHood.MAB = { name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+6%','MND+9','Mag. Acc.+15',}}
	
	MerlinicDastanas = {}
	MerlinicDastanas.FC = { name="Merlinic Dastanas",  augments={'"Fast Cast"+6','Mag. Acc.+9','"Mag.Atk.Bns."+1',}}
	
	MerlinicCrackows = {}
	MerlinicCrackows.FC = { name="Merlinic Crackows", augments={'Mag. Acc.+20','"Fast Cast"+6','CHR+4',}}
	MerlinicCrackows.MAB = { name="Merlinic Crackows",augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Magic burst dmg.+10%','AGI+6','Mag. Acc.+6','"Mag.Atk.Bns."+4',}}
	
	
	
	-- Idle sets
    sets.idle = {
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        body="Jhakri Robe +2",
        legs="Assid. Pants +1",
        feet="Herald's Gaiters",
        ear1="Genmei Earring",
        ear2="Infused Earring",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back="Solemnity Cape",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        body="Mallquis Saio +2", --6/6
        neck="Loricate Torque +1", --6/6
        ear1="Genmei Earring", --2/0
        ring1="Defending Ring", --10/10
		ring2="Gelatinous Ring +1", --7/(-1)
		back="Solemnity Cape",
    })

    sets.idle.ManaWall = {
        feet="Wicce Sabots +1",
    }

    sets.idle.DeathMode = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        feet="Merlinic Crackows",
        neck="Sanctity Necklace",
        ear1="Barkaro. Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring +1",
        ring2="Mephitas's Ring",
        back=gear.BLM_Death_Cape,
        waist="Shinjutsu-no-Obi +1",
    }

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Pemphredo Tathlum",
        head="Ea Hat +1",
        body="Merlinic Jubbah",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        feet=MerlinicCrackows.MAB,
        neck="Mizu. Kubikazari",
        ear1="Friomisi Earring",
        ear2="Barkarole earring",
        ring1="Shiva ring +1",
        ring2="Mujin Band",
        back="Taranus's Cape",
        waist="Eschan Stone",
    })

    sets.idle.Weak = sets.idle.DT
	
    ---- Precast Sets ----
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=MerlinicHood.FC, --15
        body="Anhur Robe", --10
        hands=MerlinicDastanas.FC, --7
        legs="Psycloth Lappas", --7
        feet=MerlinicCrackows.FC, --7
        neck="Voltsurge Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Etiolation Earring", --1
        ring1="Kishar Ring", -- +4
		ring2="Weather. Ring", --5/(3)
        back="Perimede Cape", --0
        waist="Witful Belt", --3/(2)
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        back="Perimede Cape",
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        ear1="Mendi. Earring", --5
        ring1="Lebeche Ring", --(2)
        back="Perimede Cape", --(4)
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    
    sets.precast.FC.DeathMode = {
        ammo="Ghastly Tathlum +1",
        head="Amalric Coif", --10
        body="Amalric Doublet",
        hands="Merlinic Dastanas", --6
        legs="Psycloth Lappas", --7
        feet="Regal Pumps +1", --7
        neck="Orunmila's Torque", --5
        ear1="Etiolation Earring", --1
        ear2="Loquacious Earring", --2
        ring1="Kishar Ring", -- +4
		ring2="Weather. Ring", --5/(3)
        back="Bane Cape", --4
        waist="Witful Belt", --3/(2)
    }

    sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {head=empty, body="Twilight Cloak"})

    -- Weaponskill sets
    sets.precast.WS = {
        ammo="Floestone",
        head="Jhakri Coronal +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Telchine Braconi",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring1="Rufescent Ring",
        ring2="Shukuyu Ring",
        back="Relucent Cape",
        waist="Fotia Belt",
    }

    sets.precast.WS['Vidohunir'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet",
        hands="Amalric Gages +1",
        legs=gear.Merlinic_MB_legs,
        feet="Merlinic Crackows",
        neck="Imbodla Necklace",
        ear1="Barkaro. Earring",
        ear2="Moonshade Earring",
        ring1="Shiva Ring +1",
        ring2="Archon Ring",
        back=gear.BLM_MAB_Cape,
        waist="Yamabuki-no-Obi",
    } -- INT

    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Weather. Robe +1",
        hands="Telchine Gloves",
        legs="Amalric Slops",
        feet="Medium's Sabots",
        neck="Orunmila's Torque",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        ring1="Mephitas's Ring +1",
        ring2="Mephitas's Ring",
        back="Bane Cape",
        waist="Shinjutsu-no-Obi +1",
    } -- Max MP

    
    ---- Midcast Sets ----
    sets.midcast.FastRecast = {
        head="Amalric Coif",
        hands="Merlinic Dastanas",
        legs=gear.Merlinic_MB_legs,
        feet="Regal Pumps +1",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        ring1="Kishar Ring",
        back=gear.BLM_FC_Cape,
        waist="Witful Belt",
    } -- Haste

    sets.midcast.Cure = {
        ammo="Esper Stone +1", --0/(-5)
        body="Vanya Robe",
        hands="Telchine Gloves", --10
        legs="Gyve Trousers", --10
        feet="Medium's Sabots", --12
        neck="Nodens Gorget", --5
        ear1="Mendi. Earring", --5
        ear2="Roundel Earring", --5
        ring1="Lebeche Ring", --3/(-5)
        ring2="Haoma's Ring",
        back="Oretan. Cape +1", --6
        waist="Bishop's Sash",
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring1="Levia. Ring +1",
        ring2="Levia. Ring +1",
        waist="Luminary Sash",
    })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        head="Vanya Hood",
        body="Vanya Robe",
        hands="Hieros Mittens",
        feet="Vanya Clogs",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        ear2="Healing Earring",
        ring1="Haoma's Ring",
        ring2="Haoma's Ring",
    })

    sets.midcast['Enhancing Magic'] = {
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        neck="Incanter's Torque",
        ear1="Augment. Earring",
        ear2="Andoaa Earring",
        ring1="Stikini Ring",
        ring2="Stikini Ring",
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
    }

    sets.midcast.EnhancingDuration = {
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main="Bolelabunga",
        sub="Genmei Shield",
        body="Telchine Chas.",
    })
    
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        head="Amalric Coif",
        waist="Gishdubar Sash",
    })
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        main="Vadose Rod",
        head="Amalric Coif",
        waist="Emphatikos Rope",
    })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, { ring1="Sheltered Ring" })
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
        head=MerlinicHood.MAB,
        feet="Skaoi Boots",
        neck="Erra Pendant",
        ear1="Barkaro. Earring",
        ear2="Dignitary's Earring",
        ring1="Kishar Ring",
        ring2="Stikini Ring",
    } 

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Pemphredo Tathlum",
    }) 
        
    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
        head=MerlinicHood.MAB,
        body="Jhakri Robe +2",
        legs=gear.Merlinic_MAcc_legs,
        feet="Merlinic Crackows",
        neck="Erra Pendant",
        ear1="Barkaro. Earring",
        ear2="Dignitary's Earring",
        ring1="Stikini Ring",
        ring2="Stikini Ring",
        back=gear.BLM_MAB_Cape,
        waist="Luminary Sash",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        feet="Merlinic Crackows",
		neck="Erra Pendent",
        ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
    })

    sets.midcast.Death = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Merlinic Jubbah", --10
        legs="Amalric Slops +1",
        feet="Merlinic Crackows", --11
        neck="Mizu. Kubikazari", --10
        ear1="Barkaro. Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring +1",
        back=gear.BLM_Death_Cape, --5
        waist="Yamabuki-no-Obi",
    }

    sets.midcast.Death.Occult = set_combine(sets.midcast.Death, {
        sub="Bloodrain Strap",
        head="Mallquis Chapeau +1",
        legs="Perdition Slops",
        feet="Battlecast Gaiters",
        neck="Seraphic Ampulla",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Petrov Ring",
        ring2="Apate Ring",
        waist="Oneiros Rope",
    })

    -- Elemental Magic sets
    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Ea Hat +1",
        body="Merlinic Jubbah",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        feet=MerlinicCrackows.MAB,
        neck="Mizu. Kubikazari",
        ear1="Friomisi Earring",
        ear2="Barkarole earring",
        ring1="Shiva ring +1",
        ring2="Mujin Band",
        back="Taranus's Cape",
        waist="Eschan Stone",
    }

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Ghastly Tathlum +1",
        legs="Amalric Slops",
		feet="Jhakri Pigaches +2",
        neck="Erra Pendant",
        back=gear.BLM_Death_Cape,
    })
            
    sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
        body="Spaekona's Coat +2",
    })

    sets.midcast['Elemental Magic'].Occult = set_combine(sets.midcast['Elemental Magic'], {
        head="Mallquis Chapeau +1",
        legs="Perdition Slops",
        feet="Battlecast Gaiters",
        neck="Seraphic Ampulla",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Petrov Ring",
        ring2="Apate Ring",
        waist="Oneiros Rope",
    })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak",
        ring2="Archon Ring",
    })

    sets.midcast.Impact.Occult = set_combine(sets.midcast.Impact, {
        legs="Perdition Slops",
        feet="Battlecast Gaiters",
        neck="Seraphic Ampulla",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Petrov Ring",
        ring2="Apate Ring",
        waist="Oneiros Rope",
    })
      
    -- Defense sets
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.magic_burst = { 
        body="Merlinic Jubbah", --10
        feet="Merlinic Crackows", --11
        neck="Mizu. Kubikazari", --10
        ring1="Mujin Band", --(5)
    }

    -- Engaged sets
    sets.engaged = {
        ammo="Jukukik feather",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        ear1="Steelflash Earring",
        ear2="Bladeborn earring",
        ring1="Rajas Ring",
        ring2="Apate Ring",
        back="Taranus's Cape",
        waist="Eschan Stone",
    }
		
	--Job Ability Sets--
    sets.precast.JA['Mana Wall'] = { feet="Wicce Sabots +1"}
    sets.precast.JA.Manafont = {body="Arch. Coat"}
	
    sets.buff.Doom = {ring1="Saida Ring", ring2="Saida Ring", waist="Gishdubar Sash"}
    sets.DarkAffinity = {head="Pixie Hairpin +1",ring2="Archon Ring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end

    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)        
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            --if state.CastingMode.value == "Resistant" then
                --equip(sets.magic_burst.Resistant)
            --else
                equip(sets.magic_burst)
            --end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end 
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
        end
    end

    if buff == "doom" then
        if gain then           
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- latent DT set auto equip on HP% change
    windower.register_event('hpp change', function(new, old)
        if new<=25 then
            equip(sets.latent_dt)
        end
    end)


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end

    return defenseSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 10')
end