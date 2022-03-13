-- Initialization function for this job file.
function get_sets()
  include('organizer-lib')
  user_unload()
  user_setup()
  gearSets()
  setDefaults()
  createDisplay()
  getItemCount()
  
end

function user_setup()
  -- First Item in List will be Defaults
  mainList = {'Excalibur','Naegling'}
  subList = {'Priwen','Aegis','Blurred Shield +1'}
  setList = {'FullDD','HybridDD','PDT','MDT','Hybrid','Idle','Refresh','Twilight'}

  -- List of Spells that will toggle enmity set
  enmitySpells = {'Flash','Jettatura','Geist Wall','Cursed Sphere','Banishga','Sheep Song','Blank Gaze'}

  

  --General Settings
  lockstyleset = 1 --Lockstyle Set

  --Set Key Binds
  send_command('bind f9 gs c _seNxt')
  send_command('bind f10 gs c _weNxt')
  send_command('bind f11 gs c _shNxt')
  send_command('bind f12 gs c PrintMode')

  -- Load Addons
  -- send_command('lua l equipviewer;wait 1')
  -- send_command('ev pos 1800 800')


  -- Global Variables
  state = {} -- Table to hold all the state values
  start_time = os.time()
  CE_Decay = 1 --Set CE Decay Rate per second
  CurrentEnmity = 50 --Should Start at 0 and increase based on action
end
  
function gearSets()
  
  ----------------------------------------------------------------------------
  -- Precast (Spell/JA/Weaponskill)
  ----------------------------------------------------------------------------
  
  -- Magic, Song, and Cure Sets
  sets.precast = {}
  --FC: 22%, HP: 2941
  sets.precast.FC = {
    ammo="Sapience Orb", -- FC: 2%
    head="Sakpata's Helm", -- FC: 8%
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+7','Mag. Acc.+5',}}, -- FC: 5%
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Etiolation Earring", -- FC: 1%
    left_ring="Kishar Ring", -- FC: 4%
    right_ring="Prolix Ring", -- FC: 2%
    back="Moonbeam Cape",
  }

  sets.precast.FC.DT = set_combine(sets.precast.FC, {})
  
  sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

  -- Job Ability Sets
  sets.precast.JA = {}
  -- sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
  -- sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}



  ----------------------------------------------------------------------------
  -- Midcast sets
  ----------------------------------------------------------------------------

  sets.midcast = {}
  sets.midcast.Enmity = {}
  sets.midcast.SIRD = {}

  sets.midcast.Divine = {}
  sets.midcast.Divine.DT = {}

  sets.midcast['Enhancing Magic'] = {}
  sets.midcast['Enhancing Magic'].DT = set_combine(sets.midcast['Enhancing Magic'], {})

  sets.midcast.Cure = {}
  sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})

  sets.midcast.Protect = {}
  sets.midcast.Phalanx = {}
  sets.midcast.Reprisal = {}
  sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})
  sets.midcast.Enlight = sets.midcast.Divine
  sets.midcast.Crusade = set_combine(sets.midcast.Enmity, {})

  -- Weaponskill Sets
  sets.midcast.WS = {
    ammo="Aurgelmir Orb",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Tuisto Earring",
    left_ring="Karieyh Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Mag. Evasion+15',}},
  }
  sets.midcast.WS['Evisceration'] = set_combine(sets.midcast.WS, {})
  sets.midcast.WS['Exenterator'] = set_combine(sets.midcast.WS, {})
  sets.midcast.WS['Mordant Rime'] = set_combine(sets.midcast.WS, {})
  sets.midcast.WS['Savage Blade'] = set_combine(sets.midcast.WS, {})

  -- Sets for specific spell enhancements TODO: eh...
  -- sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
  -- sets.midcast.Haste = sets.midcast['Enhancing Magic']
  -- sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
  -- sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
  -- sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})

  ----------------------------------------------------------------------------
  -- Aftercast sets
  ----------------------------------------------------------------------------
  sets.aftercast = {}
  -- DT:-51%, HP:2954, DA:45%,
  sets.aftercast.HybridDD = {
    ammo="Staunch Tathlum +1", 
    head="Sakpata's Helm", -- DT-7%
    body="Sakpata's Plate", -- DT-10%
    hands="Sakpata's Gauntlets", -- DT-8%
    legs="Sakpata's Cuisses", -- DT-9%
    feet="Sakpata's Leggings", -- DT-6%
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Tuisto Earring",
    left_ring="Moonbeam Ring", -- DT-4%
    right_ring="Moonbeam Ring", -- DT-4%
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Mag. Evasion+15',}},
  }
  sets.aftercast.FullDD = set_combine(sets.aftercast.HybridDD,{
    ammo="Aurgelmir Orb",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Mag. Evasion+15',}},
  })
  sets.aftercast.PDT = set_combine(sets.aftercast.HybridDD,{
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Sakpata's Gauntlets",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Tuisto Earring",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Mag. Evasion+15',}}
  })
  sets.aftercast.MDT = set_combine(sets.aftercast.HybridDD,{
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Sakpata's Gauntlets",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Tuisto Earring",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Mag. Evasion+15',}},
  })
  sets.aftercast.Hybrid = set_combine(sets.aftercast.HybridDD,{})
  sets.aftercast.Idle = set_combine(sets.aftercast.HybridDD,{})
  sets.aftercast.Refresh = set_combine(sets.aftercast.HybridDD,{})
  sets.aftercast.Twilight = set_combine(sets.aftercast.HybridDD,{})
  -- sets.aftercast.idle = {}
  -- sets.aftercast.idle.Normal = {}
  -- sets.aftercast.idle.FastDT = set_combine(sets.aftercast.idle.Normal,{})

  -- -- Normal, Acc, Pysical, Magical, Hybrid, Meva
  -- sets.aftercast.TP = {}
  -- sets.aftercast.TP.Normal = {}
  -- sets.aftercast.TP.Acc = set_combine(sets.aftercast.TP.Normal,{})
  -- sets.aftercast.TP.Pysical = set_combine(sets.aftercast.TP.Normal,{})
  -- sets.aftercast.TP.Magical = set_combine(sets.aftercast.TP.Normal,{})
  -- sets.aftercast.TP.Hybrid = set_combine(sets.aftercast.TP.Normal,{})
  -- sets.aftercast.TP.Meva = set_combine(sets.aftercast.TP.Normal,{})

