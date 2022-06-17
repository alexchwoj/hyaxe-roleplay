#if defined _weapons_callbacks_
    #endinput
#endif
#define _weapons_callbacks_

public OnPlayerConnect(playerid)
{
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 40);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 500);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 50);

    #if defined WP_OnPlayerConnect
        return WP_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect WP_OnPlayerConnect
#if defined WP_OnPlayerConnect
    forward WP_OnPlayerConnect(playerid);
#endif
