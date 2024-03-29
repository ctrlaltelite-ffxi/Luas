-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--              [ WIN+E ]           Weapon selector forward.
--              [ WIN+R ]           Weapon selector backward.

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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false

    weapon_list = S{"Apocalypse", "Caladbolg", "Anguta", "Liberator", "Loxotic"}
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    elemental_ws = S{'Dark Harvest','Shadow of Death','Infernal Scythe','Frostbite','Freezebite',
              'Burning Blade','Red Lotus Blade','Shining Blade','Seraph Blade','Sanguine Blade'}

    lockstyleset = 3
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'STP')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Caladbolg', 'Apocalypse', 'Anguta', 'Liberator', 'Loxotic'}

    state.MagicBurst = M(false, 'Magic Burst')
    state.Critical = M(false, 'Critical Aftermath TP')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-BRD-Binds.lua') -- OK to remove this line

    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @a gs c toggle Critical')
    --send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    send_command('bind !q input /ma "Drain III" <t>')
    send_command('bind !w input /ja "Last Resort" <me>')
    send_command('bind !e input /ja "Hasso" <me>')
    send_command('bind !p input /ma "Dread Spikes" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind ^numpad/ input /ja "Meditate" <me>')
        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        send_command('bind ^numpad- input /ja "Third Eye" <me>')
    end


    send_command('bind ^numpad7 input /ws "Resolution" <t>')
    send_command('bind ^numpad5 input /ws "Torcleaver" <t>')
    send_command('bind ^numpad1 input /ws "Freezebite" <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
    get_combat_weapon()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !`')
    send_command('unbind !q')
    send_command('unbind !w')
    send_command('bind !e input /ma "Haste" <stpc>')
    send_command('unbind !p')
    send_command('unbind @a')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')

    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    ---- Precast Sets ----

    -- Enmity set
    sets.Enmity = {}

    -- Precast sets to enhance JAs
    sets.precast.JA['Arcane Circle'] = {feet="Ig. Sollerets +3"}
    sets.precast.JA['Blood Weapon'] = {body="Fall. Cuirass +1"}
    sets.precast.JA['Dark Seal'] = {head="Fallen's Burgeonet +1"}
    sets.precast.JA['Diabolic Eye'] = {hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}}}
    sets.precast.JA['Last Resort'] = {feet="Fallen's Sollerets +1", back=gear.DRK_DA_Cape,}
    sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +1"}
    sets.precast.JA['Souleater'] = {head="Ig. Burgonet +3"}
    sets.precast.JA['Weapon Bash'] = {hands="Ig. Gauntlets +3"}

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Sakpata's Helm",--"Carmine Mask +1", --10
        hands="Leyline Gloves", --8
        legs=gear.Ody_FC_legs, -- 5
        feet=gear.Ody_FC_feet, -- 11
        neck="Baetyl Pendant", --4
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --4
        ring1="Kishar Ring", --4
        ring2="Weather. Ring +1", --6(4)
        --back=gear.DRK_FC_Cape, --10 Need fast cast back
        }

    --sets.precast.FC['Dark Magic'] = set_combine(sets.precast.FC, {head="Fallen's Burgeonet +1"})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Ratri Sallet",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings",
        legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
        feet="Sulev. Leggings +2",
        neck="Abyssal Beads +2",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1="Epaminondas's Ring",
        ring2="Niqmaddu Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Fotia Belt",
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        head="Sulevia's Mask +1",
        hands="Odyssean Gauntlets",
        })

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
        head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
        legs="Ig. Flanchard +3",
        feet="Sakpata's Leggings",
        ear2="Lugra Earring +1",
        ring1="Regal Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        })

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {})

    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+13','Weapon skill damage +3%','VIT+8','Attack+2',}},
		})

    sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {})

    sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS['Torcleaver'], {
        legs="Ratri Cuisses",
        ear1="Lugra Earring +1",
        waist="Sailfi Belt +1",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        })

    sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS['Catastrophe'], {})

    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
        legs="Ratri Cuisses",
        feet="Ratri Sollerets",
        ring1="Regal Ring",
        waist="Sailfi Belt +1",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        })

    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'], {})

    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS['Resolution'], {
        legs="Ratri Cuisses",
        ring1="Metamor. Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        })

    sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'], {})

    sets.precast.WS['Insurgency'] = set_combine(sets.precast.WS['Cross Reaper'], {
        waist="Fotia Belt",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        })

    sets.precast.WS['Insurgency'].Acc = set_combine(sets.precast.WS['Insurgency'], {})

    sets.precast.WS['Quietus'] = set_combine(sets.precast.WS['Cross Reaper'], {
        ring1="Epaminondas's Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        })

    sets.precast.WS['Quietus'].Acc = set_combine(sets.precast.WS['Quietus'], {})

    sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {
        hands={ name="Odyssean Gauntlets", augments={'Accuracy+13','Weapon skill damage +3%','VIT+8','Attack+2',}},
		})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast['Enfeebling Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Carmine Mask +1",
        body="Hjarrandi Breast.",
        hands="Ratri Gadlings",
        legs="Ratri Cuisses",
        feet="Ig. Sollerets +3",
        neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Malignance Earring",
        ring1="Stikini Ring +1",
        --ring2="Stikini Ring +1",
        back=gear.DRK_FC_Cape,
        waist="Eschan Stone",
        }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Carmine Mask +1",
        body="Carmine Scale Mail +1",
        hands="Ratri Gadlings",
        legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
        feet="Ratri Sollerets",
        neck="Erra Pendant",
        ear1="Mani Earring",
        ear2="Malignance Earring",
        ring1="Stikini Ring +1",
        --ring2="Stikini Ring +1",
        back=gear.DRK_FC_Cape,
        waist="Eschan Stone",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
        feet="Ig. Sollerets +3",
        ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back="Niht Mantle",
        waist="Austerity Belt +1",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
        head="Ig. Burgonet +3",
		body="Carmine Scale Mail +1",
        hands="Pavor Gauntlets",
        ring1="Kishar Ring",
        back="Chuparrosa Mantle",
        waist="Casso Sash",
        })

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {hands="Heath. Gauntlets +1"})

    sets.midcast.Stun = sets.midcast['Dark Magic']

    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
        head="Ratri Sallet",
        body="Heathen's Cuirass +1",
        hands="Ratri Gadlings",
        legs="Ratri Cuisses",
        feet="Ratri Sollerets",
        ear1="Odnowa Earring +1",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",
        })


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
        neck="Loricate Torque +1", --"Bathy Choker +1",
        ear1="Odnowa Earring +1",
        ear2="Etiolation Earring",
        ring1="Stikini Ring +1",
        ring2="Moonlight Ring",
        back="Moonlight Cape",
        waist="Sailfi Belt +1",
        }

    sets.idle.DT = set_combine(sets.idle, {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        })

    sets.idle.Town = set_combine(sets.idle, {
        head="Volte Salade",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings",
        legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
        feet="Ratri Sollerets",
        neck="Abyssal Beads +2",
        ear1="Odnowa Earring +1",
        ear2="Thrud Earring",
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        back=gear.DRK_DA_Cape,
        })

    sets.idle.Weak = set_combine(sets.idle, {})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {})
    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})
    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ammo="Seeth. Bomblet +1",
        hands="Gazu Bracelet",
        })

    sets.engaged.STP = set_combine(sets.engaged, {
        hands="Flam. Manopolas +2",
        legs=gear.Ody_DA_legs,
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        })

    sets.engaged.Caladbolg = set_combine(sets.engaged, {})
    sets.engaged.Caladbolg.LowAcc = set_combine(sets.engaged.Apocalypse, {})
    sets.engaged.Caladbolg.MidAcc = set_combine(sets.engaged.Apocalypse, {
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        })

    sets.engaged.Caladbolg.HighAcc = set_combine(sets.engaged.Apocalypse, {
        ammo="Seeth. Bomblet +1",
        })

    sets.engaged.Caladbolg.Aftermath = {
        ammo="Yetshila +1", --2/6
        --head="Blistering Sallet +1", --10/0
        body="Hjarrandi Breast.", --13/0
        hands="Flam. Manopolas +2", --8/0,
        --legs="Zoar Subligar +1", --5/0
        --feet="Valorous Greaves", --0/4
        neck="Abyssal Beads +2", --4/0
        ring1="Hetairoi Ring", --1/0
        --back=gear.DRK_Crit_Cape, --10/0
        }

    sets.engaged.Apocalypse = set_combine(sets.engaged, {
        ring1="Petrov Ring",
		left_ear="Schere Earring",
        })

    sets.engaged.Apocalypse.LowAcc = set_combine(sets.engaged.Apocalypse, {})
    sets.engaged.Apocalypse.MidAcc = set_combine(sets.engaged.Apocalypse, {
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        })

    sets.engaged.Apocalypse.HighAcc = set_combine(sets.engaged.Apocalypse, {
        ammo="Seeth. Bomblet +1",
        hands="Gazu Bracelet",
        })
		
	sets.engaged.Anguta = set_combine(sets.engaged, {
        ring1="Petrov Ring",
		left_ear="Schere Earring",
        })

    sets.engaged.Anguta.LowAcc = set_combine(sets.engaged.Apocalypse, {})
    sets.engaged.Anguta.MidAcc = set_combine(sets.engaged.Apocalypse, {
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        })

    sets.engaged.Anguta.HighAcc = set_combine(sets.engaged.Apocalypse, {
        ammo="Seeth. Bomblet +1",
        hands="Gazu Bracelet",
        })
		
	sets.engaged.Liberator = set_combine(sets.engaged, {
        ring1="Petrov Ring",
		left_ear="Schere Earring",
        })

    sets.engaged.Liberator.LowAcc = set_combine(sets.engaged.Apocalypse, {})
    sets.engaged.Liberator.MidAcc = set_combine(sets.engaged.Apocalypse, {
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        })

    sets.engaged.Liberator.HighAcc = set_combine(sets.engaged.Apocalypse, {
        ammo="Seeth. Bomblet +1",
        hands="Gazu Bracelet",
        })	
		
	sets.engaged.Liberator.Aftermath = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		neck="Abyssal Beads +2",
		ear1="Schere Earring", --"Dedition Earring",
		ear2="Brutal Earring", --"Balder Earring +1",
		body="Sakpata's Plate", --"Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		ring1="Chirich Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		waist="Sailfi Belt +1", --"Windbuffet Belt +1",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
	}

    sets.engaged.Loxotic = set_combine(sets.engaged, {
        ring1="Petrov Ring",
		left_ear="Schere Earring",
        })

    sets.engaged.Loxotic.LowAcc = set_combine(sets.engaged.Apocalypse, {})
    sets.engaged.Loxotic.MidAcc = set_combine(sets.engaged.Apocalypse, {
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        })

    sets.engaged.Loxotic.HighAcc = set_combine(sets.engaged.Apocalypse, {
        ammo="Seeth. Bomblet +1",
        hands="Gazu Bracelet",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        ammo="Seeth. Bomblet +1",
        legs="Sakpata's Cuisses",
        ring1="Defending Ring",
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.magic_burst = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.buff.Doom = {ring1={name="Saida Ring", bag="wardrobe3"}, ring2={name="Saida Ring", bag="wardrobe4"},neck="Nicander's Necklace",waist="Gishdubar Sash",}
    sets.CP = {back="Mecisto. Mantle"}

    sets.Caladbolg = {main="Caladbolg", sub="Utu Grip"}
    sets.Apocalypse = {main="Apocalypse", sub="Utu Grip"}
	sets.Anguta = {main="Anguta", sub="Utu Grip"}
	sets.Liberator = {main="Liberator", sub="Utu Grip"}
    sets.Loxotic = {main="Loxotic Mace +1", sub="Blurred Shield +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_precast(spell, action, spellMap, eventArgs)

end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(field, new_value, old_value)
    if state.WeaponSet.value == 'Caladbolg' then
        send_command('bind ^numpad7 input /ws "Resolution" <t>')
        send_command('unbind ^numpad8')
        send_command('unbind ^numpad4')
        send_command('bind ^numpad5 input /ws "Torcleaver" <t>')
        send_command('unbind ^numpad6')
        send_command('bind ^numpad1 input /ws "Freezebite" <t>')
    elseif state.WeaponSet.value == "Apocalypse" then
        send_command('unbind ^numpad7')
        send_command('bind ^numpad8 input /ws "Insurgency" <t>')
        send_command('bind ^numpad4 input /ws "Catastrophe" <t>')
        send_command('bind ^numpad5 input /ws "Cross Reaper" <t>')
        send_command('bind ^numpad6 input /ws "Quietus" <t>')
        send_command('bind ^numpad1 input /ws "Infernal Scythe" <t>')
        send_command('bind ^numpad0 input /ws "Entropy" <t>')
    elseif state.WeaponSet.value == "Anguta" then
        send_command('unbind ^numpad7')
        send_command('bind ^numpad8 input /ws "Insurgency" <t>')
        send_command('bind ^numpad4 input /ws "Catastrophe" <t>')
        send_command('bind ^numpad5 input /ws "Cross Reaper" <t>')
        send_command('bind ^numpad6 input /ws "Quietus" <t>')
        send_command('bind ^numpad1 input /ws "Infernal Scythe" <t>')
        send_command('bind ^numpad0 input /ws "Entropy" <t>')
	elseif state.WeaponSet.value == "Liberator" then
        send_command('unbind ^numpad7')
        send_command('bind ^numpad8 input /ws "Insurgency" <t>')
        send_command('bind ^numpad4 input /ws "Catastrophe" <t>')
        send_command('bind ^numpad5 input /ws "Cross Reaper" <t>')
        send_command('bind ^numpad6 input /ws "Quietus" <t>')
        send_command('bind ^numpad1 input /ws "Infernal Scythe" <t>')
        send_command('bind ^numpad0 input /ws "Entropy" <t>')
    elseif state.WeaponSet.value == "Loxotic" then
        send_command('unbind ^numpad7')
        send_command('bind ^numpad8 input /ws "Judgment" <t>')
        send_command('bind ^numpad4 input /ws "Seraph Strike" <t>')
        send_command('bind ^numpad5 input /ws "Flash Nova" <t>')
	end

    check_weaponset()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    get_combat_weapon()
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
         equip(sets.CP)
         disable('back')
     else
         enable('back')
     end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Caladbolg"
        and state.Critical.value then

        meleeSet = set_combine(meleeSet, sets.engaged.Caladbolg.Aftermath)
    end

    return meleeSet
end

function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Liberator"
        and state.Critical.value then

        meleeSet = set_combine(meleeSet, sets.engaged.Liberator.Aftermath)
    end

    return meleeSet
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_weapon()
    state.CombatWeapon:reset()
    if weapon_list:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 27 and DW_needed <= 37 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 37 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
