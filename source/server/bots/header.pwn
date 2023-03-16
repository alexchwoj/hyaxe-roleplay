#if defined _bots_header_
    #endinput
#endif
#define _bots_header_

new g_iPingTimer[MAX_PLAYERS char], g_szBotAddressWhitelist[][16] = {
    "127.0.0.1",
    "170.83.220.2",
    "51.81.85.247"
};

#define Player_Bot(%0) (g_rgePlayerTempData[(%0)][e_iBot])