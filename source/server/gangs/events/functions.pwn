#if defined _events_functions_
    #endinput
#endif
#define _events_functions_

GangEvent_SendNotification(const text[], time, color = 0xCB3126FF, bool:started = false, bool:finishied = false)
{
    foreach(new i : Player)
    {
        if (Player_Gang(i) != -1)
        {
            Notification_Show(i, text, time, color);

            if (started)
                TextDrawShowForPlayer(i, g_tdGangEventText);

            if (finishied)
                TextDrawHideForPlayer(i, g_tdGangEventText);
        }
    }
    return 1;
}

GangEvent_Cancel()
{
    switch(g_iGangEventType)
    {
        case EVENT_TRUCK_DEFENSE:
        {
            KillTimer(g_iGangTruckTimer);
            DestroyDynamicObject(g_iGangTruckParticle);
            Vehicle_Destroy(g_iGangTruckVehicleID);
            DestroyDynamicMapIcon(g_iGangEventMapIcon);
        }
    }

    TextDrawSetString(g_tdGangEventText, "_");
    g_iGangEventType = EVENT_INVALID;
    return 1;
}

GangEvent_Start(event_type)
{
    if (g_iGangEventType != EVENT_INVALID)
        GangEvent_Cancel();

    g_iGangEventType = event_type;

    switch(event_type)
    {
        case EVENT_TRUCK_DEFENSE:
        {
            // Create truck
            g_iGangTruckIndex = random( sizeof(g_rgfTruckDefensePositions) );

            g_iGangTruckVehicleID = Vehicle_Create(
                498,
                g_rgfTruckDefensePositions[g_iGangTruckIndex][0],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][1],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][2],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][3],
                252, 252, 0
            );
            Vehicle_ToggleLock(g_iGangTruckVehicleID);

            g_iGangEventMapIcon = CreateDynamicMapIcon(
                g_rgfTruckDefensePositions[g_iGangTruckIndex][0],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][1],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][2],
                51, -1, 0, 0,
                .style = MAPICON_GLOBAL, .streamdistance = 516.0
            );

            // Announce
            new city[45], zone[45];
            GetPointZone(g_rgfTruckDefensePositions[g_iGangTruckIndex][0], g_rgfTruckDefensePositions[g_iGangTruckIndex][1], city, zone);
            
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "El camión con carga ilegal se ha detenido en %s, %s. Se abrirá en 10 minutos, defiéndelo...", zone, city);
            GangEvent_SendNotification(HYAXE_UNSAFE_HUGE_STRING, 10000, 0xDAA838FF, .started = true);

            TextDrawSetString(g_tdGangEventText, "ABRIENDOSE EN ~r~10:00");
            g_iGangTruckTimeCount = gettime() + 600;
            g_iGangTruckTimer = SetTimer("GVENT_UpdateTruck", 1000, true);
        }
        case EVENT_GRAFFITI:
        {
            printf("ja! inepto...");
        }
    }
    g_iGangEventTick = GetTickCount();
    return 1;
}

command gangevent(playerid, const params[], "Inicion un evento de bandas")
{
    extract params -> new event_type; else
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/gangevent {DADADA}<tipo>");
        return 1;
    }

	GangEvent_Start(event_type);
    return 1;
}
flags:gangevent(CMD_FLAG<RANK_LEVEL_SUPERADMIN>)