#if defined _bots_header_
    #endinput
#endif
#define _bots_header_

new g_iPingTimer[MAX_PLAYERS char], g_szBotAddressWhitelist[][16] = {
    "54.243.23.87"
};

#define Player_Bot(%0) (g_rgePlayerTempData[(%0)][e_iBot])