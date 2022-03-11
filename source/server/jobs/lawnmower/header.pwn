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

    Float:e_fAreaMinX,
    Float:e_fAreaMinY,
    Float:e_fAreaMinZ,
    Float:e_fAreaMaxX,
    Float:e_fAreaMaxY,
    Float:e_fAreaMaxZ,

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

        2055.0747, -1248.8661, 23.8589, 
        1981.7301, -1148.3273, 21.2429, 

        INVALID_STREAMER_ID,
        2081.3334, -1241.6908, 23.9750, 93.9778,

        2052.7703, -1242.6202, 23.6974, 85.6861,
        INVALID_VEHICLE_ID
    }
};


new
    g_rgiPlayerLawnmowerArea[MAX_PLAYERS char] = { 0xFFFFFFFF, ... };
