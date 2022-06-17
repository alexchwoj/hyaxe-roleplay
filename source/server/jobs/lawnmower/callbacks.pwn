#if defined _lawnmower_callbacks_
    #endinput
#endif
#define _lawnmower_callbacks_

static GenerateGrassInArea(areaid)
{
    new grass_count = math_random(MIN_GRASS_PER_AREA, MAX_GRASS_PER_AREA);
    g_rgeLawnmowerAreas[areaid][e_iInitialGrassCount] =
    g_rgeLawnmowerAreas[areaid][e_iCurrentGrassCount] = grass_count;

    for(new i = grass_count; i != -1; --i)
    {
        new bool:is_above_water = false;
        new Float:x, Float:y, Float:z;

        // LOL
        new const
            Float:min_x = (g_rgeLawnmowerAreas[areaid][e_fAreaMinX] < g_rgeLawnmowerAreas[areaid][e_fAreaMaxX] ? g_rgeLawnmowerAreas[areaid][e_fAreaMinX] : g_rgeLawnmowerAreas[areaid][e_fAreaMaxX]),
            Float:max_x = (g_rgeLawnmowerAreas[areaid][e_fAreaMinX] < g_rgeLawnmowerAreas[areaid][e_fAreaMaxX] ? g_rgeLawnmowerAreas[areaid][e_fAreaMaxX] : g_rgeLawnmowerAreas[areaid][e_fAreaMinX]),
            Float:min_y = (g_rgeLawnmowerAreas[areaid][e_fAreaMinY] < g_rgeLawnmowerAreas[areaid][e_fAreaMaxY] ? g_rgeLawnmowerAreas[areaid][e_fAreaMinY] : g_rgeLawnmowerAreas[areaid][e_fAreaMaxY]),
            Float:max_y = (g_rgeLawnmowerAreas[areaid][e_fAreaMinY] < g_rgeLawnmowerAreas[areaid][e_fAreaMaxY] ? g_rgeLawnmowerAreas[areaid][e_fAreaMaxY] : g_rgeLawnmowerAreas[areaid][e_fAreaMinY]),
            Float:min_z = (g_rgeLawnmowerAreas[areaid][e_fAreaMinZ] < g_rgeLawnmowerAreas[areaid][e_fAreaMaxZ] ? g_rgeLawnmowerAreas[areaid][e_fAreaMinZ] : g_rgeLawnmowerAreas[areaid][e_fAreaMaxZ]),
            Float:max_z = (g_rgeLawnmowerAreas[areaid][e_fAreaMinZ] < g_rgeLawnmowerAreas[areaid][e_fAreaMaxZ] ? g_rgeLawnmowerAreas[areaid][e_fAreaMaxZ] : g_rgeLawnmowerAreas[areaid][e_fAreaMinZ]);

        do
        {
            x = math_random_float(min_x, max_x);
            y = math_random_float(min_y, max_y);
            z = math_random_float(min_z, max_z);
            is_above_water = CA_RayCastLine(x, y, 100.0, x, y, -100.0, x, y, z) == WATER_OBJECT;

            // FIXME
            if(z > 35.0)
                is_above_water = true;
        } while(is_above_water);

        g_rgeLawnmowerAreas[areaid][e_rgiGrassObjects][i] = CreateDynamicObject(817, x, y, z + 0.6, 0.0, 0.0, 0.0, .worldid = 0, .interiorid = 0);
        g_rgeLawnmowerAreas[areaid][e_rgiGrassAreas][i] = CreateDynamicCircle(x, y, 1.2, .worldid = 0, .interiorid = 0, .playerid = g_rgeLawnmowerAreas[areaid][e_iMowingPlayer]);
        Streamer_SetIntData(STREAMER_TYPE_AREA, g_rgeLawnmowerAreas[areaid][e_rgiGrassAreas][i], E_STREAMER_CUSTOM(0x4D4F57), i);
    }

    return 1;
}

