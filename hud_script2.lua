-- Scripts made by Pikalex and MKDasher
-- Version: 2.2

dofile "scripts/json.lua"
dofile "scripts/Utils.lua"
dofile "scripts/Memory.lua"
dofile "scripts/Input.lua"
dofile "scripts/Config.lua"
dofile "scripts/Bitmap.lua"
dofile "scripts/Program.lua"
dofile "scripts/Display.lua"
dofile "scripts/CustomHud.lua"
dofile "scripts/Actions.lua"
dofile "scripts/MarioFont.lua"

local dataBuffer = {nil,nil,nil}
local pointer = {0,0,0}

Config.load()
Bitmap.loadAllBitmaps()

function fn()
  Memory.setVersion()
  pointer = Memory.getPointers()
  if emu.framecount() > 60 then -- prevent crash
    dataBuffer = Program.main(pointer, dataBuffer)
  end
end

function fm()
  if Config.Settings.HUD_SETTINGS.green_screen_touchscreen then
    gui.box(0, 0, 640, 640, "#00ff00", "#00ff00")
  end
  Input.update()
  if Config.EDIT_CUSTOM_HUD.enabled then gui.box(0,-Config.SCREEN_SIZE.height, Config.SCREEN_SIZE.width, 0, "#00000044", "#00000044") end
  local showHUD = pointer[2] ~= 0 and dataBuffer[1] ~= nil
  Display.displayHUD(dataBuffer, showHUD)
  Display.displayEditMenu(Config.SCREEN_SIZE)
  Display.displayRamData(dataBuffer, pointer)
end

emu.registerafter(fn)
gui.register(fm)
