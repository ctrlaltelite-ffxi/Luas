-- Summoner Gearswap Lua by Pergatory - http://pastebin.com/u/pergatory
-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- PetDT: Sacrifice refresh to reduce avatar's damage taken. WARNING: Selenian Cap drops you below 119, use with caution!
-- DD: When melee mode is on and you're engaged, uses TP gear. Otherwise, avatar melee gear.
-- Favor: Uses Beckoner's Horn +1 and max smn skill to boost the favor effect.
-- Zendik: Favor build with the Zendik Robe added in, for Shiva's Favor in manaburn parties. (Shut up, it sounded like a good idea at the time)

-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > DT > PetDT)
-- F10 - Toggles MeleeMode (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP

-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c ForceIlvl - I have this set up to override a few specific slots where I normally use non-ilvl pieces.
-- /console gs c TH - Treasure Hunter toggle. By default, this is only used for Dia, Dia II, and Diaga.
-- /console gs c LagMode - Used to help BPs land in the right gear in high-lag situations.
--							Sets a timer to swap gear 0.5s after the BP is used rather than waiting for server response.

function file_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
end

function get_sets()
	include('organizer-lib')
	send_command('bind f9 gs c ToggleIdle') -- F9 = Cycle through commonly used idle modes
	send_command('bind ^f9 gs c ForceIlvl') -- Ctrl+F9 = Toggle ForceIlvl
	send_command('bind f10 gs c MeleeMode') -- F10 = Toggle Melee Mode
	send_command('bind ^f10 gs c TH') -- Ctrl+F10 = Treasure Hunter toggle

	-- Set your merits here. This is used in deciding between Enticer's Pants or Apogee Slacks +1.
	-- To change in-game, "/console gs c MeteorStrike3" will change Meteor Strike to 3/5 merits.
	-- The damage difference is very minor unless you're over 2400 TP.
	-- It's ok to just always use Enticer's Pants and ignore this section.
	MeteorStrike = 5
	HeavenlyStrike = 1
	WindBlade = 5
	Geocrush = 1
	Thunderstorm = 1
	GrandFall = 1

	StartLockStyle = '23'
	IdleMode = 'Refresh'
	AccMode = false
	ImpactDebuff = false
	MeleeMode = false
	TreasureHunter = false
	THSpells = S{"Dia","Dia II","Diaga"} -- If you want Treasure Hunter gear to swap for a spell/ability, add it here.
	ForceIlvl = false
	LagMode = false -- Default LagMode. If you have a lot of lag issues, change to "true".
	AutoRemedy = false -- Auto Remedy when using an ability while Paralyzed.
	AutoEcho = false -- Auto Echo Drop when using an ability while Silenced.
	SacTorque = true -- If you have Sacrifice Torque, this will auto-equip it when slept in order to wake up.

	-- ===================================================================================================================
	--		Sets
	-- ===================================================================================================================

	-- Base Damage Taken Set - Mainly used when IdleMode is "DT"
	sets.DT_Base = {
		main="Malignance Pole",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet="Inyan. Crackows +2",
    neck="Loricate Torque +1",
    -- waist="Embla Sash",
    -- left_ear="Odnowa Earring +1",
    -- right_ear="Odnowa Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
	}

	-- Treasure Hunter set. Don't put anything in here except TH+ gear.
	-- It overwrites slots in other sets when TH toggle is on (Ctrl+F10).
	sets.TH = {}

	sets.precast = {}

	-- Fast Cast 30/80
	sets.precast.FC = {
    body="Inyanga Jubbah +2", --14
    waist="Embla Sash", --5
    left_ear="Malignance Earring", --4
    right_ear="Etiolation Earring", --1
    left_ring="Kishar Ring", --4
    right_ring="Prolix Ring", --2
	}

	sets.precast["Dispelga"] = set_combine(sets.precast.FC, {
		main="Daybreak",
		sub="Ammurapi Shield"
	})

    sets.midcast = {}

	-- Ward blood pacts optimize summoner magic skill to maximize buff length
	sets.precast.BPWard = {
		head="Convoker's Horn +2",
		body="Baayami Robe",
		hands="Lamassu mitts +1",
		neck="Summoning Torque",
		ammo="Sancus Sachet +1",
		ear1="Gifted earring",
		ear2="Evans earring",
		ring1="Stikini ring +1",
		ring2="Evoker's ring",
		legs="Baayami Slops",
		feet="Baayami Sabots",
		waist="Lucidity sash",
		back="Tiresias' cape"
	}

	-- Rage blood pacts optimize BP timer reduction
	sets.precast.BPRage = {
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands="Lamassu mitts +1",
		neck="Adad amulet",
		ammo="Sancus Sachet +1",
		ear1="Gifted earring",
		ear2="Evans earring",
		ring1="Varar ring +1",
		ring2="Varar ring +1",
		legs="Convoker's spats +2",
		feet="Apogee pumps",
		waist="Lucidity sash",
		back="Tiresias' cape"
	}

	-- Elemental Siphon sets. Zodiac Ring is affected by day, Chatoyant Staff by weather, and Twilight Cape by both.
    sets.midcast.Siphon = {
		-- main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		-- sub="Vox Grip",
		ammo="Esper Stone +1",
		head="Convoker's horn +2",
		-- neck="Incanter's Torque",
		-- ear1="Cath Palug Earring",
		-- ear2="Lodurr Earring",
		body="Baayami Robe",
		hands="Lamassu mitts +1",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back="Twilight cape",
		waist="Ligeia sash",
		legs="Baayami Slops",
		feet="Baayami sabots"
	}

	sets.midcast.SiphonZodiac = set_combine(sets.midcast.Siphon, { ring1="Zodiac Ring" })

	sets.midcast.SiphonWeather = set_combine(sets.midcast.Siphon, { main="Chatoyant Staff" })
	
	sets.midcast.SiphonWeatherZodiac = set_combine(sets.midcast.SiphonZodiac, { main="Chatoyant Staff" })

	-- Summoning Midcast, cap spell interruption if possible (Baayami Robe gives 100, need 2 more)
	-- PDT isn't a bad idea either, so don't overwrite a lot from the DT set it inherits from.
	sets.midcast.Summon = set_combine(sets.DT_Base, {
		-- body="Baayami Robe +1",
		-- waist="Rumination Sash"
	})

	-- If you ever lock your weapon, keep that in mind when building cure potency set.
	sets.midcast.Cure = {}

	sets.midcast.Cursna = set_combine(sets.precast.FC, {})
	
	-- Just a standard set for spells that have no set
	sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {})

	-- Strong alternatives: Daybreak and Ammurapi Shield, Cath Crown, Gwati Earring
	sets.midcast.Enfeeble = {}

	sets.midcast.Enhancing = {}

	sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {})

	sets.midcast.Nuke = {}

  sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {})
  sets.midcast["Aquaveil"] = set_combine(sets.midcast.Enhancing, {})
	sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeeble, {})
	sets.midcast["Mana Cede"] = { hands="Beckoner's Bracers +1" }
  sets.midcast["Astral Flow"] = { head="Glyphic Horn +3" }
	
	-- ===================================================================================================================
	--	Weaponskills
	-- ===================================================================================================================

	-- I stack magic accuracy here to land the defense down effect, rather than MAB for damage.
	-- It's a personal preference, use whatever you prefer.
	sets.midcast["Garland of Bliss"] = {
    -- head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','CHR+9','"Mag.Atk.Bns."+11',}},
    -- body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    -- hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+12 Pet: Rng. Acc.+12','Blood Pact Dmg.+9','Pet: INT+4','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+15',}},
    -- legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','"Occult Acumen"+8','Mag. Acc.+9','"Mag.Atk.Bns."+12',}},
    -- feet="Tali'ah Crackows +1",
    -- neck="Saevus Pendant +1",
    -- waist="Eschan Stone",
    -- left_ear="Friomisi Earring",
    -- right_ear="Novio Earring",
    -- left_ring="Karieyh Ring",
	}

	-- My set focuses on accuracy here to make skillchains with Ifrit
	-- Just like Garland, it's not hard to improve on the damage from this set if that's what you're after.
	sets.midcast["Shattersoul"] = {}

	sets.midcast["Cataclysm"] = sets.midcast.Nuke

	sets.pet_midcast = {}

	-- Main physical pact set (Volt Strike, Pred Claws, etc.)
	-- Prioritize BP Damage & Pet: Double Attack
	-- Strong Alternatives:
	-- Gridarvor, Apogee Crown, Apogee Pumps, Convoker's Doublet, Apogee Dalmatica, Shulmanu Collar, Gelos Earring, Regal Belt
	sets.pet_midcast.Physical_BP = {
		main="Grioavolr",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Apogee crown",
		body="Shomonjijoe +1",
		hands="Merlinic Dastanas",
		legs="Enticer's Pants",
		feet="Apogee pumps",
		neck="Shulmanu Collar",
		waist="Regal belt",
		ear1="Gelos earring",
		ear2="Lugalbanda earring",
		ring1="Varar ring +1",
		ring2="Varar ring +1",
		back="Campestres's Cape"
		
	-- 	ammo="Sancus Sachet +1",
    -- head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    -- body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    -- hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+12 Pet: Rng. Acc.+12','Blood Pact Dmg.+9','Pet: INT+4','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+15',}},
    -- legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},
    -- feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    -- neck={ name="Smn. Collar +1", augments={'Path: A',}},
    -- waist="Incarnation Sash",
    -- right_ear="Lugalbanda Earring",
    -- right_ear="Kyrene's Earring",
    -- left_ring="Varar Ring +1",
    -- right_ring="Varar Ring +1",
    -- back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Mag. Acc+20 /Mag. Dmg.+20','Pet: Attack+5 Pet: Rng.Atk.+5','"Fast Cast"+10',}},
	}

	-- Physical Pact AM3 set, less emphasis on Pet:DA
	sets.pet_midcast.Physical_BP_AM3 = set_combine(sets.pet_midcast.Physical_BP, {})

	-- Physical pacts which benefit more from TP than Pet:DA (like Spinning Dive and other pacts you never use except that one time)
	sets.pet_midcast.Physical_BP_TP = set_combine(sets.pet_midcast.Physical_BP, {})

	-- Used for all physical pacts when AccMode is true
	sets.pet_midcast.Physical_BP_Acc = set_combine(sets.pet_midcast.Physical_BP, {})

	-- Base magic pact set
	-- Prioritize BP Damage & Pet:MAB
	-- Strong Alternatives:
	-- Espiritus, Apogee Crown, Adad Amulet
	sets.pet_midcast.Magic_BP_Base = {
		main="Grioavolr",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Apogee crown",
		body="Shomonjijoe +1",
		hands="Merlinic Dastanas",
		legs="Enticer's Pants",
		feet="Apogee pumps",
		neck="Adad amulet",
		waist="Regal belt",
		ear1="Gelos earring",
		ear2="Lugalbanda earring",
		ring1="Varar ring +1",
		ring2="Varar ring +1",
		back="Campestres's Cape"
	}
	
	-- Some magic pacts benefit more from TP than others.
	-- Note: This set will only be used on merit pacts if you have less than 4 merits.
	--       Make sure to update your merit values at the top of this Lua.
	sets.pet_midcast.Magic_BP_TP = set_combine(sets.pet_midcast.Magic_BP_Base, {})

	-- NoTP set used when you don't need Enticer's
	sets.pet_midcast.Magic_BP_NoTP = set_combine(sets.pet_midcast.Magic_BP_Base, {})
	sets.pet_midcast.Magic_BP_TP_Acc = set_combine(sets.pet_midcast.Magic_BP_TP, {})
	sets.pet_midcast.Magic_BP_NoTP_Acc = set_combine(sets.pet_midcast.Magic_BP_NoTP, {})

	-- Favor BP Damage above all. Pet:MAB also very strong.
	-- Pet: Accuracy, Attack, Magic Accuracy moderately important.
	-- Strong Alternatives:
	-- Keraunos, Grioavolr, Espiritus, Was, Apogee Crown, Apogee Dalmatica, Adad Amulet
	sets.pet_midcast.FlamingCrush = set_combine(sets.pet_midcast.Magic_BP_Base, {
		body="Convoker's doublet +2",
		legs="Apogee Slacks",
	})

	sets.pet_midcast.FlamingCrush_Acc = set_combine(sets.pet_midcast.FlamingCrush, {})

	-- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
	sets.pet_midcast.MagicAcc_BP = {	}
	sets.pet_midcast.Debuff_Rage = sets.pet_midcast.MagicAcc_BP

	-- Pure summoning magic set, mainly used for buffs like Hastega II.
	-- Strong Alternatives:
	-- Andoaa Earring, Summoning Earring, Lamassu Mitts +1, Caller's Pendant
	sets.pet_midcast.SummoningMagic = {}
	sets.pet_midcast.Buff = sets.pet_midcast.SummoningMagic
	
	-- Wind's Blessing set. Pet:MND increases potency.
	sets.pet_midcast.Buff_MND = set_combine(sets.pet_midcast.Buff, {})

	-- Don't drop Avatar level in this set if you can help it.
	-- You can use Avatar:HP+ gear to increase the HP recovered, but most of it will decrease your own max HP.
	sets.pet_midcast.Buff_Healing = set_combine(sets.pet_midcast.Buff, {})

	-- This set is used for certain blood pacts when ImpactDebuff mode is turned ON. (/console gs c ImpactDebuff)
	-- These pacts are normally used with magic damage gear, but they're also strong debuffs when enhanced by summoning skill.
	-- This set is safe to ignore.
	sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {})

	sets.aftercast = {
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Loricate Torque +1",
		waist="Embla Sash",
		left_ear="Evans Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Moonbeam Cape",
	}

	-- Idle set with no avatar out.
	sets.aftercast.Idle = {
		head="Convoker's Horn +2",
		body="Shomonjijoe +1",
		hands="Asteria mitts +1",
		neck="Shulmanu Collar",
		ammo="Sancus Sachet +1",
		ear2="Lugalbanda earring",
		ear1="Evans earring",
		ring1="Varar ring +1",
		ring2="Stikini Ring +1",
		legs="Assiduity pants +1",
		feet="Apogee pumps",
		waist="Regal belt",
		back="Campestres's cape"
	}
	
	-- Idle set used when ForceIlvl is ON. Use this mode to avoid Gaiters dropping ilvl.
	sets.aftercast.Idle_Ilvl = set_combine(sets.aftercast.Idle, {})
	sets.aftercast.DT = sets.DT_Base

	-- Main refresh set - Many idle sets inherit from this set.
	-- Put common items here so you don't have to repeat them over and over.
	-- Strong Alternatives:
	-- Gridarvor, Asteria Mitts, Shomonjijoe, Beckoner's Horn, Evans Earring, Isa Belt
	sets.aftercast.Perp_Base = {
		head="Convoker's Horn +2",
		body="Shomonjijoe +1",
		hands="Asteria mitts +1",
		neck="Shulmanu Collar",
		ammo="Sancus Sachet +1",
		ear2="Lugalbanda earring",
		ear1="Evans earring",
		ring1="Varar ring +1",
		ring2="Varar ring +1",
		legs="Assiduity pants +1",
		feet="Apogee pumps",
		waist="Regal belt",
		back="Campestres's cape"
	}

	-- Avatar Melee set. Equipped when IdleMode is "DD" and MeleeMode is OFF.
	-- You really don't need this set. It's only here because I can't bring myself to throw it away.
	sets.aftercast.Perp_DD = set_combine(sets.aftercast.Perp_Base, {})

	-- Refresh set with avatar out. Equipped when IdleMode is "Refresh".
	sets.aftercast.Perp_Refresh = set_combine(sets.aftercast.Perp_Base, {
		-- ring1="Evoker's ring",
		-- ring2="Stikini Ring +1"
	})

	-- Refresh set when MP is under 50%
	-- If you have Fucho and don't need Lucidity Sash for perp down, you can uncomment the belt here to enable using it.
	sets.aftercast.Perp_RefreshSub50 = set_combine(sets.aftercast.Perp_Refresh, {})
	
	-- Used when IdleMode is "Favor" to maximize avatar's favor effect.
	-- Skill tiers are 512 / 575 / 670
	sets.aftercast.Perp_Favor = set_combine(sets.aftercast.Perp_Refresh, {
		hands="Baayami Cuffs",
		neck="Incanter's Torque",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+5',}},
	})
	sets.aftercast.Perp_Zendik = set_combine(sets.aftercast.Perp_Favor, {})

	-- TP set. Equipped when IdleMode is "DD" and MeleeMode is ON.
	sets.aftercast.Perp_Melee = set_combine(sets.aftercast.Perp_Refresh, {})

	-- Pet:DT build. Equipped when IdleMode is "PetDT". Note: Avatars only need -31 PDT to cap, MDT is the hard one to cap.
	-- Strong alternatives:
	-- Selenian Cap, Enmerkar Earring, Handler's Earring, Rimeice Earring, Thurandaut Ring, Tali'ah Seraweels
	sets.aftercast.Avatar_DT = {}

	-- Perp down set used when ForceIlvl is ON. If you use Selenian Cap for Pet:DT, you can make another set here without it.
	sets.aftercast.Avatar_DT_Ilvl = set_combine(sets.aftercast.Avatar_DT, {})

	-- DT build with avatar out. Equipped when IdleMode is "DT".
	sets.aftercast.Perp_DT = set_combine(sets.DT_Base, {})

	-- Idle set used when you have a spirit summoned. Glyphic Spats will make them cast more frequently.
	sets.aftercast.Spirit = {	}

	-- ===================================================================================================================
	--		End of Sets
	-- ===================================================================================================================

	Buff_BPs_Duration = S{'Shining Ruby','Aerial Armor','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Glittering Ruby','Earthen Ward','Hastega','Noctoshield','Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Heavenward Howl','Hastega II','Soothing Current','Crystal Blessing','Katabatic Blades'}
	Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
	Buff_BPs_MND = S{"Wind's Blessing"}
	Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall','Bitter Elegy','Lunatic Voice'}
	Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}

	Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark','Tornado II','Sonic Buffet'}
	Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
	Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
	Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive','Roundhouse'}
	
	ZodiacElements = S{'Fire','Earth','Water','Wind','Ice','Lightning'}

	--TownIdle = S{"windurst woods","windurst waters","windurst walls","port windurst","bastok markets","bastok mines","port bastok","southern san d'oria","northern san d'oria","port san d'oria","upper jeuno","lower jeuno","port jeuno","ru'lude gardens","norg","kazham","tavnazian safehold","rabao","selbina","mhaura","aht urhgan whitegate","al zahbi","nashmau","western adoulin","eastern adoulin"}
	--Salvage = S{"Bhaflau Remnants","Zhayolm Remnants","Arrapago Remnants","Silver Sea Remnants"}


	send_command('input /macro book 1;wait .1;input /macro set 2;wait 3;input /lockstyleset '..StartLockStyle)
	-- End macro set / lockstyle section