end
  
function precast(spell)
  equip(sets.precast.FC)
end

function midcast(spell)
  if(spell.type) == 'WeaponSkill' then
    if sets.midcast.WS[spell.english] then equip(sets.midcast.WS[spell.english])
    else equip(sets.midcast.WS)
    end
  end
end
  
function aftercast(spell)
  equip_aftercast()
end

function status_change(new,old)
  equip_aftercast()
end

function sub_job_change(new,old)
  if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
    DW_Check = true
  else
    DW_Check = false
  end
end

function equip_aftercast()
  equip({main=mainList[state.Main], sub=subList[state.Sub]})
  equip(sets.aftercast[setList[state.Set]])
  update_displaybox()
end

function self_command(command)
  local mainCmd, subCmd
  mainCmd = string.sub(command,1,3)
  subCmd = command:sub(4)

  if mainCmd == '_we' then toggle('Main',subCmd)  --_weNxt or _wePrv
  elseif mainCmd == '_sh' then toggle('Sub',subCmd) 
  elseif mainCmd == '_se' then toggle('Set',subCmd) 
  elseif command == 'setBlueSpells' then setBlueSpells()
  elseif command == 'setGear' then equip_aftercast()
  else
  end
end

function createDisplay()
  if displayBox then displayBox:destroy() end
  local windowersettings = windower.get_windower_settings()
	local x,y
    x,y = 10, windowersettings["ui_y_res"]-18
    displayBox = texts.new()
    displayBox:pos(x,y)
    displayBox:font('Arial')--Arial
    displayBox:size(12)
    displayBox:bold(true)
    displayBox:bg_alpha(0)--128
    displayBox:right_justified(false)
    displayBox:stroke_width(2)
    displayBox:stroke_transparency(192)
    update_displaybox(displayBox)
end

function update_displaybox()
	local player = windower.ffxi.get_player()
	if not player then return end

  -- Define colors for text in the display
  local color = {
    Label='\\cs(255,255,255)', -- White
    Warning='\\cs(204, 204, 0)', -- Yellow 
    Success='\\cs(0, 204, 0)', -- Green
    Error='\\cs(204, 0, 0)', -- Red
    Info='\\cs(0, 204, 204)', -- Light Blue
  }

  local info = {}
  displayBox:clear()
  displayBox:append("W/S: "..color.Info..mainList[state.Main]..color.Label..' / '..color.Info..subList[state.Sub]..'  ')
  displayBox:append(color.Label.."Set: "..color.Info..setList[state.Set]..'  ')
  displayBox:append(color.Label.."Sird: "..color.Info..(state.Sird and 'ON' or 'OFF')..'  ')
  displayBox:append(color.Label.."Turtle: "..color.Info..(state.Turtle and 'ON' or 'OFF')..'  ')
  if state.Twilight then
    displayBox:append(color.Success.."Twilight: "..color.Info..(state.Twilight and 'ON' or 'OFF')..'  ')
  end
  displayBox:append(color.Label..'|  ')
  displayBox:append(color.Label.."R: "..color.Error..state.remedyCnt..'  ')
  displayBox:append(color.Label.."P: "..color.Warning..state.panaceaCnt..color.Label..'  ')
  -- displayBox:append(color.Label..'|  ')
  -- displayBox:append(color.Label.."VE: "..color.Info..CurrentEnmity..'  ')
  displayBox:show()

