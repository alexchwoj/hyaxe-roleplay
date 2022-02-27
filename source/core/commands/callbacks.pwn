#if defined _commands_callbacks_
    #endinput
#endif
#define _commands_callbacks_

public OnGameModeInit()
{
    new hdr[AMX_HDR], name[32];
    GetAmxHeader(hdr);

    for(new i = GetNumPublics(hdr); i != -1; --i)
    {
        if(!GetPublicNameFromIndex(i, name))
            continue;

        if(!strcmp("hy@cmd_", name, true, 7))
        {
            new addr = GetPublicAddressFromIndex(i);
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
    DEBUG_PRINT("OnPlayerCommandReceived(%d, \"%s\", \"%s\", %b)", playerid, cmd, params, flags);
    
    new cmd_level = (flags & 0xFF000000);

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
