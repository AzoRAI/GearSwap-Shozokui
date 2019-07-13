-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Magic Burst Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Full Circle
--              [ CTRL+B ]          Blaze of Glory
--              [ CTRL+A ]          Ecliptic Attrition
--              [ CTRL+D ]          Dematerialize
--              [ CTRL+L ]          Life Cycle
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


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
	add_to_chat (21, 'Loaded Geomancer Gearswap')
	add_to_chat (55, 'You are on '..('GEO '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')

    -- Additional local binds

    send_command('bind ^` input /ja "Full Circle" <me>')
    send_command('bind ^b input /ja "Blaze of Glory" <me>')
    send_command('bind ^a input /ja "Ecliptic Attrition" <me>')
    send_command('bind ^d input /ja "Dematerialize" <me>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')

    set_macros(1,7)
    set_style(1)
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind ^b')
    send_command('unbind ^b')
    send_command('unbind ^a')
    send_command('unbind ^d')
    send_command('unbind @c')
	send_command('unbind @w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

	Nantosuelta = {}
	Nantosuelta.Pet = { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
	Nantosuelta.Cure = { name="Nantosuelta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Pet: "Regen"+5',}}
	Nantosuelta.Enf = { name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Pet: "Regen"+5',}}

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1 +1"}
    sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +2", back="Nantosuelta's Cape"}

    -- Fast cast sets for spells

    sets.precast.FC = {
    --  /RDM --15
        ammo="Staunch Tathlum", --3
        head="Merlinic Hood", --5
        body="Merlinic Jubbah", --11
        hands="Merlinic Dastanas", --5
        legs="Geomancy Pants +3", --11
        feet="Merlinic Crackows", --7
        neck="Voltsurge Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Etiolation Earring", --1
        ring1="Kishar Ring", --4
        ring2="Weather. Ring", --5
        back=Nantosuelta.Enf, --10
        waist="Witful Belt", --3/(2)
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        back="Perimede Cape",
        })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        hands="Bagua Mitaines +1",
        waist="Channeler's Stone",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        main="Oranyan", --7
        sub="Clerisy Strap +1", --3
        ear1="Mendi. Earring", --5
        ring1="Lebeche Ring", --(2)
        back="Perimede Cape", --(4)
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Jhakri Coronal +2",
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


    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
		main="Idris",
		sub="Genmei Shield",
        head="Amalric Coif",
        hands="Merlinic Dastanas",
        legs="Geo. Pants +2",
        feet="Regal Pumps +1",
        ear1="Loquacious Earring",
        ear2="Etiolation Earring",
        ring1="Kishar Ring",
        back="Lifestream Cape",
        } -- Haste

   sets.midcast.Geomancy = {
		main="Idris",
		sub="Genmei Shield",
        ammo="Staunch Tathlum", --5/0
        head="Azimuth Hood +1", --0/2
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +3", --12/0
        legs="Geomancy Pants +3", --0/0
        feet="Geo. Sandals",
        ear1="Handler's Earring", --3*/0
        ear2="Handler's Earring +1", --4*/0
		ring1="Vocane ring", --7/7
        ring2="Defending Ring", --10/10
        back=Nantosuelta.Pet,
        waist="Isa Belt" --3/1
        }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        hands="Geo. Mitaines +3",
        legs="Bagua Pants +1",
        })

    sets.midcast.Cure = {
		main="Idris",
		sub="Sors Shield",
		head="Vanya hood",
        body="Vanya Robe",
        hands="Telchine Gloves", --10
        legs="Vanya Slops", --10
        feet="Vanya clogs",
        neck="Incanter's Torque",
        ear1="Mendi. Earring", --5
        ear2="Loquacious Earring",
        ring1="Lebeche Ring", --3/(-5)
        ring2="Haoma's Ring",
        back=Nantosuelta.Cure,
        waist="Bishop's Sash",
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring1="Levia. Ring +1",
        ring2="Levia. Ring +1",
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
        body="Telchine Chas.",
        })

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        head="Amalric Coif",
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        head="Amalric Coif",
        waist="Emphatikos Rope",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring1="Sheltered Ring",
        })
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect


    sets.midcast.MndEnfeebles = {
		main="Idris",
		sub="Ammurapi Shield",
        head="Geo. Galero +2",
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +3",
        legs="Geomancy Pants +3",
        feet="Geo. Sandals +2",
        neck="Erra Pendant",
        ear1="Lempo Earring",
        ear2="Regal Earring",
        ring1="Kishar Ring",
        ring2="Stikini Ring",
        back=Nantosuelta.Enf,
        waist="Luminary Sash",
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        back=Nantosuelta.Enf,
        })

    sets.midcast['Dark Magic'] = {
        head="Merlinic Hood",
        body="Jhakri Robe +2",
        hands="Ea Cuffs",
        legs="Azimuth Tights +1",
        feet="Merlinic Crackows",
        neck="Erra Pendant",
        ear1="Barkaro. Earring",
        ear2="Regal Earring",
        ring1="Evanescence Ring",
        ring2="Stikini Ring",
        back="Perimede Cape",
        waist="Luminary Sash",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Bagua Galero +1",
        feet="Merlinic Crackows",
        ear1="Hirudinea Earring",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        feet="Regal Pumps +1"
        })

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Mizu. Kubikazari",
		waist="Austerity Belt",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back=Nantosuelta.Enf,
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        feet="Jhakri Pigaches +2",
        neck="Erra Pendant",
        back="Aurist's Cape +1",
        waist="Yamabuki-no-Obi",
        })

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {
        ring1="Fenrir Ring +1",
        ring2="Fenrir Ring +1",
        })

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        body="Seidr Cotehardie",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        })

    sets.midcast.GeoElem.Seidr = set_combine(sets.midcast['Elemental Magic'].Seidr, {
        body="Seidr Cotehardie",
        neck="Erra Pendant",
        ring1="Fenrir Ring +1",
        ring2="Fenrir Ring +1",
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak",
        ring2="Archon Ring",
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		main="Idris",
		sub="Genmei Shield",
        ammo="Staunch Tathlum",
        head="Azimuth hood",
        body="Jhakri Robe +2",
        hands="Bagua Mitaines +1",
        legs="Assid. Pants +1",
        feet="Geo. Sandals +2",
        neck="Loricate Torque +1",
        ear1="Genmei Earring",
        ear2="Infused Earring",
		ring1="Vocane ring", --7/7
        ring2="Defending Ring", --10/10
        back=Nantosuelta.Pet,
        waist="Austerity Belt",
        }

    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
        })

    sets.idle.DT = set_combine(sets.idle, {
		main="Idris",
		sub="Genmei Shield",
        head="Azimuth Hood +1", --0/2
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +3", --12/0
        legs="Geomancy Pants +3", --0/0
        feet="Geo. Sandals +2", --0/2
        ear1="Handler's Earring", --3*/0
        ear2="Handler's Earring +1", --4*/0
		ring1="Vocane ring", --7/7
        ring2="Defending Ring", --10/10
        back=Nantosuelta.Pet,
        waist="Isa Belt" --3/1
        })

    sets.idle.Weak = sets.idle.DT

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        -- Pet: -DT (37.5% to cap) / Pet: Regen
		main="Idris",
		sub="Genmei Shield",
        ammo="Staunch Tathlum",
        head="Azimuth Hood +1", --0/2
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +3", --12/0
        legs="Telchine Braconi", --0/0
        feet="Bagua Sandals +2", --0/2
        ear1="Handler's Earring", --3*/0
        ear2="Handler's Earring +1", --4*/0
		ring1="Vocane ring", --7/7
        ring2="Defending Ring", --10/10
        back=Nantosuelta.Pet,
        waist="Isa Belt" --3/1
        })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        body="Mallquis Saio +1", --6/6
        legs="Psycloth Lappas", --4/0
        neck="Loricate Torque +1", --6/6
        ring1="Vocane ring", --7/(-1)
        ring2="Defending Ring", --10/10
        back="Moonbeam Cape", --5/5
        })

    -- .Indi sets are for when an Indi-spell is active.
