-- AFTER GAW.LUA, SPAWNS.LUA, UTIL.LUA
-- BEFORE COMMANDER.LUA

local spawnedVIPs = {}

SpawnVIP = function()
  local vipGrp = randomFromList(VIPSpawns)
  local spawner = Spawner(vipGrp)
  local zone = GetRandomVIPSpawnZone()
  MessageToAll("A VIP carrying classified intelligence is trying to get to Beslan from " .. zone)
  local spawnedGroup = spawner:SpawnInZone(zone)
  local path = mist.getGroupRoute(vipGrp, true)
  mist.scheduleFunction(mist.goRoute, {spawnedGroup, path}, timer.getTime() + 5)
  table.insert(spawnedVIPs, spawnedGroup:getName())
end

VIPDeathHandler = function(event)
  if event.id ~= world.event.S_EVENT_CRASH and event.id ~= world.event.S_EVENT_LAND then return end
  if not event.initiator.getGroup then return end
  local grp = event.initiator:getGroup()
  local grpName = grp:getName()
  if listContains(spawnedVIPs, grpName) then
    if event.id == world.event.S_EVENT_CRASH then
      local pt = event.initiator:getPoint()
      lat,long = coord.LOtoLL(pt)
      MessageToAll("Russian VIP has been killed! Intelligence can be found at: \n" .. mist.tostringLL(lat,long,6), 60)
      trigger.action.smoke(pt, trigger.smokeColor.Red)
    else
      MessageToAll("Russian VIP has successfully evacuated the AO!")
    end
    table.remove(spawnedVIPs, tableIndex(spawnedVIPs, grpName))
    Group.destroy(grp)
  end
end

mist.addEventHandler(VIPDeathHandler)

GetRandomVIPSpawnZone = function()
  local spawnableZones = VIPSpawnZones
  return randomFromList(spawnableZones)
end
