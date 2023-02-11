#if defined _anticheat_commands_
    #endinput
#endif
#define _anticheat_commands_

command ac(playerid, const params[], "Abre el panel del anticheat")
{
    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Detección\t{DADADA}Estado\n");

    new line[128];
    for (new i; i < sizeof(g_rgeDetectionData); ++i)
    {
        format(line, sizeof(line), "{CB3126}>{DADADA} %s\t%s\n", g_rgeDetectionData[eCheats:i][e_szDetectionName], (g_rgeDetectionData[eCheats:i][e_bDetectionEnabled] ? "{64A752}+" : "{A83225}-"));
        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_ShowCallback(playerid, using public _hydg@ac_settings<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Hyaxe{DADADA} - Anticheat", HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Salir");
    return 1;
}
flags:ac(CMD_FLAG<RANK_LEVEL_SUPERADMIN>)

dialog ac_settings(playerid, dialogid, response, listitem, const inputtext[])
{
    if (!response)
        return 1;

    if (!(0 <= listitem < sizeof(g_rgeDetectionData)))
        return 1;

    g_rgeDetectionData[eCheats:listitem][e_bDetectionEnabled] = !g_rgeDetectionData[eCheats:listitem][e_bDetectionEnabled];
    //format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `DETECTIONS` SET `ENABLED` = %i WHERE `DETECTION_ID` = %i;", g_rgeDetectionData[eCheats:listitem][e_bDetectionEnabled], listitem);
    //db_free_result(db_query(g_hAnticheatDatabase, HYAXE_UNSAFE_HUGE_STRING));
    
    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Detección\t{DADADA}Estado\n");

    new line[128];
    for (new i; i < sizeof(g_rgeDetectionData); ++i)
    {
        format(line, sizeof(line), "{CB3126}>{DADADA} %s\t%s\n", g_rgeDetectionData[eCheats:i][e_szDetectionName], (g_rgeDetectionData[eCheats:i][e_bDetectionEnabled] ? "{64A752}+" : "{A83225}-"));
        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_ShowCallback(playerid, using public _hydg@ac_settings<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Hyaxe{DADADA} - Anticheat", HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Salir");

    return 1;
}