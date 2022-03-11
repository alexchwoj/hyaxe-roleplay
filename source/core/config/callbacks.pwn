#if defined _config_callbacks_
    #endinput
#endif
#define _config_callbacks_

public OnGameModeInit()
{
    print("[config] Setting up...");
    
    SetMaxPlayers(MAX_PLAYERS);
    SetMaxNPCs(1000 - MAX_PLAYERS);

    for (new i = (sizeof(g_rgcAllowedNameChars) - 1); i != -1; --i)
	{
		AllowNickNameCharacter(g_rgcAllowedNameChars[i], true);
	}

    SetNameTagDrawDistance(20.0);

	SendRconCommand(!"hostname Hyaxe Roleplay [Rol en español]");
	SendRconCommand(!"language Español / Spanish");
	SendRconCommand(!"gamemodetext Roleplay / RPG");

	SetServerRule(!"lagcomp", "skinshot");
	SetServerRule(!"weburl", "hyaxe.com");

	SetServerRuleFlags(!"weather", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"worldtime", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"version", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"mapname", CON_VARFLAG_READONLY);

	AddServerRule(!"versión de sa-mp", !"0.3.7");
	AddServerRule(!"discord", !"hyaxe.com/discord");

	new d, m, y;
	getdate(y, m, d);

	AddServerRule(!"última actualización", Date_ToString(y, m, d));

	SetModeRestartTime(1.0);
	YSF_EnableNightVisionFix(true);
	ToggleCloseConnectionFix(true);
    UsePlayerPedAnims();
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);
    ManualVehicleEngineAndLights();

    #if defined CONFIG_OnGameModeInit
        CONFIG_OnGameModeInit();
    #endif

	CA_Init();

	return 1;
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit CONFIG_OnGameModeInit
#if defined CONFIG_OnGameModeInit
    forward CONFIG_OnGameModeInit();
#endif