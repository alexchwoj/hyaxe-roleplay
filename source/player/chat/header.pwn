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
    List:g_rglChatBuffer[MAX_PLAYERS],
    bool:g_rgbRegisterChatMessages[MAX_PLAYERS char] = { bool:0x01010101, ... },
    NativeHook:g_hChatBufHook;