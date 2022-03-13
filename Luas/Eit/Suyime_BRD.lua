-- Initialization function for this job file.
function get_sets()
  -- res = require 'resources'
  include('spellmap.lua')
  include('organizer-lib')
  user_unload()
  user_setup()
  gearSets()
end


function user_setup()
  TP_Mode = 'Normal' -- Normal, Acc, DT, Hybrid
  Song_Mode = 'Normal' -- Normal, Dummy, Duration
  Idle_Mode = 'Normal' --Normal, DT, Resist
  DW_Check = false
  lockstyleset = 1 --Lockstyle Set
  dummy_song = {
    ["Army's Paeon"]=true,
    ["Army's Paeon II"]=true,
    ["Army's Paeon III"]=true
  }

  send_command('bind f9 gs c SongModeToggle')
  send_command('bind f10 gs c TPModeToggle')
  send_command('bind f11 gs c IdleModeToggle')
  send_command('bind f12 gs c PrintMode')
  -- Load Addons
  send_command('lua l equipviewer;wait 1')
  send_command('ev pos 1300 600')



end

function gearSets()

  ----------------------------------------------------------------------------
  -- Precast (Spell/JA/Weaponskill)
  ----------------------------------------------------------------------------

  -- Magic, Song, and Cure Sets
  sets.precast = {}
  sets.precast.FC = { -- 56/80 Fast Cast
    main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}}, --7
    head="Revealer's Crown", --5
    body="Inyanga Jubbah +2", --14
    legs="Aya. Cosciales +2", --6
    waist="Witful Belt", --3
    left_ear="Enchntr. Earring +1", --2
    left_ring="Weather. Ring", --5
    right_ring="Kishar Ring", --4
    back={ name="Intarabus's Cape", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10
  }
  sets.precast.FC.Song = { --64/80 Song Cast
    main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}}, --7
    head="Fili Calot", --13
    body="Inyanga Jubbah +2", --14
    legs="Aya. Cosciales +2", --6
    waist="Witful Belt", --3
    left_ear="Enchntr. Earring +1", --2
    left_ring="Weather. Ring", --5
    right_ring="Kishar Ring", --4
    back={ name="Intarabus's Cape", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10
  }
  sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

  -- Job Ability Sets
  sets.precast.JA = {}
  sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
  sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
  sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

  -- Weaponskill Sets
  sets.precast.WS = {}
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {})

  ----------------------------------------------------------------------------
  -- Midcast sets
  ----------------------------------------------------------------------------

  -- Gear to enhance certain classes of songs
  sets.midcast = {}
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
  sets.midcast.Dirge = {range="Marsyas", hands="Bihu Cuffs +3"}
  sets.midcast.Sirvente = {head="Bihu Roundlet +3"}
  sets.midcast.Finale = {legs="Fili Rhingrave +1"}
  sets.midcast.Scherzo = {feet="Fili Cothurnes +1"}
  sets.midcast.Mazurka = {range="Marsyas"}

  -- Song Placeholder (min Duration)
  sets.midcast.SongDummy = {range="Daurdabla",}

  -- Song Buffs (max duration)
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
  sets.midcast.SongEnfeebleDuration = set_combine(sets.midcast.SongEnfeeble, {}) 

  -- Magic Enhancing Duration
  sets.midcast['Enhancing Magic'] = {
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    waist="Embla Sash",
  }

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
  sets.aftercast.idle_normal = {
    head="Inyanga Tiara +2",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet="Inyan. Crackows +2",
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist="Porous Rope",
    left_ear={ name="Moonshade Earring", augments={'HP+25','Latent effect: "Refresh"+1',}},
    right_ear="Eabani Earring",
    left_ring="Inyanga Ring",
    right_ring="Ayanmo Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
  }

  sets.aftercast.idle_DT = set_combine(sets.aftercast.idle_normal,{
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +1",
    waist="Porous Rope",
    left_ear="Eabani Earring",
    left_ring="Ayanmo Ring",
    right_ring="Inyanga Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
  })

  sets.aftercast.idle_resist = set_combine(sets.aftercast.idle_normal,{})

  sets.aftercast.TP_normal = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +1",
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist="Dynamic Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
  }

  sets.aftercast.TP_normal_dw = set_combine(sets.aftercast.TP_normal,{
    waist="Reiki Yotai",
    left_ear="Eabani Earring",
  })

  sets.aftercast.TP_ACC = set_combine(sets.aftercast.TP_normal,{})
  sets.aftercast.TP_ACC_dw = set_combine(sets.aftercast.TP_normal_dw,{})

  sets.aftercast.TP_DT = set_combine(sets.aftercast.TP_normal,{})
  sets.aftercast.TP_DT_dw = set_combine(sets.aftercast.TP_normal_dw,{})

  sets.aftercast.TP_Hybrid = set_combine(sets.aftercast.TP_normal,{})
  sets.aftercast.TP_Hybrid_dw = set_combine(sets.aftercast.TP_normal_dw,{})


