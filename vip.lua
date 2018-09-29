-- AFTER GAW.LUA, SPAWNS.LUA, UTIL.LUA
-- BEFORE COMMANDER.LUA
SpawnVIP = function(zone)
  log("Spawning VIP at " .. zone)
  local spawner = Spawner(randomFromList(VIPSpawns))
  spawner:SpawnInZone(zone)
end
