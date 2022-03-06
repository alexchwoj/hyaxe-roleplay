#if defined _textdraws_header_
    #endinput
#endif
#define _textdraws_header_

new
    Text:g_tdSpeedometer[6],
    Text:g_tdBankATM[6];

new
    PlayerText:p_tdBeatingText[MAX_PLAYERS char],
    PlayerText:p_tdBankATM_Balance[MAX_PLAYERS char],
    PlayerText:p_tdBankATM_ID[MAX_PLAYERS char];