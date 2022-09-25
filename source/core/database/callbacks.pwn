#if defined _CALLBACKS_DATABASE_
	#endinput
#endif
#define _CALLBACKS_DATABASE_

#include <YSI_Coding/y_hooks>

#if !defined CHAIN_ORDER
	#define CHAIN_ORDER() 0
#endif

CHAIN_HOOK(Database)
#undef CHAIN_ORDER
#define CHAIN_ORDER CHAIN_NEXT(Database)
CHAIN_FORWARD:Database_OnScriptInit() = 1;

public OnScriptInit()
{
    print("[db] Connecting to database... ");

	g_hDatabase = mysql_connect_file("hyaxe_db.ini");
	if(mysql_errno(g_hDatabase) > 0)
	{
		mysql_error(HYAXE_UNSAFE_HUGE_STRING, .handle = g_hDatabase);
		print("[db!] Failed to connect to MySQL server:");
		printf("[db!]  Error %i: %s", mysql_errno(g_hDatabase), HYAXE_UNSAFE_HUGE_STRING);
		SendRconCommand(!"exit");
		return 1;
	}

	print("[db] Connected.");
	print("[db] Initializing tables...");
	
	mysql_query_file(g_hDatabase, "schema.sql", false);

	if(mysql_errno(g_hDatabase) != 0)
	{
		mysql_error(HYAXE_UNSAFE_HUGE_STRING);
		print("[db!] Failed to connect to MySQL server:");
		printf("[db!]    %s", HYAXE_UNSAFE_HUGE_STRING);
		SendRconCommand(!"exit");
		return 1;
	}

	print("[db] Database initialization completed.");

	Database_OnScriptInit();
	return 1;
}

#undef OnScriptInit
#define OnScriptInit(%0) CHAIN_PUBLIC:Database_OnScriptInit(%0)

public OnScriptExit()
{
	print("[db] Closing database connection...");
	mysql_close(g_hDatabase);

	#if defined DB_OnScriptExit
		return DB_OnScriptExit();
	#else
		return 1;
	#endif
}

#if defined _ALS_OnScriptExit
	#undef OnScriptExit
#else
	#define _ALS_OnScriptExit
#endif
#define OnScriptExit DB_OnScriptExit
#if defined DB_OnScriptExit
	forward DB_OnScriptExit();
#endif