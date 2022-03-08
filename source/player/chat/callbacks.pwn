#if defined _CHAT_CALLABACKS_
    #endinput
#endif
#define _CHAT_CALLABACKS_

public OnPlayerText(playerid, text[])
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
    {
        if (GetTickDiff(GetTickCount(), g_rgePlayerTempData[playerid][e_iPlayerChatTick]) < 350)
        {
            SendClientMessage(playerid, 0xCB3126FF, "›{DADADA} ¡Vas a quemar el teclado!");
            return 0;
        }

        new string[288];
        format(string, sizeof(string), "%s dice: %s", Player_RPName(playerid), text);

        Chat_SendMessageToRange(playerid, 0xDADADAFF, 30.0, string);

        SetPlayerChatBubble(playerid, text, 0xDADADAFF, 15.0, 15000);
    }

    g_rgePlayerTempData[playerid][e_iPlayerChatTick] = GetTickCount();
    return 0;
}