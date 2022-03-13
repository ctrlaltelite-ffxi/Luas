--  Welcome to Logical's Ninja Lua.  This Lua is used for changing gear during precast and midcast and then swapping to the appropriate set for aftercast.
--  It will also cancel shadows for you when necessary to recast new shadows.
--  Please refer to my video on my NextGames YouTube channel for how to properly utilize this LUA.  

-- This is what sets the initial set that you normally want to be in by default.
tp_mode = 'Normal'
mb_mode = 'mbnin'

function get_sets()
  mote_include_version = 2
  include('Mote-Include.lua')
  res = require 'resources'
  include('organizer-lib')
end

function user_setup()
  select_default_macro_book()
  set_lockstyle()
end
	
function self_command(command)
	 local args = split_args(command)
		if args[1] == 'tp' then
		tp_mode = args[2]
	 elseif args[1] == 'mb' then
		mb_mode = args[2]
	 end
end
 
function split_args(args)
		fields = {}
		args:gsub("([^ ]*) ?", function(c)
		table.insert(fields, c)
	end)
	return fields
end

function get_sets()

	sets.W = {} --Weapon Sets
	sets.W.MAIN = {
    main={ name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+8','"Fast Cast"+5',}},
    sub={ name="Malevolence", augments={'INT+3','Mag. Acc.+5','"Mag.Atk.Bns."+7',}},
  }
	sets.W.P_Dagger = {main="Bronze Dagger", sub="Warp Cudgel",}
  sets.W.P_Club = {main="Warp Cudgel", sub="empty",}
  sets.W.P_Sword = {main="Bronze Sword", sub="Warp Cudgel",}
  sets.W.P_Staff = {main="Earth Staff"}
  sets.W.P_GreatKatana = {main="Zanmato"}
  sets.W.P_Scythe = {main="Ark Scythe"}
	sets.W.P_Polearm = {main="Pitchfork"}
	sets.W.P_GreatSword = {main="Lament"}

  sets.Idle = {
    ammo="Aurgelmir Orb",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Ken. Tekko",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck="Moonlight Nodowa",
    waist="Windbuffet Belt +1",
    left_ear="Brutal Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Gelatinous Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }

	sets.precast = {}
	sets.precast.fc = {
		head={ name="Herculean Helm", augments={'Accuracy+28','Weapon skill damage +4%','STR+8','Attack+2',}},
    body={ name="Taeon Tabard", augments={'"Fast Cast"+5',}},
    legs={ name="Taeon Tights", augments={'Accuracy+8','"Fast Cast"+4','Crit. hit damage +2%',}},
    left_ring="Prolix Ring"
  }
  
	sets.precast.utsusemi = set_combine(sets.precast.fc, {
    neck="Magoraga Beads",
    feet="Hattori Kyahan",
  })
	
	-- This is where we will define our midcast sets.  These are sets of gear that get equipped BEFORE the spell or ability lands.
	sets.midcast = {}
	sets.midcast.enmity = {
		body="Emet Harness +1",
    neck="Unmoving Collar",
    -- waist="Warwolf Belt",
    right_ring="Provocare Ring",
    back="Cerb. Mantle +1",
	}

	sets.midcast.elenin = {}
	sets.midcast.mbnin = {}
	sets.midcast.enfnin = {}
	sets.midcast.waltz = {}

	sets.midcast.bladehi = {
    ammo="Yetshila",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Ken. Tekko",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Flame Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Ishvara Earring",
    left_ring="Karieyh Ring",
    right_ring="Defending Ring",
    -- back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
  }
	sets.midcast.blademetsu = {}
	sets.midcast.bladeshun = {}
	sets.midcast.bladeten = {}
	sets.midcast.bladechi = {}
	sets.midcast.bladekamu = {}
	sets.midcast.bladeretsu = {}
	sets.midcast.bladeto = {}
	sets.midcast["Aeolian Edge"] = {
		ammo="Knobkierrie",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Anrin Obi",
		left_ear="Novio Earring",
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		right_ring="Karieyh Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
	}

	-- This is where we will define our aftercast sets.  These are sets of gear that get equipped AFTER the spell or ability is used.  Normally this is used to put you back into your current TP set.
	sets.aftercast = {}
	sets.aftercast.Normal = {
    ammo="Aurgelmir Orb",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Ken. Tekko",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck="Moonlight Nodowa",
    waist="Windbuffet Belt +1",
    left_ear="Brutal Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Gelatinous Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }
	sets.aftercast.dw40 = {}
	sets.aftercast.dw20 = {}
	sets.aftercast.dw0 = {}
	sets.aftercast.accuracy = {}
	sets.aftercast.evasion = {}
	sets.aftercast.magicdef = {}
	sets.aftercast.magiceva = {}
end

-----------------------------------------------------------------------------------
-- This is the precast section.  It is used to tell the game you should be wearing BEFORE you take an action..
function precast(spell, act)

	if spell.english:startswith('Utsusemi') then
		equip(sets.precast.utsusemi)
	end

	if spell.english:startswith('Monomi') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Tonko') then
		equip (sets.precast.fc)
	end
	
	if spell.english:startswith('Gekka') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Yain') then
		equip (sets.precast.fc)
	end
	
	if spell.english:startswith('Kakka') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Myoshu') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Migawari') then
		equip (sets.precast.fc)
	end
	
	if spell.english:startswith('Yurin') then
		equip (sets.precast.fc)
	end
	
	if spell.english:startswith('Dokumori') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Aisha') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Kurayami') then
		equip (sets.precast.fc)
	end
	
	if spell.english:startswith('Hojo') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Jubaku') then
		equip (sets.precast.fc)
	end

	if spell.english:startswith('Katon') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Hyoton') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Huton') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Doton') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Raiton') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Suiton') then
		equip(sets.precast.fc)
	end
	
	if spell.type == "Trust" then
		equip(sets.precast.fc)
	end
	
