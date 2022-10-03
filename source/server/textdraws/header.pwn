#if defined _textdraws_header_
    #endinput
#endif
#define _textdraws_header_

new
    Text:g_tdSpeedometer[10],
    Text:g_tdBankATM[8],
    Text:g_tdKeyGame[4],
    Text:g_tdShops[12],
    Text:g_tdNeedBars[4],
    Text:g_tdInventoryBG[5],
    Text:g_tdInventoryExp[2],
    Text:g_tdInventoryUsername,
    Text:g_tdInveotrySections[2],
    Text:g_tdLevelingBar[6],
    Text:g_tdGangs[9],
    Text:g_tdGangMemberSlotBg[7],
    Text:g_tdGangEventText,
    Text:g_tdPhone[30]
    //Text:g_tdDebugScreen[4]
;

new
    PlayerText:p_tdSpeedometer[MAX_PLAYERS][4 char],
    PlayerText:p_tdBeatingText[MAX_PLAYERS char],
    PlayerText:p_tdKey_BG[MAX_PLAYERS char],
    PlayerText:p_tdKey_Text[MAX_PLAYERS char],
    PlayerText:p_tdKeyGame[MAX_PLAYERS char],
    PlayerText:p_tdNeedBars[MAX_PLAYERS][2 char],
    PlayerText:p_tdItemView[MAX_PLAYERS][21 char],
    PlayerText:p_tdItemCount[MAX_PLAYERS][21 char],
    PlayerText:p_tdTrunkItemView[MAX_PLAYERS][14 char],
    PlayerText:p_tdTrunkItemCount[MAX_PLAYERS][14 char],
    PlayerText:p_tdInventorySkin[MAX_PLAYERS char],
    PlayerText:p_tdInventoryExpBar[MAX_PLAYERS char],
    PlayerText:p_tdInventoryExpText[MAX_PLAYERS char],
    PlayerText:p_tdToyView[MAX_PLAYERS][6 char],
    PlayerText:p_tdLevelingBar[MAX_PLAYERS][2 char],
    PlayerText:p_tdItemOptions[MAX_PLAYERS][6 char],
    PlayerText:p_tdGangMemberSlots[MAX_PLAYERS][7][3 char],
    PlayerText:p_tdPhone[MAX_PLAYERS][6 char]
;