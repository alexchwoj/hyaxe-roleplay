#if defined _boombox_callbacks_
    #endinput
#endif
#define _boombox_callbacks_

static
    s_rgiUsingBoombox[MAX_PLAYERS] = { INVALID_STREAMER_ID, ... };

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_NO | KEY_WALK) == KEY_NO | KEY_WALK)
    {
        new areas = GetPlayerNumberDynamicAreas(playerid);
        if (areas)
        {
            YSI_UNSAFE_HUGE_STRING[0] = 0;
            GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, areas);
            for (new i; i < areas; ++i)
            {
                new areaid = YSI_UNSAFE_HUGE_STRING[i];
                if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O'))))
                {
                    new data[eBoomboxData];
                    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), data);
                    
                    if (data[e_bBoomboxIsPublic] || data[e_iBoomboxOwnerId] == playerid)
                    {
                        new Float:x, Float:y, Float:z;
                        GetDynamicObjectPos(data[e_iBoomboxObjectId], x, y, z);
                        if (IsPlayerInRangeOfPoint(playerid, 2.0, x, y, z))
                        {
                            inline const Response(response, listitem, string:inputtext[])
                            {
                                #pragma unused inputtext

                                if (!response)
                                    return 1;

                                switch (listitem)
                                {
                                    case 0:
                                    {
                                        inline const SearchResponse(sr_response, sr_listitem, string:sr_inputtext[])
                                        {
                                            #pragma unused sr_listitem

                                            if (!sr_response)
                                            {
                                                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "{CB3126}>>{DADADA} Parlante", va_return("{CB3126}>{DADADA} Poner música\n{CB3126}>{DADADA} Recoger\n{CB3126}>{DADADA} Público: %s", (data[e_bBoomboxIsPublic] ? "{64A752}Sí" : "{A83225}No")), "Siguiente", "Salir");
                                                return 1;
                                            }

                                            if (IsNull(sr_inputtext))
                                            {
                                                Dialog_ShowCallback(playerid, using inline SearchResponse, DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Parlante {CB3126}>{DADADA} Búsqueda", "{DADADA}Introduce el nombre del video de YouTube que quieres reproducir:", "Buscar", "Cancelar");
                                                return 1;
                                            }

                                            s_rgiUsingBoombox[playerid] = areaid;
                                            HTTP(playerid, HTTP_POST, STEREO_API_ENDPOINT("/api/boombox/search"), sr_inputtext, "STEREO_SearchResponse");
                                            Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Buscando...");
                                        }
                                        Dialog_ShowCallback(playerid, using inline SearchResponse, DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Parlante {CB3126}>{DADADA} Búsqueda", "{DADADA}Introduce el nombre del video de YouTube que quieres reproducir:", "Buscar", "Cancelar");
                                    }
                                    case 1:
                                    {
                                        if (data[e_iBoomboxOwnerId] != playerid)
                                        {
                                            Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No eres el dueño del parlante");
                                            return 1;
                                        }

                                        Boombox_Destroy(areaid);
                                        Inventory_AddFixedItem(playerid, ITEM_BOOMBOX, 1, 0);
                                        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Levantaste tu parlante");
                                    }
                                    case 2:
                                    {
                                        if (data[e_iBoomboxOwnerId] != playerid)
                                        {
                                            Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No eres el dueño del parlante");
                                            return 1;
                                        }

                                        data[e_bBoomboxIsPublic] = !data[e_bBoomboxIsPublic];
                                        Streamer_SetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), data);
                                        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "{CB3126}>>{DADADA} Parlante", va_return("{CB3126}>{DADADA} Poner música\n{CB3126}>{DADADA} Recoger\n{CB3126}>{DADADA} Público: %s", (data[e_bBoomboxIsPublic] ? "{64A752}Sí" : "{A83225}No")), "Siguiente", "Salir");
                                    }
                                }
                            }
                            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "{CB3126}>>{DADADA} Parlante", va_return("{CB3126}>{DADADA} Poner música\n{CB3126}>{DADADA} Recoger\n{CB3126}>{DADADA} Público: %s", (data[e_bBoomboxIsPublic] ? "{64A752}Sí" : "{A83225}No")), "Siguiente", "Salir");           
                        }
                    }
                    else
                    {
                        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Este parlante no es público");
                    }

                    break;
                }
            }
        }
    }

    #if defined STEREO_OnPlayerKeyStateChange
        return STEREO_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange STEREO_OnPlayerKeyStateChange
