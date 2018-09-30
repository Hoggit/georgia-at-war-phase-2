-- AFTER GAW.LUA, SPAWNS.LUA, UTIL.LUA
-- BEFORE COMMANDER.LUA

local spawnedVIPs = {}

SpawnVIP = function()
  local vipGrp = randomFromList(VIPSpawns)
  local spawner = Spawner(vipGrp)
  local zone = GetRandomVIPSpawnZone()
  MessageToAll("Spawning a VIP at " .. zone)
  spawner:SpawnInZone(zone)
  spawnedVIPs
end

VIPDeathHandler = function(event)
  if event.id ~= world.event.S_EVENT_DEAD then return end
  if not event.initiator.getGroup then return end
  local grpName = event.initiator:getGroup():getName()
  if listContains(spawnedVIPs, grpName) then
    MessageToAll("Russian VIP has been killed!")
    table.remove(spawnedVIPs, grpName)
  end
end

mist.addEventHandler(VIPDeathHandler)

GetRandomVIPSpawnZone = function()
  local spawnableZones = VIPSpawnZones:filter(function(item)
    listContains(VIPSpawnZones, item)
  end)
  return randomFromList(spawnableZones)
end