end

-- ===================================================================================================================
--		Gearswap rules below this point - Modify at your own peril
-- ===================================================================================================================

function pretarget(spell,action)
	if not buffactive['Muddle'] then
		-- Auto Remedy --
		if AutoRemedy and (spell.action_type == 'Magic' or spell.type == 'JobAbility') then
			if buffactive['Paralysis'] or (buffactive['Silence'] and not AutoEcho) then
				cancel_spell()
				send_command('input /item "Remedy" <me>')
			end
		end
		-- Auto Echo Drop --
		if AutoEcho and spell.action_type == 'Magic' and buffactive['Silence'] then
			cancel_spell()
			send_command('input /item "Echo Drops" <me>')
		end
	end
end

function precast(spell)
    if (pet.isvalid and pet_midaction() and not spell.type=="SummonerPact") or spell.type=="Item" then
		-- Do not swap if pet is mid-action. I added the type=SummonerPact check because sometimes when the avatar
		-- dies mid-BP, pet.isvalid and pet_midaction() continue to return true for a brief time.
		return
	end
	-- Spell fast cast
	if sets.precast[spell.english] then
        equip(sets.precast[spell.english])
    elseif spell.action_type=="Magic" then
		if spell.name=="Stoneskin" then
			equip(sets.precast.FC,{waist="Siegel Sash"})
		else
			equip(sets.precast.FC)
		end
    end