--    sets.idle.Indi = set_combine(sets.idle, {legs="Bagua Pants +1"})
--    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants +1"})
--    sets.idle.DT.Indi = set_combine(sets.idle.DT, {legs="Bagua Pants +1"})
--    sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {legs="Bagua Pants +1"})

    sets.idle.Town = set_combine(sets.idle, {
		main="Idris",
		sub="Genmei Shield",
        ammo="Staunch Tathlum",
        head="Azimuth Hood +1", --0/2
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +3", --12/0
        legs="Geomancy Pants +3", --0/0
        feet=" Bagua Sandals +2", --0/2
        ear1="Handler's Earring", --3*/0
        ear2="Handler's Earring +1", --4*/0
		ring1="Vocane ring", --7/7
        ring2="Defending Ring", --10/10
        back=Nantosuelta.Pet,
        waist="Isa Belt" --3/1
        })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {
        feet="Geo. Sandals +1"
        }

    sets.latent_refresh = {
        waist="Fucho-no-obi"
        }

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        feet="Jhakri Pigaches +2",
        neck="Combatant's Torque",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Chirich Ring",
        ring2="Hetairoi Ring",
        back="Relucent Cape",
        waist="Windbuffet Belt +1",
        }


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = {
        body="Merlinic Jubbah", --10
        hands="Amalric Gages +1", --(6)
        feet="Merlinic Crackows", --11
        neck="Mizu. Kubikazari", --10
        ring1="Mujin Band", --(5)
        back="Seshaw Cape", --5
        }

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            --send_command('@timers d "'..indi_timer..'"')
            --indi_timer = spell.english
            --send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.skill == 'Elemental Magic' then
 --           state.MagicBurst:reset()
        end
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
  local cmd = cmdParams[1];
  if cmd == "travel" then
    equip({ left_ring="Dim. Ring (Dem)", right_ring="Warp Ring" })
  end

  if cmdParams[1]:lower() == 'nuke' then
      handle_nuking(cmdParams)
      eventArgs.handled = true
  end
end
