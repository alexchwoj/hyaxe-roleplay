#if defined _police_header_
    #endinput
#endif
#define _police_header_

enum eVehicleCarData 
{
    e_iModel,
    Float:e_fPosX,
    Float:e_fPosY,
    Float:e_fPosZ,
    Float:e_fAngle
};

new const g_rgeCopCars[][eVehicleCarData] = {
    { 596, 1535.8701, -1677.9089, 12.9863, 0.0000 },
    { 596, 1535.9146, -1666.6748, 12.9863, 0.0000 },
    { 596, 1600.4679, -1684.0504, 5.5390, 90.0000 },
    { 596, 1600.3900, -1688.1138, 5.5390, 90.0000 },
    { 596, 1600.5397, -1692.1503, 5.5390, 90.0000 },
    { 596, 1600.5990, -1696.2740, 5.5390, 90.0000 },
    { 596, 1600.6127, -1700.2358, 5.5390, 90.0000 },
    { 599, 1591.4292, -1708.9828, 5.9886, 0.0000 },
    { 599, 1587.6093, -1709.0687, 5.9886, 0.0000 }
};

new const Float:g_rgfJailPositions[][3] = {
    { 1562.0920, -1655.3381, 20.6049 },
    { 1565.4879, -1656.1748, 20.6049 },
    { 1569.7051, -1657.1235, 20.6049 },
    { 1570.5763, -1662.3217, 20.6049 },
    { 1569.2526, -1665.7942, 20.604 }
};

enum ePoliceRanks
{
    POLICE_RANK_NONE,
    POLICE_RANK_OFFICER = 1,
    POLICE_RANK_SERGEANT,
    POLICE_RANK_SECOND_LIEUTENANT,
    POLICE_RANK_LIEUTENANT,
    POLICE_RANK_FIRST_LIEUTENANT,
    POLICE_RANK_CAPTAIN,
    POLICE_RANK_MAJOR_OFFICER,
    POLICE_RANK_DEPUTY_OFFICER,
    POLICE_RANK_ASSISTANT_OFFICER,
    POLICE_RANK_DEPUTY_INSPECTOR,
    POLICE_RANK_INSPECTOR,
    POLICE_RANK_SENIOR_OFFICER,
    POLICE_RANK_DEPUTY_COMMISSIONER,
    POLICE_RANK_COMMISSIONER,
    POLICE_RANK_INSP_COMMISSIONER,
    POLICE_RANK_CHIEF_COMMISSIONER,
    POLICE_RANK_GEN_COMMISSIONER,

    POLICE_RANK_SPEC_OPS
};

new const g_rgszPoliceRankNames[_:ePoliceRanks][] = {
    "Ninguno",
    "Oficial",
    "Sargento",
    "Subteniente",
    "Teniente",
    "Teniente primero",
    "Capitán",
    "Mayor",
    "Oficial Subayudante",
    "Oficial Ayudante",
    "Oficial Subinspector",
    "Oficial Inspector",
    "Oficial Principal",
    "Subcomisario",
    "Comisario",
    "Comisario inspector",
    "Comisario mayor",
    "Comisario general",
    "Operaciones especiales"
};

new 
    Iterator:Police<MAX_PLAYERS>,
    g_rgiPlayerPoliceRank[MAX_PLAYERS char],
    bool:g_rgbPlayerOnPoliceDuty[MAX_PLAYERS char],
    g_rgszSelectedOfficer[MAX_PLAYERS][26],
    g_iArrestCheckpoint;

#define Player_IsPolice(%0) (g_rgiPlayerPoliceRank{(%0)} != _:POLICE_RANK_NONE)
#define Police_OnDuty(%0) (g_rgbPlayerOnPoliceDuty{(%0)})
#define Police_Rank(%0) (g_rgiPlayerPoliceRank{(%0)})
#define Police_GetRankName(%0) (g_rgszPoliceRankNames[(%0)])

forward Police_SetRank(playerid, ePoliceRanks:new_rank);
forward Police_SendMessage(ePoliceRanks:rank, color, const message[], soundid = 0, suspect = INVALID_PLAYER_ID);
forward POLICE_UserLoaded(playerid);