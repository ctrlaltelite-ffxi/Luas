
function get_sets()
  -- include('organizer-lib')
  -- user_unload()
  -- user_setup()
  -- gearSets()
  -- setDefaults()
  createInfoBox()
  -- getItemCount()
  
end

function createInfoBox()
  if infoBox then infoBox:destroy() end
  local windowersettings = windower.get_windower_settings()
	local x,y = 10, windowersettings["ui_y_res"]-17

  infoBox = texts.new()
  infoBox:pos(x,y)
  infoBox:font('Arial')
  infoBox:size(11)
  infoBox:bold(true)
  infoBox:bg_alpha(0)
  infoBox:right_justified(false)
  infoBox:stroke_width(2)
  infoBox:stroke_transparency(192)
  updateInfoBox(infoBox)
end

function updateInfoBox()
	local player = windower.ffxi.get_player()
	if not player then return end

  infoBox:clear()
  infoBox:append('  ')
  infoBox:append(createInfoSet('Set','FullDD','blue'))
  infoBox:append(createInfoSet('Haste','20%','blue'))
  infoBox:append(createInfoSet('Set','FullDD','green'))
  infoBox:append(createInfoSet('Set','FullDD','blue'))
  infoBox:append(createInfoSet('Set','FullDD','blue'))
  infoBox:append(createInfoSet('Set','FullDD','red'))
  infoBox:show()
end

function createInfoSet(label,body,color)
  local colOptions = {
    white='\\cs(255,255,255)',
    yellow='\\cs(204, 204, 0)', 
    green='\\cs(0, 204, 0)',
    red='\\cs(204, 0, 0)',
    blue='\\cs(0, 204, 204)',
  }
  return colOptions.white..label..': '..colOptions[color]..body..'  '
end