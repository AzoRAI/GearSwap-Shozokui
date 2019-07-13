-- <editor-fold> Initialization

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')

  -- Grab the Naught includes
  include('Naught-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  -- Track Haste and Store TP buffs
  state.Buff.Haste = buffactive['Haste'] or false
  state.Buff.March = buffactive['March'] or false
  state.Buff.SamRoll = buffactive['Samurai Roll'] or false
  state.Buff.ChaosRoll = buffactive['Chaos Roll'] or false
  -- Track Additional Buffs
  state.Buff.Hasso = buffactive['Hasso'] or false
  state.Buff.Seigan = buffactive['Seigan'] or false
  state.Buff.LastResort = buffactive['Last Resort'] or false
  state.Buff.Souleater = buffactive['Souleater'] or false
  state.Buff.Endark = buffactive['Endark'] or false
  state.Buff.DreadSpikes = buffactive['Dread Spikes'] or false
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  -- Don't blink when using
  info.UseBlinkMeNot = false

  -- If using lockstyles, set to equipset to use
  info.LockstyleSet = 16

  -- Default Macro Book [Book, Page]
  info.MacroBook = {1, 2}


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

  get_combat_weapon()
  update_melee_groups()
end

function user_keybinds()
  -- bind_key('f9', 'gs c cycle CastingMode')
  bind_key('f9', 'gs c cycle OffenseMode')
  bind_key('^f9', 'gs c cycle HybridMode')
  bind_key('f12', 'gs c cycle IdleMode')
end

function user_unbind()
  unbind('f9')
  unbind('^f9')
  unbind('f12')
end

-- </editor-fold>

-- <editor-fold> Gear Sets

function idle_sets()
  sets.idle = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }

  sets.idle.PDT = set_combine(sets.idle, {
    body="Sulevia's Plate. +2",
    legs="Sulev. Cuisses +2",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    right_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
  })
end

function ja_sets()
  -- Define for job abilities
  -- sets.precast.JA['Ability name']
end

