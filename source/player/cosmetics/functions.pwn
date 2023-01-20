#if defined _cosmetics_functions_
    #endinput
#endif
#define _cosmetics_functions_

Cosmetics_ResetSlots(playerid)
{
    for (new i; i < 6; i++)
    {
        g_rgiCosmeticsSlots[playerid][i] = -1;
    }
    return 1;
}

Cosmetics_GetFreeSlot(playerid)
{
	for(new i; i < HYAXE_MAX_COSMETICS; ++i)
	{
		if (!g_rgePlayerCosmetics[playerid][i][e_bValid])
		    return i;
	}
    return -1;
}

Player_GetPlacedCosmeticsCount(playerid)
{
    new count;
    for (new i; i < 6; i++)
    {
        if (g_rgiCosmeticsSlots[playerid][i] != -1)
            count++;
    }
    return count;
}

Player_GetCosmeticsCount(playerid)
{
    new count;
    for (new i; i < HYAXE_MAX_COSMETICS; i++)
    {
        if (g_rgePlayerCosmetics[playerid][i][e_bValid])
            count++;
    }
    return count;
}

Player_AddCosmetic(playerid, modelid, type, const name[])
{
    new cosmetic_name[32];
    StrCpy(cosmetic_name, name);

    inline const QueryDone()
    {
        new slot = Cosmetics_GetFreeSlot(playerid);
        if (slot != -1)
        {
            g_rgePlayerCosmetics[playerid][slot][e_iID] = cache_insert_id();
            g_rgePlayerCosmetics[playerid][slot][e_bValid] = true;
            g_rgePlayerCosmetics[playerid][slot][e_bPlaced] = false;

            g_rgePlayerCosmetics[playerid][slot][e_iModelID] = modelid;
            StrCpy(g_rgePlayerCosmetics[playerid][slot][e_szName], cosmetic_name);
            g_rgePlayerCosmetics[playerid][slot][e_iType] = type;

            g_rgePlayerCosmetics[playerid][slot][e_fScaleX] = 1.0;
            g_rgePlayerCosmetics[playerid][slot][e_fScaleY] = 1.0;
            g_rgePlayerCosmetics[playerid][slot][e_fScaleZ] = 1.0;

            Cosmetic_AutoAdjust(playerid, slot);
            Notification_ShowBeatingText(playerid, 2000, 0xFFFFFF, 100, 255, "Cosmético ~g~agregado");
        }
    }
    MySQL_TQueryInline(g_hDatabase, using inline QueryDone, "INSERT INTO `PLAYER_COSMETICS` (`ACCOUNT_ID`, `MODELID`, `TYPE`, `NAME`) VALUES (%d, %d, %d, '%e');", Player_AccountID(playerid), modelid, type, Str_FixEncoding(name));
    return 1;
}

Cosmetics_UpdateData(playerid, slot)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `PLAYER_COSMETICS` SET \
            `BONE` = %d, \
            `POS_X` = %f, \
            `POS_Y` = %f, \
            `POS_Z` = %f, \
            `ROT_X` = %f, \
            `ROT_Y` = %f, \
            `ROT_Z` = %f, \
            `SCALE_X` = %f, \
            `SCALE_Y` = %f, \
            `SCALE_Z` = %f, \
            `MATERIAL_COLOR_ONE` = %d, \
            `MATERIAL_COLOR_TWO` = %d, \
            `PLACED` = %d \
        WHERE `ID` = %i;\
    ",
        g_rgePlayerCosmetics[playerid][slot][e_iBone],
        g_rgePlayerCosmetics[playerid][slot][e_fPosX],
        g_rgePlayerCosmetics[playerid][slot][e_fPosY],
        g_rgePlayerCosmetics[playerid][slot][e_fPosZ],
        g_rgePlayerCosmetics[playerid][slot][e_fRotX],
        g_rgePlayerCosmetics[playerid][slot][e_fRotY],
        g_rgePlayerCosmetics[playerid][slot][e_fRotZ],
        g_rgePlayerCosmetics[playerid][slot][e_fScaleX],
        g_rgePlayerCosmetics[playerid][slot][e_fScaleY],
        g_rgePlayerCosmetics[playerid][slot][e_fScaleZ],
        g_rgePlayerCosmetics[playerid][slot][e_iMaterialColorOne],
        g_rgePlayerCosmetics[playerid][slot][e_iMaterialColorTwo],
        g_rgePlayerCosmetics[playerid][slot][e_bPlaced],
        g_rgePlayerCosmetics[playerid][slot][e_iID]
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    return 1;
}

Player_SetCosmetics(playerid)
{
    Cosmetics_ResetSlots(playerid);

    for(new i; i < 6; i++)
    {
        RemovePlayerAttachedObject(playerid, i);
    }

    new available_slot;
    for (new i; i < HYAXE_MAX_COSMETICS; i++)
    {
        if (g_rgePlayerCosmetics[playerid][i][e_bPlaced])
        {
            g_rgiCosmeticsSlots[playerid][available_slot] = i;
            g_rgePlayerCosmetics[playerid][i][e_iAttachedObjectSlot] = available_slot;
            SetPlayerAttachedObject(
                playerid,
                g_rgePlayerCosmetics[playerid][i][e_iAttachedObjectSlot],
                g_rgePlayerCosmetics[playerid][i][e_iModelID],
                g_rgePlayerCosmetics[playerid][i][e_iBone],
                g_rgePlayerCosmetics[playerid][i][e_fPosX],
                g_rgePlayerCosmetics[playerid][i][e_fPosY],
                g_rgePlayerCosmetics[playerid][i][e_fPosZ],
                g_rgePlayerCosmetics[playerid][i][e_fRotX],
                g_rgePlayerCosmetics[playerid][i][e_fRotY],
                g_rgePlayerCosmetics[playerid][i][e_fRotZ],
                g_rgePlayerCosmetics[playerid][i][e_fScaleX],
                g_rgePlayerCosmetics[playerid][i][e_fScaleY],
                g_rgePlayerCosmetics[playerid][i][e_fScaleZ],
                g_rgePlayerCosmetics[playerid][i][e_iMaterialColorOne],
                g_rgePlayerCosmetics[playerid][i][e_iMaterialColorTwo]
            );
            available_slot++;
        }
    }
    return 1;
}

