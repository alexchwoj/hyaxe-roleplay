#if defined _detections_teleport_
    #endinput
#endif
#define _detections_teleport_

public OnPlayerUpdate(playerid)
{
    if(IsPlayerSpawned(playerid) && Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
    {
        new const Float:max_dist = (IsPlayerInAnyVehicle(playerid) ? 340.0 : 50.0);
        if(GetPlayerDistanceFromPoint(playerid, Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ)) > max_dist)
        {
            if(IsPlayerInAnyVehicle(playerid))
            {
                SetVehiclePos(GetPlayerVehicleID(playerid), Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ));
            }
            else
            {
                SetPlayerPos(playerid, Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ));
            }

            Anticheat_Trigger(playerid, CHEAT_TELEPORT);
        }
        else
        {
            GetPlayerPos(playerid, Player_Data(playerid, e_fPosX), Player_Data(playerid, e_fPosY), Player_Data(playerid, e_fPosZ));
        }
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
