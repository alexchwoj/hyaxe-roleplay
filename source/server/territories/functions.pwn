#if defined _territories_functions_
    #endinput
#endif
#define _territories_functions_

Territory_CancelConquest(territory_index)
{
    g_rgeTerritories[territory_index][e_iGangAttacking] = -1;
    g_rgeTerritories[territory_index][e_fConquestProgress] = 0.0;
    
    DestroyDynamicObject(g_rgeTerritories[territory_index][e_iFlagObject]);
    DestroyDynamic3DTextLabel(g_rgeTerritories[territory_index][e_iLabel]);
    DestroyDynamicMapIcon(g_rgeTerritories[territory_index][e_iMapIcon]);

    KillTimer(g_rgeTerritories[territory_index][e_iConquestTimer]);

    GangZoneStopFlashForAll(g_rgeTerritories[territory_index][e_iGangZone]);
    return 1;
}

Territory_SetGang(territory_index, gang_index)
{
    if (gang_index == -1)
        return 0;

    g_rgeTerritories[territory_index][e_iGangID] = Gang_Data(gang_index)[e_iGangDbId];
    g_rgeTerritories[territory_index][e_iColor] = Gang_Data(gang_index)[e_iGangColor];

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `GANG_TERRITORIES` SET `GANG_ID` = '%i' WHERE `TERRITORY_ID` = '%i';", g_rgeTerritories[territory_index][e_iGangID], g_rgeTerritories[territory_index][e_iID]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    new r, g, b;
    r = (g_rgeTerritories[territory_index][e_iColor] >> 24) & 0xFF;
    g = (g_rgeTerritories[territory_index][e_iColor] >> 16) & 0xFF;
    b = (g_rgeTerritories[territory_index][e_iColor] >> 8) & 0xFF;
    g_rgeTerritories[territory_index][e_iColor] = (r << 24 | g << 16 | b << 8 | 135);

    GangZoneHideForAll(g_rgeTerritories[territory_index][e_iGangZone]);
    GangZoneShowForAll(g_rgeTerritories[territory_index][e_iGangZone], g_rgeTerritories[territory_index][e_iColor]);   
    return 1;
}