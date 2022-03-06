#if defined _ATM_CALLBACKS_
    #endinput
#endif
#define _ATM_CALLBACKS_

public OnPlayerCancelTDSelection(playerid)
{
    if (g_rgePlayerTempData[playerid][e_bInATM])
        ATM_HideMenu(playerid);    

    #if defined ATM_OnPlayerCancelTDSelection
        return ATM_OnPlayerCancelTDSelection(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerCancelTDSelection
    #undef OnPlayerCancelTDSelection
#else
    #define _ALS_OnPlayerCancelTDSelection
#endif
#define OnPlayerCancelTDSelection ATM_OnPlayerCancelTDSelection
#if defined ATM_OnPlayerCancelTDSelection
    forward ATM_OnPlayerCancelTDSelection(playerid);
#endif


public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if (g_rgePlayerTempData[playerid][e_bInATM])
    {
        // Deposit
        if (clickedid == g_tdBankATM[3])
        {
            SendClientMessage(playerid, -1, "depositar");
        }

        // Withdraw
        if (clickedid == g_tdBankATM[4])
        {
            SendClientMessage(playerid, -1, "retirar");
        }

        // Transfer
        if (clickedid == g_tdBankATM[5])
        {
            SendClientMessage(playerid, -1, "transferir");
        }
    }

    #if defined ATM_OnPlayerClickTextDraw
        return ATM_OnPlayerClickTextDraw(playerid, Text:clickedid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw ATM_OnPlayerClickTextDraw
#if defined ATM_OnPlayerClickTextDraw
    forward ATM_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif


forward ATM_LoadFromDatabase(playerid);
public ATM_LoadFromDatabase(playerid)
{
    new row_count;
    cache_get_row_count(row_count);

    if (row_count)
        cache_get_value_name_int(0, !"BALANCE", g_rgePlayerData[playerid][e_iPlayerBankBalance]);

    return 1;
}

public OnPlayerAuthenticate(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT * FROM `BANK_ACCOUNT` WHERE `ACCOUNT_ID` = %i;\
    ", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "ATM_LoadFromDatabase", "i", playerid);

    #if defined ATM_OnPlayerAuthenticate
        return ATM_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate ATM_OnPlayerAuthenticate
#if defined ATM_OnPlayerAuthenticate
    forward ATM_OnPlayerAuthenticate(playerid);
#endif


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
                if (GetPlayerVirtualWorld(playerid) == g_rgeATMBank[ info[1] ][e_iAtmWorld] && GetPlayerInterior(playerid) == g_rgeATMBank[ info[1] ][e_iAtmInterior])
                {
                    ATM_ShowMenu(playerid);
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
            g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior],
            .streamdistance = 100.0, .drawdistance = 100.0
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
    
        Key_Alert(
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], 1.2,
            KEY_YES, g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior]
        );
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
