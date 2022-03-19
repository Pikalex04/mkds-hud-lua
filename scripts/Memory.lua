Memory = {
  E = 0x50434d41, --AMCP
  U = 0x45434d41, --AMCE
  J = 0x4A434d41, --AMCJ
  version = 0,
  CTGP = false
}

Memory.variable = {
  lap = {address = {0x217B87C, 0x217B85C, 0x217B8FC, 0x217B87C}, size = 1},
  totallaps = {address = {0x217B884, 0x217B864, 0x217B904, 0x217B884}, size = 1},
  finished_run = {address = {0x217ACAC, 0x217AC8C, 0x217AD2C, 0x217ACAC}, size = 1},

  fade = {address = {0x21755B0, 0x2175590, 0x2175630, 0x21755B0}, size = 2},

  aspect_ratio = {address = {0x20775D0, 0x20775D0, 0x2077710, 0x20775D0}, size = 4},
  hud_aspect_ratio = {address = {0x208A068, 0x208A068, 0x208A1A8, 0x208A068}, size = 2},
  live_ghost = {address = {0x23CDD54, 0x23CDD54, 0x23CD394, 0x23CF774}, size = 4},
  always_100_cc = {address = {0x23CDCE8, 0x23CDCE8, 0x23CDCE8, 0x23CF708}, size = 4},
  ghost_input = {address = {0x2175686, 0x2175666, 0x2175706, 0x2175686}, size = 2},
  no_ghost_flicker = {address = {0x217AD18, 0x217ACF8, 0x217AD98, 0x217AD18}, size = 4},
  unlock_everything = {address = {0x23CE2E0, 0x23CE2E0, 0x23CE2E0, 0x23CE2E0}, size = 4},
  replay_camera = {address = {0x2040CEC, 0x2040CEC, 0x2040C88, 0x2040CEC}, size = 1},
  
  always_global_map1 = {address = {0x217AD18, 0x217ACF8, 0x217AD98, 0x217AD18}, size = 4},
  always_global_map2 = {address = {0x217B9F0, 0x217B9D0, 0x217BA70, 0x217B9F0}, size = 4},
  always_global_map3 = {address = {0x217B350, 0x217B330, 0x217B3D0, 0x217B350}, size = 4},
  
  free_fly_camera1 = {address = {0x217AD18, 0x217ACFA, 0x217ACFA, 0x217AD18}, size = 4},
  free_fly_camera2 = {address = {0x214ACB4, 0x214ACB4, 0x214ACB4, 0x214ACB4}, size = 2},
  free_fly_camera3 = {address = {0x217AA6C, 0x217AA6C, 0x217AA6C, 0x217AA6C}, size = 4},
  
  force_finish_race = {address = {0x217561C, 0x21755FC, 0x217569C, 0x217561C}, size = 4},
  
  music1 = {address = {0x217D9DC, 0x217D9BC, 0x217DA74, 0x217D9DC}, size = 4},
  music2 = {address = {0x217DA00, 0x217D9E0, 0x217DA98, 0x217DA00}, size = 4},

  hud_lapcount = {address = {0x20BC244, 0x20BC244, 0x20BC384, 0x20BC244}, size = 1},
  hud_item = {address = {0x20BA6B8, 0x20BA6B8, 0x20BA7F8, 0x20BA6B8}, size = 1},
  hud_player = {address = {0x20B9E24, 0x20B9E24, 0x20B9F64, 0x20B9E24}, size = 1},
  hud_timer = {address = {0x20BB654, 0x20BB654, 0x20BB794, 0x20BB654}, size = 1},
  hud_final_time = {address = {0x20D06E0, 0x20D06E0, 0x20D0820, 0x20D06E0}, size = 1}

}

function Memory.setVersion()
  if memory.readdword(0x02FC7ADC) == 0x746C6183 then -- CTGP Nitro
    Memory.CTGP = true
  end
  Memory.version = memory.readdword(0x023FFA8C)
end

function Memory.getPointers()
  if Memory.version == Memory.E then
    return {memory.readdword(0x021661B0), memory.readdword(0x0217AD18), memory.readdword(0x0217BC4C)}
  elseif Memory.version == Memory.U then
    return {memory.readdword(0x021661B0), memory.readdword(0x0217ACF8), memory.readdword(0x0217BC2C)}
  else --J
    return {memory.readdword(0x021662D0), memory.readdword(0x0217AD98), memory.readdword(0x0217BCCC)}
  end
end

function Memory.readVariable(variable)
  local addr = 0
  if Memory.version == Memory.E then
    if Memory.CTGP then -- CTGP Nitro
      addr = variable.address[4]
	else
	  addr = variable.address[1]
	end
  elseif Memory.version == Memory.U then addr = variable.address[2]
  else addr = variable.address[3] -- J
  end

  if variable.size == 1 then
    return memory.readbytesigned(addr)
  elseif variable.size == 2 then
    return memory.readwordsigned(addr)
  else -- 4
    return memory.readdword(addr)
  end
end

function Memory.writeVariable(variable, value)
  local addr = 0
  if Memory.version == Memory.E then
    if Memory.CTGP then -- CTGP Nitro
      addr = variable.address[4]
	else
	  addr = variable.address[1]
	end
  elseif Memory.version == Memory.U then addr = variable.address[2]
  else addr = variable.address[3] -- J
  end

  if variable.size == 1 then
    return memory.writebyte(addr, value)
  elseif variable.size == 2 then
    return memory.writeword(addr, value)
  else -- 4
    return memory.writedword(addr, value)
  end
end

function Memory.returnAddress(variable)
  local addr = 0
  if Memory.version == Memory.E then
    if Memory.CTGP then -- CTGP Nitro
      addr = variable.address[4]
	else
	  addr = variable.address[1]
	end
  elseif Memory.version == Memory.U then
    addr = variable.address[2]
  else
    addr = variable.address[3] -- J
  end
  return(addr)
end