end

function midcast(spell)
    if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
        return
    end
	-- BP length gear needs to swap here
	if (spell.type=="BloodPactWard") then
		if not buffactive["Astral Conduit"] then
			equip(sets.precast.BPWard)
		end
		-- If lag compensation mode is on, set up a timer to equip the BP gear.
		if LagMode then
			send_command('wait 0.5;gs c EquipBP '..spell.name)
		end
	-- BP Timer gear needs to swap here
	elseif (spell.type=="BloodPactRage") then
		if not buffactive["Astral Conduit"] then
			equip(sets.precast.BPRage)
		end
		-- If lag compensation mode is on, set up a timer to equip the BP gear.
		if LagMode then
			send_command('wait 0.5;gs c EquipBP '..spell.name)
		end
	-- Spell Midcast & Potency Stuff
    elseif sets.midcast[spell.english] then
        equip(sets.midcast[spell.english])
	elseif spell.name=="Elemental Siphon" then
		if pet.element==world.day_element and ZodiacElements:contains(pet.element) then
			if pet.element==world.weather_element then
				equip(sets.midcast.SiphonWeatherZodiac)
			else
				equip(sets.midcast.SiphonZodiac)
			end
		else
			if pet.element==world.weather_element then
				equip(sets.midcast.SiphonWeather)
			else
				equip(sets.midcast.Siphon)
			end
		end
	elseif spell.type=="SummonerPact" then
		equip(sets.midcast.Summon)
	elseif string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
		equip(sets.midcast.Cure)
	elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
		equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
	elseif spell.skill=="Enfeebling Magic" then
		equip(sets.midcast.Enfeeble)
	elseif spell.skill=="Enhancing Magic" then
		equip(sets.midcast.Enhancing)
	elseif spell.skill=="Elemental Magic" then
		equip(sets.midcast.Nuke)
	elseif spell.action_type=="Magic" then
		equip(sets.midcast.EnmityRecast)
    else
        idle()
    end
	-- Treasure Hunter
	if THSpells:contains(spell.name) then
		equip(sets.TH)
	end
	-- Auto-cancel existing buffs
	if spell.name=="Stoneskin" and buffactive["Stoneskin"] then
		windower.send_command('cancel 37;')
	elseif spell.name=="Sneak" and buffactive["Sneak"] and spell.target.type=="SELF" then
		windower.send_command('cancel 71;')
	elseif spell.name=="Utsusemi: Ichi" and buffactive["Copy Image"] then
		windower.send_command('wait 1;cancel 66;')
	end
end

function aftercast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
	if not string.find(spell.type,"BloodPact") then
        idle()
    end
end

function pet_change(pet,gain)
	if (not (gain and pet_midaction())) then
		idle()
	end
end

function status_change(new,old)
	if new=="Idle" then
        idle()
	end
end

function buff_change(name,gain)
    if name=="quickening" then
        idle()
    end
	if SacTorque and name=="sleep" and gain and pet.isvalid then
		equip({neck="Sacrifice Torque"})
		disable("neck")
		if buffactive["Stoneskin"] then
			windower.send_command('cancel 37;')
		end
	end
	if name=="sleep" and not gain then
		enable("neck")
	end
end

function pet_midcast(spell)
	if not LagMode then
		equipBPGear(spell.name)
	end
end

function pet_aftercast(spell)
    idle()
end

function equipBPGear(spell)
    if spell=="Perfect Defense" then
        equip(sets.pet_midcast.SummoningMagic)
	elseif Debuff_BPs:contains(spell) then
		equip(sets.pet_midcast.MagicAcc_BP)
	elseif Buff_BPs_Healing:contains(spell) then
		equip(sets.pet_midcast.Buff_Healing)
	elseif Buff_BPs_Duration:contains(spell) then
		equip(sets.pet_midcast.Buff)
	elseif Buff_BPs_MND:contains(spell) then
		equip(sets.pet_midcast.Buff_MND)
	elseif spell=="Flaming Crush" then
		if AccMode then
			equip(sets.pet_midcast.FlamingCrush_Acc)
		else
			equip(sets.pet_midcast.FlamingCrush)
		end
	elseif ImpactDebuff and (spell=="Impact" or spell=="Conflag Strike") then
		equip(sets.pet_midcast.Impact)
	elseif Magic_BPs_NoTP:contains(spell) then
		if AccMode then
			equip(sets.pet_midcast.Magic_BP_NoTP_Acc)
		else
			equip(sets.pet_midcast.Magic_BP_NoTP)
		end
	elseif Magic_BPs_TP:contains(spell) or string.find(spell," II") or string.find(spell," IV") then
		if AccMode then
			equip(sets.pet_midcast.Magic_BP_TP_Acc)
		else
			equip(sets.pet_midcast.Magic_BP_TP)
		end
	elseif Merit_BPs:contains(spell) then
		if AccMode then
			equip(sets.pet_midcast.Magic_BP_TP_Acc)
		elseif spell=="Meteor Strike" and MeteorStrike>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Geocrush" and Geocrush>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Grand Fall" and GrandFall>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Wind Blade" and WindBlade>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Heavenly Strike" and HeavenlyStrike>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		elseif spell=="Thunderstorm" and Thunderstorm>4 then
			equip(sets.pet_midcast.Magic_BP_NoTP)
		else
			equip(sets.pet_midcast.Magic_BP_TP)
		end
	elseif Debuff_Rage_BPs:contains(spell) then
		equip(sets.pet_midcast.Debuff_Rage)
	else
		if AccMode then
			equip(sets.pet_midcast.Physical_BP_Acc)
		elseif Physical_BPs_TP:contains(spell) then
			equip(sets.pet_midcast.Physical_BP_TP)
		elseif buffactive["Aftermath: Lv.3"] then
			equip(sets.pet_midcast.Physical_BP_AM3)
		else
			equip(sets.pet_midcast.Physical_BP)
		end
	end
