include('organizer-lib')

--[[
Things I need to add/ could use help adding are....

1.) line ~1280 : how to get holy waters to equip rings
2.) Add a rule that when doomed - will auto matically use holy waters w/ rings
3.) a Toggle to lock weapon/sub for when I was to use sword/shield/gax manuallly for armor break etc
4.) rule that when arcane circle is up, locks founder's body for tp and ws gear w/ added stp for difference
5.) a check to make sure sams roll is lucky or not, so only use .STP sets when lucky rolls and not-unlucky
6.) figure out weapon customized PDT sets, hybrid works currently, PDT does not and idk why.
7.) when using a ws, will let me know self sc options through chat

]] --

function get_sets()

    -- 3 Levels Of Accuracy Sets For TP/WS/Hybrid/Stun. First Set Is LowACC. 
    -- Add More ACC Sets If Needed Then Create Your New ACC Below. 
    AccIndex = 1
    AccArray = {"LowACC", "MidACC", "HighACC"}
    MaccIndex = 1
    MaccArray = {"Potency", "Resist", "Duration"}
    -- Can Delete Any Weapons/Sets That You Don't Need Or Replace/Add The New Weapons That You Want To Use. --
    WeaponIndex = 1
    WeaponArray = {"Caladbolg", "Naegling", "Sakpata's Sword"} -- ,"Liberator"
    IdleIndex = 1
    IdleArray = {"Movement", "Regen", "Refresh", "Regain"} -- Default Idle Set Is Movement --
    DarkSealIndex = 0 -- Index for Dark Seal headpiece Potency(0) vs Duration(1)
    -- add_to_chat(158,'DarkSeal Potency: [On]')
    Armor = 'None'
    Twilight = 'None'
    Samurai_Roll = 'ON' -- Set Default SAM Roll ON or OFF Here --
    target_distance = 5 -- Set Default Distance Here --
    select_default_macro_book() -- Change Default Macro Book At The End --

    Ankou = {}
    Ankou.WSDSTR = {
        name = "Ankou's Mantle",
        augments = {
            'STR+20', 'Accuracy+20 Attack+20', 'STR+10',
            'Weapon skill damage +10%'
        }
    }
    Ankou.DA = {
        name = "Ankou's Mantle",
        augments = {'STR+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10'}
    }
    Ankou.WSDVIT = {
        name = "Ankou's Mantle",
        augments = {'VIT+20', 'Weapon skill damage +10%'}
    }
    Ankou.FC = {
        name = "Ankou's Mantle",
        augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Fast Cast"+10'}
    }
    Ankou.STP = {
        name = "Ankou's Mantle",
        augments = {
            'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10'
        }
    }
    Ankou.INTDA = {
        name = "Ankou's Mantle",
        augments = {
            'INT+20', 'Accuracy+20 Attack+20', 'INT+10', '"Dbl.Atk."+10'
        }
    }
    Ankou.MEVA = {
        name = "Ankou's Mantle",
        augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Fast Cast"+10'}
    }

    sets.Idle = {
        ammo = "Coiste Bodhar",
        neck = "Twilight torque",
        ear1 = "Genmei Earring",
        ear2 = "Infused Earring",
        head = "Sakpata's helm",
        body = "Chozoron coselete",
        hands = "Sakpata's gauntlets",
        left_ring = "Apeile ring +1",
        right_ring = "Stikini ring +1",
        back = Ankou.DA,
        waist = "Flume belt",
        legs = "Carmine cuisses +1",
        feet = "Sakpata's leggings"
    }

    -- Regen Set --
    sets.Idle.Regen = set_combine(sets.Idle, {ring2 = "Chirich Ring +1"})
    sets.Idle.Regen.Liberator = set_combine(sets.Idle.Regen,
                                            {main = "Liberator"})
    sets.Idle.Regen.Ragnarok = set_combine(sets.Idle.Regen, {main = "Ragnarok"})
    sets.Idle.Regen.Caladbolg = set_combine(sets.Idle.Regen,
                                            {main = "Caladbolg"})
    sets.Idle.Regen.Apocalypse = set_combine(sets.Idle.Regen,
                                             {main = "Apocalypse"})
    sets.Idle.Regen.Anguta = set_combine(sets.Idle.Regen, {main = "Anguta"})

    -- Movement Sets --
    sets.Idle.Movement = set_combine(sets.Idle, {legs = "Carmine Cuisses +1"})
    sets.Idle.Movement.Liberator = set_combine(sets.Idle.Movement,
                                               {main = "Liberator"})
    sets.Idle.Movement.Ragnarok = set_combine(sets.Idle.Movement,
                                              {main = "Ragnarok"})
    sets.Idle.Movement.Caladbolg = set_combine(sets.Idle.Movement,
                                               {main = "Caladbolg"})
    sets.Idle.Movement.Apocalypse = set_combine(sets.Idle.Movement,
                                                {main = "Apocalypse"})
    sets.Idle.Movement.Anguta = set_combine(sets.Idle.Movement,
                                            {main = "Anguta"})

    -- Refresh Sets --
    sets.Idle.Refresh = set_combine(sets.Idle, {
        neck = "Vim Torque +1",
        body = "Lugra Cloak +1"
    })
    sets.Idle.Refresh.Liberator = set_combine(sets.Idle.Refresh,
                                              {main = "Liberator"})
    sets.Idle.Refresh.Ragnarok = set_combine(sets.Idle.Refresh,
                                             {main = "Ragnarok"})
    sets.Idle.Refresh.Caladbolg = set_combine(sets.Idle.Refresh,
                                              {main = "Caladbolg"})
    sets.Idle.Refresh.Apocalypse = set_combine(sets.Idle.Refresh,
                                               {main = "Apocalypse"})
    sets.Idle.Refresh.Anguta = set_combine(sets.Idle.Refresh, {main = "Anguta"})

    -- Regain Sets --
    sets.Idle.Regain = set_combine(sets.Idle, {
        head = "Ratri Sallet",
        ammo = "Coiste Bodhar",
        hands = "Sakpata's gauntlets",
        legs = "Ignominy flanchard +3",
        feet = "Sulevia's leggings +2",
        neck = "Abyssal bead necklace +1",
        body = "Ignominy cuirass +3",
        waist = "Sailfi belt +1",
        left_ear = "Cessance earring",
        right_ear = "Enervating Earring",
        left_ring = "Chirich ring +1",
        right_ring = "Chirich Ring +1",
        back = Ankou.STP
    })
    sets.Idle.Regain.Liberator = set_combine(sets.Idle.Regain,
                                             {main = "Liberator"})
    sets.Idle.Regain.Ragnarok = set_combine(sets.Idle.Regain,
                                            {main = "Ragnarok"})
    sets.Idle.Regain.Caladbolg = set_combine(sets.Idle.Regain,
                                             {main = "Caladbolg"})
    sets.Idle.Regain.Apocalypse = set_combine(sets.Idle.Regain,
                                              {main = "Apocalypse"})
    sets.Idle.Regain.Anguta = set_combine(sets.Idle.Regain, {main = "Anguta"})

    -- JA Sets --
    sets.JA = {}
    sets.JA['Diabolic Eye'] = {hands = "Fallen's finger gauntlets +1"}
    sets.JA['Arcane Circle'] = {
        feet = "Ignominy Sollerets +3",
        body = "Founder's Breastplate"
    }
    sets.JA['Nether Void'] = {legs = "Heath. Flanchard +1"}
    sets.JA['Souleater'] = {head = "Ignominy Burgonet +3"}
    sets.JA['Weapon Bash'] = {hands = "Ignominy Gauntlets +3"}
    sets.JA['Last Resort'] = {
        back = "Ankou's Mantle",
        feet = "Fallen's Sollerets"
    }
    sets.JA['Dark Seal'] = {head = "Fallen's Burgeonet +1"}
    sets.JA['Blood Weapon'] = {body = "Fallen's Cuirass +1"}

    sets.Precast = {}
    -- Fastcast Set --
    sets.Precast.FastCast = {
        ammo = "Impatiens",
        head = "Carmine Mask +1", -- 14
        neck = "Voltsurge Torque", -- 4
        ear1 = "Loquacious Earring", -- 2
        ear2 = "Eabani Earring",
        body = "Ignominy cuirass +3", -- 10
        hands = "Leyline Gloves", -- 8
        ring1 = "Kishar Ring", -- 4
        ring2 = "Weatherspoon Ring", -- 5
        back = Ankou.FC, -- 10
        waist = "Tempus Fugit",
        legs = "Eschite cuisses" -- 8
    } -- 11
    -- 72 FC

    -- Precast Dark Magic --
    sets.Precast['Healing Magic'] = set_combine(sets.Precast.FastCast, {})

    -- Midcast Base Set --
    sets.Midcast = {}

    -- Magic Haste Set --
    sets.Midcast.Haste = set_combine(sets.PDT, {})

    sets.HighEnmity = {
        ammo = "Staunch Tathlum +1",
        neck = "Homeric Gorget",
        ear2 = "Friomisi earring",
        ear1 = "Loquacious Earring",
        body = "Souveran cuirass +1",
        left_ring = "Petrov Ring",
        right_ring = "Apeile Ring +1",
        waist = "Creed Baudrier",
        legs = "Odyssean Cuisses",
        hands = "Souveran handschuhs +1",
        feet = "Eschite Greaves",
    }
    -- Endark Set --
    sets.Midcast['Flash'] = set_combine(sets.HighEnmity, {})

    sets.JA['Provoke'] = set_combine(sets.HighEnmity, {})

    -- Precast Healing Magic --
    sets.Precast['Healing Magic'] = set_combine(sets.Precast.FastCast,
                                                {neck = "Diemer gorget"})

    -- Dark Magic Set --
    sets.Midcast['Healing Magic'] = {
        ammo = "Staunch Tathlum +1",
        body = "Souveran cuirass +1",
        feet = "Eschite Greaves",
        left_ear = "Nourish. Earring",
        right_ear = "Magnetic Earring",
        left_ring = "Menelaus's ring",
        right_ring = "Lebeche ring",
        hands = "Souveran handschuhs +1"
    }

    -- Enfeebling Magic Set --
    sets.Midcast['Enfeebling Magic'] = {
        ammo = "Pemphredo Tathlum",
        head = "Carmine Mask +1",
        body = "Ignominy Cuirass +3",
        hands = "Leyline Gloves",
        legs = "Eschite cuisses",
        feet = "Ignominy Sollerets +3",
        neck = "Sanctity necklace",
        waist = "Eschan Stone",
        left_ear = "Loquacious Earring",
        right_ear = "Hermetic Earring",
        left_ring = "Stikini Ring",
        right_ring = "Stikini Ring",
        back = Ankou.FC
    }

    -- Elemental Magic Set --
    sets.Midcast['Elemental Magic'] = {
        ammo = "Pemphredo Tathlum",
        head = "Carmine Mask +1",
        body = "Carmine Scale Mail",
        hands = "Leyline gloves",
        legs = "Eschite Cuisses",
        feet = "Ignominy Sollerets +3",
        neck = "Sanctity necklace",
        waist = "Eschan Stone",
        left_ear = "Hecate's Earring",
        right_ear = "Friomisi Earring",
        left_ring = "Stikini Ring",
        right_ring = "Shiva Ring",
        back = Ankou.FC
    }

    -- Dread Spikes Set --
    sets.Midcast['Dread Spikes'] = {
        ammo = "Happy Egg",
        head = "Ratri Sallet",
        body = "Heathen's Cuirass +1",
        hands = "Ratri Gadlings",
        legs = "Ratri Cuisses",
        feet = "Ratri Sollerets",
        neck = "Sanctity necklace",
        waist = "Silver moogle belt",
        left_ear = "Insomnia earring",
        right_ear = "Assuage Earring",
        left_ring = "Griffon Ring",
        right_ring = "Moonbeam Ring",
        back = "Moonbeam Cape"
    }

    sets.Midcast.Drain = {
        ammo = "Pemphredo Tathlum",
        neck = "Erra Pendant",
        left_ear = "Hermetic Earring", -- higer macc earring if you got
        right_ear = "Hirudinea Earring",
        head = "Pixie Hairpin +1",
        body = "Carmine Scale Mail",
        hands = "Fallen's finger gauntlets +1",
        left_ring = "Archon Ring", -- use archon if you have it
        right_ring = "Evanescence Ring",
        back = "Niht Mantle",
        waist = "Austerity belt +1",
        legs = "Eschite cuisses",
        feet = "Ratri Sollerets"
    }

    sets.Midcast.Aspir = set_combine(sets.Midcast.Drain, {})

    sets.MAXDrain = {main = "Misanthropy"}

    -- TP Base Set --
    sets.TP = {}
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------	
    ---------------------------------------------------------------- LIBERATOR SETS -----------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------	

    -- Caladbolg /SAM TP Sets -------------------------------------------------------------------

    -- Caladbolg(AM Down) TP Sets --
    sets.TP.Naegling = {
        main = "Naegling",
        sub = "Blurred Shield +1",
        ammo = "Coiste Bodhar",
        head = "Flamma Zucchetto +2",
        hands = "Sakpata's gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Flamma Gambieras +2",
        neck = "Clotharius Torque",
        body = "Sakpata's breastplate",
        waist = "Sailfi belt +1",
        right_ear = "Cessance earring",
        left_ear = "Brutal earring",
        left_ring = "Chirich ring +1",
        right_ring = "Petrov ring",
        back = "Rudiano's Mantle"
    }

    sets.TP.Caladbolg = {
        main = "Caladbolg",
        sub = "Pole Grip",
        ammo = "Coiste Bodhar",
        head = "Flamma Zucchetto +2",
        hands = "Sakpata's gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Flamma Gambieras +2",
        neck = "Clotharius Torque",
        body = "Sakpata's breastplate",
        waist = "Sailfi belt +1",
        right_ear = "Cessance earring",
        left_ear = "Brutal earring",
        left_ring = "Chirich ring +1",
        right_ring = "Petrov ring",
        back = "Rudiano's Mantle"
    }

    sets.TP["Sakpata's Sword"] = set_combine(sets.TP.Naegling, {
        main = "Sakpata's Sword",
        neck = "Homeric Gorget",
        head = "Sakpata's Helm",
        feet = "Sakpata's leggings",
        sub = "Priwen"
    })

    ----------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------

    -- PDT/MDT Sets --
    sets.PDT = set_combine(sets.TP, {
        head = "Sakpata's Helm",
        body = "Sakpata's Breastplate",
        hands = "Sakpata's gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's leggings",
        waist = "Flume belt +1",
        left_ring = "Defending ring",
        back = Ankou.DA
    })

    sets.Twilight = set_combine(sets.PDT, {
        head = "Twilight Helm",
        body = "Twilight Mail"
    })

    sets.MDT = set_combine(sets.PDT, {
        back = "Moonbeam Cape",
        waist = "Tempus Fugit",
        right_ring = "Shadow Ring"
    })

    sets.Scarlet = set_combine(sets.PDT, {})

    -- Hybrid Set --
    sets.TP.Hybrid = set_combine(sets.PDT, {
        waist = "Sailfi Belt +1",
        right_ring = "Moonbeam Ring"
    })

    sets.TP.Hybrid.Liberator = set_combine(sets.TP.Hybrid, {
        main = "Liberator",
        ammo = "Coiste Bodhar"
    })
    sets.TP.Hybrid.Ragnarok = set_combine(sets.TP.Hybrid, {
        main = "Ragnarok",
        ammo = "Coiste Bodhar"
    })
    sets.TP.Hybrid.Caladbolg = set_combine(sets.TP.Hybrid, {
        main = "Caladbolg",
        ammo = "Coiste Bodhar"
    })
    sets.TP.Hybrid.Apocalypse = set_combine(sets.TP.Hybrid, {
        main = "Apocalypse",
        ammo = "Coiste Bodhar"
    })
    sets.TP.Hybrid.Anguta = set_combine(sets.TP.Hybrid, {
        main = "Anguta",
        ammo = "Coiste Bodhar"
    })

    sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid, {
        left_ear = "Cessance Earring",
        body = "Sakpata's Breastplate",
        hands = "Ignominy Gauntlets +3",
        legs = "Ignominy Flanchard +3"
    })

    sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC, {
        ammo = "Coiste Bodhar",
        head = "Ignominy Burgonet +3",
        feet = "Sakpata's Cuisses"
    })

    --[[ Scythe Light:
    Insurgency > Vorpal Scythe > Entropy > Guillotine > Entropy > Insurgency
    Vorpal Scythe > Entropy > Guillotine > Entropy > Insurgency
    Entropy > Guillotine > Entropy > Insurgency
    Guillotine > Entropy > Insurgency
   
-- Scythe Darkness:
    Insurgency (M) > Vorpal Scythe > Vorpal Scythe > Insurgency (M) > Entropy (MM) > Cross Reaper
    Entropy (MM) > Guillotine > Entropy (MM) > Cross Reaper > Entropy (MM)
    Cross Reaper > Insurgency (M) > Entropy (MM) > Cross Reaper
    Insurgency (M) > Entropy (MM) > Cross Reaper
    Cross Reaper > Entropy (MM)
    Entropy (MM) > Cross Reaper
 
-- Apoc Darkness
    Entropy (MM) > Guillotine > Entropy (MM) > Cross Reaper > Entropy (MM) > Catastrophe (R)
    Entropy (MM) > Guillotine > Entropy (MM) > Cross Reaper > Entropy (MM)
    Insurgency (M) > Entropy (MM) > Cross Reaper > Catastrophe (R)
    Insurgency (M) > Catastrophe (R) > Cross Reaper > Catastrophe (R)
    Cross Reaper > Insurgency (M) > Catastrophe (R) > Cross Reaper
    Catastrophe (R) > Cross Reaper > Catastrophe (R)
    Insurgency (M) > Catastrophe (R) > Cross Reaper
    Cross Reaper > Catastrophe (R) > Catastrophe (R)
    Cross Reaper > Entropy (MM) > Catastrophe (R)
    Entropy (MM) > Cross Reaper > Catastrophe (R)
    Catastrophe (R) > Catastrophe (R)
    Catastrophe (R) > Cross Reaper
    Cross Reaper > Catastrophe (R)
 
-- Other Light
    Catastrophe (R) > Savage Blade (Q) > Insurgency (M)
    Entropy (MM) > Savage Blade (Q) > Insurgency (M)
    Savage Blade (Q) > Insurgency (M)
    Chant du Cygne (E) > Torcleaver (E)
 
-- Other Dark
    Atonement (M) > Entropy (MM) > Cross Reaper
    Savage Blade (Q) > Cross Reaper > Entropy (MM)
    Chant du Cygne (E) > Catastrophe (R)
    Chant du Cygne (E) > Entropy (MM)
    Requiescat (MM) > Cross Reaper
    Requiescat (MM) > Torcleaver (E)
 
-- GreatSword
    Resolution (MM) > Torcleaver (E) > Scourge (R) > Resolution (MM) > Torcleaver (E)
    Resolution (MM) > Torcleaver (E) > Scourge (R) > Resolution (MM)
    Resolution (MM) > Scourge (R) > Torcleaver (E)
    Scourge (R) > Resolution (MM) > Torcleaver (E)
    Torcleaver (E) > Torcleaver (E)
    Scourge (R) > Resolution (MM)
--]]

    -- WS Base Set --
    sets.WS = {
        ammo = "Knobkierrie",
        head = "Flamma Zucchetto +2",
        body = "Ignominy Cuirass +3",
        hands = "Sakpata's gauntlets",
        legs = "Ignominy Flanchard +3",
        feet = "Argosy Sollerets +1",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Moonshade earring",
        right_ear = "Cessance earring",
        left_ring = "Chirich ring +1",
        right_ring = "Niqmaddu ring",
        back = Ankou.WSDSTR
    }

    -- Resolution Sets --
    -- Description:	Delivers a fivefold attack. Damage varies with TP.
    -- Stat Modifier:	73~85% STR fTP:	0.71875	1.5	2.25
    sets.WS.Resolution = {
        ammo = "Coiste Bodhar",
        head = "Flamma Zucchetto +2",
        body = "Ignominy Cuirass +3",
        hands = "Sakpata's gauntlets",
        legs = "Ignominy Flanchard +3",
        feet = "Argosy Sollerets +1",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Moonshade earring",
        right_ear = "Brutal earring",
        left_ring = "Chirich ring +1",
        right_ring = "Niqmaddu ring",
        back = Ankou.DA
    }

    sets.WS.Resolution.MidACC = set_combine(sets.WS.Resolution, {
        hands = "Ignominy Gauntlets +3",
        back = Ankou.DA
    })

    sets.WS.Resolution.HighACC = set_combine(sets.WS.Resolution.MidACC, {})

    -- Torcleaver Sets --
    -- Description:	Deals triple damage. Damage varies with TP.
    -- Stat Modifier:	80% VIT fTP:	4.75	7.5	10
    sets.WS.Torcleaver = {
        ammo = "Knobkierrie",
        head = "Odyssean Helm",
        body = "Ignominy Cuirass +3",
        hands = "Odyssean gauntlets",
        legs = "Fallen's flanchard +3",
        feet = "Sulevia's Leggings +2",
        neck = "Abyssal bead necklace +1",
        waist = "Fotia Belt",
        left_ear = "Moonshade earring",
        right_ear = "Thrud earring",
        left_ring = "Epaminondas's ring",
        right_ring = "Niqmaddu ring",
        back = Ankou.WSDVIT
    }

    sets.WS["Savage Blade"] = {
        ammo = "Knobkierrie",
        head = "Odyssean Helm",
        body = "Sakpata's breastplate",
        hands = "Sakpata's gauntlets",
        legs = "Sakpata's cuisses",
        feet = "Sulevia's Leggings +2",
        neck = "Abyssal bead necklace +1",
        waist = "Sailfi Belt +1",
        left_ear = "Moonshade earring",
        right_ear = "Thrud earring",
        left_ring = "Epaminondas's ring",
        right_ring = "Regal ring",
        back = "Cichol's mantle"
    }

    sets.WS.Torcleaver.MidACC = set_combine(sets.WS.Torcleaver, {})

    sets.WS.Torcleaver.HighACC = set_combine(sets.WS.Torcleaver.MidACC, {})

    -- Scourge Sets --
    -- Relic Aftermath: +5% Critical Hit Rate 15 acc
    -- Stat Modifier:	40% STR / 40% VIT	fTP:	3.0
    sets.WS.Scourge = {
        ammo = "Knobkierrie",
        head = "Odyssean Helm",
        body = "Ignominy Cuirass +3",
        hands = "Odyssean gauntlets",
        legs = "Fallen's flanchard +3",
        feet = "Sulevia's Leggings +2",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Brutal earring",
        right_ear = "Ishvara Earring",
        left_ring = "Chirich ring +1",
        right_ring = "Niqmaddu ring",
        back = Ankou.WSDSTR
    }

    sets.WS.Scourge.MidACC = set_combine(sets.WS.Scourge, {
        hands = "Odyssean gauntlets",
        legs = "Fallen's flanchard +3",
        left_ear = "Cessance earring",
        right_ear = "Cessance earring"
    })

    sets.WS.Scourge.HighACC = set_combine(sets.WS.Scourge.MidACC, {})

    sets.WS.Shockwave = {
        ammo = "Pemphredo Tathlum",
        head = "Carmine Mask +1",
        body = "Carmine Scale Mail",
        hands = "Leyline Gloves",
        legs = "Eschite cuisses",
        feet = "Ignominy Sollerets +3",
        neck = "Erra Pendant",
        waist = "Eschan Stone",
        left_ear = "Hermetic Earring",
        right_ear = "Cessance earring",
        left_ring = "Chirich ring +1",
        right_ring = "Stikini Ring",
        back = Ankou.INTDA
    }

    -- Catastrophe Sets --
    -- Stat Modifier:	40% STR / 40% INT	fTP:	2.75
    -- Relic Aftermath: 10% Equipment Haste (+102/1024) AG 10% Ability
    sets.WS.Catastrophe = {
        ammo = "Knobkierrie",
        head = "Stinger helm +1",
        body = "Ignominy Cuirass +3",
        hands = "Ratri Gadlings",
        legs = "Ratri Cuisses",
        feet = "Ratri Sollerets",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Brutal earring",
        right_ear = "Ishvara Earring",
        left_ring = "Chirich ring +1",
        right_ring = "Niqmaddu ring",
        back = Ankou.WSDSTR
    }

    sets.WS.Catastrophe.MidACC = set_combine(sets.WS.Catastrophe,
                                             {right_ear = "Cessance earring"})

    sets.WS.Catastrophe.HighACC = set_combine(sets.WS.Catastrophe.MidACC, {})

    -- Entropy Sets --
    -- Delivers a fourfold attack. Converts some of the damage into MP. Damage varies with TP.
    -- Stat Modifier:	73~85% INT fTP:	0.75	1.25	2.0
    sets.WS.Entropy = {
        ammo = "Pemphredo Tathlum",
        head = "Ignominy Burgonet +3",
        body = "Ignominy cuirass +3",
        hands = "Ignominy Gauntlets +3",
        legs = "Ignominy Flanchard +3",
        feet = "Flamma Gambieras +2",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Moonshade earring",
        right_ear = "Brutal Earring",
        left_ring = "Shiva Ring",
        right_ring = "Shiva Ring",
        back = Ankou.INTDA
    }

    sets.WS.Entropy.MidACC = set_combine(sets.WS.Entropy,
                                         {right_ear = "Cessance earring"})

    sets.WS.Entropy.HighACC = set_combine(sets.WS.Entropy.MidACC, {
        ammo = "Coiste Bodhar",
        body = "Ignominy Cuirass +3"
    })

    -- CrossReaper Sets --
    -- Delivers a two-hit attack. Damage varies with TP.
    -- Stat Modifier:	60% STR / 60% MND fTP:	2.0	4.0	7.0
    sets.WS['Cross Reaper'] = {
        ammo = "Knobkierrie",
        head = "Ratri Sallet",
        body = "Ignominy Cuirass +3",
        hands = "Ratri Gadlings",
        legs = "Ratri Cuisses",
        feet = "Ratri Sollerets",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Moonshade earring",
        right_ear = "Ishvara earring",
        left_ring = "Chirich ring +1",
        right_ring = "Niqmaddu ring",
        back = Ankou.WSDSTR
    }

    sets.WS['Cross Reaper'].MidACC = set_combine(sets.WS['Cross Reaper'], {
        legs = "Ignominy Flanchard +3",
        hands = "Ignominy Gauntlets +3"
    })

    sets.WS['Cross Reaper'].HighACC = set_combine(
                                          sets.WS['Cross Reaper'].MidACC, {
            head = "Ignominy Burgonet +3",
            right_ear = "Cessance earring"
        })

    -- Insurgency Sets --
    -- Delivers a fourfold attack. Damage varies with TP.
    -- Stat Modifier:	20% STR / 20% INT fTP:	0.5	3.25	6.0
    sets.WS.Insurgency = {
        ammo = "Coiste Bodhar",
        head = "Stinger Helm +1",
        body = "Ignominy Cuirass +3",
        hands = "Sakpata's gauntlets",
        legs = "Ignominy Flanchard +3",
        feet = "Argosy Sollerets +1",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Moonshade earring",
        right_ear = "Brutal earring",
        left_ring = "Chirich ring +1",
        right_ring = "Niqmaddu ring",
        back = Ankou.DA
    }

    sets.WS.Insurgency.MidACC = set_combine(sets.WS.Insurgency, {
        hands = "Ignominy Gauntlets +3",
        feet = "Ratri Sollerets"
    })

    sets.WS.Insurgency.HighACC = set_combine(sets.WS.Insurgency.MidACC,
                                             {right_ear = "Cessance earring"})

    -- Quietus Sets --
    -- Delivers a triple damage attack that ignores target's defense. Amount ignored varies with TP.
    -- Stat Modifier:	60% STR / 60% MND Defense ignored:	10%	30%	50% fTP:	3.0
    sets.WS.Quietus = {
        ammo = "Knobkierrie",
        head = "Ratri Sallet",
        body = "Ignominy Cuirass +3",
        hands = "Ratri Gadlings",
        legs = "Ratri Cuisses",
        feet = "Ratri Sollerets",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Moonshade earring",
        right_ear = "Ishvara earring",
        left_ring = "Chirich ring +1",
        right_ring = "Niqmaddu ring",
        back = Ankou.WSDSTR
    }

    sets.WS.Quietus.MidACC = set_combine(sets.WS.Quietus,
                                         {right_ear = "Cessance earring"})

    sets.WS.Quietus.HighACC = set_combine(sets.WS.Quietus.MidACC, {})

    -----------------------------------------------------------------------------------------------------------------
    -- works in motes based, not sure how to get it to work here
    sets.Item = {HolyWater}
    sets.Item['Holy Water'] = {
        ring1 = "Blenmot's Ring",
        ring2 = "Blenmot's Ring"
    }

    -- react sets
    sets.Meva = {
        ammo = "Staunch Tathlum",
        head = "Ratri Sallet",
        neck = "Warder's Charm",
        left_ear = "Hearty Earring",
        right_ear = "Eabani Earring",
        left_ring = "Defending Ring",
        right_ring = "Shadow Ring",
        legs = "Ratri Cuisses",
        feet = "Ratri Sollerets",
        hands = "Ratri Gadlings",
        waist = "Asklepian Belt",
        back = Ankou.MEVA
    }
    sets.CurePotencyRecieved = {
        waist = "Gishdubar sash",
        neck = "Phalaina Locket",
        ring1 = "Kunaji Ring",
        hands = "Buremte Gloves"
    }
    sets.PhalanxRecieved = {
        legs = "Ignominy flanchard +3",
        hands = "Sakpata's gauntlets"
    }
    sets.RefreshRecieved = {waist = "Gishdubar sash"} -- feet="Inspirited boots"
    sets.CursnaRecieved = {
        waist = "Gishdubar sash",
        legs = "Shabti Cuisses +1",
        ring1 = "Eshmun's Ring",
        ring2 = "Eshmun's Ring"
    }
    sets.ResistStun = set_combine(sets.Meva, {
        right_ear = "Arete del Luna",
        left_ear = "Hearty Earring",
        body = "Onca Suit"
    })
    sets.ProShellRecieved = {ear1 = "Brachyura Earring"}
    sets.ResistTerror = set_combine(sets.Meva, {feet = "Founder's Greaves"})

