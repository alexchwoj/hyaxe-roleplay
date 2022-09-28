#if defined _gps_callbacks_
    #endinput
#endif
#define _gps_callbacks_

public OnPlayerDisconnect(playerid, reason)
{
    DestroyDynamicCP(g_rgiGPSCheckpoint[playerid]);

    #if defined GPS_OnPlayerDisconnect
        return GPS_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect GPS_OnPlayerDisconnect
#if defined GPS_OnPlayerDisconnect
    forward GPS_OnPlayerDisconnect(playerid, reason);
#endif

command gps(playerid, const params[], "Abre el GPS")
{
    Player_ShowGPS(playerid);
    Chat_SendAction(playerid, "mira su GPS");
    return 1;
}

dialog gps_main(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        switch(listitem)
        {
            case 0:
            {
                Dialog_ShowCallback(playerid, using public _hydg@gps_jobs<iiiis>, DIALOG_STYLE_LIST, "{CB3126}Hyaxe{DADADA} - Trabajos", "\
                    Camionero\n\
                    Pescador\n\
                    Cortacésped\n\
                    Fabricante de armas\n\
                ", "Ver", "Volver");
            }
            case 1:
            {
                new line[128];
                strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Nombre:\t{DADADA}Distancia\n");
                for(new i; i < sizeof(g_rgeHospitalData); ++i)
                {
                    new Float:distance = GetPlayerDistanceFromPoint(playerid, g_rgeHospitalData[i][e_fHospitalPosX], g_rgeHospitalData[i][e_fHospitalPosY], g_rgeHospitalData[i][e_fHospitalPosZ]);
                    format(line, sizeof(line), "%s\t%.2f Km\n", g_rgeHospitalData[i][e_szHospitalName], distance * 0.01);
                    strcat(HYAXE_UNSAFE_HUGE_STRING, line);
                }

                Dialog_ShowCallback(playerid, using public _hydg@gps_hospital<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Hyaxe{DADADA} - Hospitales", HYAXE_UNSAFE_HUGE_STRING, "Ver", "Volver");
            }
            case 2:
            {
                new line[128];
                strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Nombre:\t{DADADA}Distancia\n");
                for(new i; i < sizeof(g_rgfDealershipPosition); ++i)
                {
                    new Float:distance = GetPlayerDistanceFromPoint(playerid, g_rgfDealershipPosition[i][0], g_rgfDealershipPosition[i][1], g_rgfDealershipPosition[i][2]);
                    new city[45], zone[45];
                    GetPointZone(g_rgfDealershipPosition[i][0], g_rgfDealershipPosition[i][1], city, zone);

                    format(line, sizeof(line), "%s, %s\t%.2f Km\n", zone, city, distance * 0.01);
                    strcat(HYAXE_UNSAFE_HUGE_STRING, line);
                }

                Dialog_ShowCallback(playerid, using public _hydg@gps_dealership<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Hyaxe{DADADA} - Concesionarios", HYAXE_UNSAFE_HUGE_STRING, "Ver", "Volver");
            }
        }
    }
    return 1;
}

dialog gps_jobs(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        switch(listitem)
        {
            case 0: Player_SetGPSCheckpoint(playerid, 91.6690, -313.3107, 1.5781); // Camionero
            case 1: Player_SetGPSCheckpoint(playerid, 2156.9067, -97.8114, 3.1911); // Pescador
            case 2: Player_SetGPSCheckpoint(playerid, 2055.0747, -1248.8661, 23.8589); // Cortacesped
            case 3: Player_SetGPSCheckpoint(playerid, 1976.0343, -1923.4221, 13.5469); // Fabricante de armas
        }
    }
    else Player_ShowGPS(playerid);
    return 1;
}

dialog gps_dealership(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        if (listitem > sizeof(g_rgfDealershipPosition))
            return 0;
            
        Player_SetGPSCheckpoint(playerid, g_rgfDealershipPosition[listitem][0], g_rgfDealershipPosition[listitem][1], g_rgfDealershipPosition[listitem][2]);
    }
    else Player_ShowGPS(playerid);
    return 1;
}

dialog gps_hospital(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        if (listitem > sizeof(g_rgeHospitalData))
            return 0;

        Player_SetGPSCheckpoint(playerid, g_rgeHospitalData[listitem][e_fHospitalPosX], g_rgeHospitalData[listitem][e_fHospitalPosY], g_rgeHospitalData[listitem][e_fHospitalPosZ]);
    }
    else Player_ShowGPS(playerid);
    return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if (checkpointid == g_rgiGPSCheckpoint[playerid])
    {
        DestroyDynamicCP(g_rgiGPSCheckpoint[playerid]);
        Notification_Show(playerid, "Llegaste al destino.", 3000, 0x64A752FF);
    }

    #if defined GPS_OnPlayerEnterDynamicCP
        return GPS_OnPlayerEnterDynamicCP(playerid, checkpointid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicCP
    #undef OnPlayerEnterDynamicCP
#else
    #define _ALS_OnPlayerEnterDynamicCP
#endif
#define OnPlayerEnterDynamicCP GPS_OnPlayerEnterDynamicCP
#if defined GPS_OnPlayerEnterDynamicCP
    forward GPS_OnPlayerEnterDynamicCP(playerid, checkpointid);
#endif
