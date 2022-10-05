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

Graffiti_Finish()
{
    foreach(new i : Player)
    {
        if (Player_Gang(i) == g_iGraffitiGang)
        {
            if (g_rgbGangGraffitiPainted[i])
                Player_GiveMoney(i, 4000);
            else
                Player_GiveMoney(i, 2000);
        }
    }

    new city[45], zone[45];
    GetPointZone(g_rgeGraffiti[g_iGangGraffitiIndex][e_fGraffitiX], g_rgeGraffiti[g_iGangGraffitiIndex][e_fGraffitiY], city, zone);
            
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "La banda %s ha ganado el graffiti de %s, %s. Todos los integrantes han ganado $2.000 y los que han pintado han ganado $4.000.", Gang_Data(g_iGraffitiGang)[e_szGangName], zone, city);
    GangEvent_SendNotification(HYAXE_UNSAFE_HUGE_STRING, 15000, 0xDAA838FF, .finishied = true);

    GangEvent_Cancel();
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
            DestroyDynamicMapIcon(g_iGangEventMapIcon);

            SetVehicleVirtualWorld(g_iGangTruckVehicleID, 20);
        }
        case EVENT_GRAFFITI:
        {
            DestroyDynamicMapIcon(g_iGangGraffitiMapIcon);
            g_iGraffitiGang = -1;

            foreach(new i : Player)
            {
                g_rgbGangGraffitiPainted[i] = false;
                KillTimer(g_rgiGangGraffitiTimer[i]);
            }
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
            // Update truck
            g_iGangTruckIndex = random( sizeof(g_rgfTruckDefensePositions) );

            SetVehiclePos(
                g_iGangTruckVehicleID,
                g_rgfTruckDefensePositions[g_iGangTruckIndex][0],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][1],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][2] + 0.2
            );
            SetVehicleZAngle(g_iGangTruckVehicleID, g_rgfTruckDefensePositions[g_iGangTruckIndex][3]);
            SetVehicleVirtualWorld(g_iGangTruckVehicleID, 0);

            g_iGangEventMapIcon = CreateDynamicMapIcon(
                g_rgfTruckDefensePositions[g_iGangTruckIndex][0],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][1],
                g_rgfTruckDefensePositions[g_iGangTruckIndex][2],
                51, -1, 0, 0,
                .style = MAPICON_GLOBAL, .streamdistance = 2064.0
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
            g_iGangGraffitiIndex = random( sizeof(g_rgeGraffiti) );

            g_iGangGraffitiMapIcon = CreateDynamicMapIcon(
                g_rgeGraffiti[g_iGangGraffitiIndex][e_fGraffitiX],
                g_rgeGraffiti[g_iGangGraffitiIndex][e_fGraffitiY],
                g_rgeGraffiti[g_iGangGraffitiIndex][e_fGraffitiZ],
                63, -1, 0, 0,
                .style = MAPICON_GLOBAL, .streamdistance = 6000.0
            );

            // Announce
            new city[45], zone[45];
            GetPointZone(g_rgeGraffiti[g_iGangGraffitiIndex][e_fGraffitiX], g_rgeGraffiti[g_iGangGraffitiIndex][e_fGraffitiY], city, zone);
            
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Una disputa de graffiti ha comenzado en %s, %s. Sé el primero en pintarlo.", zone, city);
            GangEvent_SendNotification(HYAXE_UNSAFE_HUGE_STRING, 10000, 0xDAA838FF, .started = true);
            TextDrawSetString(g_tdGangEventText, "GRAFFITI ~g~LIBRE");
            
            for(new i; i < HYAXE_MAX_GANGS; ++i) g_rgfGangGraffitiProgress[i] = 0.0;
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