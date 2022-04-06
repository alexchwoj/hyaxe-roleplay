#if defined _config_callbacks_
    #endinput
#endif
#define _config_callbacks_

on_init 00SetupServerConfig()
{
    print("[config] Setting up...");
    
	pp_public_min_index(0);

    SetMaxPlayers(MAX_PLAYERS);
    SetMaxNPCs(HYAXE_MAX_NPCS);

    for (new i = (sizeof(g_rgcAllowedNameChars) - 1); i != -1; --i)
	{
		AllowNickNameCharacter(g_rgcAllowedNameChars[i], true);
	}

	SendRconCommand(!"hostname Hyaxe Roleplay [Rol en español]");
	SendRconCommand(!"language Español / Spanish");
	SendRconCommand(!"gamemodetext Roleplay / RPG");
	SendRconCommand_s(@f("password %S", Str_Random(6)));

 
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
	SetNameTagDrawDistance(20.0);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	FCNPC_SetTickRate(GetConsoleVarAsInt("sleep"));
	
	print("[config] Server config done");
	printf("[config] maxplayers     = %i (MAX_PLAYERS = "#MAX_PLAYERS")", GetMaxPlayers());
	printf("[config] maxnpc         = %i", GetConsoleVarAsInt("maxnpc"));
	printf("[config] sleep          = %i", GetConsoleVarAsInt("sleep"));
	printf("[config] FCNPC tickrate = %i", FCNPC_GetTickRate());
	
	// Wait for full initialization
	wait_ticks(1);

	print("[config] Initializing ColAndreas...");

	CA_Init();
	
	SendRconCommand(!"password 0");

	return 1;
}