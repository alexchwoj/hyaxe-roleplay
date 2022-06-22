#if defined _anticheat_callbacks_
    #endinput
#endif
#define _anticheat_callbacks_

static Anticheat_PopulateDatabase()
{
    db_free_result(db_query(g_hAnticheatDatabase, "BEGIN;"));

    for(new eCheats:i; _:i < sizeof(g_rgeDetectionData); ++i)
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
            "INSERT OR IGNORE INTO `DETECTIONS` VALUES (%i, %i, %i, %i);", 
            i, g_rgeDetectionData[i][e_bDetectionEnabled], _:g_rgeDetectionData[i][e_ePunishmentType],
            g_rgeDetectionData[i][e_iMaxTriggers]
        );
        db_free_result(db_query(g_hAnticheatDatabase, HYAXE_UNSAFE_HUGE_STRING));
    }

    db_free_result(db_query(g_hAnticheatDatabase, "COMMIT;"));
}

public OnGameModeInit()
{
    g_hAnticheatDatabase = db_open("anticheat.db");
    if(g_hAnticheatDatabase == DB:0)
    {
        printf("[ac] Couldn't open anticheat database.");
        SendRconCommand(!"exit");
        return 1;
    }

    db_free_result(db_query(g_hAnticheatDatabase, 
        "CREATE TABLE IF NOT EXISTS DETECTIONS ( \
            DETECTION_ID INT NOT NULL PRIMARY KEY, \
            ENABLED INT NOT NULL, \
            PUNISHMENT INT NOT NULL, \
            MAX_TRIGGERS INT NOT NULL DEFAULT 0 \
        );"
    ));

    new DBResult:res = db_query(g_hAnticheatDatabase, "SELECT * FROM `DETECTIONS`;");
    new rowc = db_num_rows(res);

    if(!rowc)
    {
        Anticheat_PopulateDatabase();
        print("[ac] Created default detection options in database.");
    }
    else
    {
        if(rowc != sizeof(g_rgeDetectionData))
            Anticheat_PopulateDatabase();

        do
        {
            new eCheats:id = eCheats:db_get_field_assoc_int(res, "DETECTION_ID");
            if(!(0 <= _:id < sizeof(g_rgeDetectionData)))
                continue;

            g_rgeDetectionData[id][e_bDetectionEnabled] = bool:db_get_field_assoc_int(res, "ENABLED");
            g_rgeDetectionData[id][e_ePunishmentType] = ePunishment:db_get_field_assoc_int(res, "PUNISHMENT");
            g_rgeDetectionData[id][e_iMaxTriggers] = db_get_field_assoc_int(res, "MAX_TRIGGERS");
        } 
        while(db_next_row(res));

        print("[ac] Loaded detection options from database.");
    }

    db_free_result(res);

    #if defined AC_OnGameModeInit
        return AC_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit AC_OnGameModeInit
#if defined AC_OnGameModeInit
    forward AC_OnGameModeInit();
#endif

public OnGameModeExit()
{
    if(g_hAnticheatDatabase != DB:0)
        db_close(g_hAnticheatDatabase);

    #if defined AC_OnGameModeExit
        return AC_OnGameModeExit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit AC_OnGameModeExit
#if defined AC_OnGameModeExit
    forward AC_OnGameModeExit();
#endif

public OnIncomingPacket(playerid, packetid, BitStream:bs)
{
    if(g_rgbPlayerKicked{playerid})
    {
        printf("[dbg] caught packet from kicked player (%i): packetid %i", playerid, packetid);
        return 0;
    }

    #if defined AC_OnIncomingPacket
        return AC_OnIncomingPacket(playerid, packetid, bs);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnIncomingPacket
    #undef OnIncomingPacket
#else
    #define _ALS_OnIncomingPacket
#endif
#define OnIncomingPacket AC_OnIncomingPacket
#if defined AC_OnIncomingPacket
    forward AC_OnIncomingPacket(playerid, packetid, BitStream:bs);
#endif

public OnIncomingRPC(playerid, rpcid, BitStream:bs)
{
    if(g_rgbPlayerKicked{playerid})
    {
        printf("[dbg] caught rpc from kicked player (%i): rpcid %i", playerid, rpcid);
        return 0;
    }
    
    #if defined AC_OnIncomingRPC
        return AC_OnIncomingRPC(playerid, rpcid, bs);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnIncomingRPC
    #undef OnIncomingRPC
#else
    #define _ALS_OnIncomingRPC
#endif
#define OnIncomingRPC AC_OnIncomingRPC
#if defined AC_OnIncomingRPC
    forward AC_OnIncomingRPC(playerid, rpcid, BitStream:bs);
#endif
