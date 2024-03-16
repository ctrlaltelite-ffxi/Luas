require 'organizer-lib'

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Defense Modes
--              [ ALT+F9 ]          Weaponskill Modes
--              [ F10 ]             PDT Modes
--              [ CTRL+F10 ]        Cycle PDT Modes
--              [ ALT+F10 ]         Toggle Kiting Modes
--              [ F11 ]             MDT Modes
--              [ CTRL+F11 ]        Casting Modes
--              [ F12 ]             Cycle MDT Modes
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel MDT Mode
--
---------------------------------------------------------------------------------------------------------------------------------------
-------------------------------- Initialization function that defines sets and variables to be used -----------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
 
-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.
 
-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Mote-IncludePLD.lua')
	include('organizer-lib')
	organizer_items = {
	ss_18="Storage Slip 18",
	ss_23="Storage Slip 23",
	}
end

 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal', 'PDT'}
    options.WeaponskillModes = {'Normal', 'Acc'}
    options.CastingModes = {'Normal', 'DT'} 
    options.IdleModes = {'Normal',}
    options.RestingModes = {'Normal'}
    options.PhysicalDefenseModes = {'Aegis', 'Srivatsa', 'Ochain', 'Priwen'}
    options.MagicalDefenseModes = {'MDT' ,'BDT','ResistCharm'}
    options.HybridDefenseModes = {'None', 'Reraise',}
    options.BreathDefenseModes = {'BDT'}
	state.Defense.PhysicalMode = 'Aegis'
    state.HybridDefenseMode = 'None'
    state.BreathDefenseModes = 'BDT'
    send_command('bind f12 gs c cycle MagicalDefense')
 	send_command('bind ^= gs c activate MDT')
    select_default_macro_book()
	set_lockstyle()
end

 function user_unload()
	send_command('unbind `')
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^-')
	send_command('unbind !-')	
	send_command('unbind ^=')
	send_command('unbind !=')		
	send_command('unbind delete')
	send_command('unbind end')
	send_command('unbind home')
end

-- Define sets and vars used by this job file.
function job_setup()
 	include('caster_buffWatcher.lua')
buffWatcher.watchList = 
{
                       ["Enlight"]="Enlight II",
					   ["Enmity Boost"]="Crusade",
                       ["Phalanx"]="Phalanx",
                       ["Protect"]="Protect V",
                       ["Shell"]="Shell IV",							   
}
include('common_info.status.lua')
	lockstyleset = 17	
end

--------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------Precast sets-----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

