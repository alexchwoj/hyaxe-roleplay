#if defined _textdraws_header_
    #endinput
#endif
#define _textdraws_header_

new
    Text:g_tdSpeedometer[10],
    Text:g_tdBankATM[8],
    Text:g_tdKeyGame[4],
    Text:g_tdShops[12],
    Text:g_tdNeedBars[4]
;

new
    PlayerText:p_tdSpeedometer[MAX_PLAYERS][4 char],
    PlayerText:p_tdBeatingText[MAX_PLAYERS char],
    PlayerText:p_tdKey_BG[MAX_PLAYERS char],
    PlayerText:p_tdKey_Text[MAX_PLAYERS char],
    PlayerText:p_tdKeyGame[MAX_PLAYERS char],
    PlayerText:p_tdNeedBars[MAX_PLAYERS][2 char]
;