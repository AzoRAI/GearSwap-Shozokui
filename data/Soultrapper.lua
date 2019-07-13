-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
inspect = require('inspect')
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

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  -- Idle Mode
  --  Normal: Normal Idle gear
  --  PDT: 50% PDT Gear while idle
  state.IdleMode:options('Normal', 'PDT')

  -- Hybrid Mode
  --  Normal: Full Haste/STP Gear while engaged
  --  PDT: 50% PDT Gear while engaged
  state.HybridMode:options('Normal', 'PDT')

  -- Offense Mode/Weaponskill Mode
  --  Normal: Use full Haste/STP/Weaponskill Gear
  --  AccLite: ~1400 Accuracy Requirement
  --  AccMax: ~1550 Accuracy Requirement
  state.OffenseMode:options('Normal', 'AccLite', 'AccMax')
  state.WeaponskillMode:options('Normal', 'AccLite', 'AccMax')

  -- Set Macros for Job
  select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
end


-- Set up gear sets.
function init_gear_sets()
  sets.precast['Soultrapper 2000'] = {amoo="Blank Soulplate"}
end


-- -- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  
end
