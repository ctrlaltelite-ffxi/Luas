-- *** Credit goes to Flippant for helping me with Gearswap *** --
-- ** I Use Some of Motenten's Functions ** --
-- All Credit goes to Bokura and her Credit notes, I Simply altered a few things to make it work for me and simplify it slightly--
 
function get_sets()
    include('organizer-lib')
	organizer_items = {
	ss_23="Storage Slip 23",
	ss_24="Storage Slip 24",
	ss_25="Storage Slip 25",
	ss_27="Storage Slip 27",
	}
 
--KeyBinds
    send_command('wait 5; input /lockstyleset 5')
	add_to_chat (55, 'Slip: 23, 24, 25, 27')
    send_command('bind ^f1 gs c C7')
    send_command('bind ^f2 gs c C15')
    send_command('bind ^f3 gs c C16')
    send_command('bind !f1 gs c C2')
    send_command('bind !f2 gs c C1')
    send_command('bind !f3 gs c C3')
 
    AccIndex = 1
    AccArray = {"LowACC","MidACC","HighACC"} -- 3 Levels Of Accuracy Sets For TP/WS/Hybrid. First Set Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below. Most of These Sets Are Empty So You Need To Edit Them On Your Own. Remember To Check What The Combined Set Is For Each Sets. --
    WeaponIndex = 1
    WeaponArray = {"Chango","Montante","Shiningone", "Fencer", "Club", "KajaKnuckles", "DWSword", "DWAxe", "Staff" } --"DWSword","Ragnarok","DWSword"Default Main Weapon Is Ukonvasara. Can Delete Any Weapons/Sets That You Don't Need Or Replace/Add The New Weapons That You Want To Use. --
    IdleIndex = 1
    IdleArray = {"Movement","Regen"} -- Default Idle Set Is Movement --
    Armor = 'None'
    Twilight = 'None'
    Attack = 'OFF' -- Set Default WS Attack Set ON or OFF Here --
    Retaliation = 'OFF' -- Set Default Retaliation ON or OFF Here --
    select_default_macro_book() -- Change Default Macro Book At The End --
 
    -- Gavialis Helm --
    elements = {}
    --elements.equip = {head="Gavialis Helm"}
    --elements["Ukko's Fury"] = S{"Light","Lightning","Wind"}
    --elements.Resolution = S{"Lightning","Wind","Earth"}
 
    sets.Idle = {}
    -- Idle/Town Sets --
    sets.Idle.Regen = {
        ammo="Staunch Tathlum",
        head="Sakpata's Helm",
        body={ name={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands="Sakpata's Gauntlets",
        legs={ name={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},     
        feet="Pumm. Calligae +3",
        neck="Loricate Torque +1",
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.Idle.Regen.Fencer = set_combine(sets.Idle.Regen,{
			main="Naegling",
			sub="Blurred Shield +1"})
    sets.Idle.Regen.Club = set_combine(sets.Idle.Regen,{
			main={ name="Loxotic Mace +1", augments={'Path: A',}},
			sub="Blurred Shield +1"})		
    sets.Idle.Regen.KajaKnuckles = set_combine(sets.Idle.Regen,{
            main="Kaja Knuckles",
            sub="Utu Grip"})
    sets.Idle.Regen.Ragnarok = set_combine(sets.Idle.Regen,{
            main="Ragnarok",
            sub="Utu Grip"})
    sets.Idle.Regen.Ragnarok = set_combine(sets.Idle.Regen,{
            main="Ragnarok",
            sub="Utu Grip"})
    sets.Idle.Regen.Montante = set_combine(sets.Idle.Regen,{
            main="Agwu's Claymore",
            sub="Utu Grip"})        
    sets.Idle.Regen.Ragnarok = set_combine(sets.Idle.Regen,{
            main="Ragnarok",
            sub="Utu Grip"})    
    sets.Idle.Regen.Shiningone = set_combine(sets.Idle.Regen,{
            main="Shining One",
            sub="Utu Grip"})
    sets.Idle.Regen.Chango = set_combine(sets.Idle.Regen,{
            main="Chango",
            sub="Utu Grip"})
	sets.Idle.Regen.Staff = set_combine(sets.Idle.Regen,{
            main="Kaja Staff",
            sub="Utu Grip"})
    sets.Idle.Regen.DWSword = set_combine(sets.Idle.Regen,{
			main="Naegling",
			sub="Ternion Dagger +1"})
    sets.Idle.Regen.DWAxe = set_combine(sets.Idle.Regen,{
            main="Dolichenus",
            sub={ name="Sangarius +1", augments={'Path: A',}}})
 
 
    sets.Idle.Movement = set_combine(sets.Idle.Regen,{})
    sets.Idle.Movement.Fencer = set_combine(sets.Idle.Movement,{
			main="Naegling",
			sub="Blurred Shield +1"})
    sets.Idle.Movement.Club = set_combine(sets.Idle.Movement,{
			main={ name="Loxotic Mace +1", augments={'Path: A',}},
			sub="Blurred Shield +1"})		
    sets.Idle.Movement.KajaKnuckles = set_combine(sets.Idle.Movement,{
            main="Kaja Knuckles",
								})
    sets.Idle.Movement.Ragnarok = set_combine(sets.Idle.Movement,{
            main="Ragnarok",
            sub="Utu Grip"})
    sets.Idle.Movement.Montante = set_combine(sets.Idle.Regen,{
            main="Agwu's Claymore",
            sub="Utu Grip"})
    sets.Idle.Movement.Shiningone = set_combine(sets.Idle.Movement,{
            main="Shining One",
            sub="Utu Grip"})
    sets.Idle.Movement.Chango = set_combine(sets.Idle.Movement,{
            main="Chango",
            sub="Utu Grip"})
	sets.Idle.Movement.Staff = set_combine(sets.Idle.Movement,{
            main="Kaja Staff",
            sub="Utu Grip"})
    sets.Idle.Movement.DWSword = set_combine(sets.Idle.Movement,{
			main="Naegling",
			sub="Ternion Dagger +1"})
    sets.Idle.Movement.DWAxe = set_combine(sets.Idle.Movement,{
            main="Dolichenus",
            sub={ name="Sangarius +1", augments={'Path: A',}}})
 
 
 
    sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}
 
    -- TP Base Set --
    sets.TP = {}
 
    -- Ukonvasara TP Sets --
		sets.TP.KajaKnuckles = { 
		main="Kaja Knuckles",
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",
		body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist="Ioskeha Belt",
		left_ear="Mache Earring +1",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }
    sets.TP.KajaKnuckles.MidACC = set_combine(sets.TP.KajaKnuckles,{
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        left_ear="Telos Earring",
    })
    sets.TP.KajaKnuckles.HighACC = set_combine(sets.TP.KajaKnuckles.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Regal Ring",
})
 
    -- Ragnarok TP Sets --
    sets.TP.Ragnarok = {
        main="Ragnarok",
        sub="Utu Grip",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Ainia Collar",
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    sets.TP.Ragnarok.MidACC = set_combine(sets.TP.Ragnarok,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        head="Flam. Zucchetto +2",
        body="Pumm. Lorica +3",
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Combatant's Torque",
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Zennaroi Earring",
        left_ring="Ramuh Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    
    })
    sets.TP.Ragnarok.HighACC = set_combine(sets.TP.Ragnarok.MidACC,{})
 
 
--Montante TP
    sets.TP.Montante = {
        main="Agwu's Claymore",
        sub="Utu Grip",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Ainia Collar",
        waist="Ioskeha Belt",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Flamma Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    sets.TP.Montante.MidACC = set_combine(sets.TP.Montante,{
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        left_ear="Telos Earring",
        
    })
    sets.TP.Montante.HighACC = set_combine(sets.TP.Montante.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        neck="Combatant's Torque",
        right_ear="Digni. Earring",
        left_ring="Regal Ring",     
    })
 
    -- Shining One TP Sets --
    sets.TP.Shiningone = { 
        main="Shining One",
        sub="Utu Grip",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Flamma Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }
    sets.TP.Shiningone.MidACC = set_combine(sets.TP.Shiningone,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        head="Flam. Zucchetto +2",
        body="Pumm. Lorica +3",
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Combatant's Torque",
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    
    })
    sets.TP.Shiningone.HighACC = set_combine(sets.TP.Shiningone.MidACC,{})    
    
    --Chango Set
    sets.TP.Chango = {
        main="Chango",
        sub="Utu Grip",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Flamma Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }
    sets.TP.Chango.MidACC = set_combine(sets.TP.Chango,{
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        left_ear="Telos Earring",           
})
    sets.TP.Chango.HighACC = set_combine(sets.TP.Chango.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        right_ear="Digni. Earring",
        left_ring="Regal Ring",
    })
 
    --Duel Wield Set
    sets.TP.DWSword = {
        main="Naegling",
        sub="Ternion Dagger +1",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Agoge Lorica +3",
        hands={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Petrov Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        
        }
    sets.TP.DWSword.MidACC = set_combine(sets.TP.DWSword,{
})
    sets.TP.DWSword.HighACC = set_combine(sets.TP.DWSword.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        right_ear="Digni. Earring",
        left_ring="Regal Ring",
    })
 
    sets.TP.DWAxe = {
        main="Dolichenus",
		sub={ name="Sangarius +1", augments={'Path: A',}},
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Agoge Lorica +3",
        hands={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Petrov Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        
        }
    sets.TP.DWAxe.MidACC = set_combine(sets.TP.DWAxe,{
})
    sets.TP.DWAxe.HighACC = set_combine(sets.TP.DWAxe.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        right_ear="Digni. Earring",
        left_ring="Regal Ring",
    })
    
    --Fencer Set
    sets.TP.Fencer = {
        main="Naegling",
        sub="Blurred Shield +1",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
            }
    sets.TP.Fencer.MidACC = set_combine(sets.TP.Fencer,{
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        left_ear="Telos Earring",           
    })
    sets.TP.Fencer.HighACC = set_combine(sets.TP.Fencer.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Regal Ring"
    })
	
	    sets.TP.Club = {
        main={ name="Loxotic Mace +1", augments={'Path: A',}},
        sub="Blurred Shield +1",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
            }
    sets.TP.Club.MidACC = set_combine(sets.TP.Club,{
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        left_ear="Telos Earring",           
    })
    sets.TP.Club.HighACC = set_combine(sets.TP.Club.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Regal Ring"
    })
	
	sets.TP.Staff = {
        main="Kaja Staff",
        sub="Utu Grip",
        ammo="Aurgelmir Orb",
        head="Flam. Zucchetto +2",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
            }
    sets.TP.Staff.MidACC = set_combine(sets.TP.Staff,{
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        left_ear="Telos Earring",           
    })
    sets.TP.Staff.HighACC = set_combine(sets.TP.Staff.MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        body="Pumm. Lorica +3",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Regal Ring"
    })
 
    -- Conqueror(AM3 Up) TP Sets --
