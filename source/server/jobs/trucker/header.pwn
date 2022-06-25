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
        { 49.1907, -283.3056, 2.2144, 0.0 },
        { 40.7533, -282.6033, 1.9722, 358.5822 },
        { 25.0289, -282.3484, 2.3712, 324.9366 },
        { 23.7223, -266.1860, 2.3699, 267.6413 },
        { 23.1704, -271.5584, 2.4146, 268.7236 },
        { 47.8009, -259.6744, 1.6983, 263.3861 },
        { 48.6700, -253.0773, 1.6061, 265.2806 },
        { 45.1426, -245.2204, 1.6232, 264.1183 },
        { 44.6837, -238.4186, 1.6401, 264.7086 },
        { 43.5915, -232.8199, 1.6816, 264.1467 },
        { 43.2563, -225.2304, 1.6963, 266.9375 },
        { 128.3402, -233.8414, 1.5722, 88.6068 },
        { 143.1128, -240.5038, 1.5692, 88.7525 },
        { 144.1075, -245.3124, 1.5647, 89.4543 },
        { 115.7676, -314.5226, 1.5663, 263.7577 },
        { 115.8348, -298.0670, 1.5676, 269.7583 }
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