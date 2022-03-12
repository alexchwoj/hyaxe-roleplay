#if defined _hospital_functions_
    #endinput
#endif
#define _hospital_functions_

Player_GoToTheNearestHospital(playerid)
{
    KillTimer(g_rgiHospitalHealthTimer[playerid]);
    GetPlayerPos(playerid, g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ]);

    new
        Float:nearest_point = VectorSize(
            g_rgePlayerData[playerid][e_fSpawnPosX] - g_rgeHospitalData[0][e_fHospitalPosX],
            g_rgePlayerData[playerid][e_fSpawnPosY] - g_rgeHospitalData[0][e_fHospitalPosY],
            g_rgePlayerData[playerid][e_fSpawnPosZ] - g_rgeHospitalData[0][e_fHospitalPosZ]
        ),
        nearest_hospital
    ;

    for(new i; i < HYAXE_MAX_HOSPITALS; ++i)
    {
        new Float:distance = VectorSize(
            g_rgePlayerData[playerid][e_fSpawnPosX] - g_rgeHospitalData[i][e_fHospitalPosX],
            g_rgePlayerData[playerid][e_fSpawnPosY] - g_rgeHospitalData[i][e_fHospitalPosY],
            g_rgePlayerData[playerid][e_fSpawnPosZ] - g_rgeHospitalData[i][e_fHospitalPosZ]
        );

        if (nearest_point > distance)
        {
            nearest_point = distance;
            nearest_hospital = i;
        }
    }

    g_rgePlayerData[playerid][e_fSpawnPosX] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosX];
    g_rgePlayerData[playerid][e_fSpawnPosY] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosY];
    g_rgePlayerData[playerid][e_fSpawnPosZ] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosZ];
    g_rgePlayerData[playerid][e_fSpawnPosAngle] = g_rgeHospitalData[ nearest_hospital ][e_fHospitalAngle];

    SetSpawnInfo(
        playerid, NO_TEAM, Player_Skin(playerid),
        g_rgePlayerData[playerid][e_fSpawnPosX],
        g_rgePlayerData[playerid][e_fSpawnPosY],
        g_rgePlayerData[playerid][e_fSpawnPosZ],
        g_rgePlayerData[playerid][e_fSpawnPosAngle],
        0, 0, 0, 0, 0, 0
    );
            
    SpawnPlayer(playerid);
    TogglePlayerSpectating(playerid, true);
    
    SetPlayerPos(playerid, g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ]);
    SetPlayerFacingAngle(playerid, g_rgePlayerData[playerid][e_fSpawnPosAngle]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);

    new
        Float:cam_x = g_rgePlayerData[playerid][e_fSpawnPosX],
        Float:cam_y = g_rgePlayerData[playerid][e_fSpawnPosY],
        Float:cam_z = g_rgePlayerData[playerid][e_fSpawnPosZ] + g_rgeHospitalData[ nearest_hospital ][e_fHospitalCamZ]
    ;
    GetXYFromAngle(cam_x, cam_y, g_rgePlayerData[playerid][e_fSpawnPosAngle], g_rgeHospitalData[ nearest_hospital ][e_fHospitalCamDistance]);

    InterpolateCameraPos(
        playerid,
        cam_x, cam_y, cam_z,
        g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ],
        80000
    );

    InterpolateCameraLookAt(
        playerid,
        cam_x, cam_y, cam_z,
        g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ],
        1000
    );

    Player_GiveMoney(playerid, -1500);
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Estás siendo atendido en el ~b~%s~w~, el costo es de $1500.", g_rgeHospitalData[ nearest_hospital ][e_szHospitalName]);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 5000, 0x415BA2FF);

    g_rgiHospitalHealthTimer[playerid] = SetTimerEx("HP_HealPlayer", 1000, true, "i", playerid);
    return 1;
}