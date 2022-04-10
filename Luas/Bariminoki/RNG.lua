function get_sets()
    AccIndex = 1
    AccArray = {"LowHaste", "CapHaste", "Accuracy"}
    RaccIndex = 1
    RaccArray = {"LowACC", "HighACC", "Aftermath"}
    PDLIndex = 1
    PDLArray = {"None", "Half", "Full"}
    IdleIndex = 1
    IdleArray = {'Movement', 'Regen', 'Town'} -- Default Idle Set Is Movement --
    PreshotIndex = 1
    PreshotArray = {'Any', 'RDM'}
    Armor = 'None'
    autoRAmode = 0
    target_distance = 5 -- Set Default Distance Here --
    send_command('input /macro book 6;wait .1;input /macro set 2') -- Change Default Macro Book Here --
    send_command('bind ^` gs c flur') -- flurry toggle--
    send_command('bind f9 gs c acc') -- accuracy toggle--
    send_command('bind f11 gs c racc') -- ranged set toggle--
    send_command('bind f10 gs c pdl') -- WS PDL toggle--
    send_command('bind ^= gs c pdt') -- PDT toggle--
    send_command('bind !` gs c th') -- TH toggle--
    send_command('bind f12 gs c auto') -- Gearset update toggle--
    send_command('bind !f12 gs c C6') -- Idle Toggle--
    ranged_ws = S {
        "Hot Shot", "Split Shot", "Sniper Shot", "Slug Shot", "Blast Shot",
        "Heavy Shot", "Detonator", "Numbing Shot", "Last Stand", "Coronach",
        'Trueflight', 'Wildfire', "Flaming Arrow", "Piercing Arrow",
        "Dulling Arrow", "Sidewinder", "Blast Arrow", "Arching Arrow",
        "Empyreal Arrow", "Refulgent Arrow", "Apex Arrow", "Jishnu's Radiance",
        "Namas Arrow"
    }

    WSAmmo = {
        ['Yoichinoyumi'] = "Chrono Arrow",
        ['Gandiva'] = "Chrono Arrow",
        ['Fail-Not'] = "Chrono Arrow",
        ['Annihilator'] = "Eradicating Bullet",
        ['Armageddon'] = "Chrono Bullet",
        ['Gastraphetes'] = "Quelling Bolt",
        ['Fomalhaut'] = "Chrono Bullet",
        ['Accipiter'] = "Eminent Arrow",
        ['Holliday'] = "Eradicating Bullet",
        ['Doomsday'] = "Eradicating Bullet",
        ['Teller'] = "Eminent Arrow"
    }

    -- Idle/Town Sets --
    sets.Idle = {}
    sets.Idle.Regen = {
        head = "Meghanada Visor +2",
        neck = "Bathy Choker +1",
        body = "Meghanada Cuirie +2",
        hands = "Meg. Gloves +2",
        left_ring = "Meghanada Ring",
        right_ring = "Chirich Ring +1",
        ear1 = "Infused Earring",
        ear2 = {name = "Odnowa Earring +1", augments = {'Path: A'}},
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Meg. Chausses +2",
        feet = "Meg. Jam. +2"
    }
    sets.Idle.Movement = {
        head = "Nyame Helm",
        body = "Malignance Tabard",
        hands = "Malignance gloves",
        legs = "Carmine Cuisses +1",
        feet = "Malignance Boots",
        neck = "Loricate Torque +1",
        waist = "Flume Belt +1",
        right_ear = {name = "Odnowa Earring +1", augments = {'Path: A'}},
        left_ear = "Etiolation Earring",
        left_ring = "Meghanada Ring",
        right_ring = "Defending Ring",
        back = "Moonlight Cape"
    }
    sets.Idle.Town = {
        main = "",
        sub = "",
        range = "",
        ammo = "",
        head = "Nyame Helm",
        body = "Nisroch Jerkin", -- "Ikenga's Vest",--
        hands = "Ikenga's Gloves", -- "Regal Gloves",--
        legs = "Osh. Trousers +1",
        feet = "Orion Socks +3",
        neck = "Scout's Gorget +2",
        waist = "K. Kachina Belt +1",
        left_ear = "Dedition Earring",
        right_ear = "Telos Earring",
        left_ring = "Regal Ring",
        right_ring = "Weather. Ring +1",
        back = "Moonlight Cape"
    }

    sets.Gastraphetes = {
        main = {
            name = "Malevolence",
            augments = {
                'INT+10', 'Mag. Acc.+10', '"Mag.Atk.Bns."+10', '"Fast Cast"+5'
            }
        },
        sub = {
            name = "Malevolence",
            augments = {
                'INT+9', 'Mag. Acc.+10', '"Mag.Atk.Bns."+9', '"Fast Cast"+4'
            }
        },
        range = "Gastraphetes",
        ammo = "Quelling Bolt",
        waist = "Orpheus's Sash"
    }

    sets.Fomalhaut = {
        main = "Perun +1",
        sub = "Ternion Dagger +1",
        range = "Fomalhaut",
        ammo = "Chrono Bullet"
    }

    sets.Annihilator = {
        main = "Perun +1",
        sub = "Ternion Dagger +1",
        range = "Annihilator",
        ammo = "Eradicating bullet"
    }

    sets.Armageddon = {
        main = "Perun +1",
        sub = "Oneiros Knife",
        range = "Armageddon",
        ammo = "Chrono Bullet"
    }

    sets.Axe = {main = "Dolichenus", sub = "Gleti's Knife"}

    sets.Dagger = {main = "Tauret", sub = "Ternion Dagger +1"}

    sets.Sword = {
        main = "Naegling",
        sub = "Blurred knife +1",
        range = "Sparrowhawk +2",
        ammo = "Hauksbok Arrow"
    }

    -- Preshot --
    sets.Preshot = {
        head = "Taeon Chapeau", -- 10/0
        body = "Amini Caban +1", -- 14/0
        neck = "Scout's gorget +1",
        hands = "Carmine Fin. Ga. +1", -- 8/11
        legs = "Adhemar Kecks +1", -- 10/13
        feet = "Meg. Jam. +2", -- 10/0
        back = {name = "Belenus's Cape", augments = {'"Snapshot"+10'}},
        waist = "Impulse Belt" -- 0/5
    }

    -- Fomalhaut Preshot Sets--

    sets.Preshot.Fomalhaut = {
        head = {
            name = "Taeon Chapeau",
            augments = {'"Snapshot"+5', '"Snapshot"+5'}
        },
        body = "Amini Caban +1",
        hands = {
            name = "Carmine Fin. Ga. +1",
            augments = {'Rng.Atk.+20', '"Mag.Atk.Bns."+12', '"Store TP"+6'}
        },
        legs = {
            name = "Adhemar Kecks +1",
            augments = {'AGI+12', '"Rapid Shot"+13', 'Enmity-6'}
        },
        feet = "Meg. Jam. +2",
        neck = {name = "Scout's Gorget +2", augments = {'Path: A'}},
        waist = "Impulse Belt",
        left_ear = "Etiolation Earring",
        right_ear = {name = "Odnowa Earring +1", augments = {'Path: A'}},
        left_ring = "Ilabrat Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {'HP+60', 'HP+20', '"Snapshot"+10'}
        }
    }

    sets.Preshot.Fomalhaut.Any = set_combine(sets.Preshot.Fomalhaut, {
        head = "Orion Beret +3",
        waist = "Yemaya Belt"
    })

    sets.Preshot.Fomalhaut.RDM = set_combine(sets.Preshot.Fomalhaut.Any, {
        hands = "Mrigavyadha Gloves",
        feet = "Pursuer's Gaiters"
    })

    -- Gastraphetes Preshot Sets--

    sets.Preshot.Gastraphetes = {
        head = {
            name = "Taeon Chapeau",
            augments = {'"Snapshot"+5', '"Snapshot"+5'}
        },
        body = "Amini Caban +1",
        hands = {
            name = "Carmine Fin. Ga. +1",
            augments = {'Rng.Atk.+20', '"Mag.Atk.Bns."+12', '"Store TP"+6'}
        },
        legs = {
            name = "Adhemar Kecks +1",
            augments = {'AGI+12', '"Rapid Shot"+13', 'Enmity-6'}
        },
        feet = "Meg. Jam. +2",
        neck = {name = "Scout's Gorget +2", augments = {'Path: A'}},
        waist = "Yemaya Belt",
        left_ear = "Etiolation Earring",
        right_ear = {name = "Odnowa Earring +1", augments = {'Path: A'}},
        left_ring = "Ilabrat Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {'HP+60', 'HP+20', '"Snapshot"+10'}
        }
    }

    sets.Preshot.Gastraphetes.Any = set_combine(sets.Preshot.Gastraphetes, {
        head = "Orion Beret +3",
        waist = "Impulse Belt",
        feet = "Pursuer's Gaiters"
    })

    sets.Preshot.Gastraphetes.RDM = set_combine(sets.Preshot.Gastraphetes.Any, {
        hands = "Mrigavyadha Gloves",
        waist = "Yemaya Belt"
    })

    -- Annihilator Preshot Sets--

    sets.Preshot.Annihilator = {
        ammo = "Eradicating Bullet",
        head = "Taeon Chapeau", -- 10/0
        body = "Amini Caban +1", -- 14/0
        neck = "Scout's gorget +1",
        hands = "Carmine Fin. Ga. +1", -- 8/11
        legs = "Adhemar Kecks +1", -- 10/13
        feet = "Meg. Jam. +2", -- 10/0
        back = {name = "Belenus's Cape", augments = {'"Snapshot"+10'}},
        waist = "Impulse Belt" -- 0/5
    }

    sets.Preshot.Annihilator.Any = set_combine(sets.Preshot.Annihilator, {
        head = "Orion Beret +3",
        waist = "Yemaya Belt"
    })

    sets.Preshot.Annihilator.RDM = set_combine(sets.Preshot.Annihilator.Any, {
        hands = "Mrigavyadha Gloves",
        feet = "Pursuer's Gaiters"
    })

    -- Shooting Base Set --
    sets.Midshot = {}

    sets.Midshot.LowACC = {
        head = "Arcadian Beret +3",
        body = "Mummu Jacket +1",
        hands = "Malignance Gloves",
        legs = "Adhemar Kecks +1",
        feet = "Ikenga's clogs",
        neck = "Iskur gorget",
        ear1 = "Sherida Earring",
        ear2 = "Volley Earring",
        ring1 = "Ilabrat Ring",
        ring2 = "Regal ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng. Acc.+20 Rng.Atk.+20', '"Store TP"+10'
            }
        },
        waist = "K. Kachina Belt +1"
    }

    sets.Midshot.HighACC = set_combine(sets.Midshot.MidACC, {
        body = "Orion Jerkin +3",
        head = "Orion Beret +3",
        left_ring = "Regal Ring",
        right_ring = "Cacoethic Ring +1"
    })

    sets.Midshot.Aftermath = set_combine(sets.Midshot, {
        body = "Nisroch Jerkin",
        ear1 = "Dedition Earring"
    })

    -- Fomalhaut Sets --
    sets.Midshot.Fomalhaut = {
        range = "Fomalhaut",
        ammo = "Chrono Bullet",
        head = "Arcadian Beret +3",
        neck = "Scout's Gorget +2",
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        body = "Ikenga's Vest",
        hands = "Malignance Gloves",
        left_ring = "Ilabrat Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', '"Store TP"+10',
                'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Ikenga's Trousers",
        feet = "Malignance Boots"
    }

    sets.Midshot.Fomalhaut.LowACC = set_combine(sets.Midshot.Fomalhaut, {})

    sets.Midshot.Fomalhaut.HighACC = set_combine(sets.Midshot.Fomalhaut, {
        ear1 = "Enervating Earring",
        legs = "Malignance Tights"
    })

    sets.Midshot.Fomalhaut.Aftermath = set_combine(sets.Midshot.Fomalhaut, {
        hands = "Ikenga's Gloves",
        feet = "Ikenga's Clogs"
    })

    -- Gastraphetes Sets --
    sets.Midshot.Gastraphetes = {
        range = "Gastraphetes",
        head = "Arcadian Beret +3",
        neck = "Iskur Gorget",
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        body = "Ikenga's Vest",
        hands = "Malignance Gloves",
        left_ring = "Ilabrat Ring",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', '"Store TP"+10',
                'Damage taken-5%'
            }
        },
        waist = "Yemaya Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.Midshot.Gastraphetes.LowACC =
        set_combine(sets.Midshot.Gastraphetes, {})

    sets.Midshot.Gastraphetes.HighACC = set_combine(sets.Midshot.Gastraphetes,
                                                    {right_ring = "Regal Ring"})

    sets.Midshot.Gastraphetes.Aftermath =
        set_combine(sets.Midshot.Gastraphetes, {
            neck = "Scout's Gorget +2",
            hands = "Ikenga's Gloves",
            legs = "Ikenga's Trousers",
            feet = "Ikenga's Clogs",
            right_ring = "Dingir Ring"
        })

    -- Annihilator Sets --
    sets.Midshot.Annihilator = set_combine(sets.Midshot.LowACC, {})

    sets.Midshot.Annihilator.LowACC = sets.Midshot.Annihilator

    sets.Midshot.Annihilator.HighACC = set_combine(sets.Midshot.Annihilator, {
        left_ear = "Enervating Earring"
    })

    sets.Midshot.Annihilator.Aftermath =
        set_combine(sets.Midshot.Annihilator, {
            body = "Nisroch Jerkin",
            hands = "Ikenga's Gloves",
            left_ring = "Regal Ring",
            right_ring = "Begrudging Ring",
            waist = "K. Kachina Belt +1",
            ear1 = "Odr Earring",
            back = {
                name = "Belenus's Cape",
                augments = {
                    'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                    'Crit.hit rate+10', 'Damage taken-5%'
                }
            },
            feet = "Osh. Leggings +1"
        })

    -- Armageddon Sets --
    sets.Midshot.Armageddon = {
        range = "Armageddon",
        ammo = "Chrono Bullet",
        head = "Arcadian Beret +3",
        neck = "Scout's Gorget +2",
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        body = "Ikenga's Vest",
        hands = "Malignance Gloves",
        left_ring = "Ilabrat Ring",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', '"Store TP"+10',
                'Damage taken-5%'
            }
        },
        waist = "Yemaya Belt",
        legs = "Ikenga's Trousers",
        feet = "Malignance Boots"
    }

    sets.Midshot.Armageddon.LowACC = sets.Midshot.Armageddon

    sets.Midshot.Armageddon.HighACC = set_combine(sets.Midshot.Armageddon,
                                                  {right_ring = "Regal Ring"})

    sets.Midshot.Armageddon.Aftermath = {
        head = "Meghanada Visor +2",
        neck = "Scout's Gorget +2",
        ear1 = "Odr Earring",
        ear2 = "Telos Earring",
        body = "Nisroch Jerkin",
        hands = "Ikenga's Gloves",
        right_ring = "Begrudging Ring",
        left_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Crit.hit rate+10', 'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Darraigner's Brais",
        feet = "Osh. Leggings +1"
    }

    -- Barrage Base Set --
    sets.Midshot.Barrage = {
        body = "Nisroch Jerkin",
        hands = "Orion Bracers +3",
        neck = "Scout's Gorget +2",
        legs = "Ikenga's Trousers",
        feet = "Orion Socks +3"
    }

    -- Fomalhaut Barrage Sets --
    sets.Midshot.Fomalhaut.Barrage = {}

    sets.Midshot.Fomalhaut.LowACC.Barrage =
        set_combine(sets.Midshot.Fomalhaut, {
            head = "Ikenga's Hat",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            neck = "Scout's Gorget +2",
            legs = "Ikenga's Trousers",
            left_ring = "Dingir Ring",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Fomalhaut.HighACC.Barrage = set_combine(
                                                 sets.Midshot.Fomalhaut.HighACC,
                                                 {
            head = "Orion Beret +3",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            left_ring = "Regal Ring",
            right_ring = "Cacoethic Ring +1",
            legs = "Ikenga's Trousers"
        })

    sets.Midshot.Fomalhaut.Aftermath.Barrage =
        set_combine(sets.Midshot.Fomalhaut.Barrage,
                    {head = "Ikenga's Hat", body = "Ikenga's Vest"})

    -- Armageddon Barrage Sets --
    sets.Midshot.Armageddon.Barrage = {}

    sets.Midshot.Armageddon.LowACC.Barrage = set_combine(
                                                 sets.Midshot.Armageddon, {
            head = "Ikenga's Hat",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            neck = "Scout's Gorget +2",
            legs = "Ikenga's Trousers",
            left_ring = "Dingir Ring",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Armageddon.HighACC.Barrage =
        set_combine(sets.Midshot.Armageddon.HighACC, {
            head = "Orion Beret +3",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            left_ring = "Regal Ring",
            right_ring = "Cacoethic Ring +1",
            legs = "Ikenga's Trousers"
        })

    sets.Midshot.Armageddon.Aftermath.Barrage =
        set_combine(sets.Midshot.Armageddon.Barrage,
                    {head = "Ikenga's Vest", body = "Ikenga's Vest"})

    -- Gastraphetes Barrage Sets --
    sets.Midshot.Gastraphetes.Barrage = {}

    sets.Midshot.Gastraphetes.LowACC.Barrage =
        set_combine(sets.Midshot.Gastraphetes, {
            ammo = "Quelling Bolt",
            head = "Ikenga's Hat",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            neck = "Scout's Gorget +2",
            legs = "Ikenga's Trousers",
            left_ring = "Dingir Ring",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Gastraphetes.HighACC.Barrage =
        set_combine(sets.Midshot.Gastraphetes.HighACC, {
            ammo = "Quelling Bolt",
            head = "Orion Beret +3",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            right_ring = "Regal Ring",
            left_ring = "Ilabrat Ring",
            legs = "Ikenga's Trousers"
        })

    sets.Midshot.Gastraphetes.Aftermath.Barrage =
        set_combine(sets.Midshot.Gastraphetes.Barrage, {body = "Ikenga's Vest"})

    -- Annihilator Barrage Sets --
    sets.Midshot.Annihilator.Barrage = {}

    sets.Midshot.Annihilator.LowACC.Barrage =
        set_combine(sets.Midshot.Annihilator, {
            head = "Ikenga's Hat",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            neck = "Scout's Gorget +2",
            legs = "Ikenga's Trousers",
            left_ring = "Dingir Ring",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Annihilator.HighACC.Barrage =
        set_combine(sets.Midshot.Annihilator.HighACC, {
            head = "Orion Beret +3",
            body = "Nisroch Jerkin",
            hands = "Orion Bracers +3",
            left_ring = "Regal Ring",
            right_ring = "Cacoethic Ring +1",
            legs = "Ikenga's Trousers"
        })

    sets.Midshot.Annihilator.Aftermath.Barrage =
        set_combine(sets.Midshot.Annihilator.Barrage,
                    {head = "Ikenga's Hat", body = "Ikenga's Vest"})

    -- Doubleshot Sets --
    sets.Doubleshot = {
        head = "Oshosi Mask +1",
        body = "Arc. Jerkin +3",
        legs = "Osh. Trousers +1",
        feet = "Osh. Leggings +1"
    }

    -- Fomalhaut Doubleshot Sets --
    sets.Midshot.Fomalhaut.Doubleshot = {}

    sets.Midshot.Fomalhaut.LowACC.Doubleshot =
        set_combine(sets.Midshot.Fomalhaut, {
            head = "Oshosi Mask +1",
            body = "Arc. Jerkin +3",
            legs = "Osh. Trousers +1",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Fomalhaut.HighACC.Doubleshot =
        set_combine(sets.Midshot.Fomalhaut.HighACC, {
            body = "Arc. Jerkin +3",
            legs = "Osh. Trousers +1",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Fomalhaut.Aftermath.Doubleshot =
        set_combine(sets.Midshot.Fomalhaut.Aftermath, {
            head = "Oshosi Mask +1",
            body = "Arc. Jerkin +3",
            legs = "Osh. Trousers +1",
            feet = "Osh. Leggings +1"
        })

    -- Gastraphetes Doubleshot Sets--
    sets.Midshot.Gastraphetes.Doubleshot = {}

    sets.Midshot.Gastraphetes.LowACC.Doubleshot =
        set_combine(sets.Midshot.Gastraphetes, {
            head = "Oshosi Mask +1",
            body = "Arc. Jerkin +3",
            legs = "Osh. Trousers +1",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Gastraphetes.HighACC.Doubleshot =
        set_combine(sets.Midshot.Gastraphetes.HighACC, {
            body = "Arc. Jerkin +3",
            legs = "Osh. Trousers +1",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Gastraphetes.Aftermath.Doubleshot = {
        head = "Oshosi Mask +1",
        neck = "Scout's Gorget +2",
        ear1 = "Enervating Earring",
        ear2 = "Telos Earring",
        body = "Arc. Jerkin +3",
        hands = "Ikenga's Gloves",
        left_ring = "Begrudging Ring",
        right_ring = "Dingir Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Crit.hit rate+10', 'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Osh. Trousers +1",
        feet = "Osh. Leggings +1"
    }

    -- Annihilator Doubleshot Sets--
    sets.Midshot.Annihilator.Doubleshot = {}

    sets.Midshot.Annihilator.LowACC.Doubleshot =
        set_combine(sets.Midshot.Annihilator, {
            head = "Oshosi Mask +1",
            body = "Arc. Jerkin +3",
            legs = "Osh. Trousers +1",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Annihilator.HighACC.Doubleshot =
        set_combine(sets.Midshot.Annihilator.HighACC, {
            body = "Arc. Jerkin +3",
            legs = "Osh. Trousers +1",
            feet = "Osh. Leggings +1"
        })

    sets.Midshot.Annihilator.Aftermath.Doubleshot = {
        head = "Oshosi Mask +1",
        neck = "Scout's Gorget +2",
        ear1 = "Odr Earring",
        ear2 = "Telos Earring",
        body = "Arc. Jerkin +3",
        hands = "Ikenga's Gloves",
        left_ring = "Begrudging Ring",
        right_ring = "Dingir Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Crit.hit rate+10', 'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Osh. Trousers +1",
        feet = "Osh. Leggings +1"
    }

    -- Camouflage Sets--
    sets.Midshot.Camouflage = {}

    sets.Midshot.Fomalhaut.Camouflage = {
        head = "Meghanada Visor +2",
        neck = "Scout's Gorget +2",
        ear1 = "Odr Earring",
        body = "Meghanada Cuirie +2",
        hands = "Ikenga's Gloves",
        left_ring = "Begrudging Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Crit.hit rate+10', 'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Darraigner's Brais",
        feet = "Thereoid Greaves"
    }

    sets.Midshot.Armageddon.Camouflage = {
        head = "Meghanada Visor +2",
        neck = "Scout's Gorget +2",
        ear1 = "Odr Earring",
        body = "Meghanada Cuirie +2",
        hands = "Ikenga's Gloves",
        left_ring = "Begrudging Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Crit.hit rate+10', 'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Darraigner's Brais",
        feet = "Thereoid Greaves"
    }

    sets.Midshot.Annihilator.Camouflage = {
        head = "Meghanada Visor +2",
        neck = "Scout's Gorget +2",
        ear1 = "Odr Earring",
        body = "Meghanada Cuirie +2",
        hands = "Ikenga's Gloves",
        left_ring = "Begrudging Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Crit.hit rate+10', 'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Darraigner's Brais",
        feet = "Thereoid Greaves"
    }

    sets.Midshot.Gastraphetes.Camouflage = {
        head = "Meghanada Visor +2",
        neck = "Scout's Gorget +2",
        ear1 = "Odr Earring",
        body = "Meghanada Cuirie +2",
        hands = "Ikenga's Gloves",
        left_ring = "Begrudging Ring",
        right_ring = "Dingir Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Crit.hit rate+10', 'Damage taken-5%'
            }
        },
        waist = "K. Kachina Belt +1",
        legs = "Darraigner's Brais",
        feet = "Thereoid Greaves"
    }

    -- PDT/TH Sets --
    sets.PDT = {
        head = "Nyame Helm",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = {
            name = "Carmine Cuisses +1",
            augments = {'Accuracy+20', 'Attack+12', '"Dual Wield"+6'}
        },
        feet = {name = "Tatena. Sune. +1", augments = {'Path: A'}},
        neck = "Loricate Torque +1",
        waist = "Flume Belt +1",
        left_ear = "Suppanomimi",
        right_ear = {name = "Odnowa Earring +1", augments = {'Path: A'}},
        left_ring = "Hetairoi Ring",
        right_ring = "Defending Ring",
        back = "Moonlight Cape"
    }

    sets.TH = {
        head = {
            name = "Adhemar Bonnet +1",
            augments = {'DEX+12', 'AGI+12', 'Accuracy+20'}
        },
        body = {
            name = "Adhemar Jacket +1",
            augments = {'DEX+12', 'AGI+12', 'Accuracy+20'}
        },
        legs = {
            name = "Carmine Cuisses +1",
            augments = {'Accuracy+20', 'Attack+12', '"Dual Wield"+6'}
        },
        feet = "Volte Boots",
        neck = "Combatant's Torque",
        hands = "Volte Bracers",
        waist = "Chaac Belt",
        left_ear = "Eabani Earring",
        right_ear = "Suppanomimi",
        left_ring = "Hetairoi Ring",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Camulus's Mantle",
            augments = {
                'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10',
                '"Store TP"+10'
            }
        }
    }

    -- Melee Sets --
    sets.Melee = {}

    sets.Melee.LowHaste = {
        head = "Adhemar Bonnet",
        body = "Adhemar Jacket",
        hands = "Adhemar Wristbands",
        legs = "Samnuha Tights",
        feet = {
            name = "Herculean Boots",
            augments = {'"Triple Atk."+3', 'AGI+9', 'Accuracy+12'}
        },
        neck = "Clotharius Torque",
        ear1 = "Sherida Earring",
        ear2 = "Suppanomimi",
        ring1 = "Ilabrat ring",
        ring2 = "Hetairoi ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng. Acc.+20 Rng.Atk.+20', 'Weapon skill damage +10%'
            }
        },
        waist = "Sailfi Belt +1"
    }

    sets.Melee.CapHaste = {
        head = "Adhemar Bonnet",
        body = "Adhemar Jacket",
        hands = "Adhemar Wristbands",
        legs = "Samnuha Tights",
        feet = {
            name = "Herculean Boots",
            augments = {'"Triple Atk."+3', 'AGI+9', 'Accuracy+12'}
        },
        neck = "Clotharius Torque",
        ear1 = "Cessance Earring",
        ear2 = "Suppanomimi",
        ring1 = "Ilabrat ring",
        ring2 = "Hetairoi ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng. Acc.+20 Rng.Atk.+20', 'Weapon skill damage +10%'
            }
        },
        waist = "Sailfi Belt +1"
    }

    sets.Melee.Accuracy = {
        head = "Adhemar Bonnet",
        body = "Adhemar Jacket",
        hands = "Adhemar Wristbands",
        legs = "Samnuha Tights",
        feet = {
            name = "Herculean Boots",
            augments = {'"Triple Atk."+3', 'AGI+9', 'Accuracy+12'}
        },
        neck = "Clotharius Torque",
        ear1 = "Cessance Earring",
        ear2 = "Suppanomimi",
        ring1 = "Ilabrat ring",
        ring2 = "Hetairoi ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng. Acc.+20 Rng.Atk.+20', 'Weapon skill damage +10%'
            }
        },
        waist = "Sailfi Belt +1"
    }

    -- WS Base Set --
    sets.WS = {}

    -- WS Sets --

    -- Last Stand --
    sets.WS['Last Stand'] = set_combine(sets.WS, {
        head = "Orion Beret +3",
        body = {
            name = "Herculean vest",
            augments = {'AGI+14', 'Rng. Acc.+13', 'Weapon skill damage +3%'}
        },
        hands = "Meg. Gloves +2",
        legs = "Arc. Braccae +3",
        feet = {
            name = "Herculean Boots",
            augments = {
                'Rng. Acc.+19', 'Rng. Atk.+12', 'DEX+7',
                'Weapon skill damage +4%'
            }
        },
        neck = "Scout's Gorget +1",
        waist = "Fotia Belt",
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        ring1 = "Regal Ring",
        ring2 = "Epaminondas's ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Weapon skill damage +10%'
            }
        }
    })

    sets.WS['Last Stand'].None = sets.WS["Last Stand"]
    sets.WS['Last Stand'].Half = set_combine(sets.WS['Last Stand'],
                                             {feet = "Ikenga's Clogs"})
    sets.WS['Last Stand'].Full = set_combine(sets.WS['Last Stand'].Half,
                                             {hands = "Ikenga's Gloves"})

    -- Last Stand --
    sets.WS['Empyreal Arrow'] = set_combine(sets.WS, {
        head = "Orion Beret +3",
        body = {
            name = "Herculean vest",
            augments = {'AGI+14', 'Rng. Acc.+13', 'Weapon skill damage +3%'}
        },
        hands = "Meg. Gloves +2",
        legs = "Arc. Braccae +3",
        feet = {
            name = "Herculean Boots",
            augments = {
                'Rng. Acc.+19', 'Rng. Atk.+12', 'DEX+7',
                'Weapon skill damage +4%'
            }
        },
        neck = "Scout's Gorget +1",
        waist = "Fotia Belt",
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        ring1 = "Dingir Ring",
        ring2 = "Epaminondas's ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Weapon skill damage +10%'
            }
        }
    })

    sets.WS['Empyreal Arrow'].None = sets.WS["Empyreal Arrow"]
    sets.WS['Empyreal Arrow'].Half = set_combine(sets.WS['Empyreal Arrow'],
                                                 {feet = "Ikenga's Clogs"})
    sets.WS['Empyreal Arrow'].Full = set_combine(sets.WS['Empyreal Arrow'].Half,
                                                 {hands = "Ikenga's Gloves"})

    -- Last Stand --
    -- sets.WS['Arching Arrow'] = set_combine(sets.WS['Last Stand'], {})

    -- sets.WS['Arching Arrow'].None = sets.WS["Last Stand"]
    -- sets.WS['Arching Arrow'].Half = set_combine(sets.WS['Last Stand'],{feet="Ikenga's Clogs"})
    -- sets.WS['Arching Arrow'].Full = set_combine(sets.WS['Last Stand'].Half,{hands="Ikenga's Gloves"})

    -- Coronach--
    sets.WS['Coronach'] = set_combine(sets.WS['Last Stand'], {
        ear2 = "Sherida Earring",
    })
    sets.WS['Coronach'].None = sets.WS['Coronach']
    sets.WS['Coronach'].Half = set_combine(sets.WS['Coronach'].None,
                                           {feet = "Ikenga's Clogs"})
    sets.WS['Coronach'].Full = set_combine(sets.WS['Coronach'].Half,
                                           {hands = "Ikenga's Gloves"})

    -- Trueflight --
    sets.WS['Trueflight'] = {
        body = "Cohort Cloak +1",
        hands = "Carmine Fin. Ga. +1",
        legs = "Arcadian Braccae +3",
        feet = {
            name = "Herculean Boots",
            augments = {
                'Rng. Acc.+19', 'Rng. Atk.+12', 'DEX+7',
                'Weapon skill damage +4%'
            }
        },
        neck = "Scout's Gorget +1",
        ear1 = "Moonshade Earring",
        ear2 = "Friomisi Earring",
        ring1 = "Dingir Ring",
        ring2 = "Epaminondas's ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Mag. Acc+20 /Mag. Dmg.+20',
                'Weapon skill damage +10%'
            }
        },
        waist = "Eschan Stone"
    }

    sets.WS['Trueflight'].None = sets.WS['Trueflight']
    sets.WS['Trueflight'].Half = sets.WS['Trueflight'].None
    sets.WS['Trueflight'].Full = sets.WS['Trueflight'].None

    -- Wildfire --
    sets.WS['Wildfire'] = set_combine(sets.WS['Trueflight'], {
        left_ring = "Ilabrat Ring",
        right_ear = "Novio earring"
    })
    sets.WS['Wildfire'].None = sets.WS['Wildfire']
    sets.WS['Wildfire'].Half = sets.WS['Wildfire'].None
    sets.WS['Wildfire'].Full = sets.WS['Wildfire'].None

    -- Hot Shot--
    sets.WS['Hot Shot'] = set_combine(sets.WS['Trueflight'], {
        head = "Nyame Helm",
        body = "Carm. Sc. Mail +1",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Weapon skill damage +10%'
            }
        }
    })
    sets.WS['Hot Shot'].None = sets.WS['Hot Shot']
    sets.WS['Hot Shot'].Half = set_combine(sets.WS['Hot Shot'].None,
                                           {body = "Ikenga's Vest"})
    sets.WS['Hot Shot'].Full = set_combine(sets.WS['Hot Shot'].Half,
                                           {hands = "Ikenga's Gloves"})

    -- Dagger Weapon Skills --

    sets.WS['Exenterator'] = {
        head = {
            name = "Adhemar Bonnet +1",
            augments = {'DEX+12', 'AGI+12', 'Accuracy+20'}
        },
        neck = "Fotia Gorget",
        ear1 = "Odr Earring",
        ear2 = "Telos Earring",
        body = "Meg. Cuirie +2",
        hands = {
            name = "Adhemar Wrist. +1",
            augments = {'STR+12', 'DEX+12', 'Attack+20'}
        },
        left_ring = "Ilabrat Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10',
                'Weapon skill damage +10%'
            }
        },
        waist = "Fotia Belt",
        legs = "Darraigner's Brais",
        feet = "Thereoid Greaves"
    }

    sets.WS['Evisceration'] = sets.WS['Exenterator']

    sets.WS['Aeolian Edge'] = set_combine(sets.WS['Wildfire'], {
        head = "Nyame Helm",
        body = "Carm. Sc. Mail +1",
        right_ear = "Moonshade Earring",
        waist = "Orpheus's Sash"
    })

    sets.WS.Decimation = {
        head = {
            name = "Adhemar Bonnet +1",
            augments = {'DEX+12', 'AGI+12', 'Accuracy+20'}
        },
        body = {
            name = "Adhemar Jacket +1",
            augments = {'DEX+12', 'AGI+12', 'Accuracy+20'}
        },
        hands = {
            name = "Adhemar Wrist. +1",
            augments = {'STR+12', 'DEX+12', 'Attack+20'}
        },
        legs = "Meg. Chausses +2",
        feet = "Thereoid Greaves",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        right_ring = "Regal Ring",
        left_ring = "Ilabrat Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'STR+20', 'Accuracy+20 Attack+20', 'STR+10',
                'Weapon skill damage +10%'
            }
        }
    }

    -- Savage Blade Set--
    sets.WS['Savage Blade'] = set_combine(sets.WS['Last Stand'], {
        body = {
            name = "Herculean vest",
            augments = {'STR+2', 'Attack+15', 'Weapon skill damage +4%'}
        },
        ammo = "Hauksbok Arrow",
        waist = "Sailfi Belt +1"
    })

    -- JA Sets --
    sets.JA = {}
    sets.JA.Shadowbind = {
        head = "Orion Beret +3",
        neck = "Scout's Gorget +2",
        ear1 = "Enervating Earring",
        ear2 = "Telos Earring",
        body = "Nisroch Jerkin",
        hands = "Orion Bracers +3",
        left_ring = "Regal Ring",
        right_ring = "Cacoethic Ring +1",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', '"Store TP"+10',
                'Damage taken-5%'
            }
        },
        waist = "Yemaya Belt",
        legs = "Ikenga's Trousers",
        feet = "Orion Socks +3"
    }

    sets.JA.Scavenge = {feet = "Orion Socks +3"}

    sets.JA.Camouflage = {body = "Nisroch Jerkin"}

    sets.JA.Sharpshot = {legs = "Orion Braccae +2"}

    sets.JA["Bounty Shot"] = {
        hands = "Amini Glove. +1",
        waist = "Chaac Belt",
        legs = "Volte Hose"
    }

    sets.JA["Double Shot"] = {}

    sets.JA["Eagle Eye Shot"] = {
        head = "Arcadian Beret +3",
        neck = "Scout's Gorget +2",
        ear1 = "Odr Earring",
        ear2 = "Telos Earring",
        body = "Ikenga's Vest",
        hands = "Orion Bracers +3",
        left_ring = "Regal Ring",
        right_ring = "Dingir Ring",
        back = {
            name = "Belenus's Cape",
            augments = {
                'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', '"Store TP"+10',
                'Damage taken-5%'
            }
        },
        waist = "Yemaya Belt",
        legs = "Arc. Braccae +3",
        feet = "Osh. Leggings +1"
    }

    sets.JA["Barrage"] = set_combine(sets.Midshot, {
        body = "Nisroch Jerkin",
        hands = "Orion Bracers +3",
        neck = "Scout's Gorget +2",
        legs = "Ikenga's Trousers",
        feet = "Osh. Leggings +1",
        left_ring = "Regal Ring",
        right_ring = "Cacoethic Ring +1"
    })

    -- Waltz Set --
    sets.Waltz = {
        head = "Mummu Bonnet +2",
        body = "Passion Jacket",
        legs = "Dashing Subligar",
        left_ring = "Asklepian Ring",
        feet = {
            name = "Herculean Boots",
            augments = {
                'Attack+12', '"Waltz" potency +10%', 'AGI+2', 'Accuracy+3'
            }
        }
    }

    sets.Precast = {}
    -- Fastcast Set --
    sets.Precast.FastCast = {
        head = "Carmine Mask +1",
        neck = "Baetyl Pendant",
        ear1 = "Tuisto Earring",
        ear2 = "Etiolation earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        left_ring = "Weather. Ring +1",
        right_ring = "Defending Ring",
        waist = "Rumination Sash",
        legs = "Carmine Cuisses +1",
        feet = "Carmine Greaves +1"
    }

    -- Utsusemi Precast Set --
    sets.Precast.Utsusemi = set_combine(sets.Precast.FastCast, {
        body = "Passion Jacket",
        neck = "Magoraga Beads"
    })

    sets.Midcast = {}

    -- Magic Haste Set --
    sets.Midcast.Haste = set_combine(sets.PDT, {})
