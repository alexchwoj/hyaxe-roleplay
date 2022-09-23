#if defined _enter_exits_callbacks_
    #endinput
#endif
#define _enter_exits_callbacks_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_CTRL_BACK) != 0)
    {
        if(IsPlayerInAnyDynamicArea(playerid))
        {
            for_list(i : GetPlayerAllDynamicAreas(playerid))
            {
                new area = iter_get(i);
                if(Streamer_HasArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x4545)))
                {
                    new info[2];
                    Streamer_GetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x4545), info);

                    new id = info[0];
                    if(g_rgeEnterExits[id][e_iEnterExitCallback] != 0)
                    {
                        new data = g_rgeEnterExits[id][e_iEnterExitData], addr = g_rgeEnterExits[id][e_iEnterExitCallback], enter = info[1];
                        __emit {
                            push.s data
                            push.s enter
                            push.s playerid
                            push.c 12
                            lctrl 6
                            add.c 0x24
                            lctrl 8
                            push.pri
                            load.s.pri addr
                            sctrl 6
                            jnz L1
                            const.pri 1
                            retn
                        }

                        L1:
                    }

                    Player_SetImmunityForCheat(playerid, CHEAT_TELEPORT, 1000);
                    Player_SetImmunityForCheat(playerid, CHEAT_AIRBREAK, 1000);

                    if(info[1])
                    {
                        Streamer_UpdateEx(playerid, g_rgeEnterExits[id][e_fExitX], g_rgeEnterExits[id][e_fExitY], g_rgeEnterExits[id][e_fExitZ], .worldid = g_rgeEnterExits[id][e_iExitWorld], .interiorid = g_rgeEnterExits[id][e_iExitInterior], .compensatedtime = 1, .freezeplayer = true);
                        SetPlayerFacingAngle(playerid, g_rgeEnterExits[id][e_fExitAngle]);
                        SetPlayerInterior(playerid, g_rgeEnterExits[id][e_iExitInterior]);
                        SetPlayerVirtualWorld(playerid, g_rgeEnterExits[id][e_iExitWorld]);

                        g_rgePlayerData[playerid][e_fPosX] = g_rgeEnterExits[id][e_fExitX];
                        g_rgePlayerData[playerid][e_fPosY] = g_rgeEnterExits[id][e_fExitY];
                        g_rgePlayerData[playerid][e_fPosZ] = g_rgeEnterExits[id][e_fExitZ];

                        new hour, minute;
                        gettime(hour, minute);
                        SetPlayerTime(playerid, hour, minute);
                    }
                    else
                    {
                        Streamer_UpdateEx(playerid, g_rgeEnterExits[id][e_fEnterX], g_rgeEnterExits[id][e_fEnterY], g_rgeEnterExits[id][e_fEnterZ], .worldid = g_rgeEnterExits[id][e_iEnterWorld], .interiorid = g_rgeEnterExits[id][e_iEnterInterior], .compensatedtime = 1, .freezeplayer = 1);
                        SetPlayerFacingAngle(playerid, g_rgeEnterExits[id][e_fEnterAngle]);
                        SetPlayerInterior(playerid, g_rgeEnterExits[id][e_iEnterInterior]);
                        SetPlayerVirtualWorld(playerid, g_rgeEnterExits[id][e_iEnterWorld]);

                        g_rgePlayerData[playerid][e_fPosX] = g_rgeEnterExits[id][e_fEnterX];
                        g_rgePlayerData[playerid][e_fPosY] = g_rgeEnterExits[id][e_fEnterY];
                        g_rgePlayerData[playerid][e_fPosZ] = g_rgeEnterExits[id][e_fEnterZ];
                    }
                }
            }
        }
    }

    #if defined EE_OnPlayerKeyStateChange
        return EE_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange EE_OnPlayerKeyStateChange
#if defined EE_OnPlayerKeyStateChange
    forward EE_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
