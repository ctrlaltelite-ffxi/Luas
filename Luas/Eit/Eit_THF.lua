-- Initialization function for this job file.
function get_sets()
  include('organizer-lib')
  user_unload()
  user_setup()
  gearSets()
end
  
  
function user_setup()
  TP_mode = 'Normal' --Normal, Acc, DT, Eva, Hybrid, Tank
  Idle_Mode = 'Normal' --Normal, DT, Eva, Speed
  TH_Mode = 'None' --None, Min, Max
  lockstyleset = 1 --Lockstyle Set


  -- send_command('bind f9 gs c SongModeToggle')
  -- send_command('bind f10 gs c TPModeToggle')
  -- send_command('bind f11 gs c IdleModeToggle')
  send_command('bind f12 gs c PrintMode')
  -- Load Addons

end

function gearSets()
  --Job Ability Sets//
  sets.JA = {}
  sets.JA.Berserk = {}
  sets.JA.Aggressor = {}
  sets.JA.Warcry = {}
  sets.JA.Provoke = sets.Enmity
  
  sets.TP = {}
  sets.TP.Normal = {
    ammo="Aurgelmir Orb",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ashera Harness",
    hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
    legs="Malignance Tights",
    feet="Nyame Sollerets",
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Phys. dmg. taken-10%',}},
  }
  sets.TP.Acc = {}
  sets.TP.DT = {}
  sets.TP.EVA = {}
  sets.TP.Hybrid = {}
  sets.TP.Tank = {}

  sets.TH = {}
  sets.TH.Min = {
    hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
    feet="Skulk. Poulaines +1",
  }
  sets.TH.Max = set_combine(sets.TH.Min, {})
  
  sets.Enmity = {}
  sets.FC = {}
  
  sets.Idle = set_combine(sets.TP.Normal, {})
  sets.Idle.Normal = set_combine(sets.Idle, {})
  sets.Idle.DT = set_combine(sets.TP.Normal, {})
  sets.Idle.Eva = set_combine(sets.TP.Normal, {})
  sets.Idle.Speed = set_combine(sets.TP.Normal, {})
  

  sets.WS = {}
  sets.WS.Base = {
    ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
    feet={ name="Lustratio Leggings", augments={'HP+50','STR+10','DEX+10',}},
    neck="Flame Gorget",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
  }
  --Great Axe WS
  sets.WS["Rudra's Storm"] = {
    ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
    feet={ name="Lustratio Leggings", augments={'HP+50','STR+10','DEX+10',}},
    neck="Flame Gorget",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
  }
  sets.WS['Savage Blade'] = set_combine(sets.WS.Base, {})
  sets.WS['Tachi: Shosha'] = set_combine(sets.WS.Base, {})
  sets.WS['Tachi: Jinpu'] = set_combine(sets.WS, {})
  sets.WS['Impulse Drive'] = set_combine(sets.WS, {})


  
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

end

function self_command(command)
  local cType
  cType = string.sub(command,1,2)
  if command == 'DT' then
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

function printMode()
  -- (0x1F, 5) --Blue
  -- (0x1F, 6) --Green
  -- (0x1F, 25) -- White
  -- (0x1F, 36) -- Yellow
  -- (0x1E, 259 - 254) -- Pink
  -- (0x1E, 262 - 254) -- Orange

  line = ''
  line = line..string.char(0x1F, 154)..'TH Mode: ' 
  line = line..string.char(0x1F, 6)..TH_Mode 
  line = line..string.char(0x1E, 262 - 254)..' |' 
  line = line..string.char(0x1F, 154)..' TP Mode: ' 
  line = line..string.char(0x1F, 6)..TP_Mode 
  line = line..string.char(0x1E, 262 - 254)..' |' 
  line = line..string.char(0x1F, 154)..' Idle: ' 
  line = line..string.char(0x1F, 6)..Idle_Mode 
  windower.add_to_chat(6,line)
end



function user_unload()
  send_command('unbind f12')
  send_command('unbind f11')
  send_command('unbind f10')
  send_command('unbind f9')

  send_command('unbind ^`')
  send_command('unbind !`')
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

end