end

function pretarget(spell, action)
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and
        buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
        cancel_spell()
        send_command('Aggressor')
    elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
        cancel_spell()
        send_command('ThirdEye')
    elseif spell.english == "Meditate" and player.tp > 290 then -- Cancel Meditate If TP Is Above 290 --
        cancel_spell()
        add_to_chat(123, spell.name .. ' Canceled: [' .. player.tp .. ' TP]')
    elseif (spell.english == 'Ranged' and spell.target.distance > 24.9) or
        (player.status == 'Engaged' and
            ((ranged_ws:contains(spell.english) and spell.target.distance > 16 +
                target_distance) or
                (spell.type == "WeaponSkill" and
                    not ranged_ws:contains(spell.english) and
                    spell.target.distance > target_distance))) then -- Cancel Ranged Attack or WS If You Are Out Of Range --
        cancel_spell()
        add_to_chat(123, spell.name .. ' Canceled: [Out of Range]')
        return
    end
end

function precast(spell, action)
    if spell.english == 'Ranged' then
        equipSet = sets.Preshot
        add_to_chat(57, "Flurry Level " .. PreshotArray[PreshotIndex])
        if buffactive['Flurry'] then
            add_to_chat(122, "Flurry found")
            if PreshotArray[PreshotIndex] == 'RDM' then
                if equipSet[player.equipment.range].RDM then
                    equipSet = equipSet[player.equipment.range].RDM
                end
            else
                if equipSet[player.equipment.range].Any then
                    equipSet = equipSet[player.equipment.range].Any
                end
            end
        else
            if equipSet[player.equipment.range] then
                equipSet = equipSet[player.equipment.range]
            end
            add_to_chat(122, "No flurry")
        end

        if player.equipment.ammo == "Hauksbok Arrow" then
                cancel_spell()
                add_to_chat(122, "Don't shoot your hauksbok, canceling...")
        end
        equip(equipSet)

    elseif spell.type == "WeaponSkill" then
        equipSet = sets.WS
        if equipSet[spell.english] then
            equipSet = equipSet[spell.english]
        end
        if equipSet[PDLArray[PDLIndex]] then
            equipSet = equipSet[PDLArray[PDLIndex]]
        end
        if player.tp > 2249 or buffactive.Sekkanoki then
            if spell.english == "Last Stand" then -- Equip Telos Earring When You Have 3000 TP or Sekkanoki For Last Stand --
                equipSet = set_combine(equipSet, {ear2 = "Telos Earring"})
            elseif spell.english == "Jishnu's Radiance" then -- Equip Telos Earring When You Have 3000 TP or Sekkanoki For Jishnu's Radiance --
                equipSet = set_combine(equipSet, {ear2 = "Telos Earring"})
            elseif spell.english == 'Trueflight' then -- Equip Ishvara Earring When you have 3000 TP or Sekkanoki for Trueflight --
                equipSet = set_combine(equipSet, {ear2 = "Ishvara Earring"})

            elseif spell.english == 'Hot Shot' then -- Equip Novio Earring when you have 3000 TP or Sakkanoki for Hot Shot --
                equipSet = set_combine(equipSet, {ear2 = "Novio Earring"})
            end
        end

        if spell.english == 'Trueflight' and spell.target.distance < 8 then
            equipSet = set_combine(equipSet, {waist = "Orpheus's Sash"})

        elseif spell.english == 'Trueflight' and
            (world.weather_element == 'Light' or world.day_element == 'Light') then
            add_to_chat(125, 'weather mode')
            equipSet = set_combine(equipSet, {waist = "Hachirin-no-Obi"})

        end

        if spell.english == 'Wildfire' and spell.target.distance < 8 then
            equipSet = set_combine(equipSet, {waist = "Orpheus's Sash"})

        elseif spell.english == 'Wildfire' and
            (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            add_to_chat(125, 'weather mode')
            equipSet = set_combine(equipSet, {waist = "Hachirin-no-Obi"})
        end
        equip(equipSet)

    elseif spell.type == "JobAbility" then
        if sets.JA[spell.english] then equip(sets.JA[spell.english]) end
    elseif spell.type:endswith('Magic') or spell.type == "Ninjutsu" then
        if string.find(spell.english, 'Utsusemi') then
            if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
                cancel_spell()
                add_to_chat(123, spell.name .. ' Canceled: [3+ Images]')
                return
            else
                equip(sets.Precast.Utsusemi)
            end
        else
            equip(sets.Precast.FastCast)
        end
    elseif spell.type == "Waltz" then
        equip(sets.Waltz)
    elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
        cast_delay(0.2)
        send_command('cancel Sneak')
    end
end

function midcast(spell, action)
    if spell.english == 'Ranged' then
        equipSet = sets.Midshot
        if equipSet[player.equipment.range] then
            equipSet = equipSet[player.equipment.range]
        end
        if equipSet[RaccArray[RaccIndex]] then
            equipSet = equipSet[RaccArray[RaccIndex]]
        end

        if buffactive.Barrage and equipSet["Barrage"] then
            equipSet = equipSet["Barrage"]
        end
        if buffactive['Double Shot'] and equipSet["Doubleshot"] then
            equipSet = equipSet["Doubleshot"]
        end
        if buffactive['Camouflage'] and equipSet["Camouflage"] then
            equipSet = equipSet["Camouflage"]
        end

        equip(equipSet)

    elseif spell.type:endswith('Magic') or spell.type == "Ninjutsu" then
        if string.find(spell.english, 'Utsusemi') then
            if spell.english == 'Utsusemi: Ichi' and
                (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
                send_command('@wait 1.7;cancel Copy Image*')
            end
            equip(sets.Midcast.Haste)
        elseif spell.english == 'Monomi: Ichi' then
            if buffactive['Sneak'] then
                send_command('@wait 1.7;cancel sneak')
            end
            equip(sets.Midcast.Haste)
        else
            equip(sets.Midcast.Haste)
        end

    end
end

function aftercast(spell, action) status_change(player.status) end

function status_change(new, old)
    if Armor == 'PDT' then
        equip(sets.PDT)
    elseif Armor == 'TH' then
        equip(sets.TH)
    elseif new == 'Engaged' then
        equipSet = sets.Melee
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end
        equip(equipSet)
    else
        equip(sets.Idle[IdleArray[IdleIndex]])
    end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
    if command == 'acc' then -- Accuracy Level Toggle --
        AccIndex = (AccIndex % #AccArray) + 1
        add_to_chat(158, 'Accuracy Level: ' .. AccArray[AccIndex])
        status_change(player.status)
    elseif command == 'racc' then -- Ranged Accuracy Level Toggle --
        RaccIndex = (RaccIndex % #RaccArray) + 1
        add_to_chat(158, 'Midshot Set: ' .. RaccArray[RaccIndex])
        status_change(player.status)
    elseif command == 'pdl' then -- PDL WS Toggle --
        PDLIndex = (PDLIndex % #PDLArray) + 1
        add_to_chat(158, 'WS PDL Level: ' .. PDLArray[PDLIndex])
        status_change(player.status)
    elseif command == 'flur' then -- Flurry Level Toggle --
        PreshotIndex = (PreshotIndex % #PreshotArray) + 1
        add_to_chat(158, 'Flurry Level: ' .. PreshotArray[PreshotIndex])
        status_change(player.status)
    elseif command == 'auto' then -- Auto Update Gear Toggle --
        status_change(player.status)
        add_to_chat(158, 'Auto Update Gear')
    elseif command == 'pdt' then -- PDT Toggle --
        if Armor == 'PDT' then
            Armor = 'None'
            add_to_chat(123, 'PDT Set: [Unlocked]')
        else
            Armor = 'PDT'
            add_to_chat(158, 'PDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'th' then -- TH Toggle --
        if Armor == 'TH' then
            Armor = 'None'
            add_to_chat(123, 'TH Set: [Unlocked]')
        else
            Armor = 'TH'
            add_to_chat(158, 'TH Set: [Locked]')
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
        add_to_chat(158, 'Idle Set: ' .. IdleArray[IdleIndex])
        status_change(player.status)
    elseif command == 'TP' then
        add_to_chat(158, 'TP Return: [' .. tostring(player.tp) .. ']')
    elseif command:match('^SC%d$') then
        send_command('//' .. sc_map[command])
    end
end

function autoRA() send_command('@wait 2.5; input /ra <t>') end