end

function precast(spell)
  if spell.type == 'BardSong' then
    equip(sets.precast.FC.Song)
  elseif spell_map[spell.english] == 'Cure' or spell_map[spell.english] == 'Curaga' then
    equip(sets.precast.FC.Cure)
  else
    equip(sets.precast.FC)
  end

end

function midcast(spell)
  -- Bard Songs
  if (spell.type == 'BardSong' and dummy_song[spell.english]) then
    equip(sets.midcast.SongDummy)
  elseif spell.type == 'BardSong' then
    if spell_map[spell.english] == 'Lullaby' then
      if Song_Mode == 'Normal' then equip({range="Blurred Harp +1"})
      elseif Song_Mode == 'Duration' then
      end
      equip(set_combine(sets.midcast.SongEnfeebleDuration, sets.midcast[spell_map[spell.english]]))
    elseif Song_Mode == 'Duration' then
      equip(sets.midcast.SongDummy)
    elseif songDebuff[spell_map[spell.english]] then
      equip({range="Gjallarhorn"})
      equip(set_combine(sets.midcast.SongEnfeeble, sets.midcast[spell_map[spell.english]]))
    else
      equip({range="Gjallarhorn"})
      equip(set_combine(sets.midcast.SongEnhancing))
    end
  -- Cure Spells
  elseif spell_map[spell.english] == 'Cure' then
    equip(sets.precast.FC.Cure)
  -- All other Magic
  elseif white_Magic_noSkill[spell_map[spell.english]] then
    equip(sets.midcast['Enhancing Magic'])
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
  if player.status == 'Engaged' then
    if TP_Mode == 'Normal' and DW_Check == false then equip(sets.aftercast.TP_normal)
    elseif TP_Mode == 'Normal' and DW_Check == true then equip(sets.aftercast.TP_normal_dw)
    elseif TP_Mode == 'Acc' and DW_Check == false then equip(sets.aftercast.TP_ACC)
    elseif TP_Mode == 'Acc' and DW_Check == true then equip(sets.aftercast.TP_ACC_dw)
    elseif TP_Mode == 'DT' and DW_Check == false then equip(sets.aftercast.TP_DT)
    elseif TP_Mode == 'DT' and DW_Check == true then equip(sets.aftercast.TP_DT_dw)
    elseif TP_Mode == 'Hybrid' and DW_Check == false then equip(sets.aftercast.TP_Hybrid)
    elseif TP_Mode == 'Hybrid' and DW_Check == true then equip(sets.aftercast.TP_Hybrid_dw)
    end
  else
    if Idle_Mode == 'Normal' then equip(sets.aftercast.idle_normal)
    elseif Idle_Mode == 'DT' then equip(sets.aftercast.idle_DT)
    elseif Idle_Mode == 'Resist' then equip(sets.aftercast.idle_resist)
    end
  end
end

function self_command(command)
  if command == 'SongModeToggle' then songModeToggle()
  elseif command == 'TPModeToggle' then tpModeToggle()
  elseif command == 'IdleModeToggle' then idleModeToggle()
  elseif command == 'PrintMode' then printMode()
  elseif command == 'prebuff' then send_command('input /ma "victory march" <me>; wait 6; input /ma valor minuet V <me>; wait 6; input /ma "Army\'s Paeon" <me>; wait 6; input /ma "Army\'s Paeon II" <me>; wait 6; input /ma "blade madrigal" <me>; wait 6; input /ma "sword madrigal" <me>')
  elseif command == 'rebuff' then send_command('input /ma "victory march" <me>; wait 6; input /ma valor minuet V <me>; wait 6; input /ma "blade madrigal" <me>; wait 6; input /ma "sword madrigal" <me>')
  end
end

function songModeToggle()
  if Song_Mode == 'Normal' then Song_Mode = 'Dummy'
  elseif Song_Mode == 'Dummy' then Song_Mode = 'Duration'
  else Song_Mode = 'Normal'
  end
  equip_aftercast()
  printMode()
end

function tpModeToggle()
  if TP_Mode == 'Normal' then TP_Mode = 'Acc'
  elseif TP_Mode == 'Acc' then TP_Mode = 'DT'
  elseif TP_Mode == 'DT' then  TP_Mode = 'Hybrid'
  else TP_Mode = 'Normal'
  end
  equip_aftercast()
  printMode()
end

