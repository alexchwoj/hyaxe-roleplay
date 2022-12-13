#if defined _gunsmaker_callbacks_
    #endinput
#endif
#define _gunsmaker_callbacks_

static
    bool:s_rgbPlayerIsInJobCp[MAX_PLAYERS char] = {false, ...};

static GunsmakerBuildingEvent(playerid, bool:enter, data)
{
    #pragma unused data

    if(enter)
    {
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Habla con el supervisor para trabajar como fabricante de armas");
    }
    else
    {
        if(Player_Job(playerid) == JOB_GUNSMAKER)
        {
            Job_TriggerCallback(playerid, JOB_GUNSMAKER, JOB_EV_LEAVE_PLACE);
            Player_Job(playerid) = JOB_NONE;
        }
    }

    return 1;
}

static GunsmakerEvent(playerid, eJobEvent:event, data)
{
    #pragma unused data
       
    switch(event)
    {
        case JOB_EV_JOIN:
        {
            new id = Cell_GetLowestBlank(g_iGunsmakerUsedBenchs);
            if(id == sizeof(g_rgfGunsmakerBenchSites))
            {
                if(Iter_Contains(GunsmakerBenchQueue, playerid))
                {
                    Notification_ShowBeatingText(playerid, 7000, 0xED2B2B, 100, 255, "Ya estás en la cola");
                }
                else
                {
                    Iter_Add(GunsmakerBenchQueue, playerid);
                    Notification_Show(playerid, "Todas las mesas están usadas. Se te notificará cuando se libere una.", 5000);
                }

                return 1;
            }

            g_iGunsmakerUsedBenchs |= (1 << id);
            g_rgiGunsmakerUsedBench{playerid} = id;
            TogglePlayerDynamicCP(playerid, g_rgiGunsmakerBenchCheckpoint[id], true);
            Streamer_Update(playerid, STREAMER_TYPE_CP);
            Notification_ShowBeatingText(playerid, 7000, 0xDAA838, 100, 255, "Diríjete a tu mesa asignada para empezar a trabajar");
        }
        case JOB_EV_LEAVE:
        {
            if(PlayerJob_Paycheck(playerid) > 0)
            {
                Player_Job(playerid) = JOB_GUNSMAKER;
                new pay = Job_ApplyPaycheckBenefits(playerid, PlayerJob_Paycheck(playerid));
                Player_GiveMoney(playerid, pay, true);
                
                new str[120];
                format(str, sizeof(str), "Te pagaron ~g~$%i~w~ por tus trabajos. Vuelve a tu mesa o presiona ~k~~CONVERSATION_YES~ para dejar de trabajar.", pay);
                Notification_Show(playerid, str, 6000, 0xCB3126);
                PlayerJob_Paycheck(playerid) = 0;

                return 0;
            }

            if(g_rgiGunsmakerUsedBench{playerid} != 0xFF)
            {
                TogglePlayerDynamicCP(playerid, g_rgiGunsmakerBenchCheckpoint[g_rgiGunsmakerUsedBench{playerid}], false);
                g_iGunsmakerUsedBenchs &= ~(1 << g_rgiGunsmakerUsedBench{playerid});
                g_rgiGunsmakerUsedBench{playerid} = 0xFF;

                Gunsmaker_ProcessQueue();
            }
            
            if(Iter_Contains(GunsmakerBenchQueue, playerid))
            {
                Iter_Remove(GunsmakerBenchQueue, playerid);
                Notification_Show(playerid, "Abandonaste la cola para trabajar como fabricante de armas.", 5000);
            }
            else
            {
                Notification_Show(playerid, "Abandonaste el trabajo de fabricante de armas.", 5000);
            }
        }
        case JOB_EV_LEAVE_PLACE:
        {
            if(PlayerJob_Paycheck(playerid) > 0)
            {
                new pay = Job_ApplyPaycheckBenefits(playerid, PlayerJob_Paycheck(playerid));
                Player_GiveMoney(playerid, pay, true);
                
                new str[120];
                format(str, sizeof(str), "Fuiste despedido por salir de la fábrica. Se te pagó tu sueldo pendiente de ~g~$%i~w~ al despedirte.", pay);
                Notification_Show(playerid, str, 6000, 0xCB3126);
                PlayerJob_Paycheck(playerid) = 0;
            }
            else
            {
                Notification_Show(playerid, "Fuiste despedido por abandonar la fábrica.", 6000, 0xCB3126);
            }

            if(g_rgiGunsmakerUsedBench{playerid} != 0xFF)
            {
                TogglePlayerDynamicCP(playerid, g_rgiGunsmakerBenchCheckpoint[g_rgiGunsmakerUsedBench{playerid}], false);
                g_iGunsmakerUsedBenchs &= ~(1 << g_rgiGunsmakerUsedBench{playerid});
                g_rgiGunsmakerUsedBench{playerid} = 0xFF;
                Gunsmaker_ProcessQueue();
            }
            else if(Iter_Contains(GunsmakerBenchQueue, playerid))
            {
                Iter_Remove(GunsmakerBenchQueue, playerid);
                Notification_Show(playerid, "Abandonaste la cola para trabajar como fabricante de armas.", 5000);
            }
        }
        case JOB_EV_RESIGN:
        {
            if (g_rgiGunsmakerUsedBench{playerid} != 0xFF)
            {
                TogglePlayerDynamicCP(playerid, g_rgiGunsmakerBenchCheckpoint[g_rgiGunsmakerUsedBench{playerid}], false);
                g_iGunsmakerUsedBenchs &= ~(1 << g_rgiGunsmakerUsedBench{playerid});
                g_rgiGunsmakerUsedBench{playerid} = 0xFF;
                Gunsmaker_ProcessQueue();

                Notification_Show(playerid, "Abandonaste tu labor como fabricante de armas.", 5000);
            }
            else if (Iter_Contains(GunsmakerBenchQueue, playerid))
            {
                Iter_Remove(GunsmakerBenchQueue, playerid);
                Notification_Show(playerid, "Abandonaste la cola para trabajar como fabricante de armas.", 5000);
            }
        }
    }
    return 1;
}

