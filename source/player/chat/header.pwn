#if defined _CHAT_HEADER_
    #endinput
#endif
#define _CHAT_HEADER_

new
    bool:g_rgbMessagesDisabled[MAX_PLAYERS char] = { false, ... };

forward Chat_SendMessageToRange(playerid, color, Float:range, const string[]);
#define Player_DisableChat(%0,%1) (g_rgbMessagesDisabled{(%0)} = (%1))