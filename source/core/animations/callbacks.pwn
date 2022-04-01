#if defined _animations_callbacks_
    #endinput
#endif
#define _animations_callbacks_

public FADINGS_FadeTextDraw(playerid, PlayerText:textdraw, rounds, interval, Task:t)
{
    log_function();

    new color = PlayerTextDrawGetColor(playerid, textdraw);
    new alpha = (color & 0xFF);

    if(g_rgbFadingInOut[playerid]{textdraw} == FADING_OUT)
    {
        alpha += interval;
    }
    else
    {
        alpha -= interval;
    }

    new alpha_new = clamp(alpha, 0, 255);
    PlayerTextDrawColor(playerid, textdraw, (color & 0xFFFFFF00) | alpha_new);
    PlayerTextDrawShow(playerid, textdraw);

    if(alpha_new == 0)
    {
        g_rgbFadingInOut[playerid]{textdraw} = FADING_OUT;
    }
    else if(alpha_new == 255)
    {
        g_rgbFadingInOut[playerid]{textdraw} = FADING_IN;
        g_rgiFadingRounds[playerid]{textdraw}++;

        if(g_rgiFadingRounds[playerid]{textdraw} >= rounds)
        {
            Timer_Kill(g_rgiFadingTimers[playerid][textdraw]);
            task_set_result(t, 1);
        }
    }

    return 1;
}