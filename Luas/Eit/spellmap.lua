
----------------------------------------------------------------------------
-- Spell Mapping to Categorize
-- As new spells are added, this will have to be updated
----------------------------------------------------------------------------
  
spell_map = {
  ["Absorb-Acc"]='Absorb',
  ["Absorb-Agi"]='Absorb',
  ["Absorb-Attri"]='Absorb',
  ["Absorb-Chr"]='Absorb',
  ["Absorb-Dex"]='Absorb',
  ["Absorb-Int"]='Absorb',
  ["Absorb-Mnd"]='Absorb',
  ["Absorb-Str"]='Absorb',
  ["Absorb-TP"]='Absorb',
  ["Absorb-Vit"]='Absorb',
  ["Aspir"]='Aspir',
  ["Aspir II"]='Aspir',
  ["Aspir III"]='Aspir',
  ["Mage's Ballad"]='Ballad',
  ["Mage's Ballad II"]='Ballad',
  ["Mage's Ballad III"]='Ballad',
  ["Banish"]='Banish',
  ["Banish II"]='Banish',
  ["Banish III"]='Banish',
  ["Banishga"]='Banish',
  ["Banishga II"]='Banish',
  ["Baraera"]='BarElement',
  ["Baraero"]='BarElement',
  ["Barblizzara"]='BarElement',
  ["Barblizzard"]='BarElement',
  ["Barfira"]='BarElement',
  ["Barfire"]='BarElement',
  ["Barstone"]='BarElement',
  ["Barstonra"]='BarElement',
  ["Barthunder"]='BarElement',
  ["Barthundra"]='BarElement',
  ["Barwater"]='BarElement',
  ["Barwatera"]='BarElement',
  ["Dark Carol"]='Carol',
  ["Dark Carol II"]='Carol',
  ["Earth Carol"]='Carol',
  ["Earth Carol II"]='Carol',
  ["Fire Carol"]='Carol',
  ["Fire Carol II"]='Carol',
  ["Ice Carol"]='Carol',
  ["Ice Carol II"]='Carol',
  ["Light Carol"]='Carol',
  ["Light Carol II"]='Carol',
  ["Lightning Carol"]='Carol',
  ["Lightning Carol II"]='Carol',
  ["Water Carol"]='Carol',
  ["Water Carol II"]='Carol',
  ["Wind Carol"]='Carol',
  ["Wind Carol II"]='Carol',
  ["Cura"]='Curaga',
  ["Cura II"]='Curaga',
  ["Cura III"]='Curaga',
  ["Curaga"]='Curaga',
  ["Curaga II"]='Curaga',
  ["Curaga III"]='Curaga',
  ["Curaga IV"]='Curaga',
  ["Curaga V"]='Curaga',
  ["Cure"]='Cure',
  ["Cure II"]='Cure',
  ["Cure III"]='Cure',
  ["Cure IV"]='Cure',
  ["Cure V"]='Cure',
  ["Cure VI"]='Cure',
  ["Full Cure"]='Cure',
  ["Drain"]='Drain',
  ["Drain II"]='Drain',
  ["Drain III"]='Drain',
  ["Battlefield Elegy"]='Elegy',
  ["Carnage Elegy"]='Elegy',
  ["Burn"]='ElementalEnfeeble',
  ["Choke"]='ElementalEnfeeble',
  ["Drown"]='ElementalEnfeeble',
  ["Frost"]='ElementalEnfeeble',
  ["Rasp"]='ElementalEnfeeble',
  ["Shock"]='ElementalEnfeeble',
  ["Doton: Ichi "]='ElementalNinjutsu',
  ["Doton: Ni "]='ElementalNinjutsu',
  ["Doton: San "]='ElementalNinjutsu',
  ["Huton: Ichi "]='ElementalNinjutsu',
  ["Huton: Ni "]='ElementalNinjutsu',
  ["Huton: San "]='ElementalNinjutsu',
  ["Hyoton: Ichi "]='ElementalNinjutsu',
  ["Hyoton: Ni "]='ElementalNinjutsu',
  ["Hyoton: San "]='ElementalNinjutsu',
  ["Katon: Ichi "]='ElementalNinjutsu',
  ["Katon: Ni "]='ElementalNinjutsu',
  ["Katon: San "]='ElementalNinjutsu',
  ["Raiton: Ichi "]='ElementalNinjutsu',
  ["Raiton: Ni "]='ElementalNinjutsu',
  ["Raiton: San "]='ElementalNinjutsu',
  ["Suiton: Ichi "]='ElementalNinjutsu',
  ["Suiton: Ni "]='ElementalNinjutsu',
  ["Suiton: San "]='ElementalNinjutsu',
  ["Endark"]='Endark',
  ["Endark II"]='Endark',
  ["Deodorize"]='Enhancing',
  ["Invisible"]='Enhancing',
  ["Sneak"]='Enhancing',
  ["Enlight"]='Enlight',
  ["Enlight II"]='Enlight',
  ["Bewitching Etude"]='Etude',
  ["Dextrous Etude"]='Etude',
  ["Enchanting Etude"]='Etude',
  ["Herculean Etude"]='Etude',
  ["Learned Etude"]='Etude',
  ["Logical Etude"]='Etude',
  ["Quick Etude"]='Etude',
  ["Sage Etude"]='Etude',
  ["Sinewy Etude"]='Etude',
  ["Spirited Etude"]='Etude',
  ["Swift Etude"]='Etude',
  ["Uncanny Etude"]='Etude',
  ["Vital Etude"]='Etude',
  ["Vivacious Etude"]='Etude',
  ["Magic Finale"]='Finale',
  ["Haste"]='Haste',
  ["Haste II"]='Haste',
  ["Anemohelix"]='Helix',
  ["Anemohelix II"]='Helix',
  ["Cryohelix"]='Helix',
  ["Cryohelix II"]='Helix',
  ["Geohelix"]='Helix',
  ["Geohelix II"]='Helix',
  ["Hydrohelix"]='Helix',
  ["Hydrohelix II"]='Helix',
  ["Ionohelix"]='Helix',
  ["Ionohelix II"]='Helix',
  ["Luminohelix"]='Helix',
  ["Luminohelix II"]='Helix',
  ["Noctohelix"]='Helix',
  ["Noctohelix II"]='Helix',
  ["Pyrohelix"]='Helix',
  ["Pyrohelix II"]='Helix',
  ["Holy"]='Holy',
  ["Holy II"]='Holy',
  ["Foe Lullaby"]='Lullaby',
  ["Foe Lullaby II"]='Lullaby',
  ["Horde Lullaby"]='Lullaby',
  ["Horde Lullaby II"]='Lullaby',
  ["Blade Madrigal"]='Madrigal',
  ["Sword Madrigal"]='Madrigal',
  ["Dragonfoe Mambo"]='Mambo',
  ["Sheepfoe Mambo"]='Mambo',
  ["Dark Maneuver"]='Maneuver',
  ["Earth Maneuver"]='Maneuver',
  ["Fire Maneuver"]='Maneuver',
  ["Ice Maneuver"]='Maneuver',
  ["Light Maneuver"]='Maneuver',
  ["Thunder Maneuver"]='Maneuver',
  ["Water Maneuver"]='Maneuver',
  ["Wind Maneuver"]='Maneuver',
  ["Advancing March"]='March',
  ["Honor March"]='March',
  ["Victory March"]='March',
  ["Chocobo Mazurka"]='Mazurka',
  ["Raptor Mazurka"]='Mazurka',
  ["Knight's Minne"]='Minne',
  ["Knight's Minne II"]='Minne',
  ["Knight's Minne III"]='Minne',
  ["Knight's Minne IV"]='Minne',
  ["Knight's Minne V"]='Minne',
  ["Valor Minuet"]='Minuet',
  ["Valor Minuet II"]='Minuet',
  ["Valor Minuet III"]='Minuet',
  ["Valor Minuet IV"]='Minuet',
  ["Valor Minuet V"]='Minuet',
  ["Army's Paeon"]='Paeon',
  ["Army's Paeon II"]='Paeon',
  ["Army's Paeon III"]='Paeon',
  ["Army's Paeon IV"]='Paeon',
  ["Army's Paeon V"]='Paeon',
  ["Army's Paeon VI"]='Paeon',
  ["Archer's Prelude"]='Prelude',
  ["Hunter's Prelude"]='Prelude',
  ["Protect"]='Protect',
  ["Protect II"]='Protect',
  ["Protect III"]='Protect',
  ["Protect IV"]='Protect',
  ["Protect V"]='Protect',
  ["Protectra"]='Protect',
  ["Protectra II"]='Protect',
  ["Protectra III"]='Protect',
  ["Protectra IV"]='Protect',
  ["Protectra V"]='Protect',
  ["Arise"]='Raise',
  ["Raise"]='Raise',
  ["Raise II"]='Raise',
  ["Raise III"]='Raise',
  ["Reraise"]='Raise',
  ["Reraise II"]='Raise',
  ["Reraise III"]='Raise',
  ["Reraise IV"]='Raise',
  ["Refresh"]='Refresh',
  ["Refresh II"]='Refresh',
  ["Refresh III"]='Refresh',
  ["Regen"]='Regen',
  ["Regen II"]='Regen',
  ["Regen III"]='Regen',
  ["Regen IV"]='Regen',
  ["Regen V"]='Regen',
  ["Foe Requiem"]='Requiem',
  ["Foe Requiem II"]='Requiem',
  ["Foe Requiem III"]='Requiem',
  ["Foe Requiem IV"]='Requiem',
  ["Foe Requiem V"]='Requiem',
  ["Foe Requiem VI"]='Requiem',
  ["Foe Requiem VII"]='Requiem',
  ["Shell"]='Shell',
  ["Shell II"]='Shell',
  ["Shell III"]='Shell',
  ["Shell IV"]='Shell',
  ["Shell V"]='Shell',
  ["Shellra"]='Shell',
  ["Shellra II"]='Shell',
  ["Shellra III"]='Shell',
  ["Shellra IV"]='Shell',
  ["Shellra V"]='Shell',
  ["Blindna"]='StatusRemoval',
  ["Cursna"]='StatusRemoval',
  ["Erase"]='StatusRemoval',
  ["Paralyna"]='StatusRemoval',
  ["Poisona"]='StatusRemoval',
  ["Silena"]='StatusRemoval',
  ["Stona"]='StatusRemoval',
  ["Viruna"]='StatusRemoval',
  ["Aurorastorm"]='Storm',
  ["Aurorastorm II"]='Storm',
  ["Firestorm"]='Storm',
  ["Firestorm II"]='Storm',
  ["Hailstorm"]='Storm',
  ["Hailstorm II"]='Storm',
  ["Rainstorm"]='Storm',
  ["Rainstorm II"]='Storm',
  ["Sandstorm"]='Storm',
  ["Sandstorm II"]='Storm',
  ["Thunderstorm"]='Storm',
  ["Thunderstorm II"]='Storm',
  ["Voidstorm"]='Storm',
  ["Voidstorm II"]='Storm',
  ["Windstorm"]='Storm',
  ["Windstorm II"]='Storm',
  ["Recall-Jugner"]='Teleport',
  ["Recall-Meriph"]='Teleport',
  ["Recall-Pashh"]='Teleport',
  ["Teleport-Altep"]='Teleport',
  ["Teleport-Dem"]='Teleport',
  ["Teleport-Holla"]='Teleport',
  ["Teleport-Mea"]='Teleport',
  ["Teleport-Vahzl"]='Teleport',
  ["Teleport-Yhoat"]='Teleport',
  ["Dark Threnody"]='Threnody',
  ["Dark Threnody II"]='Threnody',
  ["Earth Threnody"]='Threnody',
  ["Earth Threnody II"]='Threnody',
  ["Fire Threnody"]='Threnody',
  ["Fire Threnody II"]='Threnody',
  ["Ice Threnody"]='Threnody',
  ["Ice Threnody II"]='Threnody',
  ["Light Threnody"]='Threnody',
  ["Light Threnody II"]='Threnody',
  ["Lightning Threnody"]='Threnody',
  ["Lightning Threnody II"]='Threnody',
  ["Water Threnody"]='Threnody',
  ["Water Threnody II"]='Threnody',
  ["Wind Threnody"]='Threnody',
  ["Wind Threnody II"]='Threnody',
  ["Utsusemi: Ichi"]='Utsusemi',
  ["Utsusemi: Ni"]='Utsusemi',
  ["Utsusemi: San"]='Utsusemi',
  -- ["Pining Nocturne"]='Finale',
  ["Adventurer's Dirge"]='Dirge',
  ["Sentinel's Scherzo"]='Scherzo',
  ["Foe Sirvente"]='Sirvente',
}

-- Spells that require no Skill
white_Magic_noSkill = S{'Haste','Refresh','Regen','Protect','Shell','Raise','Enhancing'}

-- Songs that are used to Debuff
songDebuff = S{'Requiem','Threnody','Elegy','Finale','Lullaby'}

