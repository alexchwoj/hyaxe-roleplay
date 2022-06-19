#if defined _death_functions_
    #endinput
#endif
#define _death_functions_

Player_Revive(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_INJURED, false);
	
    ClearAnimations(playerid);
	SetPlayerDrunkLevel(playerid, 0);
    KillTimer(g_rgeCrawlData[playerid][e_iCrawlKeyTimer]);
	
    ApplyAnimation(playerid, "PED", "CAR_CRAWLOUTRHS", 4.1, false, true, true, false, 0, false);
    return 1;
}

command kill(playerid, const params[], "Suicidarse")
{
    Player_SetHealth(playerid, 0);
    return 1;
}