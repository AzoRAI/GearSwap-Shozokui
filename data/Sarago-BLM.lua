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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Dual Wield', 'MaxAcc')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'MB')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  sets.idle = {
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+6%','MND+9','Mag. Acc.+15',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Magic burst dmg.+8%','Mag. Acc.+8',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Magic burst dmg.+10%','AGI+6','Mag. Acc.+6','"Mag.Atk.Bns."+4',}},
    neck="Mizu. Kubikazari",
    waist="Eschan Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Locus Ring",
    right_ring="Mujin Band",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
  }

  sets.precast.FC = {
    ammo="Impatiens",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+6%','MND+9','Mag. Acc.+15',}},
    body="Anhur Robe",
    hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+6','Mag. Acc.+9','"Mag.Atk.Bns."+1',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+20','"Fast Cast"+6','CHR+4',}},
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Locus Ring",
    right_ring="Mujin Band",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
  }

  sets.midcast['Elemental Magic'] = {
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+6%','MND+9','Mag. Acc.+15',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Magic burst dmg.+8%','Mag. Acc.+8',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Magic burst dmg.+10%','AGI+6','Mag. Acc.+6','"Mag.Atk.Bns."+4',}},
    neck="Mizu. Kubikazari",
    waist="Eschan Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Locus Ring",
    right_ring="Mujin Band",
    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
  }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()

end
