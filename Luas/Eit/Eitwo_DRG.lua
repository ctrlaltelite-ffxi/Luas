include('organizer-lib')

function get_sets()
  --Variables
  TP_mode = 'Normal'

  sets.JA = {}
  sets.JA.Provoke = sets.Enmity
  
  sets.TP = {}
  sets.TP.Normal = {
    ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Anu Torque",
    waist="Sailfi Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Chirich Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
  }
  sets.TP.Acc = {}
  sets.TP.DT = sets.DT
  
  sets.Enmity = {}
  sets.FC = {}
  
  
  
  sets.Idle = {}
  
  sets.DT = {}

  sets.WS = {}
  sets.WS['Impulse Drive'] = {}

  sets.WS["Camlann's Torment"] = {
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Anu Torque",
    waist="Sailfi Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Thrud Earring",
    left_ring="Chirich Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
  }

  sets.WS['Stardriver'] = {}

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


function self_command(command)
  local cType
  cType = string.sub(command,1,2)
  if command == 'DT' then
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

