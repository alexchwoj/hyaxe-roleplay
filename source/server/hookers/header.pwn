#if defined _hookers_header_
    #endinput
#endif
#define _hookers_header_

const INVALID_HOOKER_ID = -1;

enum eHookerTask(<<=1)
{
    HOOKER_TASK_IDLE = 0,
    HOOKER_TASK_WAIT_FOR_CUSTOMER = 1,
    HOOKER_TASK_GO_TO_FRONT_OF_PLY,
    HOOKER_TASK_KISS,
    HOOKER_TASK_FOLLOW_PLAYER,
    HOOKER_TASK_BLOWJOB,
    HOOKER_TASK_GO_BACK_TO_SPOT
};

new const 
    g_rgiHookerSkins[] = { 63, 64, 75, 90, 152, 237, 238, 243, 245, 256 },
    Float:g_rgfHookerPos[][4] = {
        { 2209.7964, -1137.6082, 25.8063, 352.5046 },
        { 2157.7563, -1310.4421, 23.9802, 316.2672 }, 
        { 1961.9397, -1332.3245, 23.3618, 179.1913 }, 
        { 2438.4302, -1648.4514, 13.5039, 171.9164 }, 
        { 2760.3604, -1985.7839, 13.5547, 217.9749 }, 
        { 2102.0112, -1603.6997, 13.5547, 156.7746 }, 
        { 1952.4130, -2067.9409, 13.5469, 273.9130 }, 
        { -2741.9604, 698.6432, 41.2734, 62.4107 }, 
        { -2596.4250, 1013.4578, 78.2672, 173.0701 }, 
        { -2375.6658, 949.5578, 45.4453, 55.6985 }, 
        { -2041.7632, 1277.0322, 7.5113, 48.4336 }, 
        { 2030.5636, 1442.2020, 10.8203, 306.7499 }, 
        { 2119.4460, 1763.8992, 10.8203, 13.2649 }, 
        { 2162.6855, 2032.0566, 10.8203, 116.9441 }
    };

const HYAXE_MAX_HOOKERS = sizeof(g_rgfHookerPos);
new
    g_rgiHookers[HYAXE_MAX_HOOKERS],
    eHookerTask:g_rgeHookerTasks[HYAXE_MAX_HOOKERS],
    g_rgiHookerCustomer[HYAXE_MAX_HOOKERS] = { INVALID_PLAYER_ID, ... },
    g_rgiPlayerHooker[MAX_PLAYERS] = { INVALID_HOOKER_ID, ... },
    g_rgiHookerUpdateTimer[HYAXE_MAX_HOOKERS],
    Iterator:Hookers<MAX_PLAYERS>;

forward Hooker_WalkToFrontOfPlayer(hookernpcid, playerid, Float:dist = 0.9);