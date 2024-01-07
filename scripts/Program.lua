Program = {

}

function Program.main(pointer, dataBuffer)
  if Program.isTimeTrials() then
    Program.disableHUD()
    Program.disableMusic()
    Program.wideScreen()
    Program.liveGhost()
    Program.always100cc()
    Program.unlockEverything()
    Program.alwaysGlobalMap()
    Program.forceFinishRace()
    Program.replayCamera()
    Program.replayAsGhost()
    Program.executeActions()
  end

  data = {}

  if pointer[2] == 0 then
    data = nil
  else
    data.prb = memory.readbyteunsigned(pointer[2] + 0x4B)
    data.prb = bit.rshift(bit.band(data.prb, 32), 5)
    data.speed = memory.readbytesigned(pointer[2] + 0x45E)
    data.boost = memory.readbytesigned(pointer[2] + 0x238)
    data.boost_mt = memory.readbytesigned(pointer[2] + 0x23C)
    data.shroom = memory.readbytesigned(pointer[3] + 0x54)
    data.lap = Memory.readVariable(Memory.variable.lap)
    data.totallaps = Memory.readVariable(Memory.variable.totallaps)
    data.time_total = memory.readdword(pointer[1] + 0xD68)
	if Memory.CTGP then
	  data.time_lap = memory.readdword(pointer[1] + 0x9E8C)
	else
	  data.time_lap = memory.readdword(pointer[1] + 0xD80)
	end
    data.finished_run = Memory.readVariable(Memory.variable.finished_run)
    data.ghost_input = Memory.readVariable(Memory.variable.ghost_input)
    data.fade = Memory.readVariable(Memory.variable.fade)

    data.checkpoint = memory.readbytesigned(pointer[1] + 0xDAE)
  	data.keycheckpoint = memory.readbytesigned(pointer[1] + 0xDB0)

  	data.position = {}
  	data.position.x = memory.readdwordsigned(pointer[2] + 0x80)
  	data.position.y = memory.readdwordsigned(pointer[2] + 0x88)
  	data.position.z = memory.readdwordsigned(pointer[2] + 0x84)
  	data.real_speed = memory.readdwordsigned(pointer[2] + 0x2A8) / 360

    data.current_timer = Program.readTimer(pointer[1] + 0xD70)
    data.lap_timer = {}
    for i = 1, data.totallaps, 1 do
        data.lap_timer[i] = Program.readTimer(pointer[1] + 0xD88 + 4 * (i-1))
      end
    data.final_timer = Program.readTimer(pointer[1] + 0xD9C)

    if Program.isTimeTrials() then
      Program.noGhostFlickering()
      Program.removeReplayGhost()
    end
  end

  if dataBuffer[1] == nil then
    table.insert(dataBuffer, data)
    table.insert(dataBuffer, data)
    table.insert(dataBuffer, data)
  end

  table.insert(dataBuffer, data)
  table.remove(dataBuffer, 1)

  if dataBuffer[2] ~= nil and dataBuffer[3] ~= nil then
	 dataBuffer[3].real_speed = math.sqrt((dataBuffer[3].position.y - dataBuffer[2].position.y) * (dataBuffer[3].position.y - dataBuffer[2].position.y) + (dataBuffer[3].position.x - dataBuffer[2].position.x) * (dataBuffer[3].position.x - dataBuffer[2].position.x))
  end

  return dataBuffer
end

function Program.executeActions()
  local actions_size, actions_keys = Utils.getTableSizeAndKeys(Actions.Items)
  local actions_buttontypes = {}

  for i = 1, actions_size, 1 do
    Actions.Items[actions_keys[i]].execute()
  end
end

function Program.wideScreen()

  base_ratio = 5461
  local aspect_ratio = Config.Settings.AR_MENU.widescreen and "16:9" or "4:3"

  if aspect_ratio == nil or aspect_ratio == "original" or aspect_ratio == "native" or aspect_ratio == "4:3" then
    Memory.writeVariable(Memory.variable.aspect_ratio, base_ratio)
    Memory.writeVariable(Memory.variable.hud_aspect_ratio, 1794)
    return
  elseif aspect_ratio == "wide" or aspect_ratio == "widescreen" or aspect_ratio == "16:9" then
    Memory.writeVariable(Memory.variable.aspect_ratio, 0x1C71)
    Memory.writeVariable(Memory.variable.hud_aspect_ratio, 2730)
    return
  end

  if aspect_ratio == string.match(aspect_ratio, '%d+:%d+') then
    ratio = {}
    for k in string.gmatch(aspect_ratio, '%d+') do
      table.insert(ratio, tonumber(k))
    end
    if ratio[2] == 0 then
      Memory.writeVariable(Memory.variable.aspect_ratio, base_ratio)
    else
      new_ratio = math.floor(base_ratio * 3 * ratio[1] / 4 / ratio[2])
      Memory.writeVariable(Memory.variable.aspect_ratio, new_ratio)
    end
  else
    Memory.writeVariable(Memory.variable.aspect_ratio, base_ratio)
  end

