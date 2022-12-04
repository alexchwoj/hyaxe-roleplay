#if defined _controller_functions_
    #endinput
#endif
#define _controller_functions_

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