function idleModeToggle()
  if Idle_Mode == 'Normal' then Idle_Mode = 'DT'
  elseif Idle_Mode == 'DT' then Idle_Mode = 'Resist'
  else Idle_Mode = 'Normal'
  end
  equip_aftercast()
  printMode()
end

function printMode()
  -- (0x1F, 5) --Blue
  -- (0x1F, 6) --Green
  -- (0x1F, 25) -- White
  -- (0x1F, 36) -- Yellow
  -- (0x1E, 259 - 254) -- Pink
  -- (0x1E, 262 - 254) -- Orange

  line = ''
  line = line..string.char(0x1F, 154)..'Song: ' 
  line = line..string.char(0x1F, 6)..Song_Mode 
  line = line..string.char(0x1E, 262 - 254)..' |' 
  line = line..string.char(0x1F, 154)..' TP: ' 
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

-- windower.register_event('prerender', function()
--   recastMap = windower.ffxi.get_spell_recasts()
--   for key,value in pairs(recastMap) do 
--     if value ~= 0 then print(key,value) end
--   end
--   self = windower.ffxi.get_player()
--   for key,value in pairs(self) do 
--     if key == 'status' then print(key,value) end
--   end 
-- end)

-- windower.register_event('action', function(act)
--   for key,value in pairs(act) do 
--     if key == 'recast' then print(key,value) 
--     elseif key == 'param' then print(spell[value].en) 
--     end
--   end
-- end)

-- windower.register_event('gain buff', function(new, old)
--   print(new, old)
-- end)



-- --[[
--    Save Table to File
--    Load Table from File
--    v 1.0
   
--    Lua 5.2 compatible
   
--    Only Saves Tables, Numbers and Strings
--    Insides Table References are saved
--    Does not save Userdata, Metatables, Functions and indices of these
--    ----------------------------------------------------
--    table.save( table , filename )
   
--    on failure: returns an error msg
   
--    ----------------------------------------------------
--    table.load( filename or stringtable )
   
--    Loads a table that has been saved via the table.save function
   
--    on success: returns a previously saved table
--    on failure: returns as second argument an error msg
--    ----------------------------------------------------
   
--    Licensed under the same terms as Lua itself.
-- ]]--
-- do
--   -- declare local variables
--   --// exportstring( string )
--   --// returns a "Lua" portable version of the string
--   local function exportstring( s )
--      return string.format("%q", s)
--   end

--   --// The Save Function
--   function table.save(  tbl,filename )
--      local charS,charE = "   ","\n"
--      local file,err = io.open( filename, "wb" )
--      if err then return err end

--      -- initiate variables for save procedure
--      local tables,lookup = { tbl },{ [tbl] = 1 }
--      file:write( "return {"..charE )

--      for idx,t in ipairs( tables ) do
--         file:write( "-- Table: {"..idx.."}"..charE )
--         file:write( "{"..charE )
--         local thandled = {}

--         for i,v in ipairs( t ) do
--            thandled[i] = true
--            local stype = type( v )
--            -- only handle value
--            if stype == "table" then
--               if not lookup[v] then
--                  table.insert( tables, v )
--                  lookup[v] = #tables
--               end
--               file:write( charS.."{"..lookup[v].."},"..charE )
--            elseif stype == "string" then
--               file:write(  charS..exportstring( v )..","..charE )
--            elseif stype == "number" then
--               file:write(  charS..tostring( v )..","..charE )
--            end
--         end

--         for i,v in pairs( t ) do
--            -- escape handled values
--            if (not thandled[i]) then
           
--               local str = ""
--               local stype = type( i )
--               -- handle index
--               if stype == "table" then
--                  if not lookup[i] then
--                     table.insert( tables,i )
--                     lookup[i] = #tables
--                  end
--                  str = charS.."[{"..lookup[i].."}]="
--               elseif stype == "string" then
--                  str = charS.."["..exportstring( i ).."]="
--               elseif stype == "number" then
--                  str = charS.."["..tostring( i ).."]="
--               end
           
--               if str ~= "" then
--                  stype = type( v )
--                  -- handle value
--                  if stype == "table" then
--                     if not lookup[v] then
--                        table.insert( tables,v )
--                        lookup[v] = #tables
--                     end
--                     file:write( str.."{"..lookup[v].."},"..charE )
--                  elseif stype == "string" then
--                     file:write( str..exportstring( v )..","..charE )
--                  elseif stype == "number" then
--                     file:write( str..tostring( v )..","..charE )
--                  end
--               end
--            end
--         end
--         file:write( "},"..charE )
--      end
--      file:write( "}" )
--      file:close()
--   end
-- end

-- -- ChillCode