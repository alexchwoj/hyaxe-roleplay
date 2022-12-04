#if defined _controller_functions_
    #endinput
#endif
#define _controller_functions_

GetPlayerWrappedKeys(playerid, &keys, &updown, &leftright)
{
    new ud, lr;
    GetPlayerKeys(playerid, keys, ud, lr);

    if (g_rgiPlayerUpDownKeys[playerid])
        updown = g_rgiPlayerUpDownKeys[playerid];
    else
        updown = ud;

    if (g_rgiPlayerLeftRightKeys[playerid])
        leftright = g_rgiPlayerLeftRightKeys[playerid];
    else
        leftright = lr;

    g_rgiPlayerUpDownKeys[playerid] = 0;
    g_rgiPlayerLeftRightKeys[playerid] = 0;
    return 1;
}

Controller_Show(playerid)
{
    for(new i; i < 6; ++i)
	{
        TextDrawShowForPlayer(playerid, g_tdController[i]);
	}

    SelectTextDraw(playerid, 0xDAA838FF);
    return 1;
}

Controller_Hide(playerid)
{
    for(new i; i < 6; ++i)
	{
        TextDrawHideForPlayer(playerid, g_tdController[i]);
	}

    CancelSelectTextDraw(playerid);
    return 1;
}