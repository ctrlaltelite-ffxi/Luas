function get_sets()

	----------------------------------------------------------------------
	-- Bind the keys you wish to use with GearSwap
	----------------------------------------------------------------------
	send_command('bind f9 gs c toggle idle set')

	mode = 'Normal'
	
	----------------------------------------------------------------------
	-- Idle sets
	----------------------------------------------------------------------
	sets.idle = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Genbu's Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body="Jhakri Robe +2",
		hands="Geomancy Mitaines +1",
		legs="Assid. Pants +1",
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		neck="Loricate Torque +1",
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring="Fortified ring",
		right_ring="Defending ring",
		back="Lifestream Cape",
	} -- end Idle


	----------------------------------------------------------------------
	-- Melee sets
	----------------------------------------------------------------------
	sets.melee = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Genbu's Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +2",
		neck="Lissome Necklace",
		waist="Eschan Stone",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring="Petrov Ring",
		right_ring="Defending ring",
		back="Lifestream Cape",
	} -- end Melee


	----------------------------------------------------------------------
	-- Precast sets
	----------------------------------------------------------------------
	-- Initialize an array to begin storing set data
	sets.precast = {}

	-- Precast : Fastcast
	-- Fast Cast: 80%
	sets.precast.fastCast = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Genbu's Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+5','Magic burst dmg.+5%','CHR+10','Mag. Acc.+10',}},
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Geomancy Pants",
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+26','Magic burst dmg.+6%',}},
		neck="Loricate Torque +1",
		waist="Othila Sash",
		left_ear="Malignance Earring",
		right_ear="Etiolation Earring",
		left_ring="Jhakri Ring",
		right_ring="Kishar Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +7','Indi. eff. dur. +14',}},
	} -- end Fast Cast


	----------------------------------------------------------------------
	-- Midcast sets
	----------------------------------------------------------------------
	-- Initialize an array to begin storing set data
	sets.midcast = {}

	-- Magic : Default
	sets.midcast.magic = {}
	sets.midcast.magic.default = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Ammurapi Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +2",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Jhakri Ring",
		right_ring="Kishar Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +7','Indi. eff. dur. +14',}},
	} -- end Magic

	-- Magic : Cure Potency
	sets.midcast.magic.curePotency = {
		--main="Daybreak",
		sub="Sors Shield",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		--body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		--hands={ name="Vanya Cuffs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		--legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		--feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		neck="Nodens Gorget",
		waist="Othila Sash",
		--left_ear="Lifestorm Earring",
		--right_ear="Handler's Earring +1",
		--left_ring="Mephitas's Ring",
		--right_ring="Mephitas's Ring +1",
		--back="Swith Cape",
	} -- end Cure Potency

	-- Magic Burst
	sets.midcast.magic.magicBurst = {
		main="Malignance Pole",
    sub="Enki Strap",
	} 




	----------------------------------------------------------------------
	-- Utility Sets (not bound to a key)
	----------------------------------------------------------------------
	-- Initialize an array to begin storing set data
	sets.utility = {}

	-- Dark magic
	sets.utility.darkMagic = {}

	-- Geomancer magic skill
	sets.utility.geoSkill = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
		hands="Geomancy Mitaines +1",
		legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
		feet="Azimuth Gaiters",
		neck="Reti Pendant",
		left_ear="Gna Earring",
		back="Lifestream Cape",
	} -- end Geomancy Skill


	----------------------------------------------------------------------
	-- Job Ability Sets (not bound to a key)
	----------------------------------------------------------------------
	-- Initialize an array to begin storing set data
	sets.jobAbility = {}

	-- Bolster set
	sets.jobAbility.bolster = {
        body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
	} -- end sets.jobAbility.bolster

	-- Full circle set
	sets.jobAbility.fullCircle = {
        head="Azimuth Hood +1",
	} -- end sets.jobAbility.fullCircle

	-- Life cycle set
	sets.jobAbility.lifeCycle = {
	    body="Geomancy Tunic",
        --back={ name="Nantosuelta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	} -- end sets.jobAbility.lifeCycle

	-- Mending halation set
	sets.jobAbility.mendingHalation = {
        legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
	} -- end sets.jobAbility.mendingHalation

	-- Radial arcana set
	sets.jobAbility.radialArcana = {
	    feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
	} -- end sets.jobAbility.radialArcana


	----------------------------------------------------------------------
	-- Spell arrays
	----------------------------------------------------------------------
	CureSpells = {
		["Cure"] = true,
		["Cure II"] = true,
		["Cure III"] = true,
		["Cure IV"] = true,
	}

	DarkSpells = {
		["Aspir"] = true,
		["Aspir II"] = true,
		["Aspir III"] = true,
		["Drain"] = true,
	}

end -- end get_sets()


----------------------------------------------------------------------
-- Callback for when casting begins
----------------------------------------------------------------------
function precast(spell)
    if spell.action_type == 'Magic' then
		equip(sets.precast.fastCast)
	end
end -- end precast()


----------------------------------------------------------------------
-- Callback for after casting begins, but before it fires
----------------------------------------------------------------------
function midcast(spell)

	-- Check if the action is magic
	if spell.action_type == 'Magic' then

		-- Check if the spell is a geo spell
		if spell.skill == 'Geomancy' or spell.skill == 'Handbell' then
			equip(set_combine(sets.midcast.magic.default, sets.utility.geoSkill))
		-- Check if the spell is a cure
    	elseif CureSpells[spell.english] then
			equip(set_combine(sets.midcast.magic.default, sets.midcast.magic.curePotency))
		-- Check if the spell is dark magic
		elseif DarkSpells[spell.english] then
			equip(set_combine(sets.midcast.magic.default, sets.utility.darkMagic))
		-- For all other spells that do not meet the above conditions
		elseif mode == 'MB' then
			equip(sets.midcast.magic.magicBurst)
		else
			equip(sets.midcast.magic.default)
		end

	-- Check if the action is a job ability
	elseif spell.type == 'JobAbility' then

		if spell.name == 'Bolster' then
			equip(sets.jobAbility.bolster)
		elseif spell.name == 'Full Circle' then
			equip(sets.jobAbility.fullCircle)
		elseif spell.name == 'Life Cycle' then
			equip(sets.jobAbility.lifeCycle)
		elseif spell.name == 'Mending Halation' then
			equip(sets.jobAbility.mendingHalation)
		elseif spell.name == 'Radial Arcana' then
			equip(sets.jobAbility.radialArcana)
		end

	end
end -- end midcast()


----------------------------------------------------------------------
-- Callback for after casting has fired
----------------------------------------------------------------------
function aftercast(spell)
	-- Check if the player is still engaged after the cast
	if player.status =='Engaged' then
		equip(sets.melee)
	-- Check if the player is not still engaged after the cast
	else
		equip(sets.idle)
	end
end -- end aftercast()


----------------------------------------------------------------------
-- Callback for whenever engagment status changes
----------------------------------------------------------------------
function status_change(newStatus, oldStatus)
	-- Check if player status has switched to engaged
	if newStatus == 'Engaged' then
		equip(sets.melee)
	-- Check if player status has switched to idle
	else
		equip(sets.idle)
	end
end -- end status_change()


----------------------------------------------------------------------
-- In game alerts to gear set changes
----------------------------------------------------------------------
function self_command(command)

	-- Equip the idle set
	if command == 'toggle idle set' then
		-- Alert the user which set is currently being equipped
		send_command('@input /echo <----- Idle: Default Set Equipped ----->')
		-- Equip the set
		equip(sets.idle)
	elseif command == 'toggle MB Mode' then
		if mode == 'Normal' then
			mode = 'MB'
		else
			mode = 'Normal'
		end
		send_command('@input /echo Current Mode is '..mode)
	end -- end if

end -- end self_command()

----------------------------------------------------------------------
-- Callback function for when the lua is unloaded
----------------------------------------------------------------------
function file_unload()

	-- Upon unloading this lua file, remove commonly used key binds
    send_command('unbind f9')

end    