function init_gear_sets()

	 -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.precast.JA['Provoke'], {legs="Cab. Breeches +1"})
   
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.JA['Provoke'], {feet="Rev. Leggings +3"})
         
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.JA['Provoke'], {hands="Cab. Gauntlets +1", left_ear="Knightly Earring", left_ring="Guardian's Ring",right_ring="Fenian Ring"})
     
    sets.precast.JA['Intervene'] = sets.precast.JA['Shield Bash']
    
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.JA['Provoke'], {feet="Cab. Leggings +1"})   
     
    --The amount of damage absorbed is variable, determined by VIT*2
    sets.precast.JA['Rampart'] = 
{
    ammo="Egoist's Tathlum",
    head={ name="Cab. Coronet +1", augments={'Enhances "Iron Will" effect',}},
    body="Rev. Surcoat +3",
    hands="Regal Gauntlets",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back="Moonbeam Cape",
}

     
    sets.buff['Rampart'] = sets.precast.JA['Rampart']
   
    sets.precast.JA['Fealty'] = set_combine(sets.precast.JA['Provoke'], {body="Cab. Surcoat +1",})
     
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.JA['Provoke'], {feet="Chev. Sabatons +1"})
     
    --15 + min(max(floor((user VIT + user MND - target VIT*2)/4),0),15)
    sets.precast.JA['Cover'] = set_combine(sets.precast.JA['Rampart'], {head="Rev. Coronet +3", body="Cab. Surcoat +1"})
    
    sets.buff['Cover'] = sets.precast.JA['Cover']
     
    -- add MND for Chivalry
    sets.precast.JA['Chivalry'] = 
{
	ammo="Strobilus",
    head="Jumalik Helm",
    body="Rev. Surcoat +3",
    hands={ name="Cab. Gauntlets +1", augments={'Enhances "Chivalry" effect',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Dualism Collar +1",
    waist="Creed Baudrier",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    --right_ear=,
    left_ring="Metamor. Ring +1",
    right_ring="Stikini Ring",
    back={ name="Weard Mantle", augments={'VIT+5','DEX+3','Phalanx +5',}}
}
     
    ------------------------ Sub WAR ------------------------ 
	sets.precast.JA['Provoke'] =    --enmity +112 to 125
{

    ammo="Paeapua", -- 2
    head={ name="Loess Barbuta +1", augments={'Path: A',}}, --19 or 24
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- 20
    hands={ name="Yorium Gauntlets", augments={'Enmity+10',}}, -- 14
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- 9
    feet={ name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}}, -- 15
    neck={ name="Unmoving Collar +1", augments={'Path: A',}}, -- 10
    waist="Creed Baudrier", -- 5
    left_ear="Tuisto Earring", -- "Trux Earring",
    right_ear="Cryptic Earring", -- 2
    left_ring="Apeile Ring", -- 5 to 9
    right_ring="Apeile Ring +1", -- 5 to 9
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}}, 
}	
 
    sets.precast.JA['Warcry'] = sets.precast.JA['Provoke'] 
     
    sets.precast.JA['Defender'] = sets.precast.JA['Provoke']
 
    ------------------------ Sub DNC ------------------------ 
     
    -- Waltz set (chr and vit)
    sets.precast.Waltz = 
{
    ammo="Iron Gobbet",
    head="Jumalik Helm",
    body={ name="Found. Breastplate", augments={'Accuracy+11','Mag. Acc.+10','Attack+10','"Mag.Atk.Bns."+9',}},
    hands={ name="Founder's Gauntlets", augments={'STR+10','Attack+15','"Mag.Atk.Bns."+15','Phys. dmg. taken -5%',}},
    legs="Dashing Subligar",
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Kgt. Beads +2",
    waist="Latria Sash",
    --left_ear="Terra's Pearl",
    --right_ear="Terra's Pearl",
    left_ring="Valseur's Ring",
    right_ring="Asklepian Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Enmity+10',}},
}
         
    -- Special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = sets.precast.Waltz
     
    sets.precast.Step = sets.precast.JA['Provoke']
        
    sets.precast.Flourish1 = sets.precast.Step
     
    ------------------------ Sub RUN ------------------------ 
    sets.precast.JA['Ignis'] = sets.precast.JA['Provoke']   
    sets.precast.JA['Gelus'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Flabra'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Tellus'] = sets.precast.JA['Provoke']  
    sets.precast.JA['Sulpor'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Unda'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Lux'] = sets.precast.JA['Provoke']     
    sets.precast.JA['Tenebrae'] = sets.precast.JA['Provoke'] 
     
    sets.precast.JA['Vallation'] = sets.precast.JA['Provoke'] 
     
    sets.precast.JA['Pflug'] = sets.precast.JA['Provoke'] 
          
    -- Fast cast sets for spells   2844HP FC+60/80
	sets.precast.FC = 
{
    ammo="Sapience Orb",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --{ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
    body="Rev. Surcoat +3",
    hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
    legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+3','DEX+15','Weapon skill damage +7%','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}, -- Need
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}}, -- Need
    neck="Voltsurge Torque", -- "Orunmila's Torque",
    waist="Creed Baudrier",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}}, -- add dye +20 HP
}	
     
	sets.precast.FC.DT = 
{ 
    ammo="Impatiens",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +3",
    hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}}, -- Need
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}}, -- Need
    neck="Moonlight Necklace",
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}}, -- add dye +20HP
}
	 
    sets.precast.FC.Phalanx = set_combine(sets.precast.FC , {waist="Siegel Sash",})
	sets.precast.FC.Enlight = sets.precast.FC.Phalanx
	sets.precast.FC['Enlight II'] = sets.precast.FC.Phalanx
	sets.precast.FC.Protect = sets.precast.FC.Phalanx
	sets.precast.FC.Shell = sets.precast.FC.Phalanx
	sets.precast.FC.Crusade = sets.precast.FC.Phalanx
         
    sets.precast.FC.Cure = 
{
    ammo="Sapience Orb", --FC 2%
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, -- Need 14%
    body="Rev. Surcoat +3", -- Need 10%
    hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}}, -- FC 6%
    legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+3','DEX+15','Weapon skill damage +7%','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}, -- FC 3%
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}}, -- FC 9%
    neck="Voltsurge Torque", -- 
    waist="Creed Baudrier",
    right_ear="Odnowa Earring +1",
    left_ring="Kishar Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}}, -- FC 10%
	
	
}       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = 
{
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
	body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Rajas Ring",
    right_ring="Regal Ring",
    back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
 
    --Stat Modifier:     73~85% MND  fTP:    1.0
 sets.precast.WS['Requiescat'] = 
{
    ammo="Hasty Pinion +1",
    head="Sakpata's Helm",
	body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Rufescent Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Mag. Evasion+15',}},
}
    
   --Stat Modifier:  50%MND / 30%STR MAB+    fTP:2.75
    sets.precast.WS['Sanguine Blade'] = 
{
    ammo="Pemphredo Tathlum",
    head="Jumalik Helm",
    body={ name="Found. Breastplate", augments={'Accuracy+11','Mag. Acc.+10','Attack+10','"Mag.Atk.Bns."+9',}},
    hands={ name="Founder's Gauntlets", augments={'STR+10','Attack+15','"Mag.Atk.Bns."+15','Phys. dmg. taken -5%',}},
    legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+29','Accuracy+24','Accuracy+17 Attack+17','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
    neck="Fotia Gorget",
    waist="Orpheus's Sash",
    left_ear="Crematio Earring",
    right_ear="Friomisi Earring",
    left_ring="Metamor. Ring +1",
    right_ring="Epaminonda's Ring",
    back={ name="Rudianos's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Mag. Evasion+15',}},
}	
	
     
    sets.precast.WS['Aeolian Edge'] = 
{
    ammo="Pemphredo Tathlum",
    head="Jumalik Helm",
    body={ name="Found. Breastplate", augments={'Accuracy+11','Mag. Acc.+10','Attack+10','"Mag.Atk.Bns."+9',}},
    hands={ name="Founder's Gauntlets", augments={'STR+10','Attack+15','"Mag.Atk.Bns."+15','Phys. dmg. taken -5%',}},
    legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+29','Accuracy+24','Accuracy+17 Attack+17','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Crematio Earring",
    right_ear="Friomisi Earring",
    left_ring="Metamor. Ring +1",
    right_ring="Epaminonda's Ring",
    back={ name="Rudianos's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Mag. Evasion+15',}},
}	
 
    --Stat Modifier: 50%MND / 50%STR fTP: 1000:4.0 2000:10.25 3000:13.75
    sets.precast.WS['Savage Blade'] = 
{
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
	body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
    feet="Sulev. Leggings +2",
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	right_ear="Thrud Earring",
    left_ring="Rajas Ring",
    right_ring="Regal Ring",
    back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}},
}

   --Stat Modifier:  80%DEX  fTP:2.25
   sets.precast.WS['Chant du Cygne'] = 
{	
    ammo="Hasty Pinion +1",
    head="Blistering Sallet +1",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Lustratio Leggings +1",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Kentarch Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Rajas Ring",
    right_ring="Regal Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Mag. Evasion+15',}},
}
	
    --Stat Modifier: WS damage + 62/81   2350DMG maxaggro
    sets.precast.WS['Atonement'] = 
{
    ammo="Paeapua",
    head={ name="Loess Barbuta +1", augments={'Path: A',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Yorium Gauntlets", augments={'Enmity+10',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Trux Earring",
    right_ear="Cryptic Earring",
    left_ring="Apeile Ring",
    right_ring="Apeile Ring +1",
    back="Reiki Cloak",
}

    ------------------------------------------------------------------------------------------------
    -----------------------------------------Midcast sets-------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.midcast.FastRecast = 
{
    ammo="Staunch Tathlum",
    head="Jumalik Helm",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet="Chev. Sabatons +1",
    neck="Kgt. Beads +2",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Weard Mantle", augments={'VIT+5','DEX+3','Phalanx +5',}},
}
	
    -- Divine Skill 599/560 140 Acc
    sets.midcast.Divine = 
{

    ammo="Staunch Tathlum",
    head="Jumalik Helm",
    body="Rev. Surcoat +3",
    hands={ name="Eschite Gauntlets", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    legs={ name="Kaiser Diechlings", augments={'Magic dmg. taken -3%','Divine magic skill +5',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Incanter's Torque",
    waist="Asklepian Belt",
    left_ear="Saxnot Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Moonbeam Cape",
}

    sets.midcast.Divine.DT = 
{

    ammo="Staunch Tathlum",
    head="Jumalik Helm",
    body="Rev. Surcoat +3",
    hands={ name="Eschite Gauntlets", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    legs={ name="Kaiser Diechlings", augments={'Magic dmg. taken -3%','Divine magic skill +5',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Incanter's Torque",
    waist="Asklepian Belt",
    left_ear="Saxnot Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Moonbeam Cape",
}

	
	--skill 430
	sets.midcast['Enhancing Magic'] =
{
    ammo="Staunch Tathlum",
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body="Shabti Cuirass",
    hands="Regal Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Merciful Cape",
}

	sets.midcast.MAB = 
{
    ammo="Pemphredo Tathlum",
    head={ name="Odyssean Helm", augments={'Attack+18','"Mag.Atk.Bns."+29','Accuracy+5 Attack+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    body={ name="Found. Breastplate", augments={'Accuracy+11','Mag. Acc.+10','Attack+10','"Mag.Atk.Bns."+9',}},
    hands={ name="Odyssean Gauntlets", augments={'"Mag.Atk.Bns."+29','DEX+9','Accuracy+15 Attack+15','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+29','Accuracy+24','Accuracy+17 Attack+17','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
    neck="Eddy Necklace",
    waist="Orpheus's Sash",
    left_ear="Crematio Earring",
    right_ear="Friomisi Earring",
    left_ring="Metamor. Ring +1",
    right_ring="Metamor. Ring +1",
    back={ name="Rudianos's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Mag. Evasion+15',}},
}

    sets.midcast.Flash = -- 113 to 126
{
    ammo="Paeapua", -- 2
    head={ name="Loess Barbuta +1", augments={'Path: A',}}, -- 19 or 24
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- 20
    hands={ name="Yorium Gauntlets", augments={'Enmity+10',}}, -- 14
    legs={ name="Yorium Cuisses", augments={'Enmity+10',}}, -- 10
    feet={ name="Yorium Sabatons", augments={'Enmity+10',}}, -- 15
    neck={ name="Unmoving Collar +1", augments={'Path: A',}}, -- 10
    waist="Creed Baudrier", -- 5
    left_ear="Tuisto Earring", -- "Trux Earring", 
    right_ear="Cryptic Earring", -- 2
    left_ring="Apeile Ring", -- 5 to 9
    right_ring="Apeile Ring +1", -- 5 to 9
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}}, -- 10
}
	

    sets.midcast.Enlight = sets.midcast.Divine --+95 accu
    sets.midcast['Enlight II'] = sets.midcast.Enlight--+142 accu (+2 acc each 20 divine skill)

    --SIRD 104
    sets.midcast.Reprisal =	
{
	ammo="Staunch Tathlum", -- SID = 10,
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- SID = 20,
    --body=,
    --hands=,
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}}, -- Need
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}}, -- SID = 20
    neck="Moonlight Necklace", -- SID = 15
    waist="Audumbla Sash", -- 10
    --left_ear=,
    right_ear="Knightly Earring", -- SID = 9
    --left_ring="Moonbeam Ring",
    --right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}},
}

    --Phalanx skill 391/386 = Damage-31/31  + (phalanx +equipment) 31/31 total 62/62; after test = 61
	
    sets.midcast.Phalanx = 
{
	sub="Priwen",
	ammo="Staunch Tathlum",
	head={ name="Odyssean Helm", augments={'Mag. Acc.+25','MND+6','Phalanx +5','Accuracy+18 Attack+18',}},
    body={ name="Odyss. Chestplate", augments={'Pet: Mag. Acc.+26','"Fast Cast"+1','Phalanx +5','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs="Sakpata's Cuisses",
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Weard Mantle", augments={'VIT+5','DEX+3','Phalanx +5',}},
}

    sets.midcast.Banish = 
{
    ammo="Pemphredo Tathlum",
    head="Wh. Rarab Cap +1",
    body={ name="Odyss. Chestplate", augments={'Pet: "Subtle Blow"+9','Pet: Mag. Acc.+13 Pet: "Mag.Atk.Bns."+13','"Treasure Hunter"+1',}},
    hands={ name="Founder's Gauntlets", augments={'STR+10','Attack+15','"Mag.Atk.Bns."+15','Phys. dmg. taken -5%',}},
    legs={ name="Odyssean Cuisses", augments={'Pet: "Dbl.Atk."+1 Pet: Crit.hit rate +1','AGI+14','"Treasure Hunter"+2',}},
    feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
    neck="Eddy Necklace",
    waist="Orpheus's Sash",
    left_ear="Crematio Earring",
    right_ear="Friomisi Earring",
    left_ring="Metamor. Ring +1",
    right_ring="Fenian Ring",
    back={ name="Rudianos's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Mag. Evasion+15',}},
}
	
	
    sets.midcast['Banish II'] = set_combine(sets.midcast.MAB, {right_ring="Fenian Ring"})

    sets.midcast.Holy = sets.midcast.MAB
    sets.midcast['Holy II'] = sets.midcast.Holy

    sets.midcast.Crusade = 
{
    ammo="Staunch Tathlum", -- SID = 10, DT = 2
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- SID = 20, BDT = 7, HP = 280
    --body=,
    --hands=,
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},-- 20%-- Need
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}}, -- 20%
    neck="Moonlight Necklace", -- SID = 15
    waist="Audumbla Sash", -- 10
    --left_ear=,
    right_ear="Knightly Earring", -- SID = 9
    --left_ring="Moonbeam Ring",
    --right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}},
}

-- Cure1=120; Cure2=266; Cure3=600; Cure4=1123; cure potency caps at 50/50% received caps at 32/30%. sans signet 
    sets.midcast.Cure = -- SU5 Sword 20% + 32% = 52-53%, SIRD 100%
{
    ammo="Staunch Tathlum", -- SIRD 10%
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- SIRD 20%
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}}, -- Cure Pot 15%
    hands="Macabre Gaunt. +1", -- Cure Pot 11%
    legs="Carmine Cuisses +1", -- Founder's Hose
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},  -- SIRD 20%
    neck="Moonlight Necklace", -- SIRD 15% -- Phalaina Locket
    waist="Audumbla Sash", -- SIRD 10%
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}}, -- Cure Pot 6-7%, Cure Cast - 4%, SIRD 5%
    right_ear="Odnowa Earring  +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}},    -- "Solemnity Cape", -- If I remove SU5 Sword will need Cure Pot 7%
}	

    sets.midcast.Cure.DT = 
{
    ammo="Staunch Tathlum", -- SIRD 10%
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- SIRD 20%
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},
    hands="Macabre Gaunt. +1", -- Cure Pot 11%
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- Founder's Hose
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},  -- Odyssean Greaves
    neck="Moonlight Necklace", -- SIRD 15% -- Phalaina Locket
    waist="Audumbla Sash", -- SIRD 10%
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}}, -- Cure Pot 6-7%, Cure Cast - 4%
    right_ear="Odnowa Earring  +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back="Solemnity Cape",
}
-- 630 HP (curecheat)
	sets.self_healing =
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- SIRD 20%
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}}, -- Jumalik Mail
    hands="Macabre Gaunt. +1",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- Founder's Hose
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},  -- Odyssean Greaves
    neck="Moonlight Necklace", --Phalaina Locket
    waist="Audumbla Sash", -- SIRD 10% -- If enmity is needed "Creed Baudrier",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}},    -- "Solemnity Cape", -- If I remove SU5 Sword will need Cure Pot 7%
}
	
	sets.self_healing.DT =
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},  -- Jumalik Mail
    hands="Macabre Gaunt. +1",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- Founder's Hose
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},  -- Odyssean Greaves
    neck="Phalaina Locket",
    waist="Gishdubar Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back="Solemnity Cape",
}

    sets.midcast.Protect = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Shabti Cuirass",
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},--"Regal Gauntlets",
    legs= { name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet= { name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck= "Incanter's Torque",
    waist= "Olympus Sash",
    left_ear= "Andoaa Earring",
    right_ear="Mimir Earring",
    left_ring="Evanescence Ring",
    right_ring="Sheltered Ring",
    back="Testudo Mantle",
}
    sets.midcast.Shell = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Shabti Cuirass",
    hands="Regal Gauntlets",
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Sheltered Ring",
    back="Solemnity Cape",
}
	sets.midcast.Raise = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Moonlight Necklace",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}	
    sets.midcast.Stun = sets.midcast.Flash
	
	--Spell interupt down (pro shell raise)104/102
	sets.SID =
{
    ammo="Staunch Tathlum", -- SID = 10, DT = 2
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- SID = 20, BDT = 7, HP = 280
    --body=,
    --hands=,
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},-- 20%
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}}, -- 20%
    neck="Moonlight Necklace", -- SID = 15
    waist="Audumbla Sash", -- 10
    --left_ear=,
    right_ear="Knightly Earring", -- SID = 9
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}},
}

	sets.RefreshPotencyRecieved =
{
    hands="Regal Gauntlets",
    feet="Shabti Sabatons +1",
    waist="Gishdubar Sash",
}


