#if defined _anticheat_header_
    #endinput
#endif
#define _anticheat_header_

enum eCheats
{
    CHEAT_REPAIR_CAR,
    CHEAT_MONEY_HACK,
    CHEAT_FLY,
    CHEAT_SPEEDHACK,
    CHEAT_WEAPON,
    CHEAT_CARJACK,
    CHEAT_SLAPPER,
    CHEAT_TELEPORT,
    CHEAT_INVISIBLE,
    CHEAT_INVALID_SYNC,
    CHEAT_AIRBREAK
};

enum ePunishment
{
    PUNISHMENT_IGNORE,
    PUNISHMENT_WARN_ADMINS,
    PUNISHMENT_KICK,
    PUNISHMENT_BAN,
    PUNISHMENT_KICK_ON_MAX_TRIGGERS,
    PUNISHMENT_BAN_ON_MAX_TRIGGERS
};

enum eDetectionData
{
    e_szDetectionName[32],
    bool:e_bDetectionEnabled,
    ePunishment:e_ePunishmentType,
    e_iMaxTriggers
};

new g_rgeDetectionData[eCheats][eDetectionData] =
{
    { "Reparar vehículo", true, PUNISHMENT_KICK, 0 },
    { "Dinero", true, PUNISHMENT_IGNORE, 0 },
    { "Volar", true, PUNISHMENT_KICK, 0 },
    { "Speedhack", true, PUNISHMENT_KICK, 0 },
    { "Weaponhack", true, PUNISHMENT_KICK, 0 },
    { "CarJack", true, PUNISHMENT_KICK, 0 }, // External detection on vehicle module
    { "Slapper", true, PUNISHMENT_KICK, 0 },
    { "Teletransportación", true, PUNISHMENT_KICK_ON_MAX_TRIGGERS, 20 },
    { "Invisibilidad", true, PUNISHMENT_WARN_ADMINS, 0 },
    { "Sincronización inválida", true, PUNISHMENT_KICK, 0 },
    { "AirBreak", true, PUNISHMENT_KICK_ON_MAX_TRIGGERS, 5 }
};

new 
    DB:g_hAnticheatDatabase,
    g_rgiAnticheatImmunity[MAX_PLAYERS][eCheats],
    g_rgiAnticheatTriggers[MAX_PLAYERS][eCheats char];

forward Anticheat_Trigger(playerid, eCheats:cheat, extra = 0);
//forward bool:Player_HasImmunityForCheat(playerid, eCheats:cheat);
#define Anticheat_PlayerImmunity(%0,%1) (g_rgiAnticheatImmunity[(%0)][(%1)])
#define Player_SetImmunityForCheat(%0,%1,%2) (Anticheat_PlayerImmunity(%0,%1) = GetTickCount() + (%2))
#define Player_HasImmunityForCheat(%0,%1) (g_rgiAnticheatImmunity[(%0)][(%1)] && GetTickDiff(g_rgiAnticheatImmunity[(%0)][(%1)], GetTickCount()) > 0)