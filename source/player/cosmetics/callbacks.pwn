#if defined _cosmetics_callbacks_
    #endinput
#endif
#define _cosmetics_callbacks_

forward COS_OnCosmeticInserted(playerid, slot);
public COS_OnCosmeticInserted(playerid, slot)
{
    g_rgePlayerCosmetics[playerid][slot][e_iID] = cache_insert_id();
    return 1;
}

forward COS_LoadFromDatabase(playerid);
public COS_LoadFromDatabase(playerid)
{
    new row_count;
    cache_get_row_count(row_count);

    for(new i = 0; i < row_count; ++i)
    {
        new slot = Cosmetics_GetFreeSlot(playerid);
        if (slot != -1)
        {
            g_rgePlayerCosmetics[playerid][slot][e_bValid] = true;
            cache_get_value_name_int(i, "ID", g_rgePlayerCosmetics[playerid][slot][e_iID]);
            cache_get_value_name_int(i, "MODELID", g_rgePlayerCosmetics[playerid][slot][e_iModelID]);
            cache_get_value_name(i, "NAME", g_rgePlayerCosmetics[playerid][slot][e_szName]);
            cache_get_value_name_int(i, "TYPE", g_rgePlayerCosmetics[playerid][slot][e_iType]);
            cache_get_value_name_bool(i, "PLACED", g_rgePlayerCosmetics[playerid][slot][e_bPlaced]);

            cache_get_value_name_float(i, "POS_X", g_rgePlayerCosmetics[playerid][slot][e_fPosX]);
            cache_get_value_name_float(i, "POS_Y", g_rgePlayerCosmetics[playerid][slot][e_fPosY]);
            cache_get_value_name_float(i, "POS_Z", g_rgePlayerCosmetics[playerid][slot][e_fPosZ]);
            
            cache_get_value_name_float(i, "ROT_X", g_rgePlayerCosmetics[playerid][slot][e_fRotX]);
            cache_get_value_name_float(i, "ROT_Y", g_rgePlayerCosmetics[playerid][slot][e_fRotY]);
            cache_get_value_name_float(i, "ROT_Z", g_rgePlayerCosmetics[playerid][slot][e_fRotZ]);
            
            cache_get_value_name_float(i, "SCALE_X", g_rgePlayerCosmetics[playerid][slot][e_fScaleX]);
            cache_get_value_name_float(i, "SCALE_Y", g_rgePlayerCosmetics[playerid][slot][e_fScaleY]);
            cache_get_value_name_float(i, "SCALE_Z", g_rgePlayerCosmetics[playerid][slot][e_fScaleZ]);

            cache_get_value_name_int(i, "MATERIAL_COLOR_ONE", g_rgePlayerCosmetics[playerid][slot][e_iMaterialColorOne]);
            cache_get_value_name_int(i, "MATERIAL_COLOR_TWO", g_rgePlayerCosmetics[playerid][slot][e_iMaterialColorTwo]);
            cache_get_value_name_int(i, "BONE", g_rgePlayerCosmetics[playerid][slot][e_iBone]);
        }
    }
    return 1;
}

