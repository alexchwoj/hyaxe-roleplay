#if defined _animations_functions_
    #endinput
#endif
#define _animations_functions_

TD_Fade(playerid, PlayerText:textdraw, rounds = 5, interval = 5, Func:callback<> = F@_@:-1)
{
    DEBUG_PRINT("[func] TD_Fade(playerid = %i, PlayerText:textdraw = %i, rounds = %i, interval = %i, Func:callback<> = %i)", playerid, _:textdraw, rounds, interval, _:callback);

    if ((interval % 2) != 0 && (interval % 5) != 0)
    {
        return 0;
    }

    g_rgiFadingTimers[playerid][textdraw] = SetTimerEx("FADINGS_FadeTextDraw", 15, true, "iiii", playerid, _:textdraw, rounds, interval);
    g_rgiFadingRounds[playerid]{textdraw} = 0;
    g_rgbFadingInOut[playerid]{textdraw} = FADING_IN;

    if (_:callback != -1)
    {
        Indirect_Claim(callback);
        g_rgpFadingCallbacks[playerid][textdraw] = callback;
    }

    return 1;
}