public OnScriptInit()
{
    // Actors
    CreateDynamicActor(168, 2548.1860, -1293.0232, 1045.1250, 182.7474, .worldid = 0, .interiorid = 2);

    // EnExs
    EnterExit_Create(19902, "{CB3126}Fábrica de armas", "{DADADA}Salida", 1976.0343, -1923.4221, 13.5469, 180.1644, 0, 0, 2570.4001, -1301.9230, 1044.1250, 88.4036, 0, 2, .callback_address = __addressof(GunsmakerBuildingEvent));

    // Jobs
    Job_CreateSite(JOB_GUNSMAKER, 2548.1860, -1293.0232, 1044.1250, 0, 2, "{DADADA}Presiona {CB3126}Y {DADADA}para recibir tu paga");
    Job_SetCallback(JOB_GUNSMAKER, __addressof(GunsmakerEvent));

    // Block the factory gates
    new tmpobjectid = CreateDynamicObject(19447, 2571.55078, -1301.67456, 1044.49414, 0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 2);
    SetDynamicObjectMaterial(tmpobjectid, 0, 19297, "matlights", "emergencylights64", 0x00FFFFFF);
    tmpobjectid = CreateDynamicObject(19447, 2530.55127, -1306.86475, 1048.78259, 0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 2);
    SetDynamicObjectMaterial(tmpobjectid, 0, 19297, "matlights", "emergencylights64", 0x00FFFFFF);

    for(new i = sizeof(g_rgfGunsmakerBenchSites) - 1; i != -1; --i)
    {
        g_rgiGunsmakerBenchCheckpoint[i] = CreateDynamicCP(g_rgfGunsmakerBenchSites[i][0], g_rgfGunsmakerBenchSites[i][1], g_rgfGunsmakerBenchSites[i][2], 1.0, .worldid = 0, .interiorid = 2);
    }

    #if defined GSMAKER_OnScriptInit
        return GSMAKER_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit GSMAKER_OnScriptInit
#if defined GSMAKER_OnScriptInit
    forward GSMAKER_OnScriptInit();
#endif

static GunsmakerKeyGameCallback(playerid, bool:success)
{
    static const gun_names[][] = {
        "un rifle rudimentario",
        "un revólver",
        "un subfusil",
        "un rifle",
        "una carabina",
        "un rifle de asalto",
        "un fusil de francotirador"
    };

    ClearAnimations(playerid);
    TogglePlayerControllable(playerid, true);

    if(success)
    {
        new crafted_gun = random(sizeof(gun_names));
        PlayerJob_Paycheck(playerid) += 50 * (crafted_gun + 1);
        Player_AddXP(playerid, crafted_gun + 11);

        new str[101];
        format(str, sizeof(str), "Fabricaste ~y~%s~w~. Ve con el armero para que te paguen o fabrica otra arma.", gun_names[crafted_gun]);
        Notification_Show(playerid, str, 5000);
    }
    else
    {
        Notification_Show(playerid, "Fallaste en tu trabajo. Inténtalo nuevamente.", 5000);
    }

    TogglePlayerDynamicCP(playerid, g_rgiGunsmakerBenchCheckpoint[g_rgiGunsmakerUsedBench{playerid}], true);
    return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if(Player_Job(playerid) == JOB_GUNSMAKER && g_rgiGunsmakerUsedBench{playerid} != 0xFF)
    {
        new benchid = g_rgiGunsmakerUsedBench{playerid};
        if(g_rgiGunsmakerBenchCheckpoint[benchid] == checkpointid)
        {
            if(s_rgbPlayerIsInJobCp{playerid})
                return 1;

            s_rgbPlayerIsInJobCp{playerid} = true;
            TogglePlayerDynamicCP(playerid, checkpointid, false);
            TogglePlayerControllable(playerid, false);

            Player_SetPos(playerid, g_rgfGunsmakerBenchSites[benchid][0], g_rgfGunsmakerBenchSites[benchid][1], g_rgfGunsmakerBenchSites[benchid][2]);
            SetPlayerFacingAngle(playerid, g_rgfGunsmakerBenchSites[benchid][3]);
            
            Player_StartKeyGame(playerid, __addressof(GunsmakerKeyGameCallback), 9.9, 2.5);

            return 1;
        }
    }

    #if defined GSMAKER_OnPlayerEnterDynamicCP
        return GSMAKER_OnPlayerEnterDynamicCP(playerid, checkpointid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicCP
    #undef OnPlayerEnterDynamicCP
#else
    #define _ALS_OnPlayerEnterDynamicCP
#endif
#define OnPlayerEnterDynamicCP GSMAKER_OnPlayerEnterDynamicCP
#if defined GSMAKER_OnPlayerEnterDynamicCP
    forward GSMAKER_OnPlayerEnterDynamicCP(playerid, checkpointid);
#endif

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
    if(Player_Job(playerid) == JOB_GUNSMAKER && g_rgiGunsmakerUsedBench{playerid} != 0xFF)
    {
        s_rgbPlayerIsInJobCp{playerid} = false;
        return 1;
    }

    #if defined GSMAKER_OnPlayerLeaveDynamicCP
        return GSMAKER_OnPlayerLeaveDynamicCP(playerid, checkpointid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicCP
    #undef OnPlayerLeaveDynamicCP
#else
    #define _ALS_OnPlayerLeaveDynamicCP
#endif
#define OnPlayerLeaveDynamicCP GSMAKER_OnPlayerLeaveDynamicCP
#if defined GSMAKER_OnPlayerLeaveDynamicCP
    forward GSMAKER_OnPlayerLeaveDynamicCP(playerid, checkpointid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if(Player_Job(playerid) == JOB_GUNSMAKER)
    {
        if(Iter_Contains(GunsmakerBenchQueue, playerid))
        {
            Iter_Remove(GunsmakerBenchQueue, playerid);
        }
        else if(g_rgiGunsmakerUsedBench{playerid} != 0xFF)
        {
            g_iGunsmakerUsedBenchs &= ~(1 << g_rgiGunsmakerUsedBench{playerid});
            g_rgiGunsmakerUsedBench{playerid} = 0xFF;

            Gunsmaker_ProcessQueue();
        }

        if(PlayerJob_Paycheck(playerid) > 0)
        {
            Player_Money(playerid) += PlayerJob_Paycheck(playerid);
        }
    }

    #if defined J_GSMAKER_OnPlayerDisconnect
        return J_GSMAKER_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect J_GSMAKER_OnPlayerDisconnect
#if defined J_GSMAKER_OnPlayerDisconnect
    forward J_GSMAKER_OnPlayerDisconnect(playerid, reason);
#endif
