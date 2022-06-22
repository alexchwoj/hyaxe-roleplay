#if defined _animations_callbacks_
    #endinput
#endif
#define _animations_callbacks_

static bool:s_rgbKillFadings[MAX_PLAYERS char];

public FADINGS_FadeTextDraw(playerid, PlayerText:textdraw, rounds, interval, Task:t)
{
    if(s_rgbKillFadings{playerid})
    {
        if(task_valid(t))
            task_delete(t);

        Timer_Kill(g_rgiFadingTimers[playerid][textdraw]);
        s_rgbKillFadings{playerid} = false;
        return 1;
    }
    
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
            if(task_valid(t))
                task_set_result(t, 1);
        }
    }

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    s_rgbKillFadings{playerid} = true;

    #if defined ANIMS_OnPlayerDisconnect
        return ANIMS_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect ANIMS_OnPlayerDisconnect
#if defined ANIMS_OnPlayerDisconnect
    forward ANIMS_OnPlayerDisconnect(playerid, reason);
#endif
