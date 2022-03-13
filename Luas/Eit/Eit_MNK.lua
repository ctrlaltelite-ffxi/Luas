
TP_mode = 'Normal'
--Normal, DT, MidAcc, MaxAcc

-- function get_sets()
--   mote_include_version = 2
--   include('Mote-Include.lua')
--   res = require 'resources'
-- end

function user_setup()
  select_default_macro_book()
  set_lockstyle()
  

  -- send_command('bind f9 gs c tp Normal')
  -- send_command('bind f10 gs c tp DT')
  -- send_command('bind f11 gs c tp MEVA')
  -- send_command('bind f12 gs c tp MaxAcc')
end
	
function get_sets()
  include('organizer-lib')

  send_command('bind f9 gs c tp Normal')
  send_command('bind f10 gs c tp DT')
  send_command('bind f11 gs c tp MEVA')
  send_command('bind f12 gs c tp MaxAcc')

  sets.Idle = {}
  sets.JA = {}
  sets.JA["Chi Blast"] = {head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},}
  sets.JA.Boost = {waist="Ask Sash"}
  sets.TP = {}
  sets.TP.Normal = {
    ammo="Aurgelmir Orb",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    -- legs="Ken. Hakama +1",
    legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
    feet="Anch. Gaiters +3",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
  }
  sets.TP.DT = {
    ammo="Aurgelmir Orb",
    head="Nyame Helm",
    body="Mpaca's Doublet",
    hands="Nyame Gauntlets",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Gere Ring",
    right_ring="Chirich Ring +1",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
  }
  sets.TP.MEVA = {
    ammo="Ginsen",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
  }
  sets.TP.MidAcc = {}
  sets.TP.MaxAcc = {}

  sets.WS = {}
  sets.WS["Victory Smite"] = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Bhikku Cyclas +1",
    hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    legs="Mpaca's Hose",
    feet={ name="Herculean Boots", augments={'Accuracy+6','Crit. hit damage +5%','STR+7',}},
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Odr Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }
  sets.WS["Shijin Spiral"] = {
    ammo="Aurgelmir Orb",
    head="Ken. Jinpachi +1",
    body="Mpaca's Doublet",
    hands="Mpaca's Gloves",
    legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
    feet="Mpaca's Boots",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Mache Earring +1",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
  }
  sets.WS["Raging Fists"] = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Mpaca's Doublet",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet="Mpaca's Boots",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
  }
  sets.WS["Howling Fist"] = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Mpaca's Doublet",
    hands="Mpaca's Gloves",
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet={ name="Herculean Boots", augments={'Attack+12','"Triple Atk."+4','STR+6','Accuracy+12',}},
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
  }

  sets.WS["Cataclysm"] = {
    ammo="Knobkierrie",
    head="Pixie Hairpin +1",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Novio Earring",
    right_ear="Friomisi Earring",
    left_ring="Archon Ring",
    right_ring="Shiva Ring +1",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
  }

	sets.FC = {
    head={ name="Herculean Helm", augments={'Accuracy+28','Weapon skill damage +4%','STR+8','Attack+2',}},
    body={ name="Taeon Tabard", augments={'"Fast Cast"+5',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+7','Mag. Acc.+5',}},
    legs={ name="Taeon Tights", augments={'Accuracy+8','"Fast Cast"+4','Crit. hit damage +2%',}},
    feet="Anch. Gaiters +3",
    neck="Magoraga Beads",
    right_ear="Etiolation Earring",
    right_ring="Prolix Ring",
  }
end


function precast(spell, act)
  if spell.cast_time then
    equip(sets.FC)
  end
end

-----------------------------------------------------------------------------------
  -- This is the midcast section.  It is used to designate gear that you want on as the ability or spell is used.
function midcast(spell, act)
  -- if spell.english:startswith('Utsusemi') and buffactive['Yonin'] then
	-- 	equip (sets.midcast.enmity)
  -- end
  
  if sets.JA[spell.english] then
    if buffactive['Impetus'] then
      equip({body="Bhikku Cyclas +1"})
      -- equip (set_combine(sets.WS["Victory Smite"], {body="Bhikku Cyclas +1",}))
    else
      equip(sets.JA[spell.english])
    end
  elseif sets.WS[spell.english] then
    equip(sets.WS[spell.english])
  end
end

-----------------------------------------------------------------------------------

	-- This section is the aftercast section that makes it so that after any of the above abilities you get put back into the correct gearset.  It should not be modified.
function aftercast(spell, act, spellMap, eventArgs)
  if player.status == 'Engaged' then
    if buffactive['Impetus'] then
      equip (set_combine(sets.TP[TP_mode], {body="Bhikku Cyclas +1",}))
    else
      equip(sets.TP[TP_mode])
    end
  else
    equip(sets.Idle)
  end
end

function status_change(new,old)
  if T{'Idle','Resting'}:contains(new) then
    equip(sets.Idle)
  elseif new == 'Engaged' then
    if buffactive['Impetus'] then
      equip (set_combine(sets.TP[TP_mode], {body="Bhikku Cyclas +1",}))
		  -- equip(sets.TP.Impetus)
    else
      equip(sets.TP[TP_mode])
    end
  end
end

function self_command(command)
  local args = split_args(command)
  if args[1] == 'tp' then
    TP_mode = args[2]
    windower.add_to_chat('TP Mode is '..args[2])
    equip(sets.TP[TP_mode])
  end
end

function split_args(args)
   fields = {}
   args:gsub("([^ ]*) ?", function(c)
   table.insert(fields, c)
 end)
 return fields
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
    set_macro_page(1, 2)
  end
end

function set_lockstyle()
  send_command('wait 2; input /lockstyleset 4')
end

function sub_job_change(new,old)
end