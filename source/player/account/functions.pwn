#if defined _account_functions_
    #endinput
#endif
#define _account_functions_

Account_RegisterConnection(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "INSERT INTO `CONNECTION_LOG` (`ACCOUNT_ID`, `IP_ADDRESS`) VALUES (%i, '%e');", Player_AccountID(playerid), RawIpToString(Player_IP(playerid)));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
}

Account_Register(playerid, callback = -1)
{
    Config_ResetDefaults(playerid);
    Player_Money(playerid) = PLAYER_DEFAULT_MONEY;
    Player_SetHealth(playerid, 100);
    
    g_rgePlayerData[playerid][e_fSpawnPosX] = PLAYER_SPAWN_X;    
    g_rgePlayerData[playerid][e_fSpawnPosY] = PLAYER_SPAWN_Y;    
    g_rgePlayerData[playerid][e_fSpawnPosZ] = PLAYER_SPAWN_Z;    
    g_rgePlayerData[playerid][e_fSpawnPosAngle] = PLAYER_SPAWN_ANGLE;

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        INSERT INTO `ACCOUNT` \
            (`NAME`, `EMAIL`, `EMAIL_VERIFICATION_CODE`, `PASSWORD`, `SKIN`, `SEX`, `MONEY`, `POS_X`, `POS_Y`, `POS_Z`, `ANGLE`, `CURRENT_CONNECTION`, `CURRENT_PLAYERID`, `CONFIG_BITS`) \
        VALUES \
            ('%e', '%e', REPLACE(UUID(), '-', ''), SHA2('%e', 256), %i, %i, %i, %.2f, %.2f, %.2f, %.2f, UNIX_TIMESTAMP(), %i, '%s');\
        ",
        Player_Name(playerid), Player_Email(playerid), Player_Password(playerid),
        Player_Skin(playerid), Player_Sex(playerid), PLAYER_DEFAULT_MONEY, 
        PLAYER_SPAWN_X, PLAYER_SPAWN_Y, PLAYER_SPAWN_Z, PLAYER_SPAWN_ANGLE,
        playerid, Config_ToString(playerid)
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "OnAccountInserted", !"ii", playerid, callback);

    memset(g_rgePlayerData[playerid][e_szPassword], '\0');

    return 1;
}

Account_Save(playerid, bool:disconnect = false)
{
    if(!Player_AccountID(playerid))
        return 0;

    if(!Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
        return 0;

    if(IsPlayerSpawned(playerid))
    {
        GetPlayerPos(playerid, g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ]);
        GetPlayerFacingAngle(playerid, g_rgePlayerData[playerid][e_fSpawnPosAngle]);
        Player_VirtualWorld(playerid) = GetPlayerVirtualWorld(playerid);
        Player_Interior(playerid) = GetPlayerInterior(playerid);
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `ACCOUNT` SET \
            `PLAYED_TIME` = (`PLAYED_TIME` + (UNIX_TIMESTAMP() - `CURRENT_CONNECTION`)) - %i, \
            `POS_X` = %.2f, \
            `POS_Y` = %.2f, \
            `POS_Z` = %.2f, \
            `ANGLE` = %.2f, \
            `VIRTUAL_WORLD` = %i, \
            `INTERIOR` = %i, \
            `HEALTH` = %i, \
            `ARMOR` = %i, \
            `HUNGER` = %f, \
            `THIRST` = %f, \
            `SKIN` = %i, \
            `LEVEL` = %i, \
            `XP` = %i, \
            `CURRENT_PLAYERID` = %i%s \
        WHERE `ID` = %i;\
    ", 
        g_rgePlayerData[playerid][e_iPlayerPausedTime],
        g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ], g_rgePlayerData[playerid][e_fSpawnPosAngle],
        Player_VirtualWorld(playerid), Player_Interior(playerid), Player_Health(playerid), Player_Armor(playerid), Player_Hunger(playerid), Player_Thirst(playerid),
        Player_Skin(playerid), Player_Level(playerid), Player_XP(playerid), (disconnect ? -1 : playerid), 
        (disconnect ? ", CURRENT_CONNECTION = 0" : ""), Player_AccountID(playerid)
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    return 1;
}