Cosmetic_AutoAdjust(playerid, slot)
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
    return 1;
}

Cosmetic_ChangeName(playerid, slot)
{
    inline const CosmeticChangeName(response, listitem, string:inputtext[])
    {
        #pragma unused listitem
        #pragma unused inputtext

        if (response)
        {
            if(isnull(inputtext) || strlen(inputtext) > 32)
            {
                Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "El nombre debe tener más de 1 carácter y menos de 32 caracteres");
                return 1;
            }

            strcpy(g_rgePlayerCosmetics[playerid][slot][e_szName], inputtext);

            mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                UPDATE `PLAYER_COSMETICS` SET \
                    `NAME` = '%e' \
                WHERE `ID` = %i;\
            ",
                g_rgePlayerCosmetics[playerid][slot][e_szName],
                g_rgePlayerCosmetics[playerid][slot][e_iID]
            );
            mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

            Notification_ShowBeatingText(playerid, 2000, 0xFFFFFF, 100, 255, "Nombre ~g~cambiado");
        }
    }
    Dialog_ShowCallback(playerid, using inline CosmeticChangeName, DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} Cambiar nombre", va_return("{DADADA}Introduzca un nuevo nombre para el cosmético \"%s\":", g_rgePlayerCosmetics[playerid][slot][e_szName]), "Cambiar", "Cancelar");
    return 1;
}

Cosmetic_StartEdit(playerid, slot)
{
    inline const SelectBone(response, listitem, string:inputtext[])
    {
        #pragma unused inputtext

        if (response)
        {
            Player_SelectedBone(playerid) = listitem + 1;

            RemovePlayerAttachedObject(playerid, g_rgePlayerCosmetics[playerid][slot][e_iAttachedObjectSlot]);
            SetPlayerAttachedObject(
                playerid,
                g_rgePlayerCosmetics[playerid][slot][e_iAttachedObjectSlot],
                g_rgePlayerCosmetics[playerid][slot][e_iModelID],
                Player_SelectedBone(playerid),
                g_rgePlayerCosmetics[playerid][slot][e_fPosX],
                g_rgePlayerCosmetics[playerid][slot][e_fPosY],
                g_rgePlayerCosmetics[playerid][slot][e_fPosZ],
                g_rgePlayerCosmetics[playerid][slot][e_fRotX],
                g_rgePlayerCosmetics[playerid][slot][e_fRotY],
                g_rgePlayerCosmetics[playerid][slot][e_fRotZ],
                g_rgePlayerCosmetics[playerid][slot][e_fScaleX],
                g_rgePlayerCosmetics[playerid][slot][e_fScaleY],
                g_rgePlayerCosmetics[playerid][slot][e_fScaleZ],
                g_rgePlayerCosmetics[playerid][slot][e_iMaterialColorOne],
                g_rgePlayerCosmetics[playerid][slot][e_iMaterialColorTwo]
            );

            EditAttachedObject(playerid, g_rgePlayerCosmetics[playerid][slot][e_iAttachedObjectSlot]);
        }
    }

    Dialog_ShowCallback(playerid, using inline SelectBone, DIALOG_STYLE_LIST, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} ¿Dónde va el cosmético?", "\
        Espalda\n\
        Cabeza\n\
        Brazo izquierdo\n\
        Brazo derecho\n\
        Mano izquierda\n\
        Mano derecha\n\
        Muslo izquierdo\n\
        Muslo derecho\n\
        Pie izquierdo\n\
        Pie derecho\n\
        Pantorrilla derecha\n\
        Pantorrilla izquierda\n\
        Antebrazo izquierdo\n\
        Antebrazo derecho\n\
        Hombro izquierdo\n\
        Hombro derecho\n\
        Cuello\n\
        Boca", "Seleccionar", "Cancelar"
    );
    return 1;
}

Cosmetic_Delete(playerid, slot)
{
    inline ConfirmDelete(response, listitem, string:inputtext[])
    {
        #pragma unused listitem
        #pragma unused inputtext

        if (response)
        {
            g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_bValid] = false;
            g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_bPlaced] = false;

            mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `PLAYER_COSMETICS` WHERE `ID` = %d;", g_rgePlayerCosmetics[playerid][Player_SelectedCosmetic(playerid)][e_iID]);
            mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

            Player_SetCosmetics(playerid);
            Notification_ShowBeatingText(playerid, 2000, 0xFFFFFF, 100, 255, "Cosmético ~r~borrado");
        }
    }
    Dialog_ShowCallback(playerid, using inline ConfirmDelete, DIALOG_STYLE_MSGBOX, "{CB3126}>>{DADADA} Cosmético {CB3126}>{DADADA} Borrar", va_return("{DADADA}¿Estás seguro de que quieres borrar el cosmético \"%s\"?", g_rgePlayerCosmetics[playerid][slot][e_szName]), "Borrar", "Cancelar");
    return 1;
}