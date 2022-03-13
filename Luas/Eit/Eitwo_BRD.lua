-- Simple fuckin lua

function get_sets()
  TP_mode = 'Normal' -- Normal, Acc, DT, Hybrid
  Casting_mode = 'Normal' -- Normal, Acc, Duration
  Idle_mode = 'Normal' --Normal, DT, Resist
  include('spellmap.lua')

end


function init_gear_sets()
  ----------------------------------------------------------------------------
  ---------------- Precast (Spell/JA/Weaponskill) ----------------------------
  ----------------------------------------------------------------------------

  -- Fast Cast for Spells and Songs
  sets.precast.FC = {feet="Bihu Slippers +3"}
  sets.precast.FC.BardSong = {}
  sets.precast.FC.Cure = {}

  -- Job Ability Sets
  sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
  sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
  sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

  -- Weaponskill Sets
  sets.precast.WS = {}
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {})

  ----------------------------------------------------------------------------
  ---------------- Midcast ---------------------------------------------------
  ----------------------------------------------------------------------------

  -- Gear to enhance certain classes of songs.
  sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
  sets.midcast.Carol = {hands="Mousai Gages"}
  sets.midcast.Etude = {head="Mousai Turban"}
  sets.midcast.HonorMarch = {range="Marsyas", hands="Fili Manchettes +1"}
  sets.midcast.Lullaby = {body="Fili Hongreline +1", hands="Brioso Cuffs +3",range="Blurred Harp +1",}
  sets.midcast.Madrigal = {head="Fili Calot +1"}
  sets.midcast.Mambo = {feet="Mousai Crackows"}
  sets.midcast.March = {hands="Fili Manchettes +1"}
  sets.midcast.Minne = {legs="Mousai Seraweels"}
  sets.midcast.Minuet = {body="Fili Hongreline +1"}
  sets.midcast.Paeon = {head="Brioso Roundlet +3"}
  sets.midcast.Threnody = {body="Mou. Manteel +1"}
  sets.midcast['Adventurer\'s Dirge'] = {range="Marsyas", hands="Bihu Cuffs +3"}
  sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +3"}
  sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +1"}
  sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
  sets.midcast["Chocobo Mazurka"] = {range="Marsyas"}

  -- Song Placeholder (min Duration)
  sets.midcast.SongPlaceholder = {}

  -- Song Buffs (duration)
  sets.midcast.SongEnhancing = {
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Embla Sash",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
  }

  -- Song Enfeeble for max Duration
  sets.midcast.SongEnfeeble = {
    head="Brioso Roundlet +2",
    body="Brioso Justau. +3",
    hands="Brioso Cuffs +3",
    legs="Brioso Cannions +3",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Eschan Stone",
    left_ear="Arete del Luna",
    right_ear="Hermetic Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
  }

  -- Song Enffeble for max Accuracy
  sets.midcast.SongEnfeebleAcc = {
    head="Brioso Roundlet +2",
    body="Brioso Justau. +3",
    hands="Brioso Cuffs +3",
    legs="Brioso Cannions +3",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Eschan Stone",
    left_ear="Arete del Luna",
    right_ear="Hermetic Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
  }

  -- Magic Enhancing Duration
  sets.midcast['Enhancing Magic'] = {
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    waist="Embla Sash",
  }

  -- Sets for specific spell enhancements 
  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
  sets.midcast.Haste = sets.midcast['Enhancing Magic']
  sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
  sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})

end

function precast(spell, action, spellMap, eventArgs)
  if spell.type == 'BardSong' then
    -- equip(sets.precast.FC.BardSong)
  elseif CureSpells[spell.english] then
    equip(sets.precast.FC.Cure)
  else
    equip(sets.precast.FC)
  end

end

function midcast(spell, action, spellMap, eventArgs)
  -- windower.add_to_chat(spell.type)
  -- windower.add_to_chat(spell.name)
  -- if CureSpells[spell.english] then 
  --   windower.add_to_chat('Cure Spell')
  -- end

end