end

function pretarget(spell, action)
    if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
        cancel_spell()
        send_command('Aggressor')
    elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
        cancel_spell()
        send_command('ThirdEye')
    elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
        cancel_spell()
        add_to_chat(123, spell.name .. ' Canceled: [' .. player.tp .. ' TP]')
    elseif spell.type == "WeaponSkill" and spell.target.distance >
        target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
        cancel_spell()
        add_to_chat(123, spell.name .. ' Canceled: [Out of Range]')
        return
    end
end

function precast(spell, action)
    if spell.type == "WeaponSkill" then
        equipSet = sets.WS
        if equipSet[spell.english] then
            equipSet = equipSet[spell.english]
        end
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end
        if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
            equipSet = set_combine(equipSet, {neck = "Ygnas's Resolve +1"})
        end
        if (spell.english == "Entropy" or spell.english == "Resolution" or
            spell.english == "Insurgency") and
            (player.tp > 2990 or buffactive.Sekkanoki) then
            if world.time <= (7 * 60) or world.time >= (17 * 60) then
                equipSet = set_combine(equipSet, {ear1 = "Lugra Earring +1"})
            else
                equipSet = set_combine(equipSet, {ear1 = "Ishvara Earring"})
            end
        end
        equip(equipSet)
    elseif spell.type == "JobAbility" then
        if sets.JA[spell.english] then equip(sets.JA[spell.english]) end
    elseif spell.action_type == 'Magic' then
        if buffactive.silence or spell.target.distance > 16 + target_distance then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
            cancel_spell()
            add_to_chat(123, spell.name ..
                            ' Canceled: [Silenced or Out of Casting Range]')
            return
        else
            if spell.english == 'Utsusemi: Ni' then
                if buffactive['Copy Image (3)'] then
                    cancel_spell()
                    add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
                    return
                else
                    equip(sets.Precast.FastCast)
                end
            elseif sets.Precast[spell.skill] then
                equip(sets.Precast[spell.skill])
            else
                equip(sets.Precast.FastCast)
            end
        end
    elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
        cast_delay(0.2)
        send_command('cancel Sneak')
    end
    if Twilight == 'Twilight' then equip(sets.Twilight) end
