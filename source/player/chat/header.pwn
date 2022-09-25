#if defined _CHAT_HEADER_
    #endinput
#endif
#define _CHAT_HEADER_

enum eMessageData
{
    e_iColor,
    e_szMessage[144]
};

const CHAT_BUFFER_SIZE = 200;

new
    g_rgeChatBuffer[MAX_PLAYERS][CHAT_BUFFER_SIZE][eMessageData],
    bool:g_rgbRegisterChatMessages[MAX_PLAYERS char] = { bool:0x01010101, ... };

forward Chat_SendMessageToRange(playerid, color, Float:range, const string[]);