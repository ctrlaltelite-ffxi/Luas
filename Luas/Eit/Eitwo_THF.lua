-- include('organizer-lib')

function get_sets()
  --Variables
  TP_mode = 'Normal'

  sets.W = {} --Weapon Sets
  sets.W.GA_MAIN = {}

  sets.JA = {}
  sets.JA.Berserk = {}
  sets.JA.Aggressor = {}
  sets.JA.Warcry = {}

  sets.JA.Provoke = sets.Enmity
  
  sets.TP = {}
  sets.TP.Normal = {
    main={ name="Sandung", augments={'Accuracy+50','Crit. hit rate+5%','"Triple Atk."+3',}},
    sub="Thief's Knife",
    ammo="Aurgelmir Orb",
    head="Mummu Bonnet +1",
    body="Mummu Jacket +1",
    hands="Mummu Wrists +1",
    legs="Mummu Kecks +1",
    feet="Mummu Gamash. +1",
    neck="Anu Torque",
    waist="Chaac Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="K'ayres Ring",
    right_ring="Warp Ring",
    back="Atheling Mantle",
  }
  sets.TP.Acc = {}
  sets.TP.DT = sets.DT
  sets.TH = set_combine(sets.TP.Normal, {
    hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
    feet="Skulk. Poulaines",
  })
  
  sets.Enmity = {}
  sets.FC = {}
  
  sets.Idle = set_combine(sets.TP.Normal, {})
  
  sets.DT = {}
  sets.WS = {}
  sets.WS.Base = {
    ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+15 Attack+15','Crit. hit damage +4%',}},
    feet={ name="Herculean Boots", augments={'Accuracy+25 Attack+25','DEX+4','Accuracy+4','Attack+11',}},
    neck="Rancor Collar",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Moonbeam Ring",
    right_ring="Ilabrat Ring",
    back="Moonbeam Cape",
  }
  --Great Axe WS
  sets.WS['Tachi: Fudo'] = set_combine(sets.WS.Base, {})
  sets.WS['Tachi: Kasha'] = set_combine(sets.WS.Base, {})
  sets.WS['Tachi: Shosha'] = set_combine(sets.WS.Base, {})
  sets.WS['Tachi: Jinpu'] = set_combine(sets.WS, {})
  sets.WS['Impulse Drive'] = set_combine(sets.WS, {})

  --Magic
  sets.WS.Gavialis = {}
  
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
  send_command('wait 2;input /lockstyleset 1')
  if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
    WP_Mode = 'Dual'
  else
    WP_Mode = 'Single'
  end
end

function self_command(command)
  local cType
  cType = string.sub(command,1,2)
  if cType == 'we' then
    equip_weapon(command)
  elseif cType == 'e2' then
    send_to_mule(command)
  elseif command == 'DT' then
    equip(sets.DT)
  elseif command == 'TH' then
    equip(sets.TH)
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
  if cmd == 'wega' then
    equip(sets.W.GA_MAIN)
    send_command('input /macro book 1;wait .1;input /macro set 1')
    windower.add_to_chat('Main GA Equiped')
  elseif cmd == 'wegs' then
    equip(sets.W.GS_MAIN)
    send_command('input /macro book 1;wait .1;input /macro set 2')
    windower.add_to_chat('Main GS Equiped')
  elseif cmd == 'wesw' then
    if WP_Mode == 'Dual' then
      equip(sets.W.SW_MAIN_DH)
      send_command('input /macro book 1;wait .1;input /macro set 3')
      windower.add_to_chat('Main Sword Equiped - Dual Handed')
    else
      equip(sets.W.SW_MAIN_SH)  
      send_command('input /macro book 1;wait .1;input /macro set 2')
      windower.add_to_chat('Main Sword Equiped - Single Handed')
    end
  elseif cmd == 'weax' then
      if WP_Mode == 'Dual' then
        equip(sets.W.AX_MAIN_DH)
        send_command('input /macro book 1;wait .1;input /macro set 3')
        windower.add_to_chat('Main Axes Equiped - Dual Handed')
      else
        equip(sets.W.AX_MAIN_SH)
        send_command('input /macro book 1;wait .1;input /macro set 4')
        windower.add_to_chat('Main Axe Equiped - Single Handed')
      end
  end
end