Account_LoadFromCache(playerid)
{
    if(Player_Cache(playerid) == MYSQL_INVALID_CACHE)
        return 0;

    cache_set_active(Player_Cache(playerid));

    cache_get_value_name_int(0, !"ID", Player_AccountID(playerid));
    cache_get_value_name(0, !"PASSWORD", Player_Password(playerid));
    cache_get_value_name_int(0, !"SEX", Player_Sex(playerid));
    cache_get_value_name_int(0, !"MONEY", Player_Money(playerid));
    cache_get_value_name_int(0, !"HEALTH", Player_Health(playerid));
    cache_get_value_name_int(0, !"ARMOR", Player_Armor(playerid));
    cache_get_value_name_float(0, !"POS_X", g_rgePlayerData[playerid][e_fSpawnPosX]);
    cache_get_value_name_float(0, !"POS_Y", g_rgePlayerData[playerid][e_fSpawnPosY]);
    cache_get_value_name_float(0, !"POS_Z", g_rgePlayerData[playerid][e_fSpawnPosZ]);
    cache_get_value_name_float(0, !"ANGLE", g_rgePlayerData[playerid][e_fSpawnPosAngle]);
    cache_get_value_name_int(0, !"VIRTUAL_WORLD", Player_VirtualWorld(playerid));
    cache_get_value_name_int(0, !"INTERIOR", Player_Interior(playerid));
    cache_get_value_name(0, !"LAST_CONNECTION", Player_LastConnection(playerid));
    cache_get_value_name_int(0, !"SKIN", Player_Skin(playerid));
    cache_get_value_name_float(0, !"HUNGER", Player_Hunger(playerid));
    cache_get_value_name_float(0, !"THIRST", Player_Thirst(playerid));
    cache_get_value_name_int(0, !"XP", Player_XP(playerid));
    cache_get_value_name_int(0, !"LEVEL", Player_Level(playerid));
    cache_get_value_name_int(0, !"ADMIN_LEVEL", Player_AdminLevel(playerid));
    cache_get_value_name_int(0, !"PLAYED_TIME", Player_SavedPlayedTime(playerid));

    Player_LoadWeaponsFromCache(playerid);
    Config_LoadFromCache(playerid);

    cache_unset_active();
    cache_delete(Player_Cache(playerid));
    Player_Cache(playerid) = MYSQL_INVALID_CACHE;

    return 1;
}

Player_Ban(playerid, adminid, const reason[] = "No especificada", time_seconds = -1)
{
    new admin_db[24] = "NULL";
    if(adminid != ADMIN_ID_ANTICHEAT)
        format(admin_db, sizeof(admin_db), "%i", Player_AccountID(adminid));

    new expiration_db[80] = "NULL";
    if(time_seconds > 0)
        format(expiration_db, sizeof(expiration_db), "DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL %i SECOND)", time_seconds);

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        INSERT INTO `BANS` \
            (`BANNED_USER`, `BANNED_IP`, `ADMIN_ID`, `REASON`, `EXPIRATION_DATE`) \
        VALUES \
            ('%e', '%e', %s, '%e', %s);\
    ",
        Player_Name(playerid), RawIpToString(Player_IP(playerid)), admin_db, reason, expiration_db
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    new year, month, day, hour, minute, second;
    gettime(hour, minute, second);
    getdate(year, month, day);

    new String:dialog_str = @f(
        "{DADADA}Tu cuenta fue vetada %s del servidor.\n\n\
        {CB3126}Administrador\n\
        \t{DADADA}\
    ",
        (time_seconds < 0 ? "permanentemente" : "temporalmente")
    );

    if(adminid == ADMIN_ID_ANTICHEAT)
    {
        dialog_str += @("Anticheat\n\n");
    }
    else
    {
        dialog_str += @f("%s (Cuenta ID {CB3126}%i{DADADA})\n\n", Player_RPName(adminid), Player_AccountID(adminid));
    }

    dialog_str += @f("\
        {CB3126}Razón de expulsión\n\t{DADADA} %s\n\n\
        {CB3126}Fecha de expulsión\n\t{DADADA}%i/%i/%i %i:%i:%i\n\n\
        {CB3126}Expira en\n\t{DADADA}\
    ", 
        reason,
        day, month, year, hour, minute, second
    );

    if(time_seconds < 0)
    {
        dialog_str += @("Nunca");
    }
    else
    {
        new seconds = (time_seconds % 60);
        new minutes = (time_seconds % 3600) / 60;
        new hours = (time_seconds % 86400) / 3600;
        new days = (time_seconds % (86400 * 30)) / 86400;

        new bool:has_previous = false;

        if(days)
        {
            dialog_str += @f("%i día%s", days, (days > 1 ? "s" : ""));
            has_previous = true;
        }

        if(hours)
        {
            dialog_str += @f("%s%i hora%s", (has_previous ? ", " : ""), hours, (hours > 1 ? "s" : ""));
            has_previous = true;
        }

        if(minutes)
        {
            dialog_str += @f("%s%i minuto%s", (has_previous ? ", " : ""), minutes, (minutes > 1 ? "s" : ""));
            has_previous = true;
        }

        if(seconds)
        {
            dialog_str += @f("%s%i segundo%s", (has_previous ? " y " : ""), seconds, (seconds > 1 ? "s" : ""));
        }
    }

    Dialog_Show_s(playerid, "kick", DIALOG_STYLE_MSGBOX, @("{CB3126}Hyaxe {DADADA}- Expulsión"), dialog_str, "Salir");

    KickTimed(playerid, 500);

    return 1;
}

Player_GiveMoney(playerid, money, bool:update = true)
{
    Player_Money(playerid) += money;

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, Player_Money(playerid));

	if(update)
	{
        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `MONEY` = %i WHERE `ID` = %i;", Player_Money(playerid), Player_AccountID(playerid));
		mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
	}

	return 1;
}

Player_SetMoney(playerid, money, bool:update = true)
{
    Player_Money(playerid) = money;

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, money);

	if(update)
	{
        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `MONEY` = %i WHERE `ID` = %i;", Player_Money(playerid), Player_AccountID(playerid));
		mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
	}

	return 1;
}
