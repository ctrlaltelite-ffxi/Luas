include('organizer-lib')

function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


function user_setup()
    select_default_macro_book()
end

function get_sets()
  --cycle
  send_command('bind ^= gs c TP')
  --Variables
  TP_mode = 'Normal'

  sets.W = {} --Weapon Sets
  sets.W.GK_MAIN = {
    main="Kaja Tachi",
    sub="Utu Grip",
  }

  sets.JA = {}
  sets.JA.Meditate = {
	head="Wakido Kabuto +1",
	back="Smertrios's Mantle",
  }
  sets.JA.Aggressor = {}
  sets.JA.Warcry = {}

  sets.JA.Provoke = sets.Enmity
  
  sets.TP = {}
  sets.TP.Normal = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Kendatsuba Hakama",
    feet="Flam. Gambieras +2",
    neck="Samurai's Nodowa +2",
    waist="Sarissaphoroi Belt",
    ear1="Cessance Earring",
    ear2="Brutal Earring",
    ring1="Flamma Ring",
    ring2="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }
  
    sets.TP.MDT = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
	body="Kendatsuba Samue",
    hands="Wakido Kote +3",
    legs="Kendatsuba Hakama",
    feet="Flam. Gambieras +2",
    neck="Samurai's Nodowa +2",
    waist="Sarissaphoroi Belt",
    ear1="Cessance Earring",
    ear2="Brutal Earring",
    ring1="Flamma Ring",
    ring2="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }
  
  sets.TP.Acc = {}
  sets.TP.PDT = sets.DT
  
  sets.Enmity = {}
  sets.FC = {}
  
  
  
  sets.idle = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
	--body="Kendatsuba Samue",
    hands="Wakido Kote +3",
    legs="Kendatsuba Hakama",
    feet="Flam. Gambieras +2",
    neck="Samurai's Nodowa +2",
    waist="Sarissaphoroi Belt",
    ear1="Cessance Earring",
    ear2="Brutal Earring",
    ring1="Flamma Ring",
    ring2="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
  }
  
  sets.DT = {
	--ring1="Warden's Ring",
	--waist="Flume Belt +1",
  }

  sets.WS = {}
  --Great Katana WS
  sets.WS['Tachi: Fudo'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +4%','AGI+8','Accuracy+15','Attack+11',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Pet: DEX+8','Accuracy+5','Weapon skill damage +7%','Accuracy+1 Attack+1',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','DEX+7','Accuracy+4','Attack+1',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    ear2="Thrud Earring",
    ring1="Epaminondas's Ring",
    ring2="Karieyh Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }
    sets.WS['Tachi: Kasha'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +4%','AGI+8','Accuracy+15','Attack+11',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Pet: DEX+8','Accuracy+5','Weapon skill damage +7%','Accuracy+1 Attack+1',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','DEX+7','Accuracy+4','Attack+1',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    ear2="Thrud Earring",
    ring1="Epaminondas's Ring",
    ring2="Karieyh Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }
    sets.WS['Tachi: Shoha'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Weapon skill damage +4%','AGI+8','Accuracy+15','Attack+11',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Pet: DEX+8','Accuracy+5','Weapon skill damage +7%','Accuracy+1 Attack+1',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +4%','DEX+7','Accuracy+4','Attack+1',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    ear2="Thrud Earring",
    ring1="Epaminondas's Ring",
    ring2="Karieyh Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }
  sets.WS['Tachi: Ageha'] = {
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Sakonji Domaru +3",
    hands="Valorous Mitts",
    legs="Wakido Haidate +3",
    feet="Flam. Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Moonshade Earring",
    ear2="Thrud Earring",
    ring1="Epaminondas's Ring",
    ring2="Karieyh Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }
  --Polearm WS
  --sets.WS['Impulse Drive'] = {
    --ammo="Knobkierrie",
    --head="Flam. Zucchetto +2",
    --body="Flamma Korazin +2",
    --hands="Flam. Manopolas +2",
    --legs={ name="Valor. Hose", augments={'Accuracy+30','Weapon skill damage +4%','INT+10','Attack+2',}},
    --feet="Flam. Gambieras +2",
    --neck="Moonbeam Nodowa",
    --waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    --ear1="Telos Earring",
    --ear2="Ishvara Earring",
    --ring1="Flamma Ring",
    --ring2="Karieyh Ring",
    --back="Cerb. Mantle +1",
  -- }
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
        equip(sets.idle)
    end
end

function status_change(new,old)
    if T{'Idle','Resting'}:contains(new) then
        equip(sets.idle)
    elseif new == 'Engaged' then
        equip(sets.TP[TP_mode])
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
    if TP_mode=="MDT" then
      TP_mode="Normal"
    elseif TP_mode=="Normal" then
       TP_mode="PDT"
    elseif TP_mode=="PDT" then
       TP_mode='MDT'
    end
    windower.add_to_chat('TP mode is now: '..TP_mode)
    equip(sets.TP[TP_mode])
  end
end
