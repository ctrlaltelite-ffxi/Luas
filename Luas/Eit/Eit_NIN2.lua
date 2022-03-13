
-- Global Variables 
TP_mode = 'Normal'
Main_MacroBook = 1
Main_MacroPage = 1

function get_sets()
  mote_include_version = 2
  include('Mote-Include.lua')
  res = require 'resources'
end

function job_setup()
  no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)","Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
  lockstyleset = 5
end

function user_setup()
  select_default_macro_book()
  set_lockstyle()
end

function user_unload()
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^f11')
  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind @a')
  send_command('unbind @c')
  send_command('unbind @d')
  send_command('unbind !q')
  send_command('unbind @w')
  send_command('unbind @e')
  send_command('unbind @r')
  send_command('unbind !o')
  send_command('unbind !p')
  send_command('unbind ^,')
  send_command('unbind @w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad9')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad1')
  send_command('unbind @numpad*')

  send_command('unbind #`')
  send_command('unbind #1')
  send_command('unbind #2')
  send_command('unbind #3')
  send_command('unbind #4')
  send_command('unbind #5')
  send_command('unbind #6')
  send_command('unbind #7')
  send_command('unbind #8')
  send_command('unbind #9')
  send_command('unbind #0')

  -- send_command('lua u gearinfo')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  sets.W = {} --Weapon Sets
  sets.W.MAIN = {
    main={ name="Aizushintogo", augments={'DMG:+15','STR+15','Accuracy+10',}},
    sub={ name="Shigi", augments={'Accuracy+50','Rng.Acc.+50','Damage Taken -5%',}},
  }

  sets.W.P_Dagger = {main="Bronze Dagger"}
  sets.W.P_Club = {main="Warp Cudgel"}
  sets.W.P_Sword = {main="Bronze Sword"}
  sets.W.P_Staff = {main="Earth Staff"}
  sets.W.P_GreatKatana = {main="Kiikanemitsu"}
  sets.W.P_Scythe = {main="Ark Scythe"}
  sets.W.P_Polearm = {main="Pitchfork"}

  sets.Enmity = {
    body="Emet Harness +1",
    neck="Unmoving Collar",
    waist="Warwolf Belt",
    right_ring="Provocare Ring",
    back="Cerb. Mantle +1",
  }

  sets.midcast.Utsusemi = sets.Enmity
  

  sets.JA = {}
  sets.JA.Provoke = sets.Enmity
  
  sets.TP = {}
  sets.TP.Normal = {
    ammo="Suppa Shuriken",
    head="Ken. Jinpachi",
    body="Ken. Samue",
    hands="Ken. Tekko",
    legs="Mummu Kecks +2",
    feet="Ken. Sune-Ate",
    neck="Ninja Nodowa +1",
    waist="Windbuffet Belt",
    left_ear="Brutal Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Mummu Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }
  sets.TP.Acc = {}
  sets.TP.DT = sets.DT
  
  sets.FC = {
    ammo="Suppa Shuriken",
    head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Phys. dmg. taken -4%','STR+1','Accuracy+10','Attack+15',}},
    body={ name="Taeon Tabard", augments={'"Fast Cast"+5',}},
    legs={ name="Taeon Tights", augments={'Accuracy+8','"Fast Cast"+4','Crit. hit damage +2%',}},
    feet="Hattori Kyahan",
    neck="Magoraga Beads",
    left_ring="Prolix Ring"
  }
  
  sets.Idle = {
    ammo="Suppa Shuriken",
    head="Ken. Jinpachi",
    body="Ken. Samue",
    hands="Ken. Tekko",
    legs="Mummu Kecks +2",
    feet="Danzo Sune-Ate",
    neck="Ninja Nodowa +1",
    waist="Windbuffet Belt",
    left_ear="Brutal Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Mummu Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }
  
  sets.DT = {}
  
  sets.TP.DT = sets.DT

  sets.WS = {}
  sets.WS['Blade: Shun'] = {
    head="Hiza. Somen　+2",
    body="Hiza. Haramaki +2",
    hands="Hizamaru Kote +2",
    legs="Mummu Kecks +2",
    feet="Hiza. Sune-Ate +2",
    neck="Flame Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Rajas Ring",
    right_ring="Mummu Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }

  
  --send_command('input /lockstyleset 1')
end

function precast(spell)
    if spell.cast_time then
        equip(sets.FC)
    end
end

function midcast(spell)
    if sets.JA[spell.english] then
        equip(sets.JA[spell.english])
    elseif sets.WS[spell.english] then
        equip(sets.WS[spell.english])
        if sets.WS[spell.english].Gavialis and sets.WS[spell.english].Gavialis[world.day] then
            equip(sets.WS.Gavialis)
        end
    end
end

function aftercast(spell)
    if player.status == 'Engaged' then
        equip(sets.TP[TP_mode])
    else
        equip(sets.Idle)
    end
end

function status_change(new,old)
    if T{'Idle','Resting'}:contains(new) then
        equip(sets.Idle)
    elseif new == 'Engaged' then
        equip(sets.TP[TP_mode])
        
    end
end

function sub_job_change(new,old)
  -- 68
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
    equip(sets.W.P_Club)
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
  send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
