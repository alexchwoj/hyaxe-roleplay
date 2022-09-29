#if defined _detections_rapidfire_
    #endinput
#endif
#define _detections_rapidfire_

static g_rgiLastShotTick[MAX_PLAYERS][55];

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if (!Player_HasImmunityForCheat(playerid, CHEAT_RAPIDFIRE))
    {
        new diff = GetTickDiff(GetTickCount(), g_rgiLastShotTick[playerid][weaponid]);
        if (diff < g_rgiWeaponsShootRate[weaponid])
        {
            printf("[rapidfire:dbg] playerid = %d, weaponid = %d, diff = %d, shot_rate = %d", playerid, weaponid, diff, g_rgiWeaponsShootRate[weaponid]);
            Anticheat_Trigger(playerid, CHEAT_RAPIDFIRE);
            Player_SetImmunityForCheat(playerid, CHEAT_RAPIDFIRE, 1000);
            return 0;
        }
    }

    g_rgiLastShotTick[playerid][weaponid] = GetTickCount();

    #if defined AC_OnPlayerWeaponShot
        return AC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerWeaponShot
    #undef OnPlayerWeaponShot
#else
    #define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot AC_OnPlayerWeaponShot
#if defined AC_OnPlayerWeaponShot
    forward AC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif
