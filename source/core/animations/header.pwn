#if defined _animations_header_
    #endinput
#endif
#define _animations_header_

enum
{
    FADING_OUT,
    FADING_IN
};

new
    g_rgiFadingRounds[MAX_PLAYERS][PlayerText:MAX_PLAYER_TEXT_DRAWS char],
    g_rgiFadingTimers[MAX_PLAYERS][PlayerText:MAX_PLAYER_TEXT_DRAWS],
    g_rgbFadingInOut[MAX_PLAYERS][PlayerText:MAX_PLAYER_TEXT_DRAWS char];

forward Task:TD_Fade(playerid, PlayerText:textdraw, rounds = 5, interval = 5);
forward FADINGS_FadeTextDraw(playerid, PlayerText:textdraw, rounds, interval, Task:t);