#if defined _CHAT_CALLABACKS_
    #endinput
#endif
#define _CHAT_CALLABACKS_

forward CHAT_SendClientMessage(playerid, color, const message[]);
public CHAT_SendClientMessage(playerid, color, const message[])
{
    if(g_rgbRegisterChatMessages{playerid})
    {
        ChatBuffer_Push(playerid, color, message);
    }

    return SendClientMessage(playerid, color, message);
}

on_init InstallChatBufHook()
{
    printf("[chatbuffer] Installing native hooks...");
    g_hChatBufHook = pawn_add_hook("SendClientMessage", "-", "CHAT_SendClientMessage");
    return 1;
}

on_exit RemoveChatBufHook()
{
    pawn_remove_hook(g_hChatBufHook);
    return 1;
}

public OnPlayerConnect(playerid)
{
    g_rglChatBuffer[playerid] = list_new();
    list_reserve(g_rglChatBuffer[playerid], CHAT_BUFFER_SIZE);

    #if defined CHAT_OnPlayerConnect
        return CHAT_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect CHAT_OnPlayerConnect
#if defined CHAT_OnPlayerConnect
    forward CHAT_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if(list_valid(g_rglChatBuffer[playerid]))
    {
        list_delete_deep(g_rglChatBuffer[playerid]);
    }

    #if defined CHAT_OnPlayerDisconnect
        return CHAT_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect CHAT_OnPlayerDisconnect
#if defined CHAT_OnPlayerDisconnect
    forward CHAT_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerText(playerid, text[])
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
    {
        if (GetTickCount() - g_rgePlayerTempData[playerid][e_iPlayerChatTick] < 350)
        {
            SendClientMessage(playerid, 0xCB3126FF, "›{DADADA} ¡Vas a quemar el teclado!");
            return 0;
        }

        new string[150];
        format(string, sizeof(string), "%s dice: %s", Player_RPName(playerid), text);

        Chat_SendMessageToRange(playerid, 0xDADADAFF, 30.0, string);

        SetPlayerChatBubble(playerid, text, 0xDADADAFF, 15.0, 15000);
    }

    g_rgePlayerTempData[playerid][e_iPlayerChatTick] = GetTickCount();
    return 0;
}