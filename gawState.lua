-- Setup an initial state object and provide functions for manipulating that state.
game_state = {
    ["last_launched_time"] = 0,
    ["CurrentTheater"] = "North Georgia",
    ["Theaters"] = {
        ["Russian Theater"] ={
            ["last_cap_spawn"] = 0,
            ["Airfields"] = {
                ["Sochi-Adler"] = Airbase.getByName("Sochi-Adler"):getCoalition(),
                ["Gudauta"] = Airbase.getByName("Gudauta"):getCoalition(),
                ["Mineralnye Vody"] = Airbase.getByName("Mineralnye Vody"):getCoalition(),
                ["Nalchik"] = Airbase.getByName("Nalchik"):getCoalition(),
                ["Mozdok"] = Airbase.getByName("Mozdok"):getCoalition(),
                ["Sukhumi-Babushara"] = Airbase.getByName("Sukhumi-Babushara"):getCoalition(),
            },
            ["Primary"] = {
                ["Beslan"] = false,
                ["Sukhumi-Babushara"] = false
            },
            ["StrategicSAM"] = {},
            ["C2"] = {},
            ["EWR"] = {},
            ["CASTargets"] = {},
            ["StrikeTargets"] = {},
            ["TheaterObjectives"] = {},
            ["InterceptTargets"] = {},
            ["DestroyedStatics"] = {},
            ["OpforCAS"] = {},
            ["CAP"] = {},
            ["BAI"] = {},
            ["AWACS"] = {},
            ["Tanker"] = {},
            ["NavalStrike"] = {},
            ["CTLD_ASSETS"] = {},
            ['Convoys'] ={},
            ["FARPS"] = {
                ["FARP ALPHA"] = Airbase.getByName("FARP ALPHA"):getCoalition(),
                ["FARP BRAVO"] = Airbase.getByName("FARP BRAVO"):getCoalition(),
                ["FARP CHARLIE"] = Airbase.getByName("FARP CHARLIE"):getCoalition(),
                ["FARP DELTA"] = Airbase.getByName("FARP DELTA"):getCoalition(),
            }
        }
    }
}

log("Game State INIT")


abslots = {
    ['Sochi-Adler'] = {"Sochi Mi8 1", "Sochi Mi8 2", "Sochi UH-1H 1", "Sochi UH-1H 2", "Sochi Ka50"},
    ['Gudauta'] = {"Gudauta Ka50", "Gudauta Mi8 1", "Gudauta Mi8 2", "Gudauta Mi8 3", "Gudauta Mi8 4", "Gudauta UH-1H 1", "Gudauta UH-1H 2"},
    ['Sukhumi-Babushara'] = {},
    ['Mineralnye Vody'] = {"Vody UH-1H 1", "Vody UH-1H 2", "Vody Mi8 1", "Vody Mi8 2"},
    ['Nalchik'] = {},
    ['Mozdok'] = {},
    ['FARP ALPHA'] = {"FARP Alpha UH-1H 1", "FARP Alpha UH-1H 2", "FARP Alpha Mi8 1", "FARP Alpha Mi8 2"},
    ['FARP BRAVO'] = {"FARP Bravo Mi8 1", "FARP Bravo Mi8 2", "FARP Bravo UH-1H 1", "FARP Bravo UH-1H 2"},
    ['FARP CHARLIE'] = {"FARP Charlie Mi8 1", "FARP Charlie Mi8 2", "FARP Charlie UH-1H 1", "FARP Charlie UH-1H 2", "FARP Charlie Ka50"},
    ['FARP DELTA'] = {"FARP Delta UH-1H 1", "FARP Delta UH-1H 2", "FARP Delta Mi8 1", "FARP Delta Mi8 2"},
}

logiSlots = {
    ['Sochi-Adler'] = LogiAdlerSpawn,
    ['Gudauta'] = LogiGudautaSpawn,
    ['Mineralnye Vody'] = LogiVodySpawn,
    ['FARP ALPHA'] = LogiFARPALPHASpawn,
    ['FARP BRAVO'] = LogiFARPBRAVOSpawn,
    ['FARP CHARLIE'] = LogiFARPCHARLIESpawn,
    ['FARP DELTA'] = LogiFARPDELTASpawn
}
