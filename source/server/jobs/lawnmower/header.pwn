#if defined _lawnmower_header_
    #endinput
#endif
#define _lawnmower_header_

const MIN_GRASS_PER_AREA = 50;
const MAX_GRASS_PER_AREA = 100;

/*
enum eGrass
{
    e_iGrassObject,
    e_iGrassArea
};
*/

enum eLawnmowerArea
{
    e_iAreaId,
    e_iMowingPlayer,
    e_rgiGrassObjects[MAX_GRASS_PER_AREA],
    e_rgiGrassAreas[MAX_GRASS_PER_AREA],
    e_iInitialGrassCount,
    e_iCurrentGrassCount,

    Float:e_fParkAreaMinX,
    Float:e_fParkAreaMinY,
    Float:e_fParkAreaMinZ,
    Float:e_fParkAreaMaxX,
    Float:e_fParkAreaMaxY,
    Float:e_fParkAreaMaxZ,

    Float:e_fGrassAreaMinX,
    Float:e_fGrassAreaMinY,
    Float:e_fGrassAreaMinZ,
    Float:e_fGrassAreaMaxX,
    Float:e_fGrassAreaMaxY,
    Float:e_fGrassAreaMaxZ,

    e_iPedContractorId,
    Float:e_fPedContractorX,
    Float:e_fPedContractorY,
    Float:e_fPedContractorZ,
    Float:e_fPedContractorAngle,

    Float:e_fVehicleSpawnX,
    Float:e_fVehicleSpawnY,
    Float:e_fVehicleSpawnZ,
    Float:e_fVehicleSpawnRot,
    e_iMowerId,
};

new g_rgeLawnmowerAreas[][eLawnmowerArea] =
{
    {
        INVALID_STREAMER_ID, 
        INVALID_PLAYER_ID,  
        INVALID_STREAMER_ID, 
        INVALID_STREAMER_ID, 
        0, 0,

        2061.4148, -1255.3127, 23.8203, // Park area
        1974.7877, -1140.8844, 25.8047, 
        2055.0747, -1248.8661, 23.8589, // Grass generation area
        1981.7301, -1148.3273, 21.2429, 

        INVALID_STREAMER_ID,
        2081.3334, -1241.6908, 23.9750, 93.9778,

        2052.7703, -1242.6202, 23.6974, 85.6861,
        INVALID_VEHICLE_ID
    }
};


new
    g_rgiPlayerLawnmowerArea[MAX_PLAYERS char] = { 0xFFFFFFFF, ... };
