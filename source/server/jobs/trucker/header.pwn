#if defined _trucker_header_
    #endinput
#endif
#define _trucker_header_

enum eTruckerRoute
{
    e_szRouteName[24],
    e_iBoxCount,
    Float:e_fTruckCpX,
    Float:e_fTruckCpY,
    Float:e_fTruckCpZ,
    e_iTruckCp,
    Float:e_fBoxUnloadX,
    Float:e_fBoxUnloadY,
    Float:e_fBoxUnloadZ,
    e_iBoxUnloadCp
};

new g_rgeTruckerRoutes[][eTruckerRoute] = {
    { 
        "Insumos de pesca", 4,
        2792.2153, -2418.1289, 13.6326, INVALID_STREAMER_ID, 
        2794.8582, -2410.6621, 13.6319, INVALID_STREAMER_ID
    }
};

new const 
    Float:g_rgfTrucksPos[][4] = {
        { 81.1208, -283.3056, 2.1126, 0.0 },
        { 74.8400, -283.3056, 2.1126, 0.0 },
        { 67.9444, -283.3056, 2.1126, 0.0 },
        { 61.8388, -283.3056, 2.1126, 0.0 },
        { 55.9454, -283.3056, 2.1126, 0.0 },
        { 49.1907, -283.3056, 2.2144, 0.0 }
    };

new
    g_iPickBoxCheckpoint = INVALID_STREAMER_ID,
    g_iTruckerCentralArea = INVALID_STREAMER_ID,
    g_iTruckerCentralCp = INVALID_STREAMER_ID,
    g_rgiPlayerTruckCheckpoint[MAX_PLAYERS],
    g_rgiPlayerRemainingBoxes[MAX_PLAYERS char],
    bool:g_rgbPlayerLoadingTruck[MAX_PLAYERS char],
    bool:g_rgbPlayerUnloadingTruck[MAX_PLAYERS char],
    bool:g_rgbPlayerHasBoxInHands[MAX_PLAYERS char],
    g_rgiPlayerUsingTruck[MAX_PLAYERS],
    g_rgiPlayerTruckerRoute[MAX_PLAYERS char],
    bool:g_rgbTruckLoaded[MAX_VEHICLES char],
    bool:g_rgbTruckLoadDispatched[MAX_VEHICLES char];