end

-----------------------------------------------------------------------------------
  -- This is the midcast section.  It is used to designate gear that you want on as the ability or spell is used.
function midcast(spell, act)

	-- The below command is used to cancel old shadows if they can not be overwritten by the newly cased Utsusemi.
	-- if spell.english == "Utsusemi: Ichi" then
	-- 	if buffactive['Copy Image'] then
	-- 		send_command('cancel 66')
	-- 	elseif buffactive['Copy Image (2)'] then 
	-- 		send_command('cancel 444')
	-- 	elseif buffactive['Copy Image (3)'] then
	-- 		send_command('cancel 445')
	-- 	elseif buffactive['Copy Image (4+)'] then
	-- 		send_command('cancel 446')
	-- 	end
  -- end
  
  if spell.english:startswith('Utsusemi') and buffactive['Yonin'] then
		equip (sets.midcast.enmity)
	end

	if spell.english == "Provoke" then
		equip (sets.midcast.enmity)
	end

	if spell.english == "Warcry" then
		equip (sets.midcast.enmity)
	end

	if spell.english == "Animated Flourish" then
		equip (sets.midcast.enmity)
	end

	if spell.english == "Violent Flourish" then
		equip (sets.midcast.enfnin)
	end

	if spell.english:startswith('Curing') then
		equip (sets.midcast.waltz)
	end

	if spell.english == "Divine Waltz" then
		equip (sets.midcast.waltz)
	end
	
	if spell.english:startswith('Migawari') then
		equip (sets.midcast.migawari)
	end
	
	if spell.english:startswith('Kurayami') then
		equip (sets.midcast.enfnin)
	end

	if spell.english:startswith('Hojo') then
		equip (sets.midcast.enfnin)
	end

	if spell.english:startswith('Jubaku') then
		equip (sets.midcast.enfnin)
	end

	if spell.english:startswith('Katon') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Hyoton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Huton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Doton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Raiton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Suiton')then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end
	
	if spell.english == "Blade: Hi" then
		equip (sets.midcast.bladehi)
	end

	if spell.english == "Blade: Metsu" then
		equip (sets.midcast.blademetsu)
	end

	if spell.english == "Blade: Shun" then
		equip (sets.midcast.bladeshun)
	end

	if spell.english == "Blade: Ten" then
		equip (sets.midcast.bladeten)
	end
	
	if spell.english == "Blade: Chi" then
		equip (sets.midcast.bladechi)
	end
	
	if spell.english == "Blade: To" then
		equip (sets.midcast.bladechi)
	end
	
	if spell.english == "Blade: Kamu" then
		equip (sets.midcast.bladechi)
	end

	if spell.english == "Aeolian Edge" then
		equip (sets.midcast["Aeolian Edge"])
	end

	if spell.english == "Blade: Retsu" then
		equip (sets.midcast.bladeten)
	end

	if spell.type == "Trust" then
		equip(sets.precast.fc)
	end