end

function Program.disableHUD()
  Memory.writeVariable(Memory.variable.hud_lapcount, Config.Settings.ORIGINAL_HUD.lap_counter and 1 or 0)
  Memory.writeVariable(Memory.variable.hud_item, Config.Settings.ORIGINAL_HUD.item_roulette and 1 or 0)
  Memory.writeVariable(Memory.variable.hud_player, Config.Settings.ORIGINAL_HUD.player_position and 1 or 0)
  Memory.writeVariable(Memory.variable.hud_timer, Config.Settings.ORIGINAL_HUD.timer and 1 or 0)
  Memory.writeVariable(Memory.variable.hud_final_time, Config.Settings.ORIGINAL_HUD.final_time and 1 or 0)
end

function Program.liveGhost()
  Memory.writeVariable(Memory.variable.live_ghost, Config.Settings.AR_MENU.live_ghost and 1 or 0)
end

function Program.disableMusic()
  music_value = 0x7f
  if Config.Settings.AR_MENU.disable_music then music_value = 0 end
  Memory.writeVariable(Memory.variable.music1, music_value)
  Memory.writeVariable(Memory.variable.music2, music_value)
end

function Program.readTimer(offset)
  if Memory.CTGP then
    offset = offset + 0x910C
  end
  minutes = memory.readbyte(offset + 2)
  seconds = memory.readbyte(offset + 3)
  milisecs = memory.readword(offset)

  minutes = (" " .. tostring(minutes)):sub(-2,-1)
  seconds = ("00" .. tostring(seconds)):sub(-2,-1)
  milisecs = ("000" .. tostring(milisecs)):sub(-3,-1)

  return minutes .. ":" .. seconds .. ":" .. milisecs
end

function Program.always100cc()
  Memory.writeVariable(Memory.variable.always_100_cc, Config.Settings.AR_MENU.always_100_cc and 1 or 2)
end

function Program.noGhostFlickering()
  if Config.Settings.AR_MENU.no_ghost_flickering then
    address = Memory.readVariable(Memory.variable.no_ghost_flicker) + 0x5A8 + 0x384
    memory.writebyte(address, 1)
  end
end

function Program.unlockEverything()
  if Config.Settings.AR_MENU.unlock_everything then
    Memory.writeVariable(Memory.variable.unlock_everything, 0x7FFFFFF)
  end
end

function Program.alwaysGlobalMap()
  if Config.Settings.AR_MENU.always_global_map then
    if Memory.readVariable(Memory.variable.always_global_map1) > 0 then
	  if Memory.readVariable(Memory.variable.always_global_map2) < 2 then
		address = Memory.readVariable(Memory.variable.always_global_map3)
		memory.writebyte(address + 2088, 0)
		memory.writebyte(address + 2092, 1)
	  end
	end
  end
end

function Program.forceFinishRace()
  if Config.Settings.AR_MENU.force_finish_race then
    address = Memory.readVariable(Memory.variable.force_finish_race)
    memory.writeword(address + 14, 8)
    memory.writebyte(address + 20, 1)
  end
end

function Program.replayCamera()
  Memory.writeVariable(Memory.variable.replay_camera, Config.Settings.AR_MENU.replay_camera and 0 or 1)
end

function Program.removeReplayGhost()
  if Config.Settings.AR_MENU.remove_replay_ghost then
    address = Memory.readVariable(Memory.variable.remove_replay_ghost) + 0x5A8 + 0x80
    memory.writedword(address, 0x80000000)
    memory.writedword(address + 4, 0x10000000)
    memory.writedword(address + 8, 0x80000000)
  end
end

function Program.replayAsGhost()
  Memory.writeVariable(Memory.variable.replay_as_ghost, Config.Settings.AR_MENU.replay_as_ghost and 2 or 0)
end

function Program.isTimeTrials()
  return Memory.readVariable(Memory.variable.gamemode) == 1
end