end

function midcast(spell, action)
    equipSet = {}
    if spell.action_type == 'Magic' then
        equipSet = sets.Midcast
        if spell.english:startswith('Drain') or
            spell.english:startswith('Aspir') or spell.english:startswith('Bio') then
            if world.day == "Darksday" or world.weather_element == "Dark" then -- Equip Hachirin-no-Obi On Darksday or Dark Weather --
                equipSet = set_combine(equipSet, {waist = "Hachirin-no-Obi"})
            end
            equipSet = sets.Midcast.Drain
        elseif spell.english == "Stoneskin" then
            if buffactive.Stoneskin then
                send_command('@wait 1.7;cancel stoneskin')
            end
            equipSet = equipSet.Stoneskin
        elseif spell.english == "Sneak" then
            if spell.target.name == player.name and buffactive['Sneak'] then
                send_command('cancel sneak')
            end
            equipSet = equipSet.Haste
        elseif spell.english:startswith('Utsusemi') then
            if spell.english == 'Utsusemi: Ichi' and
                (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or
                    buffactive['Copy Image (3)']) then
                send_command('@wait 1.7;cancel Copy Image*')
            end
            equipSet = equipSet.Haste
        elseif spell.english == 'Monomi: Ichi' then
            if buffactive['Sneak'] then
                send_command('@wait 1.7;cancel sneak')
            end
            equipSet = equipSet.Haste
        else
            if equipSet[spell.english] then
                equipSet = equipSet[spell.english]
            end
            if equipSet[MaccArray[MaccIndex]] then
                equipSet = equipSet[MaccArray[MaccIndex]]
            end
            if equipSet[spell.skill] then
                equipSet = equipSet[spell.skill]
            end
            if equipSet[spell.type] then
                equipSet = equipSet[spell.type]
            end
        end
    elseif equipSet[spell.english] then
        equipSet = equipSet[spell.english]
    end
    if buffactive["Dark Seal"] and DarkSealIndex == 0 then -- Equip Aug'd Fall. Burgeonet +1 When You Have Dark Seal Up --
        equipSet = set_combine(equipSet, {head = "Fall. Burgeonet +1"})
    end
    if buffactive['Dark Seal'] and buffactive['Nether Void'] and
        S {"Drain II", "Drain III"}:contains(spell.english) and player.tp < 600 then
        equipSet = set_combine(equipSet, (sets.MAXDrain))
        add_to_chat(100, 'WARNING: Misanthropy is on now *****')
    end
    equip(equipSet)
