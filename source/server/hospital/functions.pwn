#if defined _hospital_functions_
    #endinput
#endif
#define _hospital_functions_

Player_GoToTheNearestHospital(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_HOSPITAL, true);

    KillTimer(g_rgiHospitalHealthTimer[playerid]);
    if (Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
        GetPlayerPos(playerid, g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ]);

    new
        Float:nearest_point = VectorSize(
            g_rgePlayerData[playerid][e_fPosX] - g_rgeHospitalData[0][e_fHospitalPosX],
            g_rgePlayerData[playerid][e_fPosY] - g_rgeHospitalData[0][e_fHospitalPosY],
            g_rgePlayerData[playerid][e_fPosZ] - g_rgeHospitalData[0][e_fHospitalPosZ]
        ),
        nearest_hospital
    ;

    for (new i; i < HYAXE_MAX_HOSPITALS; ++i)
    {
        new Float:distance = VectorSize(
            g_rgePlayerData[playerid][e_fPosX] - g_rgeHospitalData[i][e_fHospitalPosX],
            g_rgePlayerData[playerid][e_fPosY] - g_rgeHospitalData[i][e_fHospitalPosY],
            g_rgePlayerData[playerid][e_fPosZ] - g_rgeHospitalData[i][e_fHospitalPosZ]
        );

        if (nearest_point > distance)
        {
            nearest_point = distance;
            nearest_hospital = i;
        }
    }

    g_rgePlayerData[playerid][e_fPosX] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosX];
    g_rgePlayerData[playerid][e_fPosY] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosY];
    g_rgePlayerData[playerid][e_fPosZ] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosZ];
    g_rgePlayerData[playerid][e_fPosAngle] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalAngle];

    SetSpawnInfo(
        playerid, NO_TEAM, Player_Skin(playerid),
        g_rgePlayerData[playerid][e_fPosX],
        g_rgePlayerData[playerid][e_fPosY],
        g_rgePlayerData[playerid][e_fPosZ],
        g_rgePlayerData[playerid][e_fPosAngle],
        0, 0, 0, 0, 0, 0
    );
            
    //SpawnPlayer(playerid);
    TogglePlayerSpectating(playerid, true);
    
    //Player_SetPos(playerid, g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ]);
    //SetPlayerFacingAngle(playerid, g_rgePlayerData[playerid][e_fPosAngle]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerDrunkLevel(playerid, 0);
    //Player_RemoveAllWeapons(playerid);

    new
        Float:cam_x = g_rgePlayerData[playerid][e_fPosX],
        Float:cam_y = g_rgePlayerData[playerid][e_fPosY],
        Float:cam_z = g_rgePlayerData[playerid][e_fPosZ] + g_rgeHospitalData[ nearest_hospital ][e_fHospitalCamZ]
    ;
    GetXYFromAngle(cam_x, cam_y, g_rgePlayerData[playerid][e_fPosAngle], g_rgeHospitalData[ nearest_hospital ][e_fHospitalCamDistance]);

    InterpolateCameraPos(
        playerid,
        cam_x, cam_y, cam_z,
        g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ],
        80000
    );

    InterpolateCameraLookAt(
        playerid,
        cam_x, cam_y, cam_z,
        g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ],
        1000
    );

    new cost = (Player_Money(playerid) > 1500 ? 1500 : Player_Money(playerid));
    Player_GiveMoney(playerid, -cost);
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Estás siendo atendido en el ~b~%s~w~, el costo es de $%d.", g_rgeHospitalData[ nearest_hospital ][e_szHospitalName], cost);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 5000, 0x415BA2FF);

    g_rgiHospitalHealthTimer[playerid] = SetTimerEx("HP_HealPlayer", 1000, true, "ii", playerid, nearest_hospital);
    return 1;
}