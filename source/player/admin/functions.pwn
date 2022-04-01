#if defined _admin_functions_
    #endinput
#endif
#define _admin_functions_

Admins_SendMessage(level, color, const message[])
{
    foreach(new i : Admin)
    {
        if(Player_AdminLevel(i) >= level)
        {
            SendClientMessage(i, color, message);
        }
    }

    return 1;
}

Admins_SendMessage_s(level, color, ConstString:message)
{
    new ConstAmxString:addr = str_addr_const(message);

    foreach(new i : Admin)
    {
        if(Player_AdminLevel(i) >= level)
        {
            SendClientMessage_s(i, color, addr);
        }
    }

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

Account_Ban(const account_name[], adminid, const reason[] = "No especificada", time_seconds = -1)
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
            ('%e', NULL, %s, '%e', %s);\
    ",
        account_name, admin_db, reason, expiration_db
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    return 1;
}