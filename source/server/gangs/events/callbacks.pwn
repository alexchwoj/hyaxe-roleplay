#if defined _events_callbacks_
    #endinput
#endif
#define _events_callbacks_

public OnGameModeInit()
{
    g_iGangEventType = EVENT_INVALID;
    SetTimer("GVENT_CheckTime", 60000, true);

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
    new diff = GetTickDiff(GetTickCount(), g_iGangEventTick);
    if (diff >= 600000)
    {
        new hour, minute;
        gettime(hour, minute);

        if (minute >= 0 && minute <= 5)
        {
            GangEvent_Start(EVENT_TRUCK_DEFENSE);
        }
    }
    return 1;
}

forward GVENT_TruckSpawnLoot();
public GVENT_TruckSpawnLoot()
{
    new loot[][] = {
        {ITEM_CRACK, 2, 8},
        {ITEM_MEDICINE, 25, 50},
        {ITEM_TEC9, 1, 1},
        {ITEM_KNIFE, 1, 1},
        {ITEM_SAWEDOFF, 1, 1},
        {ITEM_DEAGLE, 1, 1},
        {ITEM_CRACK, 2, 8}
    };

    for(new i; i < minrand(12, 24); ++i)
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
    new minutes = elapsed / 60, seconds = elapsed % 60;

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

        TextDrawSetString_s(g_tdGangEventText, @f("ABRIENDOSE EN ~r~%02i:%02i", minutes, seconds));
    }
    return 1;
}