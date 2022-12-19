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
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        INSERT INTO `PLAYER_COSMETICS` (`ACCOUNT_ID`, `MODELID`, `TYPE`, `NAME`) VALUES (%d, %d, %d, %s);\
    ", Player_AccountID(playerid), modelid, name);

    new slot = Cosmetics_GetFreeSlot(playerid);
    if (slot != -1)
    {
        g_rgePlayerCosmetics[playerid][slot][e_bValid] = true;
        
        g_rgePlayerCosmetics[playerid][slot][e_iModelID] = modelid;
        g_rgePlayerCosmetics[playerid][slot][e_szName] = name;
        g_rgePlayerCosmetics[playerid][slot][e_iType] = type;

        g_rgePlayerCosmetics[playerid][slot][e_fScaleX] = 1.0;
        g_rgePlayerCosmetics[playerid][slot][e_fScaleY] = 1.0;
        g_rgePlayerCosmetics[playerid][slot][e_fScaleZ] = 1.0;

        g_rgePlayerCosmetics[playerid][slot][e_bPlaced] = false;

        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "COS_OnCosmeticInserted", !"ii", playerid, slot);
    }
    return 1;
}

Player_SetCosmetics(playerid)
{
    Cosmetics_ResetSlots(playerid);

    for(new i; i < 6; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i))
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