#if defined STEREO_OnPlayerKeyStateChange
    forward STEREO_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if (Player_Boombox(playerid))
    {
        Boombox_Destroy(Player_Boombox(playerid));
        Player_Boombox(playerid) = INVALID_STREAMER_ID;
    }

    #if defined STEREO_OnPlayerDisconnect
        return STEREO_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect STEREO_OnPlayerDisconnect
#if defined STEREO_OnPlayerDisconnect
    forward STEREO_OnPlayerDisconnect(playerid, reason);
#endif

static enum eVideoData
{
    e_szVideoId[12],
    e_szVideoTitle[128],
    e_szVideoDuration[12],
    e_iVideoDurationSecs,
};

forward STEREO_SearchResponse(playerid, response_code, const data[]);
public STEREO_SearchResponse(playerid, response_code, const data[])
{
    printf("[func] STEREO_SearchResponse(playerid = %d, response_code = %d, data[] = \"%s\")", playerid, response_code, data);

    if (response_code == 404)
    {
        s_rgiUsingBoombox[playerid] = INVALID_STREAMER_ID;
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No se encontraron resultados");
        return 1;
    }

    if (response_code != 200)
    {
        s_rgiUsingBoombox[playerid] = INVALID_STREAMER_ID;
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Error del servidor. Informe a un administrador e intente nuevamente");
        return 1;
    }

    if (!Boombox_Exists(s_rgiUsingBoombox[playerid]))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El parlante que estabas usando fue guardado");
        return 1;
    }

    // parse results
    new 
        cur = 0, next = -1,
        result_count = 0,
        videos[10][eVideoData];

    while ((next = strfind(data, "\n", .pos = cur)) != -1)
    {
        new result_str[256];
        strmid(result_str, data, cur, next);

        static video_title[128];
        if (sscanf(result_str, "p<,>s[12]s[128]s[12]i", videos[result_count][e_szVideoId], video_title, videos[result_count][e_szVideoDuration], videos[result_count][e_iVideoDurationSecs]))
        {
            Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Error normalizando datos. Informe a un administrador e intentelo nuevamente.");
            print("[stereo!] Error parsing data with sscanf.");
            print("[stereo!] line:");
            printf("[stereo!] %s", result_str);
            break;
        }

        for (new i; i < 128; ++i)
        {
            if (!video_title[i])
                break;

            if (video_title[i] == '\1')
            {
                video_title[i] = ',';
            }
        }

        utf8decode(videos[result_count][e_szVideoTitle], video_title);

        cur = next + 1;
        result_count++;
    }

    StrCpy(YSI_UNSAFE_HUGE_STRING, "{DADADA}Título\t{DADADA}Duración\t{DADADA}ID\n", YSI_UNSAFE_HUGE_LENGTH);

    for (new i; i < result_count; ++i)
    {
        strcat(YSI_UNSAFE_HUGE_STRING, va_return("{DADADA}%s\t{DADADA}%s\t{DADADA}%s\n", videos[i][e_szVideoTitle], videos[i][e_szVideoDuration], videos[i][e_szVideoId]), YSI_UNSAFE_HUGE_LENGTH);
    }

    inline const Response(response, listitem, string:inputtext[])
    {
        #if NDEBUG
            #pragma unused inputtext
        #endif

        DEBUG_PRINT("[func] inline const Response(response = %d, listitem = %d, inputtext[] = \"%s\") @ STEREO_SearchResponse", response, listitem, inputtext);

        if (!response || !(0 <= listitem < 10))
            return 1;
        
        if (!videos[listitem][e_szVideoTitle])
            return 1;

        if (!Boombox_Exists(s_rgiUsingBoombox[playerid]))
        {
            Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El parlante que estabas usando fue guardado");
            return 1;
        }

        new stereo_data[eBoomboxData];
        Streamer_GetArrayData(STREAMER_TYPE_AREA, s_rgiUsingBoombox[playerid], E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), stereo_data);
        StrCpy(stereo_data[e_szBoomboxCurrentlyPlaying], videos[listitem][e_szVideoId]);
        Streamer_SetArrayData(STREAMER_TYPE_AREA, s_rgiUsingBoombox[playerid], E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), stereo_data);

        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Espera mientras el servidor procesa tu petición");

        HTTP(playerid, HTTP_GET, va_return(STEREO_API_ENDPOINT("/api/boombox/download/%s"), videos[listitem][e_szVideoId]), "", "STEREO_DownloadResponse");
    }
    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}>>{DADADA} Parlante {CB3126}>{DADADA} Búsqueda", YSI_UNSAFE_HUGE_STRING, "Seleccionar", "Cancelar");

    return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if (Boombox_Exists(areaid))
    {
        StopAudioStreamForPlayer(playerid);
    }

    #if defined STEREO_OnPlayerLeaveDynamicArea
        return STEREO_OnPlayerLeaveDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea STEREO_OnPlayerLeaveDynamicArea
#if defined STEREO_OnPlayerLeaveDynamicArea
    forward STEREO_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if (Boombox_Exists(areaid))
    {
        new data[eBoomboxData];
        Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), data);

        if (data[e_bBoomboxDownloadDone])
        {
            new Float:x, Float:y, Float:z;
            GetDynamicObjectPos(data[e_iBoomboxObjectId], x, y, z);
            PlayAudioStreamForPlayer(playerid, va_return(STEREO_API_ENDPOINT("/api/boombox/play/%s"), data[e_szBoomboxCurrentlyPlaying]), x, y, z, 50.0, 1);
        }
    }

    #if defined STEREO_OnPlayerEnterDynamicArea
        return STEREO_OnPlayerEnterDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea STEREO_OnPlayerEnterDynamicArea
#if defined STEREO_OnPlayerEnterDynamicArea
    forward STEREO_OnPlayerEnterDynamicArea(playerid, areaid);
#endif

forward STEREO_DownloadResponse(playerid, response_code, const data[]);
public STEREO_DownloadResponse(playerid, response_code, const data[])
{
    if (!Boombox_Exists(s_rgiUsingBoombox[playerid]))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El parlante que estabas usando fue guardado");
        return 1;
    }

    if (response_code != 200)
    {
        printf("[stereo!] STEREO_DownloadResponse(playerid = %d, response_code = %d, const data[] = 0x%x)", playerid, response_code, data);
        printf("[stereo!] data = \"%s\"", data);
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No se pudo reproducir este video");
        return 1;
    }

    new stereo_data[eBoomboxData];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, s_rgiUsingBoombox[playerid], E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), stereo_data);

    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(stereo_data[e_iBoomboxObjectId], x, y, z);

    foreach (new i : PlayerInArea(s_rgiUsingBoombox[playerid], true))
    {
        PlayAudioStreamForPlayer(i, va_return("http://static.hyaxe.com/audio/%s.mp3", stereo_data[e_szBoomboxCurrentlyPlaying]), x, y, z, 50.0, 1);
    }

    stereo_data[e_bBoomboxDownloadDone] = true;
    Streamer_SetArrayData(STREAMER_TYPE_AREA, s_rgiUsingBoombox[playerid], E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), stereo_data);

    return 1;
}