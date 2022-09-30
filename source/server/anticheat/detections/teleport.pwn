#if defined _detections_teleport_
    #endinput
#endif
#define _detections_teleport_

public OnPlayerUpdate(playerid)
{
    if (IsPlayerSpawned(playerid) && Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
    {
        if(!GetPlayerInterior(playerid))
        {
            new
                const Float:max_dist = (IsPlayerInAnyVehicle(playerid) ? 340.0 : 50.0),
                Float:dist = GetPlayerDistanceFromPoint(playerid, Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ))
            ;

            if (!Player_HasImmunityForCheat(playerid, CHEAT_TELEPORT))
            {
                if (Player_Data(playerid, e_fPosZ) < -90.0)
                {
                    Player_SetImmunityForCheat(playerid, CHEAT_TELEPORT, 1000);
                    return 1;
                }

                if (dist > max_dist)
                {
                    if (IsPlayerInAnyVehicle(playerid))
                    {
                        SetVehiclePos(GetPlayerVehicleID(playerid), Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ));
                    }
                    else
                    {
                        SetPlayerPos(playerid, Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ));
                    }

                    //printf("CHEAT_TELEPORT > dist = %f, data[PR_animationId] = %d", dist, GetPlayerAnimationIndex(playerid));
                    Anticheat_Trigger(playerid, CHEAT_TELEPORT);
                    return 0;
                }
            }

            if (!Player_HasImmunityForCheat(playerid, CHEAT_AIRBREAK))
            {
                if (Player_Data(playerid, e_fPosZ) < -90.0 && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)
                {
                    Player_SetImmunityForCheat(playerid, CHEAT_AIRBREAK, 1000);
                    return 1;
                }

                if (dist >= 5.0 && !IsPlayerInAnyVehicle(playerid))
                {
                    //printf("CHEAT_AIRBREAK > dist = %f, data[PR_animationId] = %d", dist, GetPlayerAnimationIndex(playerid));
                    Anticheat_Trigger(playerid, CHEAT_AIRBREAK);
                    return 0;
                }
            }
        }

        GetPlayerPos(playerid, Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ));
    }

    #if defined AC_OnPlayerUpdate
        return AC_OnPlayerUpdate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate AC_OnPlayerUpdate
#if defined AC_OnPlayerUpdate
    forward AC_OnPlayerUpdate(playerid);
#endif

public OnPlayerExitVehicle(playerid, vehicleid)
{
    Player_SetImmunityForCheat(playerid, CHEAT_TELEPORT, 1000);
    Player_SetImmunityForCheat(playerid, CHEAT_AIRBREAK, 1000);

    GetPlayerPos(playerid, Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ));

    #if defined AC_OnPlayerExitVehicle
        return AC_OnPlayerExitVehicle(playerid, vehicleid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerExitVehicle
    #undef OnPlayerExitVehicle
#else
    #define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle AC_OnPlayerExitVehicle
#if defined AC_OnPlayerExitVehicle
    forward AC_OnPlayerExitVehicle(playerid, vehicleid);
#endif
