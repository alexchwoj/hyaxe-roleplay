#if defined _events_callbacks_
    #endinput
#endif
#define _events_callbacks_

public OnGameModeInit()
{
    // Initialize
    g_iGangEventType = EVENT_INVALID;
    SetTimer("GVENT_CheckTime", 60000, true);

    // Create graffiti object
    for(new i; i < sizeof(g_rgeGraffiti); ++i)
	{
        g_rgeGraffiti[i][e_iGraffitiObject] = CreateDynamicObject(
            19482,
            g_rgeGraffiti[i][e_fGraffitiX],
            g_rgeGraffiti[i][e_fGraffitiY],
            g_rgeGraffiti[i][e_fGraffitiZ],
            g_rgeGraffiti[i][e_fGraffitiRX],
            g_rgeGraffiti[i][e_fGraffitiRY],
            g_rgeGraffiti[i][e_fGraffitiRZ],
            0, 0
        );

        new area = CreateDynamicSphere(g_rgeGraffiti[i][e_fGraffitiX], g_rgeGraffiti[i][e_fGraffitiY], g_rgeGraffiti[i][e_fGraffitiZ], 4.0, 0, 0);
        Streamer_SetIntData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x47524146), i); // GRAF

        new city[45], zone[45];
        GetPointZone(g_rgeGraffiti[i][e_fGraffitiX], g_rgeGraffiti[i][e_fGraffitiY], city, zone);
        #pragma unused city

        SetDynamicObjectMaterialText(g_rgeGraffiti[i][e_iGraffitiObject], 0, zone, OBJECT_MATERIAL_SIZE_512x64, "Comic Sans MS", 60, 0, math_random_unsigned(0, 0xFFFFFFFF) | 0xFF000000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
    }

    #if defined GVENT_OnGameModeInit
        return GVENT_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit GVENT_OnGameModeInit
#if defined GVENT_OnGameModeInit
    forward GVENT_OnGameModeInit();
#endif

forward GVENT_CheckTime();
public GVENT_CheckTime()
{
    if (GetTickCount() - g_iGangEventTick >= 600000)
    {
        new hour, minute;
        gettime(hour, minute);

        if (minute >= 0 && minute <= 5)
        {
            GangEvent_Start( random(EVENT_INVALID) );
        }
    }
    return 1;
}

forward GVENT_TruckSpawnLoot();
public GVENT_TruckSpawnLoot()
{
    static const loot[][] = {
        {ITEM_CRACK, 2, 8},
        {ITEM_MEDICINE, 25, 50},
        {ITEM_TEC9, 1, 1},
        {ITEM_KNIFE, 1, 1},
        {ITEM_SAWEDOFF, 1, 1},
        {ITEM_DEAGLE, 1, 1},
        {ITEM_CRACK, 2, 8}
    };

    for(new i, j = math_random(12, 24); i < j; ++i)
    {
        new item = random( sizeof(loot) );

        DroppedItem_Create(
            loot[item][0], minrand(loot[item][1], loot[item][2]), 0, 
            g_rgfTruckDefensePositions[g_iGangTruckIndex][0] + math_random_float(-5.0, 5.0),
            g_rgfTruckDefensePositions[g_iGangTruckIndex][1] + math_random_float(-5.0, 5.0),
            g_rgfTruckDefensePositions[g_iGangTruckIndex][2] + 2.0,
            0, 0
        );
    }

    GangEvent_Cancel();
    GangEvent_SendNotification("El botín de la camioneta ya está disponible.", 5000, 0xDAA838FF, .finishied = true);
    return 1;
}

