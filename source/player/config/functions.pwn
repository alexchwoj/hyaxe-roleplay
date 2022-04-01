#if defined _player_config_functions_
    #endinput
#endif
#define _player_config_functions_

Config_ToString(playerid)
{
    new str[CONFIG_MAX + 1];
    for(new i; i < CONFIG_MAX; ++i)
    {
        format(str, sizeof(str), "%s%i", str, Bit_Get(g_rgbsPlayerConfig[playerid], i));
    }
    return str;
}

Config_ResetDefaults(playerid)
{
    for(new i = 0; i < CONFIG_MAX; ++i)
    {
        Bit_Set(g_rgbsPlayerConfig[playerid], i, g_rgbConfigOptionDefaults{i});
    }
}

Config_Save(playerid)
{
    mysql_tquery_s(g_hDatabase, @f("UPDATE `ACCOUNT` SET `CONFIG_BITS` = '%s' WHERE `ID` = %i;", Config_ToString(playerid), Player_AccountID(playerid)));
    return 1;
}

Config_LoadFromCache(playerid)
{
    if(Player_Cache(playerid) == MYSQL_INVALID_CACHE)
        return 0;

    Config_ResetDefaults(playerid);

    static buf[CONFIG_MAX + 1];
    cache_get_value_name(0, !"CONFIG_BITS", buf);
    
    for(new i, j = strlen(buf); i < CONFIG_MAX && i < j; ++i)
    {
        Bit_Set(g_rgbsPlayerConfig[playerid], i, (buf[i] == '1'));
    }

    return 1;
}

command config(playerid, const params[], "Abre el panel de configuración")
{
    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Opción\t{DADADA}Estado\n");
    new line[128];
    for(new i; i < CONFIG_MAX; ++i)
    {
        format(line, sizeof(line), "{DADADA}%s\t%s\n", g_rgszConfigOptionNames[i], (Bit_Get(g_rgbsPlayerConfig[playerid], i) ? "{64A752}Sí" : "{A83225}No"));
        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_Show(playerid, "player_config", DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Hyaxe {DADADA}- Configuración", HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Salir");
    return 1;
}

dialog player_config(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(!(0 <= listitem < CONFIG_MAX))
        return 1;

    Bit_Toggle(g_rgbsPlayerConfig[playerid], listitem);

    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Opción\tEstado\n");
    new line[128];
    for(new i; i < CONFIG_MAX; ++i)
    {
        format(line, sizeof(line), "{DADADA}%s\t%s\n", g_rgszConfigOptionNames[i], (Bit_Get(g_rgbsPlayerConfig[playerid], i) ? "{64A752}Sí" : "{A83225}No"));
        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_Show(playerid, "player_config", DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Hyaxe {DADADA}- Configuración", HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Salir");

    Config_Save(playerid);

    return 1;
}