#if defined _leveling_header_
    #endinput
#endif
#define _leveling_header_

const LEVEL_BAR_ANIMATION_STEPS = 100;
const Float:LEVEL_BAR_MIN_X = 233.500;
const Float:LEVEL_BAR_MAX_X = 397.500;

new 
    g_rgiLevelingBarSteps[MAX_PLAYERS char],
    g_rgiLevelingTimer[MAX_PLAYERS];

forward Player_AddXP(playerid, xp);
forward Player_SetLevel(playerid, level);

forward Levels_ShowBarToPlayer(playerid);
forward Level_GetRequiredXP(level);

#define Player_Level(%0) (g_rgePlayerData[(%0)][e_iPlayerLevel])
#define Player_XP(%0) (g_rgePlayerData[(%0)][e_iPlayerXp])

forward LEVELS_InterpolateTo(playerid, Float:init_x, Float:end_x, bool:new_level);
forward LEVELS_HideAllBars(playerid);