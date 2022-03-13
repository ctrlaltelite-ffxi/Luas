-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Chain Affinity
--              [ CTRL+= ]          Burst Affinity
--              [ CTRL+[ ]          Efflux
--              [ ALT+[ ]           Diffusion
--              [ ALT+] ]           Unbridled Learning
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ CTRL+` ]          Blank Gaze
--              [ ALT+Q ]            Nature's Meditation/Fantod
--              [ ALT+W ]           Cocoon/Reactor Cool
--              [ ALT+E ]           Erratic Flutter
--              [ ALT+R ]           Battery Charge/Refresh
--              [ ALT+T ]           Occultation
--              [ ALT+Y ]           Barrier Tusk/Phalanx
--              [ ALT+U ]           Diamondhide/Stoneskin
--              [ ALT+P ]           Mighty Guard/Carcharian Verve
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad9 ]    Chant Du Cygne
--              [ CTRL+Numpad4 ]    Requiescat
--              [ CTRL+Numpad5 ]    Expiacion
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


--------------------------------------------------------------------------------------------------------------------
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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave'}

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
        'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
        'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
        'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

    blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
        'Tenebral Crush'}

    blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
        'Retinal Glare'}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
        'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
        'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
        'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
        'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
        'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
        'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

    -- Stun spells
    blue_magic_maps.StunPhysical = S{'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'}
    blue_magic_maps.StunMagical = S{'Blitzstrahl','Temporal Shift','Thunderbolt'}

    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
        'Wild Carrot'}

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
        'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
        'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

    blue_magic_maps.Refresh = S{'Battery Charge'}

    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
        'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    elemental_ws = S{'Flash Nova', 'Sanguine Blade'}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 3
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'STP')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal', 'DT')--, 'Learning')

    state.MagicBurst = M(false, 'Magic Burst')
    -- state.CP = M(false, "Capacity Points Mode")

    --send_command('lua l azureSets')

    select_default_macro_book()
    set_lockstyle()

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs

    -- Enmity set
    sets.Enmity = {

        }

    --sets.precast.JA['Provoke'] = sets.Enmity
	--
    sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +3", feet="Hashi. Basmak +1"}
    sets.buff['Diffusion'] = {feet="Luhlaza Charuqs +3"}
    sets.buff['Efflux'] = {legs="Hashishin Tayt +1"}
	--
    sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}
    sets.precast.JA['Chain Affinity'] = {feet="Assim. Charuqs +1"}
    sets.precast.JA['Convergence'] = {head="Luh. Keffiyeh +3"}
    sets.precast.JA['Enchainment'] = {body="Luhlaza Jubbah +3"}

    sets.precast.FC = {
       	ammo="Sapience Orb",
		head="Carmine Mask +1",
		neck="Voltsurge Torque",
		ear1="Loquac. Earring",
		ear2="Enchntr. Earring +1",
		body="	Luhlaza Jubbah +3",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back={ name="Rosmerta's Cape", augments={'Fast Cast +10'}},
	  	waist="Witful Belt",
		legs="Lengo Pants",
		feet="Carmine Greaves +1"
	}

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
		ammo="Sapience Orb",
		head="Carmine Mask +1",
		neck="Voltsurge Torque",
		ear1="Loquac. Earring",
		ear2="Enchntr. Earring +1",
		body="Hashishin Mintan +1",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back={ name="Rosmerta's Cape", augments={'Fast Cast +10'}},
		waist="Witful Belt",
		legs="Lengo Pants",
		feet="Carmine Greaves +1"
	})
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        ring1="Lebeche Ring",
        waist="Rumination Sash",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Aurgelmir Orb",
        --head=gear.Herc_WSD_head,
        body="Assim. Jubbah +3",
        hands="Jhakri Cuffs +2",
        legs="Luhlaza Shalwar +3",
        --feet=gear.Herc_WS_feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
        waist="Fotia Belt",
        }
	--
    --sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    --    ammo="Voluspa Tathlum",
    --    head="Dampening Tam",
    --    hands=gear.Herc_WS_hands,
    --    ear2="Telos Earring",
    --    })
	--
    --sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
    --    head=gear.Adhemar_B_head,
    --    body="Abnoba Kaftan",
    --    hands=gear.Adhemar_B_hands,
    --    legs="Zoar Subligar +1",
    --    feet="Thereoid Greaves",
    --    neck="Mirage Stole +2",
    --    ear2="Brutal Earring",
    --    ring1="Begrudging Ring",
    --    ring2="Epona's Ring",
    --    back=gear.BLU_WS1_Cape,
    --    })
	--
    --sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
    --    ammo="Voluspa Tathlum",
    --    head="Dampening Tam",
    --    body=gear.Adhemar_B_body,
    --    hands=gear.Adhemar_A_hands,
    --    feet=gear.Herc_STP_feet,
    --    ear2="Mache Earring +1",
    --    })
	--
    --sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
    --sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc
	--
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",
    head="Gleti's Mask",
    neck="Mirage Stole +2",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
    body="Assim. Jubbah +3",
    hands="Jhakri Cuffs +2",
    ring1="Epaminondas's Ring",
    ring2="Karieyh Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10', 'Accuracy +10','Weapon skill damage +10%',}},
    waist="Sailfi Belt +1",
    legs="Luhlaza Shalwar +3",
    feet="Gleti's Boots"
    })
	--
    --sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
    --    ammo="Voluspa Tathlum",
    --    feet=gear.Herc_STP_feet,
    --    ear2="Telos Earring",
    --    waist="Grunfeld Rope",
    --    })
	--
    --sets.precast.WS['Requiescat'] = {
    --    head="Luh. Keffiyeh +3",
    --    body="Luhlaza Jubbah +3",
    --    hands="Jhakri Cuffs +2",
    --    legs="Luhlaza Shalwar +3",
    --    feet="Luhlaza Charuqs +3",
    --    neck="Fotia Gorget",
    --    ear1="Moonshade Earring",
    --    ear2="Brutal Earring",
    --    ring1="Rufescent Ring",
    --    ring2="Epona's Ring",
    --    back=gear.BLU_WS1_Cape,
    --    waist="Fotia Belt",
    --    }
	--
    --sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
    --    ammo="Voluspa Tathlum",
    --    head="Dampening Tam",
    --    feet=gear.Herc_STP_feet,
    --    ear1="Cessance Earring",
    --    ear2="Telos Earring",
    --    })
	--
    sets.precast.WS['Expiacion'] = sets.precast.WS['Savage Blade']
	--
    --sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Expiacion'], {
    --    body=gear.Adhemar_B_body,
    --    feet=gear.Herc_STP_feet,
    --    ear2="Telos Earring",
    --    })
	--
    sets.precast.WS['Sanguine Blade'] = {
	ammo="Ghastly Tathlum +1",
    head="Pixie Hairpin +1",
    neck="Baetyl Pendant",
    ear1="Friomisi Earring",
    ear2="Regal Earring",
    body="Amalric Doublet +1",
    hands="Jhakri Cuffs +2",
    ring1="Archon Ring",
    ring2="Epaminondas's Ring",
    back="Rosmerta's Cape",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1",
}
	--
    sets.precast.WS['True Strike'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['True Strike'].Acc = sets.precast.WS['Savage Blade'].Acc
    sets.precast.WS['Judgment'] = sets.precast.WS['True Strike']
    sets.precast.WS['Judgment'].Acc = sets.precast.WS['True Strike'].Acc
	--
    --sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {
    --    ear2="Regal Earring",
    --    waist="Sailfi Belt +1",
    --    })
	--
    --sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
    --    feet=gear.Herc_STP_feet,
    --    ear2="Telos Earring",
    --    })
	--
    --sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']
    --sets.precast.WS['Realmrazer'].Acc = sets.precast.WS['Requiescat'].Acc
	--
    --sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {
    --    head=gear.Herc_MAB_head,
    --    ring2="Weather. Ring +1",
    --    })
	--
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC, {
	ammo="Sapience Orb",
    head="Carmine Mask +1",
    neck="Baetyl Pendant",
    ear1="Loquac. Earring",
    ear2="Enchntr. Earring +1",
    body="Luhlaza Jubbah +3",
    hands="Leyline Gloves",
    ring1="Prolix Ring",
    ring2="Kishar Ring",
    back="Perimede cape",
    waist="Witful Belt",
    legs="Psycloth Lappas",
    feet="Carmine Greaves +1"
}

    sets.midcast.SpellInterrupt = {
        ammo="Impatiens", --10
        ring1="Evanescence Ring", --5
        waist="Rumination Sash", --10
        }

    sets.midcast['Blue Magic'] = {
		ammo="Ghastly Tathlum +1",
		neck="Baetyl Pendant",
		ear1="Regal Earring",
		ear2="Friomisi Earring",
		body="Cohort Cloak +1",
		hands="Amalric Gages +1",
		ring1="Metamor. Ring +1",
		ring2="Shiva Ring +1",
		back="Aurist's Cape +1",
		waist="Orpheus's Sash",
		legs="Luhlaza Shalwar +3",
		feet="Amalric Nails +1"
}
	
    sets.midcast['Blue Magic'].Physical = {
		ammo="Aurgelmir Orb +1",
		head="Luh. Keffiyeh +3",
		neck="Mirage Stole +2",
		ear1="Tati Earring +1",
		ear2="Tati Earring +1",
		body="Luhlaza Jubbah +3",
		hands="Luh. Bazubands +3",
		ring1="Shukuyu Ring",
		ring2="Ifrit Ring +1",
		back="Rosmerta's Cape",
		waist="Prosilio Belt +1",
		legs="Herculean Trousers",
		feet="Luhlaza Charuqs +3"
}
	
    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Aurgelmir Orb +1",
		head="Luh. Keffiyeh +3",
		neck="Mirage Stole +2",
		ear1="Tati Earring +1",
		ear2="Tati Earring +1",
		body="Luhlaza Jubbah +3",
		hands="Luh. Bazubands +3",
		ring1="Shukuyu Ring",
		ring2="Ifrit Ring +1",
		back="Rosmerta's Cape",
		waist="Prosilio Belt +1",
		legs="Herculean Trousers",
		feet="Luhlaza Charuqs +3"
        })
	
    sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical
	
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })
	
    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical
	
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })
	
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })
	
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })
	
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {ear1="Regal Earring", ear2="Enchntr. Earring +1"})
	
    sets.midcast['Blue Magic'].Magical = {
	ammo="Ghastly Tathlum +1",
    neck="Baetyl Pendant",
    ear1="Regal Earring",
    ear2="Friomisi Earring",
    body="Cohort Cloak +1",
    hands="Amalric Gages +1",
    ring1="Metamor. Ring +1",
    ring2="Shiva Ring +1",
    back="Aurist's Cape +1",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1"
}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
	ammo="Ghastly Tathlum +1",
    neck="Baetyl Pendant",
    ear1="Regal Earring",
    ear2="Dignitary's Earring",
    body="Cohort Cloak +1",
    hands="Amalric Gages +1",
    ring1="Metamor. Ring +1",
    ring2="Shiva Ring +1",
    back="Aurist's Cape +1",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1"
        })
	
    sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
	ammo="Ghastly Tathlum +1",
    neck="Baetyl Pendant",
    ear1="Regal Earring",
    ear2="Friomisi Earring",
	head="Pixie Hairpin +1",
    body="Amalric Doublet +1",
    hands="Amalric Gages +1",
    ring1="Metamor. Ring +1",
    ring2="Archon Ring",
    back="Aurist's Cape +1",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1"
        })
	
    sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Ghastly Tathlum +1",
    neck="Baetyl Pendant",
    ear1="Regal Earring",
    ear2="Friomisi Earring",
    body="Cohort Cloak +1",
    hands="Amalric Gages +1",
    ring1="Metamor. Ring +1",
    ring2="Shiva Ring +1",
    back="Aurist's Cape +1",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1"
        })
	
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Ghastly Tathlum +1",
    neck="Baetyl Pendant",
    ear1="Regal Earring",
    ear2="Friomisi Earring",
    body="Cohort Cloak +1",
    hands="Amalric Gages +1",
    ring1="Metamor. Ring +1",
    ring2="Shiva Ring +1",
    back="Aurist's Cape +1",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1"
        })
	
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Ghastly Tathlum +1",
    neck="Baetyl Pendant",
    ear1="Regal Earring",
    ear2="Friomisi Earring",
    body="Cohort Cloak +1",
    hands="Amalric Gages +1",
    ring1="Metamor. Ring +1",
    ring2="Shiva Ring +1",
    back="Aurist's Cape +1",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1"
        })
	
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })
	
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })

    sets.midcast['Blue Magic'].MagicAccuracy = {
		ammo="Ghastly Tathlum +1",
    neck="Baetyl Pendant",
    ear1="Regal Earring",
    ear2="Friomisi Earring",
    body="Cohort Cloak +1",
    hands="Amalric Gages +1",
    ring1="Metamor. Ring +1",
    ring2="Shiva Ring +1",
    back="Aurist's Cape +1",
    waist="Orpheus's Sash",
    legs="Luhlaza Shalwar +3",
    feet="Amalric Nails +1"
        }

    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {head="Luh. Keffiyeh +3"})
	
    sets.midcast['Blue Magic'].StunPhysical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })
	
    sets.midcast['Blue Magic'].StunMagical = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Blue Magic'].Healing = {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        }
	
    sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        }) 
	
    sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })

    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic']
    --sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {head="Amalric Coif +1", waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']

    sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        }) -- 1 shadow per 50 skill
	
    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        })
	
    sets.midcast['Enhancing Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Atzintli Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back="Aurist's Cape +1",
        }
	--
    --sets.midcast.EnhancingDuration = {
    --    head=gear.Telchine_ENH_head,
    --    body=gear.Telchine_ENH_body,
    --    hands=gear.Telchine_ENH_hands,
    --    legs=gear.Telchine_ENH_legs,
    --    feet=gear.Telchine_ENH_feet,
    --    }
	--
    --sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1", waist="Gishdubar Sash", back="Grapevine Cape"})
    --sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {waist="Siegel Sash"})
	--
    --sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration, {
    --    body=gear.Taeon_Phalanx_body, --3(10)
    --    hands=gear.Taeon_Phalanx_hands, --3(10)
    --    legs=gear.Taeon_Phalanx_legs, --3(10)
    --    feet=gear.Taeon_Phalanx_feet, --3(10)
    --    })
	--
    --sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    --    head="Amalric Coif +1",
    --    hands="Regal Cuffs",
    --    waist="Emphatikos Rope",
    --    })
	--
    --sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
    --sets.midcast.Protectra = sets.midcast.Protect
    --sets.midcast.Shell = sets.midcast.Protect
    --sets.midcast.Shellra = sets.midcast.Protect
	--
    --sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
    --    head=empty;
    --    body="Cohort Cloak +1",
    --    ear2="Vor Earring",
    --    })
	--
    --sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	--
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		body="Assim. Jubbah +3",
		hands="Nyame Gauntlets",
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets",
		neck="Loricate Torque",
		waist="Flume Belt +1",
		left_ear="Allegro Earring",
		right_ear="Suppanomimi",
		left_ring="Defending Ring",
		right_ring="Patricius Ring",
		back="Aurist's Cape +1",
        }

    sets.idle.DT = {
	ammo="Amar Cluster",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Malignance Gloves",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Bathy Choker +1",
    waist="Svelt. Gouriz +1",
    left_ear="Infused Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinious Ring +1",
	back={ name="Rosmerta's Cape", augments={'Evasion +3','Fast Cast +10%','Eva.+20/Mag. Eva._+20',}}
   }
   
     

    sets.idle.Town = set_combine(sets.idle, {
		ammo="Pemphredo Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Loricate Torque",
		waist="Flume Belt +1",
		left_ear="Allegro Earring",
		right_ear="Suppanomimi",
		left_ring="Defending Ring",
		right_ring="Patricius Ring",
		back="Aurist's Cape +1",
        })

    sets.idle.Weak = sets.idle.DT

    --sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
	

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
	ammo="Coiste Bodhar",
    head="Adhemar Bonnet +1",
    neck="Mirage Stole +2",
    ear1="Dedition Earring", 
    ear2="Telos Earring",
    body="Adhemar Jacket +1",
    hands="Adhemar Wrist. +1",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
    waist="Reiki Yotai",
    legs="Samnuha Tights",
    feet="Gleti's Boots",
}

    sets.engaged.LowAcc = set_combine(sets.engaged, {

        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {

        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {

        })

    sets.engaged.STP = set_combine(sets.engaged, {

        })

    -- Base Dual-Wield Values:
    -- * DW6: +37%
    -- * DW5: +35%
    -- * DW4: +30%
    -- * DW3: +25% (NIN Subjob)
    -- * DW2: +15% (DNC Subjob)
    -- * DW1: +10%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {

        } -- 37%

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {

        })

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {

        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {

        })

    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {

        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {

        }) -- 37%

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {

        })

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {

        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {

        })

    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {

        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {

        } -- 27%

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {

        })

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {

        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {

        })

    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {

        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {

        } -- 22%

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {

        })

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {

        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {

        })

    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {

        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {

        } -- 6%

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {

        })

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {

        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {

        })

    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {

        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {

        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.magic_burst = set_combine(sets.midcast['Blue Magic'].Magical, {

        })

    sets.Kiting = {legs="Carmine Cuisses +1"}
    --sets.Learning = {hands="Assim. Bazu. +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.buff.Doom = {

        }

    -- sets.CP = {back="Mecisto. Mantle"}
    sets.TreasureHunter = {head="Volte Cap", hands=gear.Herc_TH_hands, waist="Chaac Belt"}
    sets.midcast.Dia = sets.TreasureHunter
    sets.midcast.Diaga = sets.TreasureHunter
    sets.midcast.Bio = sets.TreasureHunter
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Magical' then
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' then
            equip(sets.midcast['Blue Magic'].HealingSelf)
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
        if spell.english == "Dream Flower" then
            send_command('@timers c "Dream Flower ['..spell.target.name..']" 90 down spells/00098.png')
        elseif spell.english == "Soporific" then
            send_command('@timers c "Sleep ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sheep Song" then
            send_command('@timers c "Sheep Song ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Yawn" then
            send_command('@timers c "Yawn ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Entomb" then
            send_command('@timers c "Entomb ['..spell.target.name..']" 60 down spells/00547.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
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
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    --if state.IdleMode.value == 'Learning' then
    --    equip(sets.Learning)
    --    disable('hands')
    --else
    --    enable('hands')
    --end


    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
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
    if state.TreasureMode.value == 'Tag' then
        msg = msg .. ' TH: Tag |'
    end
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

function update_active_abilities()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Efflux'] = buffactive['Efflux'] or false
    state.Buff['Diffusion'] = buffactive['Diffusion'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
    if state.Buff['Burst Affinity'] and (spellMap == 'Magical' or spellMap == 'MagicalLight' or spellMap == 'MagicalDark' or spellMap == 'Breath') then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        equip(sets.buff['Burst Affinity'])
    end
    if state.Buff.Efflux and spellMap == 'Physical' then
        equip(sets.buff['Efflux'])
    end
    if state.Buff.Diffusion and (spellMap == 'Buffs' or spellMap == 'BlueSkill') then
        equip(sets.buff['Diffusion'])
    end

    if state.Buff['Burst Affinity'] then equip (sets.buff['Burst Affinity']) end
    if state.Buff['Efflux'] then equip (sets.buff['Efflux']) end
    if state.Buff['Diffusion'] then equip (sets.buff['Diffusion']) end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end
--
--function check_moving()
--    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
--        if state.Auto_Kite.value == false and moving then
--            state.Auto_Kite:set(true)
--        elseif state.Auto_Kite.value == true and moving == false then
--            state.Auto_Kite:set(false)
--        end
--    end
--end
--
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
    if player.sub_job == 'WAR' then
        set_macro_page(3, 7)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 7)
    else
        set_macro_page(3, 7)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 30 ' .. lockstyleset)
end