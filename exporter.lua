write_state = function()
    log("Writing State...")
    local stateFile = lfs.writedir()..[[Scripts\GAW2\state.json]]
    local fp = io.open(stateFile, 'w')
    fp:write(json:encode(game_state))
    fp:close()
    log("Done writing state.")
end

mist.scheduleFunction(write_state, {}, timer.getTime() + 524, 580)

-- update list of active CTLD AA sites in the global game state
function countHawkSites()
    local CTLDstate = {}
    log("Counting the number of HAWK sites.")
    local hawkCount = 0
    for _groupname, _groupdetails in pairs(ctld.completeAASystems) do
        local CTLDsite = {}
        for k,v in pairs(_groupdetails) do
            CTLDsite[v['unit']] = v['point']
        end
        CTLDstate[_groupname] = CTLDsite
        hawkCount = hawkCount + 1
    end
    game_state["Theaters"]["Russian Theater"]["Hawks"] = CTLDstate
    log("Done counting Hawks. Found " .. tostring(hawkCount) .. " sites")
end


function sortByCreationTime(a, b)
  --TODO: handle nil..
  return a["creationTime"] > b["creationTime"]
end

function limitCTLDByType(typ, num)
  local _ignored = {} -- We hold the types we don't care about in here
  local _limited = {} -- holds the types we're limiting by
  for _, v in pairs(game_state["Theaters"]["Russian Theater"]["CTLD_ASSETS"]) do
    if v["name"] ~= typ then
      table.insert(_ignored, v)
    else
      log(typ .. " are at " .. tostring(#_limited) .. "/" .. tostring(num))
      table.insert(_limited, v)
    end
  end
  table.sort(_limited, sortByCreationTime) -- In place.
  _limited = { unpack(_limited, 1, 5 ) }

  game_state["Theaters"]["Russian Theater"]["CTLD_ASSETS"] = TableConcat(_ignored, _limited)
end

ctld.addCallback(function(_args)
    if _args.action and _args.action == "unpack" then
        local name
        local groupname = _args.spawnedGroup:getName()
        if string.match(groupname, "Avenger") then
            name = "avenger"
        elseif string.match(groupname, "M 818") then
            name = 'ammo'
        elseif string.match(groupname, "Gepard") then
            name = 'gepard'
        elseif string.match(groupname, "MLRS") then
            name = 'mlrs'
        elseif string.match(groupname, "Hummer") then
            name = 'jtac'
        end

        --We don't care about the drop if it's not one of the above.
        if not name then
          return
        end

        table.insert(game_state["Theaters"]["Russian Theater"]["CTLD_ASSETS"], {
            name=name,
            pos=GetCoordinate(Group.getByName(groupname)),
            creationTime = os.time() -- This is unsanitized, right?
        })
        countHawkSites()
        limitCTLDByType('jtac', 7)
        write_state()
    end
end)
