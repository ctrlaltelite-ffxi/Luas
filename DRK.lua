--[[     
=== Features ===
If you want auto Reive detection for Ygnas Resolve+1, and Gavialis Helm for some of your WS, then you will need my User-Globals.lua
Otherwise, you might be able to get away without it.  (not tested)
If you don't usew organizer, then remove the include('organizer-lib') in get_sets() and remove sets.Organizer
This lua has a few MODES you can toggle with hotkeys or macros, and there's a few situational RULES that activate without hotkeys
::MODES::
SouleaterMode 
Status: OFF by default. 
Hotkey: Toggle this with @F9 (window key + F9). 
Macro: /console gs c togggle SouleaterMode
Notes: This mode makes it possible to use Souleater in situations where you would normally avoid using it. When SouleaterMode 
is ON, Souleater will be canceled automatically after the first Weaponskill used. CAVEAT -. If Bloodweapon 
is active, or if Drain's HP Boost buff is active, then Souleater will remain active until the next WS used after 
either buff wears off. 
CapacityMode
Status: OFF by default. 
Hotkey: with ALT + = 
Macro: /console cs c toggle CapacityMode
Notes: It will full-time whichever piece of gear you specify in sets.CapacityMantle 
Extra Info: You can change the default (true|false) status of any MODE by changing their values in job_setup()
::RULES::
Gavialis helm
Status: enabled
Setting: set use_gavialis = true below in job_setup. 
Notes: wslist defines weaponskills uused with Gavialis helm. This is a recent change Jan/2020, as it 
used to be the opposite, where you defined ws's that you didn't want to use it.
Ygna's Resolve +1 
Status: enabled in Reive
Setting: n/a
Notes: Will automatically be used when you're in a reive. If you have my User-Globals.lua this will work
with all your jobs that use mote's includes. Not just this one! 
Moonshade earring
Status: Not used for WS's at 3000 TP. 
Setting: n/a
You can hit F12 to display custom MODE status as well as the default stuff. 
Single handed weapons are handled in the sets.engaged.SW set. (sword + shield, etc.)
::NOTES::
My sets have a specific order, or they will not function correctly. 
sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups or CustomClass]
CombatForm = Haste, DW, SW
CombatWeapon = GreatSword, Scythe, Apocalypse, Ragnarok, Caladbolg, Liberator, Anguta
OffenseMode = Mid, Acc
HybridMode = PDT
CustomMeleeGroups = AM3, AM, Haste
CustomClass = OhShit 
CombatForm Haste is used when Last Resort + Hasso AND either Haste, March, Indi-Haste Geo-Haste is on you.
CombatForm DW will activate with /dnc or /nin AND a weapon listed in drk_sub_weapons equipped offhand. 
SW is active with an empty sub-slot, or a shield listed in the shields = S{} list.  
CombatWeapon GreatSword will activate when you equip a GS listed in gsList in job_setup(). 
CombatWeapon Scythe will activate when you equip a Scythe listed in scytheList in job_setup(). 
Weapons that do not fall into these groups, or have sets by weapon name, will use default sets.engaged
most gear sets derrive themselves from sets.engaged, so try to keep it updated. It's much smarter to derrive sets than to 
completely re-invent each gear set for every weapon. Let your gear inherit. Less code written means less errors. 
CustomMeleeGroups AM3 will activate when Aftermath lvl 3 is up, and CustomMeleeGroups AM will activate when relic Aftermath is up.
There are no empy AM sets for now.
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    -- Weaponskills you want Gavialis helm used with (only considered if use_gavialis = true)
    wsList = S{'Entropy', 'Resolution'}
    -- Greatswords you use. 
    gsList = S{'Malfeasance', 'Macbain', 'Kaquljaan', 'Mekosuchus Blade', 'Ragnarok', 'Raetic Algol', 'Raetic Algol +1', 'Caladbolg', 'Montante +1', 'Albion' }
    scytheList = S{'Liberator', 'Apocalypse', 'Anguta', 'Raetic Scythe', 'Deathbane', 'Twilight Scythe' }
    remaWeapons = S{'Apocalypse', 'Anguta', 'Liberator', 'Caladbolg', 'Ragnarok', 'Redemption'}

    shields = S{'Rinda Shield'}
    -- Mote has capitalization errors in the default Absorb mappings, so we use our own
    absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC', 'Absorb-TP'}
    -- Offhand weapons used to activate DW mode
    swordList = S{"Sangarius", "Sangarius +1", "Usonmunku", "Perun +1", "Tanmogayi"}

end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'Sphere')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')

    war_sj = player.sub_job == 'WAR' or false

    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c toggle SouleaterMode')
    send_command('bind !- gs equip sets.crafting')
    --send_command('bind ^` gs c toggle LastResortMode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Augmented gear
    Niht = {}
    Niht.DarkMagic = {name={ name="Niht Mantle", augments={'Attack+5','Dark magic skill +2','"Drain" and "Aspir" potency +23',}}, augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25'}}
    Niht.WSD = {name={ name="Niht Mantle", augments={'Attack+5','Dark magic skill +2','"Drain" and "Aspir" potency +23',}}, augments={'Attack+14','Dark magic skill +4', '"Drain" and "Aspir" potency +17', 'Weapon skill damage +5%'}}

    Ankou = {}
    Ankou.FC  = { name="Ankou's Mantle", augments={'"Fast Cast"+10',}}
    Ankou.STP = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
    Ankou.DA  = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Ankou.WSD = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    Ankou.VIT = { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	
    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+5','Quadruple Attack +1','Accuracy+17 Attack+17',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Accuracy+25','DEX+1','Weapon skill damage +7%','Accuracy+10 Attack+10',}}
    
    Odyssean.Feet = {}
    Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}

    Valorous = {}
    Valorous.Feet = {}
    Valorous.Body = {}
   
    Valorous.Feet.TH = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
    Valorous.Feet.TP = { name="Valorous Greaves", augments={'Accuracy+27','"Store TP"+6','INT+1',}}
    
    Valorous.Body.STP = { name="Valorous Mail", augments={'Accuracy+30','"Store TP"+6','DEX+3','Attack+14',}}
    Valorous.Body.DA = { name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Dbl.Atk."+4','VIT+4','Attack+6',}}

    sets.TreasureHunter = { 
        head="White rarab cap +1", 
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
     }
 
    sets.Organizer = {
        ear2="Reraise Earring",
        grip="Pearlsack",
        waist="Linkpearl",
        back=Niht.DarkMagic,
    }

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +3"}
    sets.precast.JA['Nether Void']  = {legs="Fallen's Flanchard +3"}
    sets.precast.JA['Dark Seal']    = {head="Fallen's burgeonet +1"}
    sets.precast.JA['Souleater']    = {head="Ignominy Burgeonet +2"}
    sets.precast.JA['Weapn Bash']   = {hands="Ignominy Gauntlets +2"}
    sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +3"}
    sets.precast.JA['Last Resort']  = {back=Ankou.WSD}
    sets.precast.JA['Jump'] = sets.Jump
    sets.precast.JA['High Jump'] = sets.Jump

    sets.Jump = { feet="Ostro Greaves" }

    sets.CapacityMantle  = { back="Aptitude Mantle +1" }
    sets.WSDayBonus      = { head="Gavialis Helm" }
    sets.WSBack          = { back="Trepidity Mantle" }
    
    -- Earring considerations, given Lugra's day/night stats 
    sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
    sets.IshvaraLugra     = { ear1="Ishvara Earring", ear2="Lugra Earring +1" }
    sets.Lugra           = { ear1="Lugra Earring +1" }
    sets.Brutal          = { ear1="Brutal Earring" }
    sets.Ishvara          = { ear1="Ishvara Earring" }

    -- Waltz set (chr and vit) 
    -- sets.precast.Waltz = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
    ammo="Sapience Orb",
    head="Carmine Mask +1",
    neck="Voltsurge Torque",
    ear1="Loquac. Earring",
    ear2="Enchntr. Earring +1",
    body="Fallen's Cuirass +3",
    hands="Leyline Gloves",
    ring1="Prolix Ring",
    ring2="Kishar Ring",
    back="Ankou's Mantle",
    waist="Tempus Fugit +1",
    legs="Enif Cosciales",
    feet="Odyssean Greaves"
}
    
    sets.precast.FC['Drain'] = set_combine(sets.precast.FC, {
        feet="Ratri Sollerets +1" -- macc 33
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { 
        head="Cizin Helm +1",
        neck="Stoicheion Medal" 
    })
    sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
        head="Cizin Helm +1",
    })
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        -- body="Jumalik Mail",
    })

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Impatiens",
        head="Fallen's Burgeonet +1",
        back="Grounded Mantle +1",
        waist="Sailfi Belt +1",
        legs="Carmine Cuisses +1",
        ring2="Weatherspoon Ring", -- 10 macc
        feet=Odyssean.Feet.FC
    }
    -- sets.midcast.Trust =  {
    --     head="Fallen's Burgeonet +1",
    --     hands="Odyssean Gauntlets",
    --     body="Fallen's Cuirass +3",
    --     legs="Carmine Cuisses +1",
    --     feet=Odyssean.Feet.FC
    -- }
    sets.midcast["Apururu (UC)"] = set_combine(sets.midcast.Trust, {
        body="Apururu Unity shirt",
    })

    -- Specific spells
    sets.midcast.Utsusemi = {
        ammo="Impatiens",
        --head="Otomi Helm",
        neck="Incanter's Torque",
        body="Founder's Breastplate",
        hands="Leyline Gloves",
        back="Grounded Mantle +1",
        feet=Odyssean.Feet.FC
    }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum", 
        head="Ratri Sallet", -- 45 macc
        head="Ignominy Burgonet +2", -- 19
        neck="Erra Pendant", -- 10 dark + 17 macc
        ear1="Malignance Earring",
        ear2="Dark Earring", -- 3
        body="	ale Mail",
        hands="Flamma Manopolas +2",
        waist="Casso Sash", -- 5
        ring1="Evanescence Ring", -- 10
        ring2="Archon Ring", 
        back={ name="Niht Mantle", augments={'Attack+5','Dark magic skill +2','"Drain" and "Aspir" potency +23',}}, -- 10
        legs="Fallen's Flanchard +3",  -- 18 + 39macc
        feet="Ratri Sollerets", -- macc 33
    }
	
    sets.midcast.Endark =  {
    ammo="Pemphredo Tathlum",
    head="Ig. Burgonet +3",
    neck="Erra Pendant",
    ear1="Mani Earring",
    ear2="Dark Earring",
    body="Carm. Scale Mail",
    hands="Fall. Fin. Gaunt. +3",
    ring1="Stikini Ring +1",
    ring2="Evanescence Ring",
    back="Niht Mantle",
    waist="Casso Sash",
    legs="Heath. Flanchard +1",
    feet="Rat. Sollerets +1"
}
    	
    sets.midcast['Enfeebling Magic'] = {
        ammo="Pemphredo Tathlum", 
        head="Befouled Crown",
        neck="Erra Pendant", -- 10 + 17 macc
        body="Ignominy cuirass +3",
        hands="Flamma Manopolas +2",
        ring1="Kishar Ring",
        ring2="Regal Ring", -- 10 macc
        waist="Eschan Stone",
        legs="Fallen's Flanchard +3",  -- 18 + 39macc
        back="Aput Mantle",
        feet="Flamma Gambieras +2",
    }

    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum", 
        head="Ratri Sallet", -- 45 macc
        neck="Eddy Necklace", -- 11 matk
        ear1="Malignance Earring",
        ear2="Friomisi Earring", -- 10 matk
        body="Fallen's Cuirass +3",
        hands="Carmine Finger Gauntlets +1",
        ring1="Resonance Ring", -- int 8
        ring2="Regal Ring", -- matk 4
        waist="Eschan Stone", -- macc/matk 7
        legs="Eschite Cuisses", -- matk 25 
        back="Aput Mantle", -- mdmg 10
        feet="Founder's Greaves" -- matk 29
    }

    -- Mix of HP boost, -Spell interruption%, and Dark Skill
    sets.midcast['Dread Spikes'] = {
        ammo="Aqreqaq Bomblet",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		body="Heath. Cuirass +1",
		hands="Ratri Gadlings +1",
		waist="Trance Belt",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Moonbeam Ring",
		legs="Ratri Cuisses +1",
		feet="Ratri Sollerets +1",
		back="Moonbeam Cape",
		}

    -- Drain spells 
    sets.midcast['Drain'] = {
	head="Fall. Burgeonet +3",
    neck="Erra Pendant",
    ear1="Hirudinea Earring",
    ear2="Nehalennia Earring",
    body="Carm. Scale Mail",
    hands="Fall. Fin. Gaunt. +3",
    ring1="Archon Ring",
    ring2="Evanescence Ring",
    back="Niht Mantle",
    waist="Austerity Belt +1",
    legs="Fall. Flanchard +3",
    feet="Ig. Sollerets +3"
}
    -- Absorbs
   sets.midcast.Absorb = {
    ammo="Pemphredo Tathlum",
    head="Ig. Burgonet +2",
    neck="Erra Pendant",
    ear1="Mani Earring",
    ear2="Dark Earring",
    body="Carm. Scale Mail",
    hands="Heath. Gauntlets +1",
    ring1="Kishar Ring",
    ring2="Stikini Ring +1",
    back="Chuparrosa Mantle",
    waist="Casso Sash",
    legs="Fall. Flanchard +3",
    feet="Rat. Sollerets +1"
}
    
    sets.midcast['Blue Magic'] = set_combine(sets.midcast['Dark Magic'], {
        ear2="Gwati Earring", -- 3
        waist="Eschan Stone", -- 5
        ring1="Sangoma Ring", -- 10
        ring2="Weatherspoon Ring", -- 10 macc
        back="Aput Mantle",
        legs="Fallen's Flanchard +3",  -- 18 + 39macc
        feet="Ratri Sollerets" -- macc 33
    })
    -- Ranged for xbow
    sets.precast.RA = {
        --head="Otomi Helm",
        --feet="Ejekamal Boots",
        hands="Carmine Finger Gauntlets +1"
    }
    sets.midcast.RA = {
        ear2="Tripudio Earring",
        ring1="Cacoethic Ring +1",
        waist="Chaac Belt",
    }

    -- WEAPONSKILL SETS
    -- General sets
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
        neck="Abyssal Bead Necklace +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        body="Ignominy cuirass +3",
        hands="Odyssean Gauntlets",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
        waist="Fotia Belt",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1"
    }

    -- RESOLUTION
    -- 86-100% STR
    sets.precast.WS ['Resolution'] = {
		ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+5','"Dbl.Atk."+5','Attack+15',}},
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		left_ring="Flamma Ring",
		right_ring="Petrov Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
		}

    -- TORCLEAVER 
    -- VIT 80%
    sets.precast.WS ['Torcleaver'] = {
    ammo="Knobkierrie",
    head="Ratri Sallet +1",
    body="Ignominy Cuirass +3",
    hands={ name="Odyssean Gauntlets", augments={'Spell interruption rate down -9%','Enmity+4','Weapon skill damage +5%','Accuracy+19 Attack+19',}},
    legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
    feet="Rat. Sollerets +1",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Thrud Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
}

    -- INSURGENCY
    -- 20% STR / 20% INT 
    -- Base set only used at 3000TP to put AM3 up
    sets.precast.WS['Insurgency'] = {
      ammo="Knobkierrie",
		head="Ratri Sallet +1",
		neck="Abyssal Beads +2",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Ignominy Cuirass +3",
		hands="Rat. Gadlings +1",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		 back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		legs="Fall. Flanchard +3",
		feet="Rat. Sollerets +1"
}
    sets.precast.WS['Fell Cleave'] = {
		ammo="Knobkierrie",
		head="Ratri Sallet +1",
		body="Ignominy Cuirass +3",
		hands={ name="Odyssean Gauntlets", augments={'Spell interruption rate down -9%','Enmity+4','Weapon skill damage +5%','Accuracy+19 Attack+19',}},
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet="Rat. Sollerets +1",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		 back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    -- CROSS REAPER
    -- 60% STR / 60% MND
    sets.precast.WS['Cross Reaper'] = {
        ammo="Knobkierrie",
    head="Ratri Sallet +1",
    neck="Abyssal Beads +2",
    ear1="Moonshade Earring",
    ear2="Thrud Earring",
    body="Ignominy Cuirass +3",
    hands="Rat. Gadlings +1",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    waist="Sailfi Belt +1",
    legs="Ratri Cuisses +1",
    feet="Rat. Sollerets +1"
}
 
    -- ENTROPY
    -- 86-100% INT 
    sets.precast.WS['Entropy'] = {
        ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Abyssal Beads +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Petrov Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}

    -- Quietus
    -- 60% STR / MND 
    sets.precast.WS['Quietus'] = {
       ammo="Knobkierrie",
    head="Ratri Sallet +1",
    neck="Abyssal Beads +2",
    ear1="Moonshade Earring",
    ear2="Thrud Earring",
    body="Ignominy Cuirass +3",
    hands="Rat. Gadlings +1",
    ring1="Niqmaddu Ring",
    ring2="Epaminondas's Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    waist="Sailfi Belt +1",
    legs="Ratri Cuisses +1",
    feet="Rat. Sollerets +1"
}

    -- SPIRAL HELL
    -- 50% STR / 50% INT 
    sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
        neck="Abyssal Bead Necklace +1",
        body="Ignominy cuirass +1",
        legs="Fallen's Flanchard +3",  
        waist="Metalsinger belt",
    })

    -- SHADOW OF DEATH
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
        head="Pixie Hairpin +1",
        neck="Abyssal Bead Necklace +2",
        body="Fallen's Cuirass +3",
        ear1="Friomisi Earring",
        hands="Carmine Finger Gauntlets +1",
        ring2="Archon Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        legs="Fallen's Flanchard +3",  
        feet="Ratri Cuisses",
        waist="Eschan Stone", -- macc/matk 7
        feet="Ratri Sollerets"
    })

    -- Sword WS's
    -- SANGUINE BLADE
    -- 50% MND / 50% STR Darkness Elemental
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        head="Pixie Hairpin +1",
        neck="Abyssal Bead Necklace +1",
        ear1="Friomisi Earring",
        body="Fallen's Cuirass +3",
        hands="Founder's Gauntlets",
        ring1="Archon Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        feet="Heathen's Sollerets +1"
    })

    -- REQUISCAT
    -- 73% MND - breath damage
    sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",
        neck="Abyssal Bead Necklace +1",
        body="Ignominy cuirass +1",
        hands="Odyssean Gauntlets",
        waist="Soil Belt",
    })

    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum",
		head="Ratri Sallet",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Carmine Cuisses +1",
		feet="Sulev. Leggings +2",
		neck="Sanctity Necklace",
		waist="Flume Belt",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Karieyh Ring",
		right_ring="Defending Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
		}
    sets.idle.Town = set_combine(sets.idle, {
        ammo="Aurgelmir Orb",
        head="Ratri Sallet +1",
        neck="Abyssal Bead Necklace +2",
        ear1="Dedition Earring",
        ear2="TelosEarring",
        body="Tartarus Platemail",
        --body="Ratri Breastplate +1",
        hands="Ratri Gadlings",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=Ankou.DA,
        waist="Sailfi Belt +1",
        legs="Carmine Cuisses +1",
        feet="Ratri Sollerets +1"
    })

    sets.idle.Field = set_combine(sets.idle, { 
        head="Ratri Sallet"
    })
    sets.idle.Regen = set_combine(sets.idle.Field, {
        head="",
        neck="Sanctity Necklace",
        body="Lugra Cloak +1",
        ear2="Infused Earring",
        ring1="Paguroidea Ring",
    })
    sets.idle.Refresh = set_combine(sets.idle.Regen, {
        head="Befouled Crown",
        body="Jumalik mail",
        neck="Coatl Gorget +1"
    })

    sets.idle.Weak = set_combine(sets.defense.PDT, {
        head="Hjarrandi Helm",
        neck="Sanctity Necklace",
        body="Tartarus Platemail",
        hands="Volte Moufles",
        ring1="Paguroidea Ring",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Flume Belt",
        legs="Sulevia's Cuisses +2",
        feet="Volte Sollerets"
    })
    sets.idle.Sphere = set_combine(sets.idle, { body="Makora Meikogai"  })

    -- Defense sets
    sets.defense.PDT = {
    ammo="Staunch Tathlum",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Twilight Torque",
    waist="Flume Belt +1",
    left_ear="Thrud Earring",
    right_ear="Impreg. Earring",
    left_ring="Defending Ring",
    right_ring="Sulevia's Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-3%',}},
    }
	
    sets.defense.Reraise = sets.idle.Weak

    sets.defense.MDT = set_combine(sets.defense.PDT, {
        head="Hjarrandi Helm", -- no haste
        neck="Twilight Torque",
        body="Tartarus Platemail",
        ear1="Etiolation Earring",
        back="Impassive Mantle",
    })

    sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- sets.HighHaste = {
    --     ammo="Aurgelmir Orb",
    --     head="Argosy Celata",
    -- }

    -- Defensive sets to combine with various weapon-specific sets below
    -- These allow hybrid acc/pdt sets for difficult content
    -- do not specify a cape so that DA/STP capes are used appropriately
    sets.Defensive = {
        --sub="Gracile grip",
        ammo="Hasty Pinion +1",
        head="Hjarrandi Helm", -- 10% dt
        neck="Agitator's Collar", -- 4% pdt
        body="Tartarus Platemail", -- 10% dt
        hands="Volte Moufles",
        ring1="Niqmaddu Ring", 
        ring2="Defending Ring", -- 10% dt
        waist="Sailfi Belt +1",
        feet="Volte Sollerets"  -- 4% pdt | 6% mdt
    }
    sets.Defensive_Mid = {
        ammo="Hasty Pinion +1",
        head="Hjarrandi Helm", -- no haste
        neck="Agitator's Collar", -- 4% pdt
        body="Tartarus Platemail",
        hands="Volte Moufles",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        waist="Sailfi Belt +1",
        feet="Volte Sollerets" 
    }
    -- Higher DT, less haste
    sets.DefensiveHigh = set_combine(sets.Defensive, {
    ammo="Staunch Tathlum",
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Twilight Torque",
    waist="Flume Belt +1",
    left_ear="Thrud Earring",
    right_ear="Impreg. Earring",
    left_ring="Defending Ring",
    right_ring="Sulevia's Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-3%',}},
    })
    sets.Defensive_Acc = set_combine(sets.Defensive_Mid, sets.DefensiveHigh)

    -- Base set (global catch-all set)
    sets.engaged = {
    ammo="Aurgelmir Orb",
    head={ name="Odyssean Helm", augments={'Crit. hit damage +2%','Crit.hit rate+3','Quadruple Attack +2','Accuracy+13 Attack+13','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist="Sailfi Belt +1",
    left_ear="Telos Earring",
    right_ear="Dignitary's earring",
    left_ring="Chirich Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-3%',}},
}
    sets.engaged.Mid = set_combine(sets.engaged, {
        ear2="Telos Earring",
        ring2="Regal Ring",
        body=Valorous.Body.STP
    })
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        -- ammo="Hasty Pinion +1",
        ear1="Telos Earring",
        ear2="Dignitary's Earring",
        body="Flamma Korazin +2",
        waist="Ioskeha Belt",
        back=Ankou.STP,
    })

    -- These only apply when delay is capped.
    sets.engaged.Haste = set_combine(sets.engaged, {
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Mid = set_combine(sets.engaged.Mid, {
        waist="Sailfi Belt +1",
        --waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Acc = set_combine(sets.engaged.Acc, {})

    -- Hybrid
    sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

    -- Hybrid with capped delay
    sets.engaged.Haste.PDT = set_combine(sets.engaged.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Mid.PDT = set_combine(sets.engaged.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Acc.PDT = set_combine(sets.engaged.Acc.PDT, sets.DefensiveHigh)

    -- Liberator
    sets.engaged.Liberator = sets.engaged
    sets.engaged.Liberator.Mid = sets.engaged.Mid
    sets.engaged.Liberator.Acc = set_combine(sets.engaged.Acc, {
    body="Flamma Korazin +2",
    })

    -- Liberator AM3
    sets.engaged.Liberator.AM3 = set_combine(sets.engaged.Liberator, {
        ammo="Aurgelmir Orb",
        head="Flamma Zucchetto +2",
        body="Flamma Korazin +2",
        neck="Abyssal Bead Necklace +2",
        hands="Flamma Manopolas +2",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Niqmaddu Ring",
        ring2="Hetairoi Ring",
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-3%',}},
        waist="Sailfi Belt +1",
        legs="Odyssean Cuisses",
        feet="Flamma Gambieras +2",
    })
    sets.engaged.Liberator.Mid.AM3 = set_combine(sets.engaged.Liberator.AM3, {
        neck="Abyssal Bead Necklace +1",
        ear1="Telos Earring",
        legs=Odyssean.Legs.TP,
    })
    sets.engaged.Liberator.Acc.AM3 = set_combine(sets.engaged.Liberator.Mid.AM3, {
        ammo="Seething Bomblet +1",
        ear1="Telos Earring",
        ear2="Telos Earring",
        body="Flamma Korazin +2",
        ring2="Regal Ring",
        waist="Ioskeha Belt",
        legs="Ignominy Flanchard +1",
        feet="Flamma Gambieras +2"
    })
    sets.engaged.Haste.Liberator = set_combine(sets.engaged.Liberator, {
        --waist="Windbuffet Belt +1"
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Liberator.Mid = set_combine(sets.engaged.Liberator.Mid, {
        --waist="Windbuffet Belt +1"
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Liberator.Acc = sets.engaged.Liberator.Acc
    
    sets.engaged.Haste.Liberator.AM3 = set_combine(sets.engaged.Liberator.AM3, {
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Liberator.Mid.AM3 = sets.engaged.Liberator.Mid.AM3
    sets.engaged.Haste.Liberator.Acc.AM3 = sets.engaged.Liberator.Acc.AM3
    
    -- Hybrid
    sets.engaged.Liberator.PDT = set_combine(sets.engaged.Liberator, {
        ammo="Hasty Pinion +1",
        head="Hjarrandi Helm",
        body="Tartarus Platemail",
        neck="Abyssal Bead Necklace +1",
        hands="Volte Moufles",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Sailfi Belt +1",
        feet="Volte Sollerets" 
    })
    sets.engaged.Liberator.Mid.PDT = set_combine(sets.engaged.Liberator.PDT, {
        ear1="Telos Earring",
    })
    sets.engaged.Liberator.Acc.PDT = set_combine(sets.engaged.Liberator.Acc, sets.DefensiveHigh)
    -- Hybrid with AM3 up
    sets.engaged.Liberator.PDT.AM3 = set_combine(sets.engaged.Liberator.AM3, sets.Defensive)
    sets.engaged.Liberator.Mid.PDT.AM3 = set_combine(sets.engaged.Liberator.Mid.AM3, sets.Defensive_Mid)
    sets.engaged.Liberator.Acc.PDT.AM3 = set_combine(sets.engaged.Liberator.Acc.AM3, sets.DefensiveHigh)
    -- Hybrid with capped delay
    sets.engaged.Haste.Liberator.PDT = set_combine(sets.engaged.Liberator.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Mid.PDT = set_combine(sets.engaged.Liberator.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Acc.PDT = set_combine(sets.engaged.Liberator.Acc.PDT, sets.DefensiveHigh)
    -- Hybrid with capped delay + AM3 up
    sets.engaged.Haste.Liberator.PDT.AM3 = set_combine(sets.engaged.Liberator.PDT.AM3, sets.Defensive)
    sets.engaged.Haste.Liberator.Mid.PDT.AM3 = set_combine(sets.engaged.Liberator.Mid.PDT.AM3, sets.Defensive_Mid)
    sets.engaged.Haste.Liberator.Acc.PDT.AM3 = set_combine(sets.engaged.Liberator.Acc.PDT.AM3, sets.DefensiveHigh)

    -- Apocalypse
    sets.engaged.Apocalypse = set_combine(sets.engaged, {
        ear1="Telos Earring",
        ear2="Brutal Earring",
        body=Valorous.Body.DA,
        hands="Sulevia's Gauntlets +2",
        ring2="Hetairoi Ring",
        back=Ankou.DA
    })
    sets.engaged.Apocalypse.Mid = set_combine(sets.engaged.Mid, {
        ear1="Telos Earring",
        ear2="TelosEarring",
        ring2="Regal Ring",
        hands="Sulevia's Gauntlets +2",
        back=Ankou.DA
    })
    sets.engaged.Apocalypse.Acc = set_combine(sets.engaged.Acc, {
        ammo="Seething Bomblet +1",
        ear1="Telos Earring",
        ear2="TelosEarring",
        body="Flamma Korazin +2",
        hands="Sulevia's Gauntlets +2",
        back=Ankou.DA
    })
    
    -- sets.engaged.Apocalypse.AM = set_combine(sets.engaged.Apocalypse, {})
    -- sets.engaged.Apocalypse.Mid.AM = set_combine(sets.engaged.Apocalypse.AM, {})
    -- sets.engaged.Apocalypse.Acc.AM = set_combine(sets.engaged.Apocalypse.Mid.AM, {
    --     ring2="Cacoethic Ring +1",
    --     waist="Ioskeha Belt"
    -- })
    sets.engaged.Haste.Apocalypse = set_combine(sets.engaged.Apocalypse, {
        --waist="Windbuffet Belt +1"
        waist="Sailfi Belt +1",
    })
    sets.engaged.Haste.Apocalypse.Mid = sets.engaged.Apocalypse.Mid
    sets.engaged.Haste.Apocalypse.Acc = sets.engaged.Apocalypse.Acc

    -- Hybrid
    sets.engaged.Apocalypse.PDT = set_combine(sets.engaged.Apocalypse, {
        head="Hjarrandi Helm",
        neck="Abyssal Bead Necklace +1",
        body="Tartarus Platemail",
        hands="Volte Moufles",
        ring2="Defending Ring",
        back=Ankou.DA,
        waist="Sailfi Belt +1",
        feet="Volte Sollerets" 
    })
    sets.engaged.Apocalypse.Mid.PDT = set_combine(sets.engaged.Apocalypse.Mid, sets.Defensive_Mid)
    sets.engaged.Apocalypse.Acc.PDT = set_combine(sets.engaged.Apocalypse.Acc, sets.Defensive_Acc)
    -- Hybrid with relic AM 
    -- sets.engaged.Apocalypse.PDT.AM = set_combine(sets.engaged.Apocalypse, sets.Defensive)
    -- sets.engaged.Apocalypse.Mid.PDT.AM = set_combine(sets.engaged.Apocalypse.Mid, sets.Defensive_Mid)
    -- sets.engaged.Apocalypse.Acc.PDT.AM = set_combine(sets.engaged.Apocalypse.Acc, sets.Defensive_Acc)
    -- Hybrid with capped delay
    sets.engaged.Haste.Apocalypse.PDT = set_combine(sets.engaged.Apocalypse.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Mid.PDT = set_combine(sets.engaged.Apocalypse.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Acc.PDT = set_combine(sets.engaged.Apocalypse.Acc.PDT, sets.DefensiveHigh)
    -- Hybrid with capped delay + AM3 up
    -- sets.engaged.Haste.Apocalypse.PDT.AM3 = set_combine(sets.engaged.Apocalypse.PDT.AM3, sets.DefensiveHigh)
    -- sets.engaged.Haste.Apocalypse.Mid.PDT.AM3 = set_combine(sets.engaged.Apocalypse.Mid.PDT.AM3, sets.DefensiveHigh)
    -- sets.engaged.Haste.Apocalypse.Acc.PDT.AM3 = set_combine(sets.engaged.Apocalypse.Acc.PDT.AM3, sets.DefensiveHigh)

    -- generic scythe
    sets.engaged.Scythe = set_combine(sets.engaged, {})
    sets.engaged.Scythe.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.Scythe.Acc = set_combine(sets.engaged.Acc, {})

    sets.engaged.Scythe.PDT = set_combine(sets.engaged.Scythe, sets.Defensive)
    sets.engaged.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid, sets.Defensive_Mid)
    sets.engaged.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc, sets.Defensive_Acc)

    sets.engaged.Haste.Scythe = set_combine(sets.engaged.Haste, {})
    sets.engaged.Haste.Scythe.Mid = set_combine(sets.engaged.Haste.Mid, {})
    sets.engaged.Haste.Scythe.Acc = set_combine(sets.engaged.Haste.Acc, {})

    sets.engaged.Haste.Scythe.PDT = set_combine(sets.engaged.Scythe.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc.PDT, sets.DefensiveHigh)

    -- generic great sword
    sets.engaged.GreatSword = set_combine(sets.engaged, {
        hands="Flamma Manopolas +2"
    })
    sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
        body="Flamma Korazin +2",
        legs="Ignominy Flanchard +1",
    })

    sets.engaged.GreatSword.PDT = set_combine(sets.engaged.GreatSword, sets.Defensive)
    sets.engaged.GreatSword.Mid.PDT = set_combine(sets.engaged.GreatSword.Mid, sets.Defensive_Mid)
    sets.engaged.GreatSword.Acc.PDT = set_combine(sets.engaged.GreatSword.Acc, sets.Defensive_Acc)

    sets.engaged.Haste.GreatSword = set_combine(sets.engaged.Haste, {})
    sets.engaged.Haste.GreatSword.Mid = set_combine(sets.engaged.Haste.Mid, {})
    sets.engaged.Haste.GreatSword.Acc = set_combine(sets.engaged.Haste.Acc, {})

    sets.engaged.Haste.GreatSword.PDT = set_combine(sets.engaged.GreatSword.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.GreatSword.Mid.PDT = set_combine(sets.engaged.GreatSword.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.GreatSword.Acc.PDT = set_combine(sets.engaged.GreatSword.Acc.PDT, sets.DefensiveHigh)

    -- Ragnarok
    sets.engaged.Ragnarok = set_combine(sets.engaged.GreatSword, {})
    sets.engaged.Ragnarok.Mid = set_combine(sets.engaged.GreatSword.Mid, {})
    sets.engaged.Ragnarok.Acc = set_combine(sets.engaged.GreatSword.Acc, {})
    
    sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok, sets.Defensive)
    sets.engaged.Ragnarok.Mid.PDT = set_combine(sets.engaged.Ragnarok.Mid, sets.Defensive_Mid)
    sets.engaged.Ragnarok.Acc.PDT = set_combine(sets.engaged.Ragnarok.Acc, sets.Defensive_Acc)
    
    -- Caladbolg
    sets.engaged.Caladbolg = set_combine(sets.engaged.GreatSword, {
        hands="Sulevia's Gauntlets +2",
        body=Valorous.Body.DA,
        back=Ankou.DA
    })
    sets.engaged.Caladbolg.Mid = set_combine(sets.engaged.GreatSword.Mid, {
        hands="Sulevia's Gauntlets +2",
        ear2="TelosEarring",
        ring2="Regal Ring",
        back=Ankou.DA
    })
    sets.engaged.Caladbolg.Acc = set_combine(sets.engaged.GreatSword.Acc, {
        ammo="Seething Bomblet +1",
        hands="Flamma Manopolas +2",
        body="Flamma Korazin +2",
        legs="Ignominy Flanchard +1",
        back=Ankou.DA
    })
    
    sets.engaged.Caladbolg.PDT = set_combine(sets.engaged.Caladbolg, sets.Defensive)
    sets.engaged.Caladbolg.Mid.PDT = set_combine(sets.engaged.Caladbolg.Mid, sets.Defensive_Mid)
    sets.engaged.Caladbolg.Acc.PDT = set_combine(sets.engaged.Caladbolg.Acc, sets.Defensive_Acc)
    
    sets.engaged.Haste.Caladbolg = set_combine(sets.engaged.Caladbolg, { 
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Caladbolg.Mid = set_combine(sets.engaged.Caladbolg.Mid, {
        hands="Sulevia's Gauntlets +2",
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Caladbolg.Acc = set_combine(sets.engaged.Caladbolg.Acc, {
        hands="Sulevia's Gauntlets +2",
    })

    sets.engaged.Haste.Caladbolg.PDT = set_combine(sets.engaged.Caladbolg.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Caladbolg.Mid.PDT = set_combine(sets.engaged.Caladbolg.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Caladbolg.Acc.PDT = set_combine(sets.engaged.Caladbolg.Acc.PDT, sets.DefensiveHigh)
    
    -- dual wield
    sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        hands="Emicho Gauntlets",
        waist="Patentia Sash",
        legs="Carmine Cuisses +1",
    })
    sets.engaged.DW.Mid = set_combine(sets.engaged.DW, {
        neck="Abyssal Bead Necklace +1",
    })
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW.Mid, {
        ear2="TelosEarring",
    })

    -- single wield (sword + shield possibly)
    sets.engaged.SW = set_combine(sets.engaged, {
        ammo="Yetshila",
    })
    sets.engaged.SW.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.SW.Acc = set_combine(sets.engaged.Acc, {})

    sets.engaged.Reraise = set_combine(sets.engaged, {
        head="Twilight Helm",
        neck="Twilight Torque",
        body="Twilight Mail"
    })

    sets.buff.Souleater = { 
        head="Ignominy Burgonet +2 +2",
        --body="Ratri Breastplate",
    }
    sets.MadrigalBonus = {
        hands="Composer's Mitts"
    }
    sets.buff['Last Resort'] = { 
		feet="Fallen's Sollerets +1" ,
    }
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_precast(spell)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Drain') then
        if player.status == 'Engaged' and state.CastingMode.current == 'Normal' and player.hpp < 70 then
            classes.CustomClass = 'OhShit'
        end
    end

    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_aftercast(spell)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Souleater and state.SouleaterMode.value then
            send_command('@wait 1.0;cancel souleater')
            --enable("head")
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 50 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    elseif player.mpp < 50 then
        idleSet = set_combine(idleSet, sets.idle.Refresh)
    end
    if state.IdleMode.current == 'Sphere' then
        idleSet = set_combine(idleSet, sets.idle.Sphere)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff['Souleater'] then
        meleeSet = set_combine(meleeSet, sets.buff.Souleater)
    end
    --meleeSet = set_combine(meleeSet, select_earring())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

    war_sj = player.sub_job == 'WAR' or false
    select_default_macro_book()
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
--function th_action_check(category, param)
--    if category == 2 or -- any ranged attack
--        --category == 4 or -- any magic action
--        (category == 3 and param == 30) or -- Aeolian Edge
--        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
--        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
--        then 
--            return true
--    end
--end
 function get_custom_wsmode(spell, spellMap, default_wsmode)
     if state.OffenseMode.current == 'Mid' then
         if buffactive['Aftermath: Lv.3'] then
             return 'AM3Mid'
         end
     elseif state.OffenseMode.current == 'Acc' then
         if buffactive['Aftermath: Lv.3'] then
             return 'AM3Acc'
         end
     else
         if buffactive['Aftermath: Lv.3'] then
             return 'AM3'
         end
     end
 end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_weapon()
    state.CombatWeapon:reset()
    if remaWeapons:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
     if remaWeapons:contains(player.equipment.main) then
         state.CombatWeapon:set(player.equipment.main)
     elseif gsList:contains(player.equipment.main) then
         state.CombatWeapon:set("GreatSword")
     elseif scytheList:contains(player.equipment.main) then
         state.CombatWeapon:set("Scythe")
     end
end

function aw_custom_aftermath_timers_precast(spell)
	update_melee_groups()
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

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.CombatForm.current ~= '' then 
        msg = msg .. ', Form: ' .. state.CombatForm.current 
    end
    if state.CombatWeapon.current ~= '' then 
        msg = msg .. ', Weapon: ' .. state.CombatWeapon.current 
    end
    if state.CapacityMode.value then
        msg = msg .. ', Capacity: ON, '
    end
    if state.SouleaterMode.value then
        msg = msg .. ', SE Cancel, '
    end
    -- if state.LastResortMode.value then
    --     msg = msg .. ', LR Defense, '
    -- end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Dark Magic' and absorbs:contains(spell.english) then
        return 'Absorb'
    end
    -- if spell.type == 'Trust' then
    --     return 'Trust'
    -- end
end

function select_earring()
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.Lugra
    else
        return sets.Brutal
    end
end

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

function select_default_macro_book()
    -- Default macro set/book
        -- set_macro_page(5, 4)
    -- if player.sub_job == 'DNC' then
    --     set_macro_page(8, 4)
    if scytheList:contains(player.equipment.main) then
        set_macro_page(1, 2)
    elseif gsList:contains(player.equipment.main) then
        set_macro_page(1, 2)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end