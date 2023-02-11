#if defined _CHAT_CALLABACKS_
    #endinput
#endif
#define _CHAT_CALLABACKS_

#include <YSI_Coding/y_hooks>

hook native SendClientMessage(playerid, color, const message[])
{
    if (g_rgbMessagesDisabled{playerid})
        return 1;

    return continue(playerid, color, message);
}

public OnPlayerConnect(playerid)
{
    g_rgbMessagesDisabled{playerid} = false;

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

public OnPlayerDisconnect(playerid, reason)
{
    static const reason_name[3][24] = {"Crash/Desconexión", "Voluntariamente", "Expulsado/Baneado"};
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "%s (%d) se ha desconectado del servidor. {DAA838}(%s)", Player_RPName(playerid), playerid, reason_name[reason]);
    Chat_SendMessageToRange(playerid, 0xDADADAFF, 60.0, HYAXE_UNSAFE_HUGE_STRING);

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
