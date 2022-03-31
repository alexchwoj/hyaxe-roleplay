#if defined _animations_functions_
    #endinput
#endif
#define _animations_functions_

Task:TD_Fade(playerid, PlayerText:textdraw, rounds = 5, interval = 5)
{
    new Task:t = task_new();

    if((interval % 2) != 0 && (interval % 5) != 0)
    {
        task_set_error_ticks(t, amx_err_params, 1);
        return t;
    }

    g_rgiFadingTimers[playerid][textdraw] = SetTimerEx("FADINGS_FadeTextDraw", 15, true, "iiiii", playerid, _:textdraw, rounds, interval, _:t);
    g_rgiFadingRounds[playerid]{textdraw} = 0;
    g_rgbFadingInOut[playerid]{textdraw} = FADING_IN;

    return t;
}