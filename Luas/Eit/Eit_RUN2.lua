include('organizer-lib')

function user_setup()
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad1')
  send_command('unbind ^numpad2')
  send_command('unbind ^numpad3')
  send_command('unbind ^numpad4')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad6')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad8')
  send_command('unbind ^numpad9')

  send_command('unbind !numpad/')
  send_command('unbind !numpad*')
  send_command('unbind !numpad-')
  send_command('unbind !numpad0')
  send_command('unbind !numpad1')
  send_command('unbind !numpad2')
  send_command('unbind !numpad3')
  send_command('unbind !numpad4')
  send_command('unbind !numpad5')
  send_command('unbind !numpad6')
  send_command('unbind !numpad7')
  send_command('unbind !numpad8')
  send_command('unbind !numpad9')

end

function user_unload()
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad1')
  send_command('unbind ^numpad2')
  send_command('unbind ^numpad3')
  send_command('unbind ^numpad4')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad6')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad8')
  send_command('unbind ^numpad9')

  send_command('unbind !numpad/')
  send_command('unbind !numpad*')
  send_command('unbind !numpad-')
  send_command('unbind !numpad0')
  send_command('unbind !numpad1')
  send_command('unbind !numpad2')
  send_command('unbind !numpad3')
  send_command('unbind !numpad4')
  send_command('unbind !numpad5')
  send_command('unbind !numpad6')
  send_command('unbind !numpad7')
  send_command('unbind !numpad8')
  send_command('unbind !numpad9')
end

function get_sets()
  --Variables
  TP_mode = 'Normal'

  sets.W = {} --Weapon Sets
  sets.W.GS_MAIN = {
    main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
    sub="Mensch Strap",
  }

  sets.JA = {}
  sets.JA.Provoke = sets.Enmity
  
  sets.TP = {}
  sets.TP.Normal = {
    ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
    body="Erilaz Surcoat +1",
    hands="Aya. Manopolas +2",
    legs="Eri. Leg Guards +1",
    feet="Aya. Gambieras +1",
    neck="Warder's Charm +1",
    waist="Flume Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Ogma's cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+3','Enmity+10','Parrying rate+5%',}},
  }
  sets.TP.Acc = {}
  sets.TP.DT = sets.DT
  
  sets.Enmity = {

  }
  sets.FC = {}
  
  
  
  sets.Idle = {
    ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
    body="Erilaz Surcoat +1",
    hands="Aya. Manopolas +2",
    legs="Eri. Leg Guards +1",
    feet="Aya. Gambieras +1",
    neck="Warder's Charm +1",
    waist="Flume Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Ogma's cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+3','Enmity+10','Parrying rate+5%',}},
  }
  
  sets.DT = {}

  sets.WS = {}
  --Axe Ws

  --Great Sword WS
  sets.WS.Resolution = {}

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
  -- send_command('wait 2;input /lockstyleset 1')
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
  if cmd == 'wega' then
    equip(sets.W.GA_MAIN)
    send_command('input /macro book 2;wait .1;input /macro set 1')
    windower.add_to_chat('Main GA Equiped')
  end
end