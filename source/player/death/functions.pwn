#if defined _death_functions_
    #endinput
#endif
#define _death_functions_

Player_Revive(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_INJURED, false);
	
    ResetPlayerWeapons(playerid);
    ClearAnimations(playerid);
	SetPlayerDrunkLevel(playerid, 0);
    KillTimer(g_rgeCrawlData[playerid][e_iCrawlKeyTimer]);
	
    ApplyAnimation(playerid, "PED", "CAR_CRAWLOUTRHS", 4.1, false, true, true, false, 0, false);
    Player_GiveAllWeapons(playerid);
    return 1;
}

command kill(playerid, const params[], "Suicidarse")
{
    if (Player_WantedLevel(playerid) || Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING) || Bit_Get(Player_Flags(playerid), PFLAG_ARRESTED))
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No puedes usar esto ahora mismo");

    Player_SetHealth(playerid, 0);
    return 1;
}