forward GVENT_UpdateTruck();
public GVENT_UpdateTruck()
{
    new elapsed = g_iGangTruckTimeCount - gettime();
    new 
        minutes = elapsed / 60, 
        seconds = elapsed % 60;

    if (minutes < 0)
    {
        KillTimer(g_iGangTruckTimer);
        TextDrawSetString(g_tdGangEventText, "CAMIONETA ~g~ABIERTA");

        Sound_PlayInRange(
            32400, 25.0,
            g_rgfTruckDefensePositions[g_iGangTruckIndex][0],
            g_rgfTruckDefensePositions[g_iGangTruckIndex][1],
            g_rgfTruckDefensePositions[g_iGangTruckIndex][2],
            0, 0
        );

        g_iGangTruckParticle = CreateDynamicObject(
            18737,
            g_rgfTruckDefensePositions[g_iGangTruckIndex][0],
            g_rgfTruckDefensePositions[g_iGangTruckIndex][1],
            g_rgfTruckDefensePositions[g_iGangTruckIndex][2],
            0.0, 0.0, 0.0,
            0, 0
        );

        SetTimer("GVENT_TruckSpawnLoot", 2000, false);
    }
    else
    {
        SetVehiclePos(
            g_iGangTruckVehicleID,
            g_rgfTruckDefensePositions[g_iGangTruckIndex][0],
            g_rgfTruckDefensePositions[g_iGangTruckIndex][1],
            g_rgfTruckDefensePositions[g_iGangTruckIndex][2] + 0.2
        );
        SetVehicleZAngle(g_iGangTruckVehicleID, g_rgfTruckDefensePositions[g_iGangTruckIndex][3]);

        new str[30];
        format(str, sizeof(str), "ABRIENDOSE EN ~r~%i:%02i", minutes, seconds);
        TextDrawSetString(g_tdGangEventText, str);
    }
    return 1;
}

forward GVENT_UpdateGraffiti(playerid);
public GVENT_UpdateGraffiti(playerid)
{
    if (g_iGangEventType == EVENT_GRAFFITI && Player_Gang(playerid) != -1 && GetPlayerWeapon(playerid) == WEAPON_SPRAYCAN && IsPlayerInAnyDynamicArea(playerid))
    {
        for_list(it : GetPlayerAllDynamicAreas(playerid))
        {
            new areaid = iter_get(it);
            if (Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x47524146)))
            {
                new graffiti_id = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x47524146));
                if (graffiti_id == g_iGangGraffitiIndex)
                {
                    g_rgbGangGraffitiPainted[playerid] = true;
                    g_iGraffitiGang = Player_Gang(playerid);
                    g_rgfGangGraffitiProgress[ Player_Gang(playerid) ] += 0.5;
                    TextDrawSetString_s(g_tdGangEventText, @f("%s: ~y~%.2f%%", Gang_Data( Player_Gang(playerid) )[e_szGangName], g_rgfGangGraffitiProgress[ Player_Gang(playerid) ]));
                    SetDynamicObjectMaterialText(g_rgeGraffiti[ graffiti_id ][e_iGraffitiObject], 0, Gang_Data( Player_Gang(playerid) )[e_szGangName], OBJECT_MATERIAL_SIZE_512x64, "Comic Sans MS", 60, 0, RGBAToARGB( Gang_Data( Player_Gang(playerid) )[e_iGangColor] ), 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
                
                    if (g_rgfGangGraffitiProgress[ Player_Gang(playerid) ] >= 100.0)
                    {
                        Graffiti_Finish();
                        KillTimer(g_rgiGangGraffitiTimer[playerid]);
                    }                
                }
            }
        }
    }
    else
        KillTimer(g_rgiGangGraffitiTimer[playerid]);

    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_FIRE) != 0)
    {
        if (g_iGangEventType == EVENT_GRAFFITI && Player_Gang(playerid) != -1 && GetPlayerWeapon(playerid) == WEAPON_SPRAYCAN && IsPlayerInAnyDynamicArea(playerid))
        {
            for_list(it : GetPlayerAllDynamicAreas(playerid))
            {
                new areaid = iter_get(it);
                if (Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x47524146)))
                {
                    new graffiti_id = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x47524146));
                    if (graffiti_id == g_iGangGraffitiIndex)
                    {
                        KillTimer(g_rgiGangGraffitiTimer[playerid]);
                        g_rgiGangGraffitiTimer[playerid] = SetTimerEx("GVENT_UpdateGraffiti", 1000, true, "i", playerid);
                    }
                }
            }
        }
    }

    if ((oldkeys & KEY_FIRE) != 0)
    {
        KillTimer(g_rgiGangGraffitiTimer[playerid]);
    }

    #if defined GVENT_OnPlayerKeyStateChange
        return GVENT_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange GVENT_OnPlayerKeyStateChange
#if defined GVENT_OnPlayerKeyStateChange
    forward GVENT_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(g_rgiGangGraffitiTimer[playerid]);

    #if defined GVENT_OnPlayerDisconnect
        return GVENT_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect GVENT_OnPlayerDisconnect
#if defined GVENT_OnPlayerDisconnect
    forward GVENT_OnPlayerDisconnect(playerid, reason);
#endif