end

-----------------------------------------------------------------------------------

	-- This section is the aftercast section that makes it so that after any of the above abilities you get put back into the correct gearset.  It should not be modified.
function aftercast(spell, act, spellMap, eventArgs)
  set = sets.aftercast
  
	if player.status == 'Engaged' then
    set = set[tp_mode]
    equip(set)
  else
    equip(sets.Idle)
	end
	
end

function status_change(new,old)
  if T{'Idle','Resting'}:contains(new) then
      equip(sets.Idle)
  elseif new == 'Engaged' then
      equip(sets.aftercast[tp_mode])
      
  end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  if player.sub_job == 'BLU' then
    set_macro_page(2, 12)
  elseif player.sub_job == 'DRK' then
    set_macro_page(3, 12)
  elseif player.sub_job == 'WHM' then
    set_macro_page(4, 12)
  else
    set_macro_page(1, 3)
  end
end

function set_lockstyle()
  send_command('wait 2; input /lockstyleset 5')
end

function sub_job_change(new,old)
  set_lockstyle()
end

function self_command(command)
  local cType
  cType = string.sub(command,1,2)
  if cType == 'we' then
    equip_weapon(command)
  elseif command == 'DT' then
    equip(sets.DT)
  elseif command == 'TP' then
    if TP_mode=="Acc" then
      TP_mode="Normal"
    elseif TP_mode=="Normal" then
       TP_mode="DT"
    elseif TP_mode=="DT" then
       TP_mode='Acc'
    end
    windower.add_to_chat('TP mode is now: '..TP_mode)
    equip(sets.TP[TP_mode])
  end
end

function equip_weapon(cmd)
  if cmd == 'weMain' then
    equip(sets.W.MAIN)
    windower.add_to_chat('Main Katana')
  elseif cmd == 'wepclub' then
    equip(sets.W.P_Club)
    windower.add_to_chat('Proc Club')
  elseif cmd == 'wepdagger' then
    equip(sets.W.P_Dagger)
    windower.add_to_chat('Proc Dagger')
  elseif cmd == 'wepsword' then
    equip(sets.W.P_Sword)
    windower.add_to_chat('Proc Sword')
  elseif cmd == 'wepstaff' then
    equip(sets.W.P_Staff)
    windower.add_to_chat('Proc Staff')
  elseif cmd == 'wepgk' then
    equip(sets.W.P_GreatKatana)
    windower.add_to_chat('Proc Great Katana')
  elseif cmd == 'weppole' then
    equip(sets.W.P_Polearm)
    windower.add_to_chat('Proc Polearm')
  elseif cmd == 'wepscythe' then
    equip(sets.W.P_Scythe)
    windower.add_to_chat('Proc Scythe')
  elseif cmd == 'wepgsword' then
    equip(sets.W.P_GreatSword)
    windower.add_to_chat('Proc Great Sword')
  end
  
end