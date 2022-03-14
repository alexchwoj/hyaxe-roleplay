#if defined _hospital_callbacks_
    #endinput
#endif
#define _hospital_callbacks_


public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(g_rgiHospitalHealthTimer[playerid]);

    #if defined HP_OnPlayerDisconnect
        return HP_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect HP_OnPlayerDisconnect
#if defined HP_OnPlayerDisconnect
    forward HP_OnPlayerDisconnect(playerid, reason);
#endif


forward HP_HealPlayer(playerid);
public HP_HealPlayer(playerid)
{
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Curando las heridas... ~r~%d%", Player_Health(playerid));
    Notification_ShowBeatingText(playerid, 1000, 0xF7F7F7, 100, 255, HYAXE_UNSAFE_HUGE_STRING);

    if (Player_Health(playerid) >= 100)
    {
        Notification_ShowBeatingText(playerid, 1000, 0xF7F7F7, 100, 255, "Curando las heridas... ~r~100%");
        
        SpawnPlayer(playerid);
        TogglePlayerSpectating(playerid, true);
        TogglePlayerSpectating(playerid, false);

        SetPlayerPos(playerid, g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ]);
        SetPlayerFacingAngle(playerid, g_rgePlayerData[playerid][e_fSpawnPosAngle]);

        SetCameraBehindPlayer(playerid);

        Notification_Show(playerid, "Los médicos te han dado de alta.", 3000, 0x64A752FF);
        KillTimer(g_rgiHospitalHealthTimer[playerid]);
        return 1;
    }

    Player_SetHealth(playerid, Player_Health(playerid) + 4);
    return 1;
}

public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgeHospitalData); ++i)
    {
        new int = g_rgeHospitalData[i][e_iHospitalInteriorType];

        EnterExit_Create(
            19902,
            g_rgeHospitalData[i][e_szHospitalName], "Salida",
            g_rgeHospitalData[i][e_fHospitalPosX], g_rgeHospitalData[i][e_fHospitalPosY], g_rgeHospitalData[i][e_fHospitalPosZ], g_rgeHospitalData[i][e_fHospitalAngle], 0, 0,
            g_rgeHospitalInteriorData[int][e_fHospitalIntPosX], g_rgeHospitalInteriorData[int][e_fHospitalIntPosY], g_rgeHospitalInteriorData[int][e_fHospitalIntPosZ], g_rgeHospitalInteriorData[int][e_fHospitalIntAngle], 400 + 1, g_rgeHospitalInteriorData[int][e_iHospitalIntInterior],
            -1,  0
        );

        // MapIcons
        CreateDynamicMapIcon(g_rgeHospitalData[i][e_fHospitalPosX], g_rgeHospitalData[i][e_fHospitalPosY], g_rgeHospitalData[i][e_fHospitalPosZ], 22, -1, .worldid = 0, .interiorid = 0);
    }

    #if defined HP_OnGameModeInit
        return HP_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit HP_OnGameModeInit
#if defined HP_OnGameModeInit
    forward HP_OnGameModeInit();
#endif
