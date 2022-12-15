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
                                                return 1;

                                            if (IsNull(sr_inputtext))
                                            {
                                                Dialog_ShowCallback(playerid, using inline SearchResponse, DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Parlante {CB3126}>{DADADA} Búsqueda", "{DADADA}Introduce el nombre del video de YouTube que quieres reproducir:", "Buscar", "Cancelar");
                                                return 1;
                                            }

                                            printf("inputtext = %s", sr_inputtext);
                                            s_rgiUsingBoombox[playerid] = areaid;
                                            HTTP(playerid, HTTP_POST, STEREO_API_ENDPOINT("/api/boombox/search"), sr_inputtext, "STEREO_SearchResponse");
                                            Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Buscando...");
                                        }
                                        Dialog_ShowCallback(playerid, using inline SearchResponse, DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Parlante {CB3126}>{DADADA} Búsqueda", "{DADADA}Introduce el nombre del video de YouTube que quieres reproducir:", "Buscar", "Cancelar");
                                    }
                                    case 1:
                                    {
                                        if(data[e_iBoomboxOwnerId] != playerid)
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
                                        if(data[e_iBoomboxOwnerId] != playerid)
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

forward STEREO_SearchResponse(playerid, response_code, data[]);
public STEREO_SearchResponse(playerid, response_code, data[])
{
    printf("[func] STEREO_SearchResponse(playerid = %d, response_code = %d, data[] = \"%s\")", playerid, response_code, data);

    if (response_code == 404)
    {
        s_rgiUsingBoombox[playerid] = INVALID_STREAMER_ID;
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No se encontraron resultados");
        return 1;
    }

    if (!Boombox_Exists(s_rgiUsingBoombox[playerid]))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El parlante que estabas usando fue guardado");
        return 1;
    }

    printf("%s", data);

    new videos[10][eVideoData];
    if (sscanf(data, "p<,>a<e<s[12]s[128]s[12]i>>[10]", videos))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Error normalizando datos. Informe a un administrador e intentelo nuevamente.");
        print("[stereo!] Error parsing data with sscanf.");
        print("[stereo!] data:");
        printf("[stereo!] %s", data);

        return 1;
    }

    return 1;
}