function spell_sets()
  sets.precast.FC = {
    ammo="Impatiens",
    body={ name="Odyss. Chestplate", augments={'"Fast Cast"+5',}},
    hands={ name="Odyssean Gauntlets", augments={'"Fast Cast"+4','CHR+6',}},
    legs={ name="Odyssean Cuisses", augments={'Mag. Acc.+23','"Fast Cast"+4','CHR+8',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+4','"Fast Cast"+5','AGI+4','Mag. Acc.+15',}},
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Kishar Ring",
    right_ring="Prolix Ring",
  }

  sets.midcast.AspirDrain = {
    ammo="Pemphredo Tathlum",
    body={ name="Carm. Sc. Mail +1", augments={'Attack+20','"Mag.Atk.Bns."+12','"Dbl.Atk."+4',}},
    hands="Flam. Manopolas +2",
    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
    feet="Ratri Sollerets",
    neck="Erra Pendant",
    left_ear="Digni. Earring",
    right_ear="Dark Earring",
    left_ring="Kishar Ring",
    right_ring="Evanescence Ring",
    back={ name="Niht Mantle", augments={'Attack+7','Dark magic skill +1','"Drain" and "Aspir" potency +25',}},
  }
  sets.midcast.En = {
    ammo="Pemphredo Tathlum",
    body={ name="Carm. Sc. Mail +1", augments={'Attack+20','"Mag.Atk.Bns."+12','"Dbl.Atk."+4',}},
    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
    feet="Ratri Sollerets",
    neck="Erra Pendant",
    waist="Casso Sash",
    left_ear="Loquac. Earring",
    right_ear="Dark Earring",
    left_ring="Stikini Ring",
    right_ring="Evanescence Ring",
    back={ name="Niht Mantle", augments={'Attack+7','Dark magic skill +1','"Drain" and "Aspir" potency +25',}},
  }
  sets.midcast.DreadSpikes = {
    ammo="Egoist's Tathlum",
    head="Ratri Sallet",
    body="Ratri Plate",
    hands="Ratri Gadlings",
    legs="Ratri Cuisses",
    feet="Ratri Sollerets",
    neck="Dualism Collar +1",
    waist="Oneiros Belt",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",
  }
  sets.midcast.Absorb = {
    ammo="Pemphredo Tathlum",
    body={ name="Carm. Sc. Mail +1", augments={'Attack+20','"Mag.Atk.Bns."+12','"Dbl.Atk."+4',}},
    hands="Pavor Gauntlets",
    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
    feet="Ratri Sollerets",
    neck="Erra Pendant",
    left_ear="Digni. Earring",
    right_ear="Dark Earring",
    left_ring="Kishar Ring",
    right_ring="Evanescence Ring",
    waist="Casso Sash",
    back="Chuparrosa Mantle",
  }
  sets.midcast.ElementalMagic = {}
  sets.midcast.DarkMagic = {}
end

function tp_sets()
  sets.engaged = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt",
    left_ear="Dedition Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }
  -- High Acc
  sets.engaged.Acc = set_combine(sets.engaged, {

  })
  -- PDT
  sets.engaged.PDT = set_combine(sets.engaged, {
    neck="Loricate Torque +1",
    waist="Flume Belt",
    right_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
  })
  -- High Acc PDT
  sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {

  })


  -- Weapon-Specific sets (To use different weapons, use this same format)
  -- Liberator
  sets.engaged.Liberator = sets.engaged
  sets.engaged.Liberator.Acc = sets.engaged.Acc
  sets.engaged.Liberator.AM3 = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Sailfi Belt +1",
    left_ear="Telos Earring",
    right_ear="Dedition Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Flamma Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }

  sets.engaged.Liberator.AM3.PDT = set_combine(sets.engaged.Liberator.AM3, {
    waist="Flume Belt",
    right_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
  })

  sets.engaged.Anguta = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands={ name="Acro Gauntlets", augments={'Accuracy+20','"Store TP"+5','DEX+10',}},
    legs={ name="Valor. Hose", augments={'Accuracy+25 Attack+25','"Store TP"+7',}},
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt",
    left_ear="Dedition Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }
  sets.engaged.Anguta.Acc = sets.engaged.Anguta
  sets.engaged.Anguta.PDT = set_combine(sets.engaged.Anguta, {
    waist="Flume Belt",
    right_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
  })
end

function ws_sets()

  WSD_GEAR = {
    ammo="Knobkierrie",
    head="Ratri Sallet",
    body="Ignominy Cuirass +3",
    hands="Ratri Gadlings",
    legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
    feet="Ratri Sollerets",
    neck="Abyssal Beads +2",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Ishvara Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }


  sets.precast.WS['Insurgency'] = WSD_GEAR
  sets.precast.WS['Spinning Scythe'] = WSD_GEAR
  sets.precast.WS['Cross Reaper'] = WSD_GEAR
  sets.precast.WS['Entropy'] = set_combine(WSD_GEAR, {
    neck="Fotia Gorget",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
  })


  sets.precast.WS['Torcleaver'] = {
    ammo="Knobkierrie",
    head="Ratri Sallet",
    body="Ignominy Cuirass +3",
    hands={ name="Odyssean Gauntlets", augments={'Accuracy+4','Weapon skill damage +4%','DEX+5','Attack+9',}},
    legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
    feet="Sulev. Leggings +2",
    neck="Abyssal Beads +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }

end

-- Set up gear sets.
function init_gear_sets()
  idle_sets()
  tp_sets()
  ws_sets()
  ja_sets()
  spell_sets()
end

-- </editor-fold>


-- <editor-fold> Events/Hooks


function job_get_spell_map(spell, defualt_map)
  if spell.en:contains("Absorb") then
    return "Absorb"
  elseif spell.en == "Dread Spikes" then
    return "Dread Spikes"
  elseif spell.en:contains("Endark") then
    return "En"
  elseif spell.en:contains("Drain") or spell.en:contains("Aspir") then
    return "AspirDrain"
  else
    return default_map
  end
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then

      if player.equipment.main == 'Apocalypse' then
          state.CombatWeapon:set('Apocalypse')
      elseif player.equipment.main == 'Anguta' then
          state.CombatWeapon:set('Anguta')
      elseif player.equipment.main == 'Ragnarok' then
          state.CombatWeapon:set('Ragnarok')
      elseif player.equipment.main == 'Caladbolg' then
          state.CombatWeapon:set('Caladbolg')
      elseif player.equipment.main == 'Liberator' then
          state.CombatWeapon:set('Liberator')
      else -- use regular set, which caters to Liberator
          state.CombatWeapon:reset()
      end

    end
end


function job_buff_change(buff, gain)
  -- AM custom groups
    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Liberator' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
                add_to_chat(8, '-------------Mythic AM3 UP-------------')
            -- elseif (buff == "Aftermath: Lv.3" and not gain) then
            --     add_to_chat(8, '-------------Mythic AM3 DOWN-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomMeleeGroups:clear()

            if buff == "Aftermath" and gain or buffactive.Aftermath then
                classes.CustomMeleeGroups:append('AM')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
end

function job_update(cmdParams, eventArgs)
  get_combat_weapon()
  update_melee_groups()
end

-- </editor-fold>


-- <editor-fold> Custom Functions

function update_melee_groups()

    classes.CustomMeleeGroups:clear()
    -- mythic AM
    if player.equipment.main == 'Liberator' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        -- relic AM
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
        -- if buffactive['Samurai Roll'] then
        --     classes.CustomRangedGroups:append('SamRoll')
        -- end
    end
end


function get_combat_weapon()
    state.CombatWeapon:reset()
    if player.equipment.main == 'Apocalypse' then
        state.CombatWeapon:set('Apocalypse')
    elseif player.equipment.main == 'Anguta' then
        state.CombatWeapon:set('Anguta')
    elseif player.equipment.main == 'Ragnarok' then
        state.CombatWeapon:set('Ragnarok')
    elseif player.equipment.main == 'Caladbolg' then
        state.CombatWeapon:set('Caladbolg')
    elseif player.equipment.main == 'Liberator' then
        state.CombatWeapon:set('Liberator')
    end
end

function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}

        local mythic_ws = "Insurgency"

        info.aftermath.weaponskill = mythic_ws
        info.aftermath.duration = 0

        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end

        if spell.english == mythic_ws and player.equipment.main == 'Liberator' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end

            if info.aftermath.level == 1 then
                info.aftermath.duration = 90
            elseif info.aftermath.level == 2 then
                info.aftermath.duration = 120
            else
                info.aftermath.duration = 180
            end
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
        info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

-- </editor-fold>
