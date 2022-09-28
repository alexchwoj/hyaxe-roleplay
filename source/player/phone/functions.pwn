#if defined _phone_functions_
    #endinput
#endif
#define _phone_functions_

Phone_Show(playerid)
{
    for(new i = sizeof(g_tdPhone) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdPhone[i]);
    }

    for(new i = sizeof(p_tdPhone) - 1; i != -1; --i)
    {
        PlayerTextDrawShow(playerid, p_tdPhone[playerid]{i});
    }
    return 1;
}

Phone_Hide(playerid)
{
    return 1;
}