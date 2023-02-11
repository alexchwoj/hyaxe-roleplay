#if defined _enter_exits_callbacks_
    #endinput
#endif
#define _enter_exits_callbacks_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_CTRL_BACK) != 0)
    {
        new areas = GetPlayerNumberDynamicAreas(playerid);
        if (areas)
        {
            YSI_UNSAFE_HUGE_STRING[areas] = INVALID_STREAMER_ID;
            GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);

            for (new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
            {
                new area = YSI_UNSAFE_HUGE_STRING[i];
                if (Streamer_HasArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x4545)))
                {
                    if (Bit_Get(Player_Flags(playerid), PFLAG_ARRESTED) || Bit_Get(Player_Flags(playerid), PFLAG_IN_JAIL))
                    {
                        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No puedes hacer esto");
                        return 1;
                    }

                    new info[2];
                    Streamer_GetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x4545), info);

                    new id = info[0];
                    if (g_rgeEnterExits[id][e_iEnterExitCallback] != 0)
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

                    if (info[1])
                    {
                        SetPlayerFacingAngle(playerid, g_rgeEnterExits[id][e_fExitAngle]);
                        SetPlayerInterior(playerid, g_rgeEnterExits[id][e_iExitInterior]);
                        SetPlayerVirtualWorld(playerid, g_rgeEnterExits[id][e_iExitWorld]);

                        g_rgePlayerData[playerid][e_fPosX] = g_rgeEnterExits[id][e_fExitX];
                        g_rgePlayerData[playerid][e_fPosY] = g_rgeEnterExits[id][e_fExitY];
                        g_rgePlayerData[playerid][e_fPosZ] = g_rgeEnterExits[id][e_fExitZ];

                        Streamer_UpdateEx(playerid, g_rgeEnterExits[id][e_fExitX], g_rgeEnterExits[id][e_fExitY], g_rgeEnterExits[id][e_fExitZ], .worldid = g_rgeEnterExits[id][e_iExitWorld], .interiorid = g_rgeEnterExits[id][e_iExitInterior], .compensatedtime = 3000, .freezeplayer = true);

                        Player_SyncTime(playerid);
                    }
                    else
                    {
                        Player_LastEnterExit(playerid) = id;
                        
                        SetPlayerFacingAngle(playerid, g_rgeEnterExits[id][e_fEnterAngle]);
                        SetPlayerInterior(playerid, g_rgeEnterExits[id][e_iEnterInterior]);
                        SetPlayerVirtualWorld(playerid, g_rgeEnterExits[id][e_iEnterWorld]);

                        g_rgePlayerData[playerid][e_fPosX] = g_rgeEnterExits[id][e_fEnterX];
                        g_rgePlayerData[playerid][e_fPosY] = g_rgeEnterExits[id][e_fEnterY];
                        g_rgePlayerData[playerid][e_fPosZ] = g_rgeEnterExits[id][e_fEnterZ];

                        Streamer_UpdateEx(playerid, g_rgeEnterExits[id][e_fEnterX], g_rgeEnterExits[id][e_fEnterY], g_rgeEnterExits[id][e_fEnterZ], .worldid = g_rgeEnterExits[id][e_iEnterWorld], .interiorid = g_rgeEnterExits[id][e_iEnterInterior], .compensatedtime = 1000, .freezeplayer = 1);
                    }

                    Player_SetImmunityForCheat(playerid, CHEAT_AIRBREAK, 2000);
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