end

function getItemCount(item)
	local inventory = windower.ffxi.get_items('inventory')
  state.remedyCnt = 0
  state.panaceaCnt = 0

  --Removing current since the calculation doesn't add it correctly
  if item == 4155 then state.remedyCnt = -1
  elseif item == 4149 then state.panaceaCnt = -1
  end

  --Loop through inventory to get counts
	for k, v in pairs(inventory) do
		if k == 80 then break -- Breaks Loop at max inventory :TODO find more elegant solution
		elseif v.id == 4155 then state.remedyCnt = state.remedyCnt + v.count -- Remedy Count 
		elseif v.id == 4149 then state.panaceaCnt = state.panaceaCnt + v.count -- Panacea Count
		end
	end
  -- print(state.remedyCnt)
  -- print(item)
  update_displaybox()
end

function calculateStuff()
  local VE_Decay = 2 --Set VE Decay Rate per second
  CurrentEnmity = CurrentEnmity - VE_Decay
end

function setDefaults()
  state.Main = 1
  state.Sub = 1
  state.Set = 1
  state.Sird = false
  state.Turtle = false
  state.Twilight = false
  state.remedyCnt = 0
	state.panaceaCnt = 0
end

function toggle(slot,direction)

  local list
  if slot == 'Main' then list = mainList
  elseif slot == 'Sub' then list = subList
  elseif slot == 'Set' then list = setList
  end

  if direction == 'Nxt' and state[slot] == #list then
    state[slot] = 1
  elseif direction == 'Nxt' then
    state[slot] = state[slot] + 1
  elseif direction == 'Prv' and state[slot] == 1 then
    state[slot] = #list
  elseif direction == 'Prv' then
    state[slot] = state[slot] - 1
  end
  
  equip_aftercast()
end

--Constant loop, keep this light
windower.register_event('prerender', function()
  -- if start_time + 1 <= os.time() and CurrentEnmity > 0 then
  --   calculateStuff()
  --   start_time = os.time()
  --   update_displaybox()
  -- end
end)

windower.register_event('action', function(act)
  if act.category == 5 and act.actor_id == player.id then getItemCount(act.param) end
  -- print(act.actor_id)
  -- print(player)

  -- local targets = act.targets
	-- for k, v in pairs(player) do
  --   print(player.id)
    -- for a, b in pairs(v.actions) do
    --   if b.reaction ~= 0 then print(b.reaction) end
      
    -- end
	-- 	if k == 80 then break -- Breaks Loop at max inventory :TODO find more elegant solution
	-- 	elseif v.id == 4155 then state.remedyCnt = v.count -- Remedy Count 
	-- 	elseif v.id == 4149 then state.panaceaCnt = v.count -- Panacea Count
	-- 	end
	-- end
end)

--Unloads binds
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

function setBlueSpells()
  -- windower.ffxi.set_blue_magic_spell(SPELL_ID,SPELL_SLOT) 
  -- SPELL_ID = blue magic spell id from windower\res\spells.lua
  -- SPELL_SLOT = the slot where you want the blue spells to go into

  windower.ffxi.reset_blue_magic_spells()
  windower.ffxi.set_blue_magic_spell(581,1)  -- Healing Breeze
  windower.ffxi.set_blue_magic_spell(584,2)  -- Sheep Song
  windower.ffxi.set_blue_magic_spell(578,3)  -- Wild Carrot
  windower.ffxi.set_blue_magic_spell(549,4)  -- Pollen
  windower.ffxi.set_blue_magic_spell(539,5)  -- Terror Touch
  windower.ffxi.set_blue_magic_spell(622,6)  -- Grand Slam
  windower.ffxi.set_blue_magic_spell(547,7)  -- Cocoon
  windower.ffxi.set_blue_magic_spell(575,8)  -- Jettatura
  windower.ffxi.set_blue_magic_spell(592,9)  -- Blank Gaze
  windower.ffxi.set_blue_magic_spell(519,10) -- Screwdriver
  windower.ffxi.set_blue_magic_spell(605,11) -- Geist Wall
  windower.ffxi.set_blue_magic_spell(544,12) -- Cursed Sphere

  -- @TODO: Create function to get spell ID based on spell name and validate spell point to prevent over setting
end


----------------------------------------------------------------------------------------------------------------------------------
-- TEST AREA DO NOT SAVE PROD CODE HERE

--Inverts Table.... for future reference
-- function table_invert(t)
--   -- state.Main = table_invert(mainList)[mainDefault]
--   -- state.Sub = table_invert(subList)[subDefault]
--   local s={}
--   for k,v in pairs(t) do
--     s[v]=k
--   end
--   return s
-- end