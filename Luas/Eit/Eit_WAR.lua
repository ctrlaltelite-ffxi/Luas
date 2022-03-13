include('organizer-lib')

function get_sets()
  --Variables
  TP_mode = 'Normal'
  WP_Mode = 'Single'

  sets.W = {} --Weapon Sets
  sets.W.GA_MAIN = {main="Bravura",sub="Utu Grip",}
  sets.W.GS_MAIN = {main="Montante +1",sub="Utu Grip",}
  sets.W.PA_MAIN = {main="Shining One",sub="Utu Grip",}
  sets.W.SW_MAIN_SH = {main="Naegling",sub="Blurred Shield +1",}
  sets.W.SW_MAIN_DH = {main="Naegling",sub="Barbarity",}
  sets.W.AX_MAIN_DH = {main="Kaja Axe",sub="Barbarity",}
  sets.W.AX_MAIN_SH = {main="Kaja Axe",sub="Blurred Shield +1",}
  sets.W.CL_MAIN_SH = {main="Beryllium Mace +1",sub="Blurred Shield +1",}

  sets.JA = {}
  sets.JA.Berserk = {
    body="Pumm. Lorica +3", 
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}, 
    feet="Agoge Calligae"
  }
  sets.JA.Aggressor = {
    head="Pummeler's Mask +2", 
    -- body={ name="Agoge Lorica", augments={'Enhances "Aggressive Aim" effect',}},
  }
  sets.JA.Warcry = {
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
  }
  sets.JA['Blood Rage'] = {
    body="Boii Lorica"
  }
  sets.JA['Mighty Strikes'] = {}
  sets.JA.Tomahawk = {ammo="Thr. Tomahawk",feet="Agoge Calligae"}
  sets.JA.Provoke = sets.Enmity
  
  sets.TP = {}  
  sets.TP.Normal = {
    ammo="Aurgelmir Orb",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    right_ring="Regal Ring",
    left_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
  }

  sets.TP.Dual = {}

  sets.TP.Acc = {}
  sets.TP.DT = sets.DT
  
  sets.Enmity = {}
  sets.FC = {}
  
  
  
  sets.Idle = {}
  
  sets.DT = {}

  sets.WS = {
    ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sulev. Leggings +2",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }
  --Great Axe WS
  sets.WS['Upheaval'] = {}
  sets.WS["Ukko's Fury"] = {}
  sets.WS["Metatron Torment"] = {}
  sets.WS["Steel Cyclone"] = {}
  sets.WS['Decimation'] = {}
  sets.WS['Cloudsplitter'] = {}
  sets.WS['Shockwave'] = {}
  sets.WS['Hexa Strike'] = {}

  sets.WS['Savage Blade'] = {
    ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sulev. Leggings +2",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }

  sets.WS.Resolution = {
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet="Pumm. Calligae +3",
    neck="Soil Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Brutal Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }

  sets.WS.Stardiver = {
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet="Pumm. Calligae +3",
    neck="Soil Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Brutal Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
  }

  sets.WS['Impulse Drive'] = {
    ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs={ name="Valorous Hose", augments={'Accuracy+30','Weapon skill damage +4%','INT+10','Attack+2',}},
    feet="Sulev. Leggings +2",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }

  sets.WS['Sonic Thrust'] = {
    ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs={ name="Valorous Hose", augments={'Accuracy+30','Weapon skill damage +4%','INT+10','Attack+2',}},
    feet="Sulev. Leggings +2",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }

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
  elseif cmd == 'wepa' then
    equip(sets.W.PA_MAIN)
    -- send_command('input /macro book 1;wait .1;input /macro set 2')
    windower.add_to_chat('Main Polearm Equiped')
  elseif cmd == 'wesw' then
    if WP_Mode == 'Dual' then
      equip(sets.W.SW_MAIN_DH)
      -- send_command('input /macro book 1;wait .1;input /macro set 3')
      windower.add_to_chat('Main Sword Equiped - Dual Handed')
    else
      equip(sets.W.SW_MAIN_SH)  
      -- send_command('input /macro book 1;wait .1;input /macro set 2')
      windower.add_to_chat('Main Sword Equiped - Single Handed')
    end
  elseif cmd == 'wecl' then
    if WP_Mode == 'Dual' then
      equip(sets.W.CL_MAIN_SH)
      -- send_command('input /macro book 1;wait .1;input /macro set 3')
      windower.add_to_chat('Main Sword Equiped - Dual Handed')
    else
      equip(sets.W.CL_MAIN_SH)  
      -- send_command('input /macro book 1;wait .1;input /macro set 2')
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
function send_to_mule(cmd)
  if cmd == 'e2Fury' then
    send_command('input //send Eitwo /ma "Indi-Fury" <me>')
  elseif cmd == 'e2Frail' then
    send_command('input //send Eitwo /ma "Geo-Frailty" <bt>')
  elseif cmd == 'e2Fire' then
    send_command('input //send Eitwo /ma "Fire" <bt>')
  elseif cmd == 'e2Curaga' then
    send_command('input //send Eitwo /ma "Curaga" Eit')
  end
end

