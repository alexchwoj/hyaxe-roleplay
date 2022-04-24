#if defined _gangs_header_
    #endinput
#endif
#define _gangs_header_

const HYAXE_MAX_GANGS = 512;
const HYAXE_MAX_GANG_RANKS = 25;

enum eGangData
{
    e_iGangDbId,
    e_szGangName[64],
    e_iGangColor
};
new g_rgeGangs[HYAXE_MAX_GANGS][eGangData],
    Map:g_mapGangIds;

enum eGangRankData
{
    e_iRankId,
    e_iRankHierarchy,
    e_szRankName[32],
    e_iRankPermisionFlags
};
new List:g_rglGangRanks[HYAXE_MAX_GANGS];

new
    g_rgiPlayerGang[MAX_PLAYERS] = { -1, ... },
    g_rgiPlayerGangRank[MAX_PLAYERS char],
    IteratorArray:GangMember[HYAXE_MAX_GANGS]<MAX_PLAYERS>,
    g_rgiGangPanelPage[MAX_PLAYERS char];

#define Gang_Data(%0) (g_rgeGangs[(%0)])
#define Player_Gang(%0) (g_rgiPlayerGang[(%0)])
#define Player_GangRank(%0) (g_rgiPlayerGangRank{(%0)})

forward Gangs_PanelForward(playerid);
forward Gangs_PanelBackwards(playerid);
forward GANGS_PanelDataFetched(playerid);
forward GANGS_PanelMembersFetched(playerid);