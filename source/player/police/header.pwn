#if defined _police_header_
    #endinput
#endif
#define _police_header_

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
    g_rgszSelectedOfficer[MAX_PLAYERS][26];

#define Player_IsPolice(%0) (g_rgiPlayerPoliceRank{(%0)} != _:POLICE_RANK_NONE)
#define Police_OnDuty(%0) (g_rgbPlayerOnPoliceDuty{(%0)})
#define Police_Rank(%0) (g_rgiPlayerPoliceRank{(%0)})
#define Police_GetRankName(%0) (g_rgszPoliceRankNames[(%0)])

forward Police_SetRank(playerid, ePoliceRanks:new_rank);
forward Police_SendMessage(ePoliceRanks:rank, color, const message[]);
forward POLICE_UserLoaded(playerid);