--    sets.TP.Conqueror.AM3 = set_combine(sets.TP.Conqueror,{
--        ammo="Aurgelmir Orb",
--        head="Flam. Zucchetto +2",
--        body="Sakpata's Plate",
--        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
--        legs={ name="Odyssean Cuisses", augments={'Accuracy+28','"Store TP"+5','Attack+12',}},
--        feet={ name="Valorous Greaves", augments={'Accuracy+29','"Store TP"+6','STR+6','Attack+7',}},
--        neck="Ainia Collar",
--        waist="Sailfi Belt +1",
--        left_ear="Telos Earring",
--        right_ear="Dedition Earring",
--        left_ring="Chirich Ring +1",
--        right_ring="Niqmaddu Ring",
--        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10',}},
--    })
--    sets.TP.Fencer.MidACC.AM3 = set_combine(sets.TP.Conqueror.MidACC,{})
--    sets.TP.Fencer.HighACC.AM3 = set_combine(sets.TP.Conqueror.HighACC,{})
 
    -- Mighty Strikes TP Set --
    sets.TP.MS = {
 
    }
 
    -- Retaliation Set --
    --sets.TP.Retaliation = {hands="Pumm. Mufflers +2",feet="Boii Calligae +1"}
 
    -- AM3 Rancor ON Mantle --
    sets.TP.Rancor = {back=""}
 
    -- PDT/MDT Sets --
    sets.PDT = {
        ammo="Aurgelmir Orb",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck={ name="Vim Torque +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Telos Earring",
        right_ear="Dedition Earring",
        left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.MDT = set_combine(sets.PDT,{
        ammo="Staunch Tathlum",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Loricate Torque +1",
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })
 
    -- Hybrid/Kiting Sets for me personally this is my Shining One AM set when expecting to take dmg --
    sets.TP.Hybrid = {
        sub="Utu Grip",
        ammo="Staunch Tathlum",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        } 
    sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
    sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})
 
    sets.Kiting = set_combine(sets.PDT,{feet="Hermes' Sandals"})
 
    -- CP Mantle --
    sets.CP = {back="Mecisto. Mantle"}
 
    -- WS Base Set --
    sets.WS = {
        ammo="Seething Bomblet +1",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Telos Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
 
    -- Upheaval Sets --
    sets.WS.Upheaval = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist="Ioskeha Belt",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring", --"Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
            }
    sets.WS.Upheaval.MidACC = set_combine(sets.WS.Upheaval,{
        left_ear="Telos Earring",
        right_ear="Cessance Earring"})
    sets.WS.Upheaval.HighACC = set_combine(sets.WS.Upheaval.MidACC,{})
 
    -- Upheaval(Attack) Set --
    sets.WS.Upheaval.ATT = set_combine(sets.WS.Upheaval,{})
 
    -- Ukko's Fury Sets --
    sets.WS["Ukko's Fury"] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
            }
    sets.WS["Ukko's Fury"].MidACC = set_combine(sets.WS["Ukko's Fury"],{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        head="Agoge Mask +3",
        body="Pumm. Lorica +3",
        hands="Sakpata's Gauntlets",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Fotia Belt",
        left_ear="Cessance Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        
    })
    sets.WS["Ukko's Fury"].HighACC = set_combine(sets.WS["Ukko's Fury"].MidACC,{
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        head="Agoge Mask +3",
        body="Pumm. Lorica +3",
        hands={ name={ name="Emicho Gauntlets", augments={'Accuracy+20','"Dual Wield"+5','Pet: Accuracy+20',}}, augments={'HP+65','DEX+12','Accuracy+20',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Fotia Belt",
        left_ear="Telos Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })
 
    -- Ukko's Fury(Attack) Set --
    sets.WS["Ukko's Fury"].ATT = set_combine(sets.WS["Ukko's Fury"],{})
 
    -- King's Justice Sets --
    sets.WS["King's Justice"] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Agoge Mask +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +3",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    sets.WS["King's Justice"].MidACC  = set_combine(sets.WS["King's Justice"],{
        left_ear="Telos Earring",
    })
    sets.WS["King's Justice"].HighACC = set_combine(sets.WS["King's Justice"].MidACC,{})
 
    -- Metatron Torment Sets --
    sets.WS["Metatron Torment"] = {
        ammo="Knobkierrie",
        head="Agoge Mask +3",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Fotia Belt",
        left_ear="Telos Earring",
        right_ear="Dignitary's Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    sets.WS["Metatron Torment"].MidACC  = set_combine(sets.WS["Metatron Torment"],{
    })
    sets.WS["Metatron Torment"].HighACC = set_combine(sets.WS["Metatron Torment"].MidACC,{})
 
    -- Fell Cleave Set --
    sets.WS["Fell Cleave"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+7','Weapon skill damage +4%','DEX+8',}},
		legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+3','DEX+15','Weapon skill damage +7%','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
    }
 
    -- Resolution --
    sets.WS.Resolution = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }
    sets.WS.Resolution.MidACC  = set_combine(sets.WS.Resolution,{
        ammo="Knobkierrie",
        head="Pummeler's Mask +2",
        body="Pumm. Lorica +3",
        hands="Pumm. Mufflers +2",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Telos Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        
    })
 
    sets.WS.Resolution.HighACC = set_combine(sets.WS.Resolution.MidACC,{})
 
    -- Scourge --
    sets.WS.Scourge = {
        ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
        feet="Sulev. Leggings +2",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Caudata Belt",
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Epaminondas's Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    sets.WS.Scourge.MidACC  = set_combine(sets.WS.Scourge,{
    })
    sets.WS.Scourge.HighACC = set_combine(sets.WS.Scourge.MidACC,{})
	-- Savage Blade --
    sets.WS["Savage Blade"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+7','Weapon skill damage +4%','DEX+8',}},
		legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+3','DEX+15','Weapon skill damage +7%','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
        
    }
	--Club Weaponskills --
    sets.WS["Hexa Strike"] = {
		ammo="Knobkierrie",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
        left_ear="Telos Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        
    }
    sets.WS["Judgment"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+7','Weapon skill damage +4%','DEX+8',}},
		legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+3','DEX+15','Weapon skill damage +7%','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        
    }
    sets.WS["Black Halo"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+7','Weapon skill damage +4%','DEX+8',}},
		legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+3','DEX+15','Weapon skill damage +7%','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
        
    }
	-- Staff Weaponskills
	sets.WS["Cataclysm"] = {
		ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body={ name="Found. Breastplate", augments={'Accuracy+13','Mag. Acc.+14','Attack+13','"Mag.Atk.Bns."+13',}},
        hands={ name="Valorous Mitts", augments={'Attack+21','Accuracy+9','Weapon skill damage +6%','Accuracy+1 Attack+1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
        legs={ name="Augury Cuisses +1", augments={'Path: A',}},
        feet="Sulev. Leggings +2",
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Archon Ring",
        back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}, --{ name="Cichol's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		
	}
		
    -- Magic Based WS --
    sets.WS.Cloudsplitter = {
        ammo="Pemphredo Tathlum",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body={ name="Found. Breastplate", augments={'Accuracy+13','Mag. Acc.+14','Attack+13','"Mag.Atk.Bns."+13',}},
        hands={ name="Valorous Mitts", augments={'Attack+21','Accuracy+9','Weapon skill damage +6%','Accuracy+1 Attack+1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
        legs={ name="Augury Cuisses +1", augments={'Path: A',}},
        feet="Sulev. Leggings +2",
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}, --{ name="Cichol's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
        }
 
    sets.WS['Sanguine Blade'] = {
        ammo="Seething Bomblet +1",
        head="Jumalik Helm",
        body={ name="Found. Breastplate", augments={'Accuracy+14','Mag. Acc.+13','Attack+14','"Mag.Atk.Bns."+14',}},
        hands={ name="Founder's Gauntlets", augments={'STR+8','Attack+15','"Mag.Atk.Bns."+13','Phys. dmg. taken -3%',}},
        legs={ name="Augury Cuisses +1", augments={'Path: A',}},
        feet={ name="Odyssean Greaves", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Weapon Skill Acc.+6','STR+4','"Mag.Atk.Bns."+15',}},
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Acumen Ring",
        right_ring="Rufescent Ring",
        back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}, --{ name="Cichol's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }
 
    sets.WS['Full Break'] = {
        ammo="Pemphedro Tathlum",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Telos Earring",
        right_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",
        right_ring="Weatherspoon Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
 
 
    sets.WS['Shield Break'] = {
        ammo="Pemphedro Tathlum",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Telos Earring",
        right_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",
        right_ring="Weatherspoon Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.WS['Armor Break'] = {
        ammo="Pemphedro Tathlum",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Telos Earring",
        right_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",
        right_ring="Weatherspoon Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.WS['Weapon Break'] = {
        ammo="Pemphedro Tathlum",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Telos Earring",
        right_ear="Dignitary's Earring",
        left_ring="Chirich Ring +1",
        right_ring="Weatherspoon Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }
 
    sets.WS.Decimation = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
 
    }
 
    sets.WS.Ruinator = {
    }
	
	sets.WS['Stardiver'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.WS['Impulse Drive'] = {
		ammo="Aurgelmir Orb",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+7','Weapon skill damage +4%','DEX+8',}},
		legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+3','DEX+15','Weapon skill damage +7%','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
	
	sets.WS['Raging Fists'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
 
    -- Mighty Strikes WS Set --
    sets.MS_WS = {
        ammo="Yetshila",
        feet={ name="Valorous Greaves", augments={'Accuracy+26','Crit. hit damage +3%','VIT+7','Attack+12',}},
 
    }
 
    sets.Upheaval2250 = {
        ammo="Knobkierrie",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist="Ioskeha Belt",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
    }       
    sets.Upheaval2k = {
        ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist="Ioskeha Belt",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
        }
 
    sets.KJTP2250 = {
 
    }
 
    sets.KJTP2k = {
 
    } 
    -- JA Sets --
    sets.JA = {}
    sets.JA.Berserk = {feet="Agoge Calligae +3", body="Pumm. Lorica +3", back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
    sets.JA.Aggressor = {head="Pummeler's Mask +2",body="Agoge Lorica +3"}
    sets.JA["Blood Rage"] = {body="Boii Lorica +1"}
    sets.JA.Warcry = {head="Agoge Mask +3"}
    sets.JA.Tomahawk = {ammo="Thr. Tomahawk",feet="Agoge Calligae +3"}
    sets.JA["Mighty Strikes"] = {hands="Agoge Mufflers +1"}
    sets.JA.Provoke = {
        ammo="Sapience Orb",
        head="Pummeler's Mask +2",
        body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands={ name="Yorium Gauntlets", augments={'Enmity+10',}},
        legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        neck={ name="Unmoving Collar +1", augments={'Path: A',}},
        waist="Trance Belt",
        left_ring="Apeile Ring +1",
        right_ring="Apeile Ring",
        back="Reiki Cloak",
        
    }
 
    -- Waltz Set --
    sets.Waltz = {}
 
    sets.Precast = {}
    -- Fastcast Set --
    sets.Precast.FastCast = {
        ammo="Staunch Tathlum",
        body={ name="Odyss. Chestplate", augments={'Accuracy+17','"Fast Cast"+5','Attack+6',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
        legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
        feet={ name="Odyssean Greaves", augments={'Mag. Acc.+12','"Fast Cast"+5','"Mag.Atk.Bns."+4',}},
        neck="Moonlight Necklace",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        --left_ring="Rahab Ring",
        --right_ring="Rahab Ring",
        waist="Ioskeha Belt"
    }
 
    sets.Midcast = {}
    -- Magic Haste Set --
    sets.Midcast.Haste = set_combine(sets.PDT,{
        ammo="Staunch Tathlum",
        head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        body={ name="Odyss. Chestplate", augments={'Accuracy+17','"Fast Cast"+5','Attack+6',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
        legs={ name="Founder's Hose", augments={'MND+9','Mag. Acc.+13','Attack+14','Breath dmg. taken -4%',}},
        feet={ name="Odyssean Greaves", augments={'Mag. Acc.+12','"Fast Cast"+5','"Mag.Atk.Bns."+4',}},
        neck="Moonlight Necklace",
        waist="Ioskeha Belt",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Evanescence Ring",
        back="Moonbeam Cape"
    
    })
 
    sets.organizer = {
        item="Sublime Sushi +1",
        item="Sublime Sushi",
        item="Echo Drops",
        ammo="Thr. Tomahawk",
    }
end
 
function pretarget(spell,action)
    if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
        cancel_spell()
        send_command('ThirdEye')
    elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
        cancel_spell()
        add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
 
    end
end
 
function precast(spell,action)
    if spell.type == "WeaponSkill" then
            equipSet = sets.WS
            if equipSet[spell.english] then
                equipSet = equipSet[spell.english]
            end
            if Attack == 'ON' then
                equipSet = equipSet["ATT"]
            end
            if equipSet[AccArray[AccIndex]] then
                equipSet = equipSet[AccArray[AccIndex]]
            end
            if elements[spell.name] and elements[spell.name]:contains(world.day_element) then
                equipSet = set_combine(equipSet,elements.equip)
            end
            if buffactive["Mighty Strikes"] then -- Equip MS_WS Set When You Have Mighty Strikes On --
                equipSet = set_combine(equipSet,sets.MS_WS)
            end
            if spell.english == "Ukko's Fury" or spell.english == "King's Justice" then
                if world.time <= (7*60) or world.time >= (17*60) then -- Equip Lugra Earring +1 From Dusk To Dawn --
                    equipSet = set_combine(equipSet,{left_ear="Lugra Earring +1"})
                end
            end
            if spell.english == "Upheaval" then 
                if player.tp > 2750 then
                    equipSet = sets.Upheaval2250
 
                 elseif player.tp > 2000 then
                    equipSet = sets.Upheaval2k
                 end
                 
                if world.time <= (760) or world.time >= (1760) then -- Equip Lugra Earring +1 From Dusk To Dawn --
                    equipSet = set_combine(equipSet,{left_ear="Lugra Earring +1"})
                end
            end
            equip(equipSet)
    elseif spell.type == "JobAbility" then
        if sets.JA[spell.english] then
            equip(sets.JA[spell.english])
        end
    elseif spell.action_type == 'Magic' then
        if spell.english == 'Utsusemi: Ni' then
            if buffactive['Copy Image (3)'] then
                cancel_spell()
                add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
                return
            else
                equip(sets.Precast.FastCast)
            end
        else
            equip(sets.Precast.FastCast)
        end
    elseif spell.type == "Waltz" then
        refine_waltz(spell,action)
        equip(sets.Waltz)
    elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
        cast_delay(0.2)
        send_command('cancel Sneak')
    end
    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end
 
function midcast(spell,action)
    if spell.action_type == 'Magic' then
        if spell.english:startswith('Utsusemi') then
            if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then -- Cancel Copy Image 1, 2 & 3 For Utsusemi: Ichi --
                send_command('@wait 1.7;cancel Copy Image*')
            end
            equip(sets.Midcast.Haste)
        elseif spell.english == 'Monomi: Ichi' then -- Cancel Sneak --
            if buffactive['Sneak'] then
                send_command('@wait 1.7;cancel sneak')
            end
            equip(sets.Midcast.Haste)
        else
            equip(sets.Midcast.Haste)
        end
    end
end
 
function aftercast(spell,action)
    if not spell.interrupted then
        if spell.type == "WeaponSkill" then
            send_command('wait 0.2;gs c TP')
        elseif spell.english == "Blood Rage" then -- Blood Rage Timer/Countdown --
            timer_blood_rage()
            send_command('wait 50;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
        elseif spell.english == "Tomahawk" then -- Tomahawk Timer/Countdown --
            timer_tomahawk()
            send_command('wait 80;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Tomahawk";input /echo '..spell.name..': [OFF]')
        end
    end
    status_change(player.status)
end
 
function status_change(new,old)
    check_equip_lock()
    if Armor == 'PDT' then
        equip(sets.PDT)
    elseif Armor == 'MDT' then
        equip(sets.MDT)
    elseif Armor == 'Kiting' then
        equip(sets.Kiting)
--[[    elseif Armor == 'CP' then
        send_command('gs disable back')]]--
    elseif new == 'Engaged' then
        equipSet = sets.TP
        if Armor == 'Hybrid' and equipSet["Hybrid"] then
            equipSet = equipSet["Hybrid"]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end
        if buffactive["Aftermath: Lv.3"] and equipSet["AM3"] then
            if Rancor == 'ON' then -- Default Rancor Toggle Is Rancorous Mantle --
                equipSet = set_combine(equipSet["AM3"],sets.TP.Rancor)
            else -- Use Rancor Toggle For Atheling Mantle --
                equipSet = equipSet["AM3"]
            end
        end
        if buffactive.Aftermath and equipSet["AM"] then
            equipSet = equipSet["AM"]
        end
        if buffactive["Mighty Strikes"] then -- Mighty Strikes TP Set --
            equipSet = set_combine(equipSet,sets.TP.MS)
        end
        equip(equipSet)
    else
        equipSet = sets.Idle
        if equipSet[IdleArray[IdleIndex]] then
            equipSet = equipSet[IdleArray[IdleIndex]]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
            equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
        end
        equip(equipSet)
    end
    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end
 
function buff_change(buff,gain)
    buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
        if gain then
            send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
        else
            send_command('timers delete "Aftermath: Lv.3"')
            add_to_chat(123,'AM3: [OFF]')
        end
    elseif buff == "blood rage" and not gain then
        send_command('timers delete "Blood Rage"')
    elseif buff == 'weakness' then -- Weakness Timer --
        if gain then
            send_command('timers create "Weakness" 300 up')
        else
            send_command('timers delete "Weakness"')
        end
    end
    if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
        equip({neck="Berserker's Torque"})
    else
        if not midaction() then
            status_change(player.status)
        end
    end
end
 
-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
    if command == 'C1' then -- Accuracy Toggle --
        AccIndex = (AccIndex % #AccArray) + 1
        add_to_chat(158,'Accuracy Level: ' .. AccArray[AccIndex])
        status_change(player.status)
    elseif command == 'C2' then -- Main Weapon Toggle --
        WeaponIndex = (WeaponIndex % #WeaponArray) + 1
        add_to_chat(158,'Main Weapon: '..WeaponArray[WeaponIndex])
        status_change(player.status)
    elseif command == 'C5' then -- Auto Update Gear Toggle --
        status_change(player.status)
        add_to_chat(158,'Auto Update Gear')
    elseif command == 'C16' then -- Hybrid Toggle --
        if Armor == 'Hybrid' then
            Armor = 'None'
            add_to_chat(123,'Hybrid Set: [Unlocked]')
        else
            Armor = 'Hybrid'
            add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
        end
        status_change(player.status)
    elseif command == 'C7' then -- PDT Toggle --
        if Armor == 'PDT' then
            Armor = 'None'
            add_to_chat(123,'PDT Set: [Unlocked]')
        else
            Armor = 'PDT'
            add_to_chat(158,'PDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C15' then -- MDT Toggle --
        if Armor == 'MDT' then
            Armor = 'None'
            add_to_chat(123,'MDT Set: [Unlocked]')
        else
            Armor = 'MDT'
            add_to_chat(158,'MDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C12' then -- Kiting Toggle --
        if Armor == 'Kiting' then
            Armor = 'None'
            add_to_chat(123,'Kiting Set: [Unlocked]')
        else
            Armor = 'Kiting'
            add_to_chat(158,'Kiting Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C10' then -- Retaliation Toggle --
        if Retaliation == 'ON' then
            Retaliation = 'OFF'
            add_to_chat(123,'Retaliation Set: [Unlocked]')
        else
            Retaliation = 'ON'
            add_to_chat(158,'Retaliation Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C9' then -- Attack Toggle --
        if Attack == 'ON' then
            Attack = 'OFF'
            add_to_chat(123,'Attack: [OFF]')
        else
            Attack = 'ON'
            add_to_chat(158,'Attack: [ON]')
        end
        status_change(player.status)
    elseif command == 'C3' then -- Twilight Toggle --
        if Twilight == 'Twilight' then
            Twilight = 'None'
            add_to_chat(123,'Twilight Set: [Unlocked]')
        else
            Twilight = 'Twilight'
            add_to_chat(158,'Twilight Set: [locked]')
        end
        status_change(player.status)
    elseif command == 'C6' then -- Idle Toggle --
        IdleIndex = (IdleIndex % #IdleArray) + 1
        add_to_chat(158,'Idle Set: ' .. IdleArray[IdleIndex])
        status_change(player.status)
    elseif command == 'TP' then
        add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
    elseif command:match('^SC%d$') then
        send_command('//' .. sc_map[command])
    end
end
 
 
function check_equip_lock() -- Lock Equipment Here --
        if player.equipment.left_ring == "Warp Ring" or player.equipment.left_ring == "Trizec Ring" or player.equipment.right_ring == "Warp Ring" or player.equipment.right_ring == "Facility Ring" then
               disable('ring1','ring2')
        elseif player.equipment.back == "Mecisto. Mantle" then
                disable('back')
        else
                enable('ring1','ring2','back')
        end
end
 
 
function timer_blood_rage()
    local duration = 60
    send_command('timers create "Blood Rage" '..tostring(duration)..' down')
end
 
function timer_tomahawk()
    local duration = 90
    send_command('timers create "Tomahawk" '..tostring(duration)..' down')
end
 
function refine_waltz(spell,action)
    if spell.type ~= 'Waltz' then
        return
    end
 
    if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
        return
    end
 
    local newWaltz = spell.english
    local waltzID
 
    local missingHP
 
    if spell.target.type == "SELF" then
        missingHP = player.max_hp - player.hp
    elseif spell.target.isallymember then
        local target = find_player_in_alliance(spell.target.name)
        local est_max_hp = target.hp / (target.hpp/100)
        missingHP = math.floor(est_max_hp - target.hp)
    end
 
    if missingHP ~= nil then
        if player.sub_job == 'DNC' then
            if missingHP < 40 and spell.target.name == player.name then
                add_to_chat(8,'Full HP!')
                cancel_spell()
                return
            elseif missingHP < 150 then
                newWaltz = 'Curing Waltz'
                waltzID = 190
            elseif missingHP < 300 then
                newWaltz = 'Curing Waltz II'
                waltzID = 191
            else
                newWaltz = 'Curing Waltz III'
                waltzID = 192
            end
        else
            return
        end
    end
 
    local waltzTPCost = {['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50}
    local tpCost = waltzTPCost[newWaltz]
 
    local downgrade
 
    if player.tp < tpCost and not buffactive.trance then
 
        if player.tp < 20 then
            add_to_chat(8, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
            cancel_spell()
            return
        elseif player.tp < 35 then
            newWaltz = 'Curing Waltz'
        elseif player.tp < 50 then
            newWaltz = 'Curing Waltz II'
        end
 
        downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
    end
 
    if newWaltz ~= spell.english then
        send_command('@input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
        if downgrade then
            add_to_chat(158, downgrade)
        end
        cancel_spell()
        return
    end
 
    if missingHP > 0 then
        add_to_chat(158,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
    end
end
 
function find_player_in_alliance(name)
    for i,v in ipairs(alliance) do
        for k,p in ipairs(v) do
            if p.name == name then
                return p
            end
        end
    end
end
 
function sub_job_change(newSubjob, oldSubjob)
    select_default_macro_book()
end
 
function set_macro_page(set,book)
    if not tonumber(set) then
        add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
        return
    end
    if set < 1 or set > 10 then
        add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
        return
    end
 
    if book then
        if not tonumber(book) then
            add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
            return
        end
        if book < 1 or book > 20 then
            add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
            return
        end
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
    else
        send_command('@input /macro set '..tostring(set))
    end
end
 
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end