---------- NIN Spell	--------------
	sets.midcast.Utsusemi = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Regal Gauntlets",
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

	
---------- BLU Spell	--------------
    sets.midcast['Geist Wall'] =
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}
	

    sets.midcast['Sheep Song'] = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

	
	sets.midcast.Soporific = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

	
	sets.midcast['Stinking Gas'] = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

    
	sets.midcast['Bomb Toss'] = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

	sets.midcast['Jettatura'] = 
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+21','"Fast Cast"+4','STR+11',}},
    neck="Incanter's Torque",
    waist="Audumbla Sash",
    left_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    right_ear="Knightly Earring",
    left_ring="Evanescence Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}	
	
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
	sets.Cover = set_combine(sets.precast.JA['Rampart'], {main="Kheshig Blade", head="Rev. Coronet +3", body="Cab. Surcoat +1"})
    sets.Doom = {neck="Nicander's Necklace", legs="Shabti Cuisses",left_ring="Eshmun's Ring",right_ring="Eshmun's Ring", waist="Gishdubar Sash"} -- +85%
	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}

	sets.Breath =
{
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Volte Sollerets",
    neck="Kgt. Beads +2",
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
   
    sets.resting = 
{
    ammo="Homiliary",
    head={ name="Odyssean Helm", augments={'INT+1','Accuracy+18','"Refresh"+2',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Regal Gauntlets",
    legs={ name="Odyssean Cuisses", augments={'Pet: INT+11','"Mag.Atk.Bns."+18','"Refresh"+2','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
    feet="Volte Sollerets",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}}, --"Creed Collar",
    waist="Fucho-no-Obi",
    left_ear="Infused Earring",
    right_ear="Ethereal Earring",
    left_ring="Sheltered Ring",
    right_ring="Stikini Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
     
    -- Idle sets
    sets.idle = 
{
    ammo="Staunch Tathlum",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Asklepian Belt",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
 
    sets.idle.Town = 
{		

    ammo="Staunch Tathlum",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Asklepian Belt",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
     
    sets.idle.Weak = 
{
	ammo="Staunch Tathlum",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Asklepian Belt",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
	sets.HQ =
{
    sub="Beveler's Shield",
    ammo="Homiliary",
    head="Magnifying Specs.",
    --body="Tanner's Apron",
    --hands="Tanner's Gloves",
    legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    --neck="Tanner's Torque",
    waist="Fucho-no-Obi",
    left_ear="Infused Earring",
    right_ear="Ethereal Earring",
    left_ring="Orvail Ring +1",
    right_ring="Craftmaster's Ring",
    back="Moonbeam Cape",
}
	

    --   Physical
    --     PDT
    --     Aegis
    -- Defense sets
    --   Magical
    --     MDT
    --   Hybrid (on top of either physical or magical)
    --     Repulse  
    --     Reraise
    --     RepulseReraise
    --   Custom
    -- sets.Repulse = {back="Repulse Mantle"}
  --3367 HP   
    sets.defense.PDT = {

    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear. Current gear set is 248/256.
    -- Shellra V can provide 75/256.
    sets.defense.MDT =
{
    ammo="Staunch Tathlum",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

	sets.defense.BDT =
{   

    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Kgt. Beads +2",
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
	right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

	sets.defense.ResistCharm =
{

	ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Asklepian Belt",
    left_ear="Eabani Earring",
    right_ear="Volunt. Earring",
    left_ring="Unyielding Ring",
    right_ring="Wuji Ring",
    back="Solemnity Cape",
}	
	
    sets.defense.Ochain = 
{
    sub="Ochain",
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Flume Belt",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

    sets.defense.Aegis = 
{
    sub="Aegis",
    ammo="Staunch Tathlum",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}	
 
    sets.defense.Srivatsa = 
{
    sub="Srivatsa",
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}}, --"Creed Collar",
    waist="Flume Belt",
    left_ear="Thureous Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

    sets.defense.Priwen = 
{
    sub="Priwen",
    ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}}, --"Creed Collar",
    waist="Flume Belt",
    left_ear="Thureous Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
 
--Doom/RR",

    sets.defense.PDT.Reraise = set_combine(sets.defense.PDT, sets.Reraise)
    sets.defense.Aegis.Reraise = set_combine(sets.defense.Aegis, sets.Reraise)
    sets.defense.MDT.Reraise = set_combine(sets.defense.MDT, sets.Reraise)
    sets.defense.Aegis.Reraise = set_combine(sets.defense.Aegis, sets.Reraise)

    sets.defense.PDT.Doom = set_combine(sets.defense.PDT, sets.Doom)
    sets.defense.Aegis.Doom = set_combine(sets.defense.Aegis, sets.Doom)
    sets.defense.MDT.Doom = set_combine(sets.defense.PDT, sets.Doom)
    sets.defense.Aegis.Doom = set_combine(sets.defense.Aegis, sets.Doom)

    sets.Kiting = {legs="Carmine Cuisses +1"}

 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = --1124 / 1264 avec enlight up
{
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	feet="Sakpata's Leggings",
    neck="Vim Torque +1",--{ name="Unmoving Collar +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Mag. Evasion+15',}},
}
 
    sets.engaged.Acc = --1199 / 1341 avec enlight up
{
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	feet="Sakpata's Leggings",
    neck="Combatant's Torque",--{ name="Unmoving Collar +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Mag. Evasion+15',}},
}
end
------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------Job-specific hooks that are called to process player actions at specific points in time-----------
------------------------------------------------------------------------------------------------------------------------------------------
 

 
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
     
    return idleSet
end
 
 
 
function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
     
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
     
    return defenseSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- General hooks for change events.
-------------------------------------------------------------------------------------------------------------------
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
 refine_various_spells(spell, action, spellMap, eventArgs)
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
 
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
 
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
 
    return idleSet
end
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    return meleeSet
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
 
        --print( buff )
        --print( state.Buff[buff] )
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end
-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    if field == 'HybridDefenseMode' then
        classes.CustomDefenseGroups:clear()
        classes.CustomDefenseGroups:append(new_value)
    end
end
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
 
end
function update_defense_mode()
    if player.equipment.main == 'Burtgang' and not classes.CustomDefenseGroups:contains('Burtgang') then
        classes.CustomDefenseGroups:append('Burtgang')
    end
     
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:endswith('Shield') and
        player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
        state.CombatForm = 'DW'
        else
        state.CombatForm = nil
        end
    end
end

function job_buff_change(buff, gain)
        if buff == "Cover" then
                if gain then
                        equip (sets.Cover)
                        disable('Body','Head')
                else
                        enable('Body','Head')
                        handle_equipping_gear(player.status)
                end
        elseif buff == "doom" then
                if gain then           
                        equip(sets.Doom)
                        send_command('@input /p Doomed, please Cursna.')
                        send_command('@input /item "Holy Water" <me>')					
                        disable('neck','legs','ring1','ring2','waist')
                elseif not gain and not player.status == "Dead" and not player.status == "Engaged Dead" then
                        enable('neck','legs','ring1','ring2','waist')
                        send_command('input /p Doom removed, Thank you.')
                        handle_equipping_gear(player.status)
                else
                        enable('neck', 'legs','ring1','ring2','waist')
                        send_command('input /p '..player.name..' is no longer Doom Thank you !')
                end
				 elseif buff == "petrification" then
                if gain then    
						equip(sets.Petri)
                        send_command('@input /p Petrification, please Stona.')		
				else
                        send_command('input /p '..player.name..' is no longer Petrify Thank you !')
					end
				 elseif buff == "Charm" then
				 if gain then  			
                        send_command('@input /p Charmed, please Sleep me.')		
				else	
                        send_command('input /p '..player.name..' is no longer Charmed, please wake me up!')
					end
				elseif buff == "paralysis" then
                 if gain then
                        
                        send_command('@input /p '..player.name..' Paralysed, please Paralyna.')
						send_command('@input /item "Remedy" <me>')	
                else                        
                        send_command('input /p '..player.name..' is no longer Paralysed Thank you !')
                    end	
				elseif buff == "Silence" then
                 if gain then
                        
                        send_command('@input /p '..player.name..' Silence, please Silena.')
						send_command('@input /item "Remedy" <me>')	
                else                        
                        send_command('input /p '..player.name..' is no longer Silenced Thank you !')
                    end

        end
	for index,value in pairs(buffWatcher.watchList) do
    if index==buff then
      buffWatch()
      break
    end
  end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 13)
	elseif player.sub_job == 'WAR' then
        set_macro_page(1, 13)	
	elseif player.sub_job == 'BLU' then
        set_macro_page(1, 13)	
    else
        set_macro_page(1, 13)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  if spellMap == 'Cure' and spell.target.type == 'SELF' then
    if options.CastingModes.value == 'DT' then
      equip(sets.self_healing.DT)
    else
      equip(sets.self_healing)
  end
end
  end


function job_self_command(cmdParams, eventArgs)
if cmdParams[1] == 'buffWatcher' then
      buffWatch(cmdParams[2],cmdParams[3])
  end
  if cmdParams[1] == 'stopBuffWatcher' then
      stopBuffWatcher()
  end
end


-- Spell swap rules
function refine_various_spells(spell,action,spellMap,eventArgs)
 	cures = S{'Cure','Cure II','Cure III','Cure IV'}
	ban = S{'Banish','Banish II'}
	blus = S{"Geist Wall","Sheep Song","Stinking Gas"} 
      if not cures:contains(spell.english) 
			and not ban:contains(spell.english)
			and not blus:contains(spell.english)then 
			return
    end 

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'

    if spell_recasts[spell.recast_id] > 0 then
        if cures:contains(spell.english) then
            if spell.english == 'Cure' then
			    add_to_chat(122,cancelling)
                eventArgs.cancel = true
            return
            elseif spell.english == 'Cure II' then
                newSpell = 'Cure'
            elseif spell.english == 'Cure III' then
                newSpell = 'Cure II'
            elseif spell.english == 'Cure IV' then
                newSpell = 'Cure III'
            end 
        elseif ban:contains(spell.english) then
            if spell.english == 'Banish' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
            return
            elseif spell.english == 'Banish II' then
                newSpell = 'Banish'
            end
         elseif blus:contains(spell.english) then
            if spell.english == "Geist Wall" then
				add_to_chat(122,cancelling)
                eventArgs.cancel = true
            return
            elseif spell.english == "Geist Wall" then
                newSpell = "Sheep Song"
            elseif spell.english == "Sheep Song" then
                newSpell = "Stinking Gas"
            elseif spell.english == "Stinking Gas" then
                newSpell = "Geist Wall"
            end	
	
			
        end
    end

	if newSpell ~= spell.english then
        send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
		add_to_chat(122,cancelling)
        eventArgs.cancel = true
        return
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
	add_to_chat (55, 'Slip: 18, 23')
end
