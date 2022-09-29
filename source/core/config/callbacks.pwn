#if defined _config_callbacks_
    #endinput
#endif
#define _config_callbacks_

#include <YSI_Coding/y_hooks>

#if !defined CHAIN_ORDER
	#define CHAIN_ORDER() 0
#endif

CHAIN_HOOK(Config)
#undef CHAIN_ORDER
#define CHAIN_ORDER CHAIN_NEXT(Config)
CHAIN_FORWARD:Config_OnScriptInit() = 1;

public OnScriptInit()
{
    print("[config] Setting up...");
    
	argon_set_thread_count(-1);

    SetMaxPlayers(MAX_PLAYERS);
    SetMaxNPCs(HYAXE_MAX_NPCS);

    for (new i = (sizeof(g_rgcAllowedNameChars) - 1); i != -1; --i)
	{
		AllowNickNameCharacter(g_rgcAllowedNameChars[i], true);
	}

	SendRconCommand(!"hostname Hyaxe Roleplay [Rol en español]");
	SendRconCommand(!"language Español / Spanish");
	SendRconCommand(!"gamemodetext Roleplay / RPG");

	new pw[7];
	Str_Random(pw, 6);
	SendRconCommand(va_return("password %s", pw));

	SetServerRule(!"lagcomp", "skinshot");
	SetServerRule(!"weburl", "hyaxe.com");

	SetServerRuleFlags(!"weather", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"worldtime", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"version", CON_VARFLAG_READONLY);
	SetServerRuleFlags(!"mapname", CON_VARFLAG_READONLY);

	AddServerRule(!"versión de sa-mp", !"0.3.7");
	AddServerRule(!"discord", !"discord.hyaxe.com");

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
	//AddPlayerClass(0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);

#if !NDEBUG
	Streamer_ToggleErrorCallback(true);
#endif

	print("[config] Server config done");
	printf("[config] maxplayers     = %i (MAX_PLAYERS = "#MAX_PLAYERS")", GetMaxPlayers());
	printf("[config] maxnpc         = %i", GetConsoleVarAsInt("maxnpc"));
	printf("[config] sleep          = %i", GetConsoleVarAsInt("sleep"));
	printf("[config] FCNPC tickrate = %i", FCNPC_GetTickRate());
	
	Config_OnScriptInit();
	return 1;
}

#undef OnScriptInit
#define OnScriptInit(%0) CHAIN_PUBLIC:Config_OnScriptInit(%0)

#if !NDEBUG
	public Streamer_OnPluginError(const error[])
	{
		printf("[streamer!] caught error: %s", error);
		PrintBacktrace();
		return 1;
	}
#endif

public OnGameModeInit()
{
	print("[config] Initializing ColAndreas...");

	CA_Init();
	
	SendRconCommand(!"password 0");
	
	printf("  _   ___   __ _    __  _______ ");
	printf(" | | | \\ \\ / // \\   \\ \\/ / ____|");
	printf(" | |_| |\\ V // _ \\   \\  /|  _|  ");
	printf(" |  _  | | |/ ___ \\  /  \\| |___ ");
	printf(" |_| |_| |_/_/   \\_\\/_/\\_\\_____|");
	printf("\n Hyaxe Server "SERVER_VERSION"\n");
                                
	for(new i = MAX_PLAYERS - 1; i != -1; --i)
	{
		if(FCNPC_IsValid(i))
			SetPlayerColor(i, 0xF7F7F700);
	}

	return 1;
}