#if defined _fixes_textdraws_
    #endinput
#endif
#define _fixes_textdraws_

forward OnPlayerCancelTDSelection(playerid);

static
    s_TextDrawCancelTick[MAX_PLAYERS],
    s_TextDrawSelectColor[MAX_PLAYERS];

stock hy_fix_SelectTextDraw(playerid, hovercolor)
{
    s_TextDrawSelectColor[playerid] = hovercolor;
    return SelectTextDraw(playerid, hovercolor);
}

#if defined _ALS_SelectTextDraw
    #undef SelectTextDraw
#else
    #define _ALS_SelectTextDraw
#endif
#define SelectTextDraw hy_fix_SelectTextDraw

stock hy_fix_CancelSelectTextDraw(playerid)
{
    s_TextDrawCancelTick[playerid] = GetTickCount();
    return CancelSelectTextDraw(playerid);
}

#if defined _ALS_CancelSelectTextDraw
    #undef CancelSelectTextDraw
#else
    #define _ALS_CancelSelectTextDraw
#endif
#define CancelSelectTextDraw hy_fix_CancelSelectTextDraw

stock GetPlayerTextDrawSelectionColor(playerid)
{
    return s_TextDrawSelectColor[playerid];
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == INVALID_TEXT_DRAW)
    {
        if(!s_TextDrawCancelTick[playerid] || GetTickDiff(GetTickCount(), s_TextDrawCancelTick[playerid]) < 50 + GetPlayerPing(playerid))
        {
            CallLocalFunction(!"OnPlayerCancelTDSelection", !"i", playerid);
        }

        s_TextDrawCancelTick[playerid] = 0;
        return 1;
    }

    #if defined TD_FIX_OnPlayerClickTextDraw
        return TD_FIX_OnPlayerClickTextDraw(playerid, clickedid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw TD_FIX_OnPlayerClickTextDraw
#if defined TD_FIX_OnPlayerClickTextDraw
    forward TD_FIX_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif