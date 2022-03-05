#if defined _ATM_CALLBACKS_
    #endinput
#endif
#define _ATM_CALLBACKS_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_YES) != 0)
    {
        if (GetPlayerNumberDynamicAreas(playerid) > 0)
        {
            new areas[1];
            GetPlayerDynamicAreas(playerid, areas);

            new info[3];
            Streamer_GetArrayData(STREAMER_TYPE_AREA, areas[0], E_STREAMER_EXTRA_ID, info);
            if (info[0] == 0x41544D)
            {
                if (IsPlayerInRangeOfPoint(playerid, 1.2, g_rgeATMBank[ info[1] ][e_fAtmPosX], g_rgeATMBank[ info[1] ][e_fAtmPosY], g_rgeATMBank[ info[1] ][e_fAtmPosZ]))
                {
                    SendClientMessage(playerid, -1, "banco");
                }
            }
        }
    }

    #if defined ATM_OnPlayerKeyStateChange
        return ATM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange ATM_OnPlayerKeyStateChange
#if defined ATM_OnPlayerKeyStateChange
    forward ATM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgeATMBank); ++i)
    {
        g_rgeATMBank[i][e_iAtmObject] = CreateDynamicObject(19324,
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ],
            g_rgeATMBank[i][e_fAtmRotX], g_rgeATMBank[i][e_fAtmRotY], g_rgeATMBank[i][e_fAtmRotZ],
            g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior]
        );

        g_rgeATMBank[i][e_fAtmHealth] = 1000.0;
        CreateDynamicMapIcon(
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ],
            52, -1, g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior]
        );
    
        g_rgeATMBank[i][e_iAtmLabel] = CreateDynamic3DTextLabel(
            "Cajero automático", 0xF7F7F7AA,
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ] + 2.0, 5.0,
            .testlos = true, .worldid = g_rgeATMBank[i][e_iAtmWorld], .interiorid = g_rgeATMBank[i][e_iAtmInterior]
        );

        new info[2];
        info[0] = 0x41544D; // ATM
        info[1] = i; // ATM ID

        g_rgeATMBank[i][e_iAtmArea] = CreateDynamicCircle(
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], 1.2,
            .worldid = g_rgeATMBank[i][e_iAtmWorld], .interiorid = g_rgeATMBank[i][e_iAtmInterior]
        );
        Streamer_SetArrayData(STREAMER_TYPE_AREA, g_rgeATMBank[i][e_iAtmArea], E_STREAMER_EXTRA_ID, info);
    }

    #if defined ATM_OnGameModeInit
        return ATM_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGamemodeInit
    #undef OnGamemodeInit
#else
    #define _ALS_OnGamemodeInit
#endif
#define OnGamemodeInit ATM_OnGamemodeInit
#if defined ATM_OnGamemodeInit
    forward ATM_OnGamemodeInit();
#endif