static LawnMowerEvent(playerid, eJobEvent:event, areaid)
{
    switch(event)
    {
        case JOB_EV_JOIN:
        {
            if(g_rgeLawnmowerAreas[areaid][e_iMowingPlayer] != INVALID_PLAYER_ID)
            {
                Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Ya hay alguien trabajando este parque. Diríjete a otro o espera.");
                return 0;
            }

            new mowerid = Vehicle_Create(572, g_rgeLawnmowerAreas[areaid][e_fVehicleSpawnX], g_rgeLawnmowerAreas[areaid][e_fVehicleSpawnY], g_rgeLawnmowerAreas[areaid][e_fVehicleSpawnZ], g_rgeLawnmowerAreas[areaid][e_fVehicleSpawnRot], -1, -1, -1);
            Vehicle_Type(mowerid) = VEHICLE_TYPE_WORK;
            Vehicle_ToggleEngine(mowerid, VEHICLE_STATE_ON);
            PutPlayerInVehicle(playerid, mowerid, 0);
            g_rgeLawnmowerAreas[areaid][e_iMowerId] = mowerid;

            g_rgiPlayerLawnmowerArea{playerid} = areaid;
            g_rgeLawnmowerAreas[areaid][e_iMowingPlayer] = playerid;
            GenerateGrassInArea(areaid);

            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Empieza a cortar el césped. Te quedan %i matorrales.", g_rgeLawnmowerAreas[areaid][e_iCurrentGrassCount]);
            Notification_ShowBeatingText(playerid, 15000, 0xED2B2B, 75, 255, HYAXE_UNSAFE_HUGE_STRING);
            PlayAudioStreamForPlayer(playerid, "https://cdn.discordapp.com/attachments/883089457329344523/938212731952181268/lawnmower.mp3", .usepos = false);
            Chat_Resend(playerid);
        }
        case JOB_EV_LEAVE_VEHICLE:
        {
            StopAudioStreamForPlayer(playerid);

            new parkid = g_rgiPlayerLawnmowerArea{playerid};
            Vehicle_Destroy(g_rgeLawnmowerAreas[parkid][e_iMowerId]);

            for(new i; i < MAX_GRASS_PER_AREA; ++i)
            {
                DestroyDynamicObject(g_rgeLawnmowerAreas[parkid][e_rgiGrassObjects][i]);
                DestroyDynamicArea(g_rgeLawnmowerAreas[parkid][e_rgiGrassAreas][i]);

                g_rgeLawnmowerAreas[parkid][e_rgiGrassObjects][i] = 
                g_rgeLawnmowerAreas[parkid][e_rgiGrassAreas][i] = INVALID_STREAMER_ID;
            }

            g_rgeLawnmowerAreas[parkid][e_iMowerId] = INVALID_VEHICLE_ID;
            g_rgeLawnmowerAreas[parkid][e_iInitialGrassCount] =
            g_rgeLawnmowerAreas[parkid][e_iCurrentGrassCount] = 0;
            g_rgeLawnmowerAreas[parkid][e_iMowingPlayer] = INVALID_PLAYER_ID;
            g_rgiPlayerLawnmowerArea{playerid} = 0xFF;

            Notification_Show(playerid, "El capataz te vio fuera del cortacésped y te ~r~despidió~w~.", 5000);
        }
    }
    #pragma unused playerid, event, areaid
    return 1;
}

public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgeLawnmowerAreas); ++i)
    {
        g_rgeLawnmowerAreas[i][e_iAreaId] = CreateDynamicRectangle(g_rgeLawnmowerAreas[i][e_fAreaMinX], g_rgeLawnmowerAreas[i][e_fAreaMinY], g_rgeLawnmowerAreas[i][e_fAreaMaxX], g_rgeLawnmowerAreas[i][e_fAreaMaxY], .worldid = 0, .interiorid = 0);
        Streamer_SetIntData(STREAMER_TYPE_AREA, g_rgeLawnmowerAreas[i][e_iAreaId], E_STREAMER_EXTRA_ID, 0x4C4D5F50); // LM_P(ARK)

        Job_CreateSite(JOB_LAWNMOWER, g_rgeLawnmowerAreas[i][e_fPedContractorX], g_rgeLawnmowerAreas[i][e_fPedContractorY], g_rgeLawnmowerAreas[i][e_fPedContractorZ], 0, 0, .cb_data = i);
 
        g_rgeLawnmowerAreas[i][e_iPedContractorId] = CreateDynamicActor(16, g_rgeLawnmowerAreas[i][e_fPedContractorX], g_rgeLawnmowerAreas[i][e_fPedContractorY], g_rgeLawnmowerAreas[i][e_fPedContractorZ], g_rgeLawnmowerAreas[i][e_fPedContractorAngle], .worldid = 0, .interiorid = 0);
        ApplyDynamicActorAnimation(g_rgeLawnmowerAreas[i][e_iPedContractorId], "SMOKING", "null", 4.1, 0, 0, 0, 0, 0);
        ApplyDynamicActorAnimation(g_rgeLawnmowerAreas[i][e_iPedContractorId], "SMOKING", "M_SMKLEAN_LOOP", 4.1, 1, 0, 0, 1, 0);
    }

    Job_SetCallback(JOB_LAWNMOWER, __addressof(LawnMowerEvent));

    #if defined JOB_LM_OnGameModeInit
        return JOB_LM_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit JOB_LM_OnGameModeInit
#if defined JOB_LM_OnGameModeInit
    forward JOB_LM_OnGameModeInit();
