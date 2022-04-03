#if defined _commands_callbacks_
    #endinput
#endif
#define _commands_callbacks_

on_init RegisterCommands()
{
    /*
    __emit
    {
        const.pri 0
        sctrl 0xFE
    }
    */

    new name[32];

    for(new i = amx_num_publics() - 1; i != -1; --i)
    {
        amx_public_name(i, name);

        if(!strcmp("hy@cmd_", name, true, 7))
        {
            new addr = amx_public_addr(i);
            __emit
            {
                push.c 0
                lctrl 6
                add.c 36
                lctrl 8
                push.pri
                load.s.pri addr
                sctrl 6
            }
        }
    }

    /*
    __emit
    {
        const.pri 2
        sctrl 0xFF
    }
    */

    #if defined CMD_OnGameModeInit
        return CMD_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit CMD_OnGameModeInit
#if defined CMD_OnGameModeInit
    forward CMD_OnGameModeInit();
#endif

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    log_function();
    
    new cmd_level = (flags >>> 24);

    if(cmd_level > Player_AdminLevel(playerid))
        return 0;

    if(!(flags & CMD_NO_COOLDOWN) && (g_rgiPlayerCommandCooldown[playerid] && GetTickDiff(GetTickCount(), g_rgiPlayerCommandCooldown[playerid]) < 500))
    {
        SendClientMessage(playerid, 0xDADADAFF, "Solo puedes enviar {ED2B2B}dos comando por segundo{DADADA}. Algunos comandos no disponen de tiempo de espera.");
        return 0;
    }

    g_rgiPlayerCommandCooldown[playerid] = GetTickCount();

    #if defined CMD_OnPlayerCommandReceived
        return CMD_OnPlayerCommandReceived(playerid, cmd, params, flags);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerCommandReceived
    #undef OnPlayerCommandReceived
#else
    #define _ALS_OnPlayerCommandReceived
#endif
#define OnPlayerCommandReceived CMD_OnPlayerCommandReceived
#if defined CMD_OnPlayerCommandReceived
    forward CMD_OnPlayerCommandReceived(playerid, cmd[], params[], flags);
#endif

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    log_function();

    if(result == -1)
    {
        Commands_ShowSuggestions(playerid, cmd);
        return 0;
    }

    if((flags >>> 24) > RANK_LEVEL_USER && !(flags & CMD_DONT_LOG_COMMAND))
    {
        Admins_SendMessage_s(Player_AdminLevel(playerid), 0x415BA2FF, @f("{DADADA}%s %s {415BA2}%s{DADADA} usó el comando {415BA2}/%s{DADADA}.", (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_GetRankName(playerid), Player_RPName(playerid), cmd));
    }

    #if defined CMD_OnPlayerCommandPerformed
        return CMD_OnPlayerCommandPerformed(playerid, cmd, params, result, flags);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerCommandPerformed
    #undef OnPlayerCommandPerformed
#else
    #define _ALS_OnPlayerCommandPerformed
#endif
#define OnPlayerCommandPerformed CMD_OnPlayerCommandPerformed
#if defined CMD_OnPlayerCommandPerformed
    forward CMD_OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags);
#endif