public OnPlayerAuthenticate(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT * FROM `PLAYER_COSMETICS` WHERE `ACCOUNT_ID` = %i;\
    ", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "COS_LoadFromDatabase", "i", playerid);

    #if defined COS_OnPlayerAuthenticate
        return COS_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate COS_OnPlayerAuthenticate
#if defined COS_OnPlayerAuthenticate
    forward COS_OnPlayerAuthenticate(playerid);
#endif

public OnPlayerConnect(playerid)
{
    Cosmetics_ResetSlots(playerid);

    #if defined COS_OnPlayerConnect
        return COS_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect COS_OnPlayerConnect
#if defined COS_OnPlayerConnect
    forward COS_OnPlayerConnect(playerid);
#endif


public OnPlayerDisconnect(playerid, reason)
{
    g_rgePlayerCosmetics[playerid] = g_rgePlayerCosmetics[MAX_PLAYERS];

    #if defined COS_OnPlayerDisconnect
        return COS_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect COS_OnPlayerDisconnect
#if defined COS_OnPlayerDisconnect
    forward COS_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerSpawn(playerid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
    {
        Player_SetCosmetics(playerid);
    }

    #if defined COS_OnPlayerSpawn
        return COS_OnPlayerSpawn(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerSpawn
    #undef OnPlayerSpawn
#else
    #define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn COS_OnPlayerSpawn
#if defined COS_OnPlayerSpawn
    forward COS_OnPlayerSpawn(playerid);
#endif

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV))
    {
        for(new i; i < 6; ++i)
	    {
            if (playertextid == p_tdToyView[playerid]{i})
            {
                if (!Player_GetCosmeticsCount(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes cosméticos, puedes comprarlos en cualquier tienda de ropa.");
                    return 1;
                }

                new slot = g_rgiCosmeticsSlots[playerid][i];
                Player_SelectedCosmeticMenu(playerid) = i;

                if (slot != -1)
                {
                    Dialog_ShowCallback(playerid, using public _hydg@cosmetic_options<iiiis>, DIALOG_STYLE_LIST, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} Opciones", va_return("%s\nCambiar nombre\nAjustar automáticamente\nAjuste manual\n{343434}Borrar cosmético", g_rgePlayerCosmetics[playerid][slot][e_bPlaced] ? "Sacar cosmético" : "Poner cosmético"), "Seleccionar", "Cerrar");
                }
                else
                {
                    HYAXE_UNSAFE_HUGE_STRING[0] = '\0';
                    new line[64];
                    for (new j; j < HYAXE_MAX_COSMETICS; j++)
                    {
                        if (g_rgePlayerCosmetics[playerid][j][e_bValid] && !g_rgePlayerCosmetics[playerid][j][e_bPlaced])
                        {
                            format(line, sizeof(line), "%s (#%d)\n", g_rgePlayerCosmetics[playerid][j][e_szName], g_rgePlayerCosmetics[playerid][j][e_iID]);
                            strcat(HYAXE_UNSAFE_HUGE_STRING, line);
                        }
                    }
                    Dialog_ShowCallback(playerid, using public _hydg@select_cosmetic<iiiis>, DIALOG_STYLE_LIST, "{CB3126}>>{DADADA} Cosméticos {CB3126}>{DADADA} Seleccionar", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Cerrar");
                }
                Inventory_Hide(playerid);
                return 1;
            }
        }
    }

    #if defined COS_OnPlayerClickPlayerTD
        return COS_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickPlayerTD
    #undef OnPlayerClickPlayerTextDraw
#else
    #define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw COS_OnPlayerClickPlayerTD
#if defined COS_OnPlayerClickPlayerTD
    forward COS_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
#endif

dialog select_cosmetic(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        PlayerPlaySound(playerid, SOUND_BUTTON);

        Player_SelectedCosmetic(playerid) = listitem;
        Dialog_ShowCallback(playerid, using public _hydg@cosmetic_options<iiiis>, DIALOG_STYLE_LIST, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} Opciones", va_return("%s\nCambiar nombre\nAjustar automáticamente\nAjuste manual\n{343434}Borrar cosmético", g_rgePlayerCosmetics[playerid][listitem][e_bPlaced] ? "Sacar cosmético" : "Poner cosmético"), "Seleccionar", "Cerrar");
    }
    return 1;
}

dialog cosmetic_options(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        new slot = Player_SelectedCosmetic(playerid);
        PlayerPlaySound(playerid, SOUND_BUTTON);

        switch(listitem)
        {
            case 0:
            {
                g_rgePlayerCosmetics[playerid][slot][e_bPlaced] = !g_rgePlayerCosmetics[playerid][slot][e_bPlaced];
                if (!g_rgePlayerCosmetics[playerid][slot][e_bPlaced])
                    g_rgiCosmeticsSlots[playerid][Player_SelectedCosmeticMenu(playerid)] = -1;
                
                Notification_ShowBeatingText(playerid, 2000, 0xFFFFFF, 100, 255, va_return("Cosmético %s", g_rgePlayerCosmetics[playerid][slot][e_bPlaced] ? "~g~activado" : "~r~desactivado"));
                
                ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 0, 0, 0, 1);
                Chat_SendAction(playerid, va_return("se %s un cosmético (%s)", g_rgePlayerCosmetics[playerid][slot][e_bPlaced] ? "pone" : "saca", g_rgePlayerCosmetics[playerid][slot][e_szName]));

                Player_SetCosmetics(playerid);
                Cosmetics_UpdateData(playerid, slot);

                PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
            }
            case 1:
            {
                Dialog_ShowCallback(playerid, using public _hydg@cosmetic_name<iiiis>, DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} Cambiar nombre", va_return("{DADADA}Introduzca un nuevo nombre para el cosmético \"%s\":", g_rgePlayerCosmetics[playerid][slot][e_szName]), "Cambiar", "Cancelar");
            }
            case 2:
            {
                g_rgePlayerCosmetics[playerid][slot][e_iBone] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_iBone];
                g_rgePlayerCosmetics[playerid][slot][e_fPosX] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fPosX];
                g_rgePlayerCosmetics[playerid][slot][e_fPosY] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fPosY];
                g_rgePlayerCosmetics[playerid][slot][e_fPosZ] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fPosZ];
                g_rgePlayerCosmetics[playerid][slot][e_fRotX] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fRotX];
                g_rgePlayerCosmetics[playerid][slot][e_fRotY] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fRotY];
                g_rgePlayerCosmetics[playerid][slot][e_fRotZ] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fRotZ];
                g_rgePlayerCosmetics[playerid][slot][e_fScaleX] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fScaleX];
                g_rgePlayerCosmetics[playerid][slot][e_fScaleY] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fScaleY];
                g_rgePlayerCosmetics[playerid][slot][e_fScaleZ] = g_rgeCosmeticsOffsets[g_rgePlayerCosmetics[playerid][slot][e_iType]][e_fScaleZ];

                Player_SetCosmetics(playerid);
                Cosmetics_UpdateData(playerid, slot);

                Notification_ShowBeatingText(playerid, 2000, 0xFFFFFF, 100, 255, "Cosmético ~g~ajustado");
                PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
            }
            case 3:
            {
                if (!g_rgePlayerCosmetics[playerid][slot][e_bPlaced])
                    return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes que tener el cosmético activado para poder editarlo");
            }
            case 4:
            {
                Dialog_ShowCallback(playerid, using public _hydg@cosmetic_confirm_delete<iiiis>, DIALOG_STYLE_MSGBOX, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} Borrar", va_return("{DADADA}¿Estás seguro de que quieres borrar el cosmético \"%s\"?", g_rgePlayerCosmetics[playerid][slot][e_szName]), "Borrar", "Cancelar");
            }
        }
    }
    return 1;
}