end

function aftercast(spell, action)

    if spell.type == "WeaponSkill" then
        send_command('wait 0.2;gs c TP')
    elseif spell.english == "Arcane Circle" then -- Arcane Circle Countdown --
        send_command('wait 260;input /echo ' .. spell.name ..
                         ': [WEARING OFF IN 10 SEC.];wait 10;input /echo ' ..
                         spell.name .. ': [OFF]')
    elseif spell.english == "Sleep II" then -- Sleep II Countdown --
        send_command(
            'wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
    elseif spell.english == "Sleep" then -- Sleep Countdown --
        send_command(
            'wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
    end
    status_change(player.status)
end

function status_change(new, old)
    if Armor == 'PDT' then
        equip(sets.PDT)
    elseif Armor == 'MDT' then
        equip(sets.MDT)
    elseif Armor == 'Scarlet' then
        equip(sets.Scarlet)
    elseif new == 'Engaged' then
        equipSet = sets.TP
        if Armor == 'Hybrid' and equipSet["Hybrid"] then
            equipSet = equipSet["Hybrid"]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if equipSet[player.sub_job] then
            equipSet = equipSet[player.sub_job]
        end
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end
        if buffactive["Aftermath: Lv.3"] and equipSet["AM3"] then
            if buffactive["Last Resort"] and
                ((buffactive.Haste and buffactive.March == 2) or
                    (buffactive.Embrava and
                        (buffactive.March == 2 or
                            (buffactive.March and buffactive.Haste) or
                            (buffactive.March and buffactive['Mighty Guard']) or
                            (buffactive['Mighty Guard'] and buffactive.Haste))) or
                    (buffactive[580] and
                        (buffactive.March or buffactive.Haste or
                            buffactive.Embrava or buffactive['Mighty Guard']))) and
                equipSet["HighHaste"] then
                equipSet = equipSet["AM3_HighHaste"]
            else
                equipSet = equipSet["AM3"]
            end
        end
        if buffactive.Aftermath and equipSet["AM"] then
            equipSet = equipSet["AM"]
        end
        if buffactive["Last Resort"] and
            ((buffactive.Haste and buffactive.March == 2) or
                (buffactive.Embrava and
                    (buffactive.March == 2 or
                        (buffactive.March and buffactive.Haste) or
                        (buffactive.March and buffactive['Mighty Guard']) or
                        (buffactive['Mighty Guard'] and buffactive.Haste))) or
                (buffactive[580] and
                    (buffactive.March or buffactive.Haste or buffactive.Embrava or
                        buffactive['Mighty Guard']))) and equipSet["HighHaste"] then
            equipSet = equipSet["HighHaste"]
        end
        if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll ==
            'ON' then equipSet = equipSet["STP"] end
        equip(equipSet)
    else
        equipSet = sets.Idle
        if equipSet[IdleArray[IdleIndex]] then
            equipSet = equipSet[IdleArray[IdleIndex]]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if equipSet[player.sub_job] then
            equipSet = equipSet[player.sub_job]
        end
        if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
            equipSet = set_combine(equipSet, {neck = "Ygnas's Resolve +1"})
        end
        if world.area:endswith('Adoulin') then
            equipSet = set_combine(equipSet, {body = "Councilor's Garb"})
        end
        equip(equipSet)
    end
    if Twilight == 'Twilight' then equip(sets.Twilight) end
end

function buff_change(buff, gain)
    buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
        if gain then
            send_command(
                'timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
        else
            send_command('timers delete "Aftermath: Lv.3"')
            add_to_chat(123, 'AM3: [OFF]')
        end
    elseif buff == 'weakness' then -- Weakness Timer --
        if gain then
            send_command('timers create "Weakness" 300 up')
        else
            send_command('timers delete "Weakness"')
        end
    end
    if buff == "sleep" and gain and player.hp > 200 and player.status ==
        "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
        equip({neck = "Vim Torque +1"})
    else
        if not midaction() then status_change(player.status) end
    end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
    if command == 'C1' then -- Accuracy Level Toggle --
        AccIndex = (AccIndex % #AccArray) + 1
        status_change(player.status)
        add_to_chat(158, 'Accuracy Level: ' .. AccArray[AccIndex])
    elseif command == 'C17' then -- Main Weapon Toggle --
        WeaponIndex = (WeaponIndex % #WeaponArray) + 1
        add_to_chat(158, 'Main Weapon: ' .. WeaponArray[WeaponIndex])
        status_change(player.status)
    elseif command == 'C14' then -- Macc Toggle --
        MaccIndex = (MaccIndex % #MaccArray) + 1
        add_to_chat(158, 'Macc Level: ' .. MaccArray[MaccIndex])
        status_change(player.status)
    elseif command == 'C5' then -- Auto Update Gear Toggle --
        status_change(player.status)
        add_to_chat(158, 'Auto Update Gear')
    elseif command == 'C2' then -- Hybrid Toggle --
        if Armor == 'Hybrid' then
            Armor = 'None'
            add_to_chat(123, 'Hybrid Set: [Unlocked]')
        else
            Armor = 'Hybrid'
            add_to_chat(158, 'Hybrid Set: ' .. AccArray[AccIndex])
        end
        status_change(player.status)
    elseif command == 'C10' then -- DarkSeal Toggle --
        if DarkSealIndex == 1 then
            DarkSealIndex = 0
            add_to_chat(158, 'DarkSeal Duration: [On]')
        else
            DarkSealIndex = 1
            add_to_chat(158, 'DarkSeal Potency: [On]')
        end
        status_change(player.status)
    elseif command == 'C7' then -- PDT Toggle --
        if Armor == 'PDT' then
            Armor = 'None'
            add_to_chat(123, 'PDT Set: [Unlocked]')
        else
            Armor = 'PDT'
            add_to_chat(158, 'PDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C15' then -- MDT Toggle --
        if Armor == 'MDT' then
            Armor = 'None'
            add_to_chat(123, 'MDT Set: [Unlocked]')
        else
            Armor = 'MDT'
            add_to_chat(158, 'MDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C9' then -- Scarlet Toggle --
        if Armor == 'Scarlet' then
            Armor = 'None'
            add_to_chat(123, 'Scarlet Set: [Unlocked]')
        else
            Armor = 'Scarlet'
            add_to_chat(158, 'Scarlet Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C3' then -- Twilight Toggle --
        if Twilight == 'Twilight' then
            Twilight = 'None'
            add_to_chat(123, 'Twilight Set: [Unlocked]')
        else
            Twilight = 'Twilight'
            add_to_chat(158, 'Twilight Set: [locked]')
        end
        status_change(player.status)
    elseif command == 'C8' then -- Distance Toggle --
        if player.target.distance then
            target_distance = math.floor(player.target.distance * 10) / 10
            add_to_chat(158, 'Distance: ' .. target_distance)
        else
            add_to_chat(123, 'No Target Selected')
        end
    elseif command == 'C6' then -- Idle Toggle --
        IdleIndex = (IdleIndex % #IdleArray) + 1
        status_change(player.status)
        add_to_chat(158, 'Idle Set: ' .. IdleArray[IdleIndex])
    elseif command == 'TP' then
        add_to_chat(158, 'TP Return: [' .. tostring(player.tp) .. ']')
    elseif command:match('^SC%d$') then
        send_command('//' .. sc_map[command])
    end
end

function sub_job_change(newSubjob, oldSubjob) select_default_macro_book() end

function set_macro_page(set, book)
    if not tonumber(set) then
        add_to_chat(123,
                    'Error setting macro page: Set is not a valid number (' ..
                        tostring(set) .. ').')
        return
    end
    if set < 1 or set > 10 then
        add_to_chat(123,
                    'Error setting macro page: Macro set (' .. tostring(set) ..
                        ') must be between 1 and 10.')
        return
    end

    if book then
        if not tonumber(book) then
            add_to_chat(123,
                        'Error setting macro page: book is not a valid number (' ..
                            tostring(book) .. ').')
            return
        end
        if book < 1 or book > 20 then
            add_to_chat(123,
                        'Error setting macro page: Macro book (' ..
                            tostring(book) .. ') must be between 1 and 20.')
            return
        end
        send_command('@input /macro book ' .. tostring(book) ..
                         ';wait .1;input /macro set ' .. tostring(set))
    else
        send_command('@input /macro set ' .. tostring(set))
    end
end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(2, 7)
    else
        set_macro_page(1, 7)
    end
end
