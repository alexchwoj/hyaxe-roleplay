#if defined _hookers_header_
    #endinput
#endif
#define _hookers_header_

const HYAXE_MAX_HOOKERS = 20;

new 
    g_rgiHookers[HYAXE_MAX_HOOKERS] = { INVALID_PLAYER_ID, ... };