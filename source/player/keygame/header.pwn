#if defined _keygame_header_
    #endinput
#endif
#define _keygame_header_

const Float:KEYGAME_BAR_MAX_Y = 115.0;
const Float:KEYGAME_BAR_MIN_Y = 16.0;

new const g_rgiRandomKeys[] = {
    KEY_YES, KEY_NO, KEY_CTRL_BACK, KEY_CROUCH, KEY_UP
};

new const g_rgszKeyNames[][] = {
    "~k~~CONVERSATION_YES~", 
    "~k~~CONVERSATION_NO~", 
    "~k~~GROUP_CONTROL_BWD~",
    "~k~~PED_DUCK~",
    "~k~~GO_FORWARD~"
};

enum eKeyGameTimers
{
    KG_TIMER_DECREASE_BAR,
    KG_TIMER_PROCESS_KEY
};

enum eKeyGameData
{
    e_pKgCallback,
    e_iKgTimers[eKeyGameTimers],
    e_iKgLastKeyAppearance,
    e_iKgCurrentKey,
    Float:e_fKgPercentagePerKey,
    Float:e_fKgDecreaseSec,
    Float:e_fKgCurrentSize,

    bool:e_bKgKeyRed,
    e_iKgKeyRedTick
};

new g_rgeKeyGameData[MAX_PLAYERS + 1][eKeyGameData];

forward Player_StartKeyGame(playerid, cb, Float:key_percentage_up = 9.9, Float:decrease_sec = 2.5);
forward Player_StopKeyGame(playerid);

forward KEYGAME_DecreaseBar(playerid);
forward KEYGAME_ProcessKey(playerid);