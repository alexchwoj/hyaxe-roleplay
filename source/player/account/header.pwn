#if defined _account_header_
    #endinput
#endif
#define _account_header_

const PLAYER_DEFAULT_MONEY = 250;
const Float:PLAYER_SPAWN_X = 1728.8326;
const Float:PLAYER_SPAWN_Y = -1174.8977;
const Float:PLAYER_SPAWN_Z = 23.8315;
const Float:PLAYER_SPAWN_ANGLE = 45.1207;

const ADMIN_ID_ANTICHEAT = cellmin;

enum 
{
    PFLAG_AUTHENTICATING = 0,
    PFLAG_REGISTERED,
    PFLAG_IN_GAME,
    PFLAG_ROBBING_STORE,
    PFLAG_USING_ATM,
    PFLAG_INJURED,
    PFLAG_SHOPPING,
    PFLAG_CAN_USE_SHOP_BUTTONS,
    PFLAG_IS_PUKING,
    PFLAG_USING_INV,
    
    MAX_PLAYER_FLAGS
};

enum
{
    SEX_FEMALE = 0,
    SEX_MALE = 1
}

enum _:eRankLevels
{
    RANK_LEVEL_USER,
    RANK_LEVEL_HELPER,
    RANK_LEVEL_MODERATOR,
    RANK_LEVEL_ADMINISTRATOR
};

new const g_rgszRankLevelNames[eRankLevels][] = {
    "Usuario",
    "Ayudante",
    "Moderador",
    "Administrador"
};

enum ePlayerData
{
    e_iPlayerAccountId,
    Cache:e_hDataCache,
    e_szPlayerName[MAX_PLAYER_NAME],
    e_szPlayerRpName[MAX_PLAYER_NAME],
    e_szPlayerEmail[128],
    e_iPlayerIp,
    e_szPlayerLastConnection[20],
    e_szPassword[65],
    
    e_iPlayerHealth,
    e_iPlayerArmor,
    e_iPlayerMoney,
    e_iPlayerBankBalance,
    Float:e_fSpawnPosX,
    Float:e_fSpawnPosY,
    Float:e_fSpawnPosZ,
    Float:e_fSpawnPosAngle,
    e_iPlayerVirtualWorld,
    e_iPlayerInterior,
    e_iPlayerSex,
    e_iPlayerSkin,
    Float:e_fPlayerHunger,
    Float:e_fPlayerThirst,
    e_iPlayerXp,
    e_iPlayerLevel,
    
    e_iAdminLevel,
    e_iPlayedTime,
    
    // MISC DATA
    e_iCurrentConnectionTime,
    e_iPlayerPausedTick,
    e_iPlayerPausedTime
};

enum ePlayerTemp
{
    e_iPlayerChatTick,
    e_iPlayerBankDest,
    e_iPlayerEatTick,
    e_iPlayerEatCount,
    e_iPlayerPukeTick,
    e_iPlayerDropItemAmount,
    e_iPlayerItemSlot
};

new 
    g_rgePlayerData[MAX_PLAYERS + 1][ePlayerData],
    g_rgePlayerTempData[MAX_PLAYERS + 1][ePlayerTemp],
    BitArray:g_rgiPlayerFlags[MAX_PLAYERS]<MAX_PLAYER_FLAGS>,
    Iterator:LoggedIn<MAX_PLAYERS>;

#define Player_ResetTemp(%0) g_rgePlayerTempData[(%0)] = g_rgePlayerTempData[MAX_PLAYERS]
#define Player_Flags(%0) Bit:(g_rgiPlayerFlags[(%0)])
#define Player_Cache(%0) (g_rgePlayerData[(%0)][e_hDataCache])
#define Player_AccountID(%0) (g_rgePlayerData[(%0)][e_iPlayerAccountId])
#define Player_Name(%0) g_rgePlayerData[(%0)][e_szPlayerName]
#define Player_RPName(%0) g_rgePlayerData[(%0)][e_szPlayerRpName]
#define Player_Email(%0) g_rgePlayerData[(%0)][e_szPlayerEmail]
#define Player_Password(%0) g_rgePlayerData[(%0)][e_szPassword]
#define Player_IP(%0) (g_rgePlayerData[(%0)][e_iPlayerIp])
#define Player_GetIpString(%0) (RawIpToString(g_rgePlayerData[(%0)][e_iPlayerIp]))
#define Player_LastConnection(%0) (g_rgePlayerData[(%0)][e_szPlayerLastConnection])
#define Player_Health(%0) (g_rgePlayerData[(%0)][e_iPlayerHealth])
#define Player_Armor(%0) (g_rgePlayerData[(%0)][e_iPlayerArmor])
#define Player_Money(%0) (g_rgePlayerData[(%0)][e_iPlayerMoney])
#define Player_VirtualWorld(%0) (g_rgePlayerData[(%0)][e_iPlayerVirtualWorld])
#define Player_Interior(%0) (g_rgePlayerData[(%0)][e_iPlayerInterior])
#define Player_Sex(%0) (g_rgePlayerData[(%0)][e_iPlayerSex])
#define Player_Skin(%0) (g_rgePlayerData[(%0)][e_iPlayerSkin])
#define Player_Hunger(%0) (g_rgePlayerData[(%0)][e_fPlayerHunger])
#define Player_Thirst(%0) (g_rgePlayerData[(%0)][e_fPlayerThirst])
#define Player_AdminLevel(%0) (g_rgePlayerData[(%0)][e_iAdminLevel])
#define Player_SavedPlayedTime(%0) (g_rgePlayerData[(%0)][e_iPlayedTime])
#define Player_PlayedTime(%0) ((gettime() - g_rgePlayerData[(%0)][e_iCurrentConnectionTime]) + g_rgePlayerData[(%0)][e_iPlayedTime] - g_rgePlayerData[(%0)][e_iPlayerPausedTime])
#define Player_Data(%0,%1) (g_rgePlayerData[(%0)][(%1)])

forward ACCOUNT_CheckForBans(playerid);
forward OnPlayerDataFetched(playerid);
forward OnPlayerDataLoaded(playerid);

forward OnAccountInserted(playerid, callback); // first step: insert to main account table
forward OnAccountFullyInserted(playerid, callback); // second step: insert to other tables that rely on the account id