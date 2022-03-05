#if defined _gunsmaker_callbacks_
    #endinput
#endif
#define _gunsmaker_callbacks_

static GunsmakerBuildingEvent(playerid, bool:enter, data)
{
    if(enter)
    {
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Habla con el supervisor para trabajar como fabricante de armas");
    }
    else
    {
        if(Player_Job(playerid) == JOB_GUNSMAKER)
        {
            Job_TriggerCallback(playerid, JOB_GUNSMAKER, JOB_EV_LEAVE_PLACE);
        }
    }

    return 1;
}

static GunsmakerEvent(playerid, eJobEvent:event, data)
{
    return 1;
}

public OnGameModeInit()
{
    // Actors
    CreateDynamicActor(168, 2548.1860, -1293.0232, 1045.1250, 182.7474, .worldid = 0, .interiorid = 2);

    // EnExs
    EnterExit_Create(19902, "{CB3126}Fábrica de armas{DADADA}\nPresiona {CB3126}H {DADADA}para entrar", "{DADADA}Presiona {CB3126}H {DADADA}para salir", 1976.0343, -1923.4221, 13.5469, 180.1644, 0, 0, 2570.4001, -1301.9230, 1044.1250, 88.4036, 0, 2, .callback_address = __addressof(GunsmakerBuildingEvent));

    // Jobs
    Job_CreateSite(JOB_GUNSMAKER, 2548.1860, -1293.0232, 1044.1250, 0, 2, "{DADADA}Presiona {CB3126}Y {DADADA}para recibir tu paga");
    Job_SetCallback(JOB_GUNSMAKER, __addressof(GunsmakerEvent));

    // Block the factory gates
    new tmpobjectid = CreateDynamicObject(19447, 2571.55078, -1301.67456, 1044.49414, 0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 2);
    SetDynamicObjectMaterial(tmpobjectid, 0, 19297, "matlights", "emergencylights64", 0x00FFFFFF);
    tmpobjectid = CreateDynamicObject(19447, 2530.55127, -1306.86475, 1048.78259, 0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 2);
    SetDynamicObjectMaterial(tmpobjectid, 0, 19297, "matlights", "emergencylights64", 0x00FFFFFF);

    #if defined GSMAKER_OnGameModeInit
        return GSMAKER_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit GSMAKER_OnGameModeInit
#if defined GSMAKER_OnGameModeInit
    forward GSMAKER_OnGameModeInit();
#endif
