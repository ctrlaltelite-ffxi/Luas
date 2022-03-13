include('organizer-lib')

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
    ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
  }
  sets.TP.Acc = {}
  sets.TP.DT = sets.DT
  
  sets.Enmity = {}
  sets.FC = {}
  
  sets.Idle = {
    ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'Pet: DEX+6','STR+13','Quadruple Attack +2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
  }
  
  sets.DT = {}
  sets.WS = {}
  sets.WS.Base = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+20','Weapon skill damage +3%','STR+6',}},
    body="Dagon Breast.",
    hands={ name="Valorous Mitts", augments={'Attack+4','Weapon skill damage +5%','Accuracy+9',}},
    legs="Wakido Haidate +3",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Karieyh Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
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