end

-- This command is called whenever you input "gs c <command>"
function self_command(command)
	IdleModeCommands = {'DD','Refresh','DT','Favor','PetDT','Zendik'}
	is_valid = command:lower()=="idle"
	
	for _, v in ipairs(IdleModeCommands) do
		if command:lower()==v:lower() then
			IdleMode = v
			send_command('console_echo "Idle Mode: ['..IdleMode..']"')
			idle()
			return
		end
	end
	if string.sub(command,1,7)=="EquipBP" then
		equipBPGear(string.sub(command,9,string.len(command)))
		return
	elseif command:lower()=="accmode" then
		AccMode = AccMode==false
		is_valid = true
		send_command('console_echo "AccMode: '..tostring(AccMode)..'"')
	elseif command:lower()=="impactmode" then
		ImpactDebuff = ImpactDebuff==false
		is_valid = true
		send_command('console_echo "Impact Debuff: '..tostring(ImpactDebuff)..'"')
    elseif command:lower()=="forceilvl" then
        ForceIlvl = ForceIlvl==false
        is_valid = true
        send_command('console_echo "Force iLVL: '..tostring(ForceIlvl)..'"')
	elseif command:lower()=="lagmode" then
		LagMode = LagMode==false
		is_valid = true
		send_command('console_echo "Lag Compensation Mode: '..tostring(LagMode)..'"')
	elseif command:lower()=="th" then
		TreasureHunter = TreasureHunter==false
		is_valid = true
		send_command('console_echo "Treasure Hunter Mode: '..tostring(TreasureHunter)..'"')
	elseif command:lower()=="meleemode" then
		if MeleeMode then
			MeleeMode = false
			enable("main","sub")
			send_command('console_echo "Melee Mode: false"')
		else
			MeleeMode = true
			equip({main="Nirvana",sub="Elan Strap +1"})
			disable("main","sub")
			send_command('console_echo "Melee Mode: true"')
		end
		is_valid = true
	elseif command=="ToggleIdle" then
		is_valid = true
		-- If you want to change the sets cycled with F9, this is where you do it
		if IdleMode=="Refresh" then
			IdleMode = "DT"
		elseif IdleMode=="DT" then
			IdleMode = "PetDT"
		elseif IdleMode=="PetDT" then
			IdleMode = "DD"
		else
			IdleMode = "Refresh"
		end
		send_command('console_echo "Idle Mode: ['..IdleMode..']"')
	elseif command:lower()=="lowhp" then
		-- Use for "Cure 500 HP" objectives in Omen
		equip({head="Apogee Crown +1",body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},legs="Apogee Slacks +1",feet="Apogee Pumps +1",back="Campestres's Cape"})
		return
	elseif string.sub(command:lower(),1,12)=="meteorstrike" then
		MeteorStrike = string.sub(command,13,13)
		send_command('console_echo "Meteor Strike: '..MeteorStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,8)=="geocrush" then
		Geocrush = string.sub(command,9,9)
		send_command('console_echo "Geocrush: '..Geocrush..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="grandfall" then
		GrandFall = string.sub(command,10,10)
		send_command('console_echo "Grand Fall: '..GrandFall..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="windblade" then
		WindBlade = +string.sub(command,10,10)
		send_command('console_echo "Wind Blade: '..WindBlade..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,14)=="heavenlystrike" then
		HeavenlyStrike = string.sub(command,15,15)
		send_command('console_echo "Heavenly Strike: '..HeavenlyStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,12)=="thunderstorm" then
		Thunderstorm = string.sub(command,13,13)
		send_command('console_echo "Thunderstorm: '..Thunderstorm..'/5"')
		is_valid = true
	end

	if is_valid then
		if not midaction() and not pet_midaction() then
			idle()
		end
	else
		sanitized = command:gsub("\"", "")
		send_command('console_echo "Invalid self_command: '..sanitized..'"')
	end
end

-- This function is for returning to aftercast gear after an action/event.
function idle()
	--if TownIdle:contains(world.area:lower()) then
	--	return
	--end
    if pet.isvalid then
		if IdleMode=='DT' then
			equip(sets.aftercast.Perp_DT)
		elseif string.find(pet.name,'Spirit') then
            equip(sets.aftercast.Spirit)
		elseif IdleMode=='PetDT' then
			if ForceIlvl then
				equip(sets.aftercast.Avatar_DT_Ilvl)
			else
				equip(sets.aftercast.Avatar_DT)
			end
        elseif IdleMode=='Refresh' then
			if player.mpp < 50 then
				equip(sets.aftercast.Perp_RefreshSub50)
			else
				equip(sets.aftercast.Perp_Refresh)
			end
		elseif IdleMode=='Favor' then
			equip(sets.aftercast.Perp_Favor)
		elseif IdleMode=='Zendik' then
			equip(sets.aftercast.Perp_Zendik)
		elseif MeleeMode then
			equip(sets.aftercast.Perp_Melee)
        elseif IdleMode=='DD' then
            equip(sets.aftercast.Perp_DD)
        end
		-- Gaiters if Fleet Wind is up
		if buffactive['Quickening'] and IdleMode~='DT' and not ForceIlvl then
			equip({feet="Herald's Gaiters"})
		end
	else
		if IdleMode=='DT' then
			equip(sets.aftercast.DT)
		elseif MeleeMode and IdleMode=='DD' then
			equip(sets.aftercast.Perp_Melee)
		elseif ForceIlvl then
			equip(sets.aftercast.Idle_Ilvl)
		else
			equip(sets.aftercast.Idle)
		end
    end
	-- Balrahn's Ring
	--if Salvage:contains(world.area) then
	--	equip({ring2="Balrahn's Ring"})
	--end
	-- Maquette Ring
	--if world.area=='Maquette Abdhaljs-Legion' and not IdleMode=='DT' then
	--	equip({ring2="Maquette Ring"})
	--end
end