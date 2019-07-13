-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
res = require('resources')

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
    state.OffenseMode:options('Normal', 'AccLite', 'AccMax', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
    state.HybridMode:options('Normal', 'PDT')
    select_default_macro_book()
    send_command('wait 6;input /lockstyleset 9')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
end


-- Set up gear sets.
function init_gear_sets()
    -- Resting sets
	sets.resting = {}

  -- Idle Sets
  sets.idle = {
    neck="Ainia Collar", ammo="Ginsen", left_ear="Cessance Earring",right_ear="Brutal Earring",
    head="Flam. Zucchetto +2", body="Dagon breastplate", hands="Sulev. Gauntlets +2",
    legs="Pumm. Cuisses +2", feet="Pumm. Calligae +3",
    left_ring="Niqmaddu ring",right_ring="Flamma Ring",
    waist="Ioskeha Belt",back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+8','"Dbl.Atk."+10','Damage taken-5%',}},
  }

  -- 43% PDT
  sets.idle.PDT = {
    body="Sulevia's Plate. +2",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    left_ear="Genmei Earring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+8','"Dbl.Atk."+10','Damage taken-5%',}},
  }

  sets.precast.JA['Tomahawk'] = {ammo="Throwing Tomahawk"}

  -- TP Sets
  sets.TP = {}
  sets.TP.Base = {
    neck="Ainia Collar", ammo="Ginsen", left_ear="Cessance Earring",right_ear="Brutal Earring",
    head="Flam. Zucchetto +2", body="Dagon breastplate", hands="Sulev. Gauntlets +2",
    legs="Pumm. Cuisses +2", feet="Pumm. Calligae +3",
    left_ring="Niqmaddu ring",right_ring="Flamma Ring",
    waist="Ioskeha Belt",back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+8','"Dbl.Atk."+10','Damage taken-5%',}},
  }
  -- TODO: Define High Acc Gear after it's gotten
  sets.TP.AccLite = set_combine(sets.TP.Base, {})
  sets.TP.AccMax = set_combine(sets.TP.Base, {})
  sets.engaged = sets.TP.Base
  sets.engaged.AccLite = sets.TP.AccLite
  sets.engaged.AccMax = sets.TP.AccMax
  sets.engaged.PDT = set_combine(sets.TP.Base, {
    left_ring="Vocane ring",
    right_ring="Defending ring",
    neck="Loricate torque +1",
    left_ear="Genmei earring"
  })

  -- DT Sets
  sets.Defense = {}
  sets.Defense.Base = {}

  -- 43% PDT
  sets.Defense.PDT = {
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    left_ear="Genmei Earring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+8','"Dbl.Atk."+10','Damage taken-5%',}},
  }
  sets.Defense.MDT = {}
  sets.engaged.PDT = set_combine(sets.engaged, sets.Defense.PDT)
  sets.engaged.AccLite.PDT = set_combine(sets.engaged.AccLite, sets.Defense.PDT)
  sets.engaged.AccMax.PDT = set_combine(sets.engaged.AccMax, sets.Defense.PDT)
  sets.engaged.MDT = set_combine(sets.engaged, sets.Defense.MDT)
  sets.engaged.AccLite.MDT = set_combine(sets.engaged.AccLite, sets.Defense.MDT)
  sets.engaged.AccMax.MDT = set_combine(sets.engaged.AccMax, sets.Defense.MDT)


  -- WS Sets
  sets.WS = {}
  sets.WS.Base = set_combine(sets.TP.Base, {
    ammo="Knobkierrie",
    left_ear="Telos Earring", right_ear="Brutal Earring",
    neck=gear.ElementalGorget, waist="Fotia belt",
    body="Argosy Hauberk +1", hands="Argosy Mufflers +1",
    right_ring="Regal ring",
    feet="Pumm. Calligae +3"
  })
  sets.WS.AccLite = set_combine(sets.TP.AccLite, {})
  sets.WS.AccMax = set_combine(sets.TP.AccMax, {})

  sets.precast.WS = sets.WS.Base
  sets.precast.WS.AccLite = sets.WS.AccLite
  sets.precast.WS.AccMax = sets.WS.AccMax

  sets.precast.WS['Upheaval'] = set_combine(sets.WS.Base, {
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
  })


  -- sets.precast.WS['Hexa Strike'] = {
  --   ammo="Knobkierrie",
  --   head="Sulevia's Mask +2",
  --   body={ name="Argosy Hauberk +1", augments={'STR+12','Attack+20','"Store TP"+6',}},
  --   hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
  --   legs="Sulev. Cuisses +2",
  --   feet="Sulev. Leggings +2",
  --   neck="Asperity Necklace",
  --   waist="Fotia Belt",
  --   left_ear="Ishvara Earring",
  --   right_ear="Telos Earring",
  --   left_ring="Niqmaddu Ring",
  --   right_ring="Regal Ring",
  --   back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+7','"Dbl.Atk."+10',}},
  -- }
end

-- --+-----------------------------------------------------------------------------------------------------------------
-- -- Job-specific hooks for standard casting events.
-- -------------------------------------------------------------------------------------------------------------------

function player_has_seigan()
  buffs = windower.ffxi.get_player()['buffs']
  found = false
  for i,id in ipairs(buffs) do
    buff = res.buffs[id]
    if buff ~= nil and buff['en'] == 'Seigan' then
      found = true
    end
  end
  return found
end

function seigan_or_third_eye()
  if player_has_seigan() == false then
    cancel_spell()
    send_command("Seigan")
  end
end

function job_pretarget(spell, action, spellMap, eventArgs)
  if spell.english == "Third Eye" then
    seigan_or_third_eye()
  end
end

-- -- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	set_macro_page(1, 2)
end
