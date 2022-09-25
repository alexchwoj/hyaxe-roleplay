#if defined _commands_callbacks_
    #endinput
#endif
#define _commands_callbacks_

#include <YSI_Coding/y_hooks>

#if !defined CHAIN_ORDER
	#define CHAIN_ORDER() 0
#endif

CHAIN_HOOK(Commands)
#undef CHAIN_ORDER
#define CHAIN_ORDER CHAIN_NEXT(Commands)
CHAIN_FORWARD:Commands_OnScriptInit() = 1;

public OnScriptInit()
{
    new hdr[AMX_HDR];
    GetAmxHeader(hdr);

    new 
        idx = 0,
        ptr;

    while((idx = AMX_GetPublicPointerPrefix(idx, ptr, _A<hy@cmd_>)))
    {
        __emit 
        {
            push.c 0
            lctrl 6
            add.c 36
            lctrl 8
            push.pri
            load.s.pri ptr
            sctrl 6
        }
    }

    Commands_OnScriptInit();
    return 1;
}

#undef OnScriptInit
#define OnScriptInit(%0) CHAIN_PUBLIC:Commands_OnScriptInit(%0)

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if (!Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No has iniciado sesión.");
        return 0;
    }

    new cmd_level = (flags >>> 24);

    if (cmd_level > Player_AdminLevel(playerid))
        return 0;

    if(!(flags & CMD_NO_COOLDOWN) && (g_rgiPlayerCommandCooldown[playerid] && 500 > GetTickCount() - g_rgiPlayerCommandCooldown[playerid]))
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
    if(result == -1)
    {
        Commands_ShowSuggestions(playerid, cmd);
        return 0;
    }

    if((flags >>> 24) > RANK_LEVEL_USER && !(flags & CMD_DONT_LOG_COMMAND))
    {
        Admins_SendMessage(Player_AdminLevel(playerid), 0x415BA2FF, va_return("{DADADA}%s %s {415BA2}%s{DADADA} usó el comando {415BA2}/%s{BFBFBF} %s.", (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_GetRankName(playerid), Player_RPName(playerid), cmd, params));
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
