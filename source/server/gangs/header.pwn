#if defined _gangs_header_
    #endinput
#endif
#define _gangs_header_

const HYAXE_MAX_GANGS = 2048;
const HYAXE_MAX_GANG_RANKS = 25;

enum eGangData
{
    e_iGangDbId,
    e_szGangName[64],
    e_iGangColor,
    e_iGangIcon,
    e_iGangOwnerId,

    bool:e_bGangAttacking
};
new g_rgeGangs[HYAXE_MAX_GANGS][eGangData],
    Map:g_mapGangIds;

enum eGangRankPermissions(<<=1)
{
    GANG_PERM_CHANGE_COLOR = 1,
    GANG_PERM_CHANGE_NAME,
    GANG_PERM_CHANGE_ICON,
    GANG_PERM_CHANGE_ROLES,
    GANG_PERM_KICK_MEMBERS,
    GANG_PERM_EDIT_MEMBERS,
    GANG_PERM_INVITE_MEMBERS,

    GANG_PERM_LAST
};

new const g_rgszGangPermNames[][32] = {
    "Cambiar color",
    "Cambiar nombre",
    "Cambiar ícono",
    "Cambiar roles",
    "Expulsar miembros",
    "Editar miembros",
    "Invitar jugadores"
};

enum eGangRankData
{
    e_iRankId,
    e_szRankName[32],
    e_iRankPermisionFlags
};
new g_rgeGangRanks[HYAXE_MAX_GANGS][10][eGangRankData];

new const g_rgszGangIcons[][2][32] = {
    { "Hamburguesa", "hud:radar_burgershot" },
    { "Dinero", "hud:radar_cash" },
    { "Gota", "hud:radar_centre"},
    { "Pistola", "hud:radar_emmetgun" },
    { "Bandera roja", "hud:radar_enemyattack" },
    { "Bandera de carreras", "hud:radar_flag" },
    { "Azul", "hud:radar_gangb" },
    { "Verde", "hud:radar_gangg" },
    { "Morado", "hud:radar_gangp" },
    { "Amarillo", "hud:radar_gangy" },
    { "Auto", "hud:radar_impound" },
    { "Calavera", "hud:radar_locosyndicate" },
    { "Dado", "hud:radar_mafiacasino" },
    { "Dos dados", "ld_tatt:11dice" },
    { "Trofeo", "hud:radar_race" },
    { "Abeja", "ld_grav:bee1" },
    { "Cohete", "ld_spac:rockshp" },
    { "Mono en cohete", "ld_shtr:ship" },
    { "Platano volador", "ld_shtr:ufo" }
};

new
    g_rgiPlayerGang[MAX_PLAYERS] = { -1, ... },
    g_rgiPlayerGangRank[MAX_PLAYERS char],
    Iterator:GangMember[HYAXE_MAX_GANGS]<MAX_PLAYERS>,
    g_rgiGangPanelPage[MAX_PLAYERS char],
    g_rgiPanelSelectedRole[MAX_PLAYERS char] = { 0xFFFFFFFF, ... };

#define Gang_Data(%0) (g_rgeGangs[(%0)])
#define Player_Gang(%0) (g_rgiPlayerGang[(%0)])
#define Player_GangRank(%0) (g_rgiPlayerGangRank{(%0)})
#define Player_GangRankData(%0) (g_rgeGangRanks[g_rgiPlayerGang[(%0)]][g_rgiPlayerGangRank{(%0)}])
#define Player_IsGangOwner(%0) (g_rgeGangs[Player_Gang(%0)][e_iGangOwnerId] == Player_AccountID(%0))
#define Player_HasPermissionInGang(%0,%1) ((g_rgeGangRanks[Player_Gang(%0)][Player_GangRank(%0)][e_iRankPermisionFlags] & (%1)) || Player_IsGangOwner(%0))

forward Gangs_PanelForward(playerid);
forward Gangs_PanelBackwards(playerid);
forward Gang_SendMessage(gangid, const message[]);
forward Gang_SendMessage_s(gangid, ConstString:message);
forward Gang_GetLowestRank(gangid);

forward GANGS_PanelDataFetched(playerid);
forward GANGS_PanelMembersFetched(playerid);
forward GANGS_RoleCreated(playerid);
forward GANGS_NewOwnerFetched(playerid);