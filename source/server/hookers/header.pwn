#if defined _hookers_header_
    #endinput
#endif
#define _hookers_header_

const HYAXE_MAX_HOOKERS = 20;

enum eHookerAction
{
    HOOKER_NONE,
    HOOKER_KISS_ONFOOT = 1,
    HOOKER_WALK_TO_VEHICLE,
    HOOKER_ASK_DRIVER,
    HOOKER_WAIT_FOR_AREA,
    HOOKER_BLOWJOB,
    HOOKER_WALK_BACK_TO_SITE,
};

new 
    g_rgiHookers[HYAXE_MAX_HOOKERS] = { INVALID_PLAYER_ID, ... },
    g_rgiHookerAreas[HYAXE_MAX_HOOKERS] = { INVALID_STREAMER_ID, ... },
    g_rgbHookerAvailable[HYAXE_MAX_HOOKERS char],
    g_rgiHookerInteractingPlayer[HYAXE_MAX_HOOKERS] = { INVALID_PLAYER_ID, ... },
    g_rgiPlayerInteractingHooker[MAX_PLAYERS] = { INVALID_PLAYER_ID, ... },
    eHookerAction:g_rgiHookerPendingTask[HYAXE_MAX_HOOKERS char];

new const 
    g_rgiHookerSkins[] = { 63, 64, 75, 90, 152, 237, 238, 243, 245, 256 },
    Float:g_rgfHookerPos[HYAXE_MAX_HOOKERS][4] = {
        { 2209.7964, -1137.6082, 25.8063, 352.5046 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 }
    };

    