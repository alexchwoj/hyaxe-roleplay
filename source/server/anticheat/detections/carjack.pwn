#if defined _detections_carjack_
    #endinput
#endif
#define _detections_carjack_

static 
    bool:s_rgbDriver[MAX_PLAYERS char] = { false, ... };

const __ac_cj_VehicleSync = 200;
IPacket:__ac_cj_VehicleSync(playerid, BitStream:bs)
{
    if(Player_HasImmunityForCheat(playerid, CHEAT_CARJACK) || s_rgbDriver{playerid})
        return 1;

    new
        vehicleid;

    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8,
        PR_UINT16, vehicleid
    );

    new driver = INVALID_PLAYER_ID;
    foreach(new i : Player)
    {
        if(i == playerid)
            continue;
            
        if(GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == 0)
        {
            driver = i;
            break;
        }
    }

    if(driver != INVALID_PLAYER_ID)
    {
        Anticheat_Trigger(playerid, CHEAT_CARJACK, 1);
        return 0;
    }

    s_rgbDriver{playerid} = true;

    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_DRIVER)
    {
        s_rgbDriver{playerid} = false;
    }

    #if defined AC_CJ_OnPlayerStateChange
        return AC_CJ_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange AC_CJ_OnPlayerStateChange
#if defined AC_CJ_OnPlayerStateChange
    forward AC_CJ_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    s_rgbDriver{playerid} = false;

    #if defined AC_CJ_OnPlayerDisconnect
        return AC_CJ_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect AC_CJ_OnPlayerDisconnect
#if defined AC_CJ_OnPlayerDisconnect
    forward AC_CJ_OnPlayerDisconnect(playerid, reason);
#endif