#endif

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if(Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4D4F57)))
    {
        new grass_id = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4D4F57))
        new park_id = g_rgiPlayerLawnmowerArea{playerid};

        if(!IsValidDynamicObject(g_rgeLawnmowerAreas[park_id][e_rgiGrassObjects][grass_id]))
            return 1;
            
        PlayerPlaySound(playerid, 20800);

        DestroyDynamicObject(g_rgeLawnmowerAreas[park_id][e_rgiGrassObjects][grass_id]);
        DestroyDynamicArea(areaid);
        Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

        g_rgeLawnmowerAreas[park_id][e_rgiGrassAreas][grass_id] = 
        g_rgeLawnmowerAreas[park_id][e_rgiGrassObjects][grass_id] = INVALID_STREAMER_ID;

        g_rgeLawnmowerAreas[park_id][e_iCurrentGrassCount]--;        
        if(!g_rgeLawnmowerAreas[park_id][e_iCurrentGrassCount])
        {
            StopAudioStreamForPlayer(playerid);
            Vehicle_Destroy(g_rgeLawnmowerAreas[park_id][e_iMowerId]);
            
            Player_Job(playerid) = JOB_NONE;

            new money = g_rgeLawnmowerAreas[park_id][e_iInitialGrassCount] * 5;
            Player_GiveMoney(playerid, money);

            new string[80];
            format(string, sizeof(string), "Terminaste tu trabajo como cortacésped y te pagaron ~g~$%s~w~ por tu labor.", Format_Thousand(money));
            Notification_Show(playerid, string, 6000);
            Player_AddXP(playerid, g_rgeLawnmowerAreas[park_id][e_iInitialGrassCount]);

            g_rgiPlayerLawnmowerArea{playerid} = 0xFF;
            g_rgeLawnmowerAreas[park_id][e_iMowingPlayer] = INVALID_PLAYER_ID;
            g_rgeLawnmowerAreas[park_id][e_iMowerId] = INVALID_VEHICLE_ID;
            g_rgeLawnmowerAreas[park_id][e_iInitialGrassCount] = 
            g_rgeLawnmowerAreas[park_id][e_iCurrentGrassCount] = 0;
            
            for(new i; i < MAX_GRASS_PER_AREA; ++i)
            {
                if(IsValidDynamicObject(g_rgeLawnmowerAreas[park_id][e_rgiGrassObjects][i]))
                {
                    DestroyDynamicObject(g_rgeLawnmowerAreas[park_id][e_rgiGrassObjects][i]);
                    DestroyDynamicArea(g_rgeLawnmowerAreas[park_id][e_rgiGrassAreas][i]);
                }

                g_rgeLawnmowerAreas[park_id][e_rgiGrassObjects][i] =
                g_rgeLawnmowerAreas[park_id][e_rgiGrassAreas][i] = INVALID_STREAMER_ID;
            }
        }
        else
        {
            SendClientMessagef(playerid, 0xDADADAFF, "Te quedan {ED2B2B}%i{DADADA} matorrales.", g_rgeLawnmowerAreas[park_id][e_iCurrentGrassCount]);
        }
    }

    #if defined JOB_LM_OnPlayerEnterDynamicArea
        return JOB_LM_OnPlayerEnterDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea JOB_LM_OnPlayerEnterDynamicArea
#if defined JOB_LM_OnPlayerEnterDynamicArea
    forward JOB_LM_OnPlayerEnterDynamicArea(playerid, areaid);
#endif

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
    {
        if(Player_Job(playerid) == JOB_LAWNMOWER)
        {
            Job_TriggerCallback(playerid, JOB_LAWNMOWER, JOB_EV_LEAVE_VEHICLE, g_rgiPlayerLawnmowerArea{playerid});
            Player_Job(playerid) = JOB_NONE;
        }
    }

    #if defined JOB_LM_OnPlayerStateChange
        return JOB_LM_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange JOB_LM_OnPlayerStateChange
#if defined JOB_LM_OnPlayerStateChange
    forward JOB_LM_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if(Player_Job(playerid) == JOB_LAWNMOWER)
    {
        new parkid = g_rgiPlayerLawnmowerArea{playerid};
        Vehicle_Destroy(g_rgeLawnmowerAreas[parkid][e_iMowerId]);

        for(new i; i < MAX_GRASS_PER_AREA; ++i)
        {
            DestroyDynamicObject(g_rgeLawnmowerAreas[parkid][e_rgiGrassObjects][i]);
            DestroyDynamicArea(g_rgeLawnmowerAreas[parkid][e_rgiGrassAreas][i]);

            g_rgeLawnmowerAreas[parkid][e_rgiGrassObjects][i] = 
            g_rgeLawnmowerAreas[parkid][e_rgiGrassAreas][i] = INVALID_STREAMER_ID;
        }

        g_rgeLawnmowerAreas[parkid][e_iMowerId] = INVALID_VEHICLE_ID;
        g_rgeLawnmowerAreas[parkid][e_iInitialGrassCount] =
        g_rgeLawnmowerAreas[parkid][e_iCurrentGrassCount] = 0;
        g_rgeLawnmowerAreas[parkid][e_iMowingPlayer] = INVALID_PLAYER_ID;
        g_rgiPlayerLawnmowerArea{playerid} = 0xFF;
    }

    #if defined JOB_LM_OnPlayerDisconnect
        return JOB_LM_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect JOB_LM_OnPlayerDisconnect
#if defined JOB_LM_OnPlayerDisconnect
    forward JOB_LM_OnPlayerDisconnect(playerid, reason);
#endif
