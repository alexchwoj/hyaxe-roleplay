#if defined _CALLBACKS_DATABASE_
	#endinput
#endif
#define _CALLBACKS_DATABASE_

on_init ConnectDatabase()
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
}

on_exit DisconnectDatabase()
{
	print("[db] Closing database connection...");
	mysql_close(g_hDatabase);
}
