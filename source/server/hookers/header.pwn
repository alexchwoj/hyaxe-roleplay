#if defined _hookers_header_
    #endinput
#endif
#define _hookers_header_

const HYAXE_MAX_HOOKERS = 20;

new 
    g_rgiHookers[HYAXE_MAX_HOOKERS] = { INVALID_PLAYER_ID, ... },
    g_rgiHookerAreas[HYAXE_MAX_HOOKERS] = { INVALID_STREAMER_ID, ... },
    g_rgbHookerAvailable[HYAXE_MAX_HOOKERS char];

new const 
    g_rgiHookerSkins[] = { 63, 64, 75, 90, 152, 237, 238, 243, 245, 256 },
    Float:g_rgfHookerPos[HYAXE_MAX_HOOKERS][4] = {
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
        { 0.0, 0.0, 0.0, 0.0 },
        { 0.0, 0.0, 0.0, 0.0 }
    };

    