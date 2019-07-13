-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'TH')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'TH')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------


    -- Resting sets
	sets.resting = {}

    -- Idle
	sets.idle = {
    main={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},
    sub={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},
    ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+4','Attack+4',}},
    neck="Ainia Collar",
    waist="Chiner's Belt +1",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back="Bleating Mantle",
	}
  sets.idle.TH = {
    main="Thief's Knife",
    sub="Sandung",
  }



    -- Engaged
  sets.engaged = {
    main={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},
    sub={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},
    ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+17','"Triple Atk."+4','Attack+4',}},
    neck="Ainia Collar",
    waist="Chiner's Belt +1",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back="Bleating Mantle",
	}


	sets.engaged.TH = set_combine(sets.engaged, {
    main="Sandung",
    sub="Thief's Knife",
		hands="Plunderer's armlets"
	})


	-- Weaponskill sets
  sets.precast.WS = {
    ammo="Jukukik Feather",
    head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
    body="Abnoba Kaftan",
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+21','Crit. hit damage +5%','STR+7',}},
    feet={ name="Herculean Boots", augments={'Accuracy+20','Crit. hit damage +4%','STR+6','Attack+14',}},
    neck=gear.ElementalGorget,
    waist=gear.ElementalBelt,
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Rajas Ring",
    right_ring="Petrov Ring",
    back="Bleating Mantle",
	}
end


-- -- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	set_macro_page(1, 8)
end