dialog cosmetic_confirm_delete(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        g_rgiCosmeticsSlots[playerid][Player_SelectedCosmeticMenu(playerid)] = -1;
        g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_bValid] = false;
        g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_bPlaced] = false;

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `PLAYER_COSMETICS` WHERE `ID` = %d;", g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_iID]);
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

        Player_SetCosmetics(playerid);
        Notification_ShowBeatingText(playerid, 2000, 0xFFFFFF, 100, 255, "Cosmético ~r~borrado");
    }
    return 1;
}

dialog cosmetic_name(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        if(isnull(inputtext) || strlen(inputtext) > 32)
        {
            Dialog_ShowCallback(playerid, using public _hydg@cosmetic_name<iiiis>, DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} Cambiar nombre", va_return("{DADADA}Introduzca un nuevo nombre para el cosmético \"%s\":", g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_szName]), "Cambiar", "Cancelar");
            return 1;
        }

        strcpy(g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_szName], inputtext);

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            UPDATE `PLAYER_COSMETICS` SET \
                `NAME` = %e \
            WHERE `ID` = %i;\
        ",
            g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_szName],
            g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_iID]
        );
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

        Notification_ShowBeatingText(playerid, 2000, 0xFFFFFF, 100, 255, "Nombre ~g~cambiado");
    }
    return 1;
}