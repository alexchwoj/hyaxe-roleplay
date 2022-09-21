#if defined _damage_callbacks_
    #endinput
#endif
#define _damage_callbacks_


public OnPlayerDisconnect(playerid, reason)
{
    g_rgiLastDamageTick[playerid] = g_rgiLastDamageTick[MAX_PLAYERS];

    #if defined DAMAGE_OnPlayerDisconnect
        return DAMAGE_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect DAMAGE_OnPlayerDisconnect
#if defined DAMAGE_OnPlayerDisconnect
    forward DAMAGE_OnPlayerDisconnect(playerid, reason);
#endif


public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    // Damage by another player
    Damage_Validate(playerid, damagedid, weaponid, bodypart);

    #if defined DAMAGE_OnPlayerGiveDamage
        return DAMAGE_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerGiveDamage
    #undef OnPlayerGiveDamage
#else
    #define _ALS_OnPlayerGiveDamage
#endif
#define OnPlayerGiveDamage DAMAGE_OnPlayerGiveDamage
#if defined DAMAGE_OnPlayerGiveDamage
    forward DAMAGE_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart);
#endif


public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    // Damage self-inflicted
    if (issuerid == INVALID_PLAYER_ID)
    {
        Damage_Send(playerid, INVALID_PLAYER_ID, g_rgiWeaponsDamage[weaponid], weaponid);
	}

    #if defined DAMAGE_OnPlayerTakeDamage
        return DAMAGE_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerTakeDamage
    #undef OnPlayerTakeDamage
#else
    #define _ALS_OnPlayerTakeDamage
#endif
#define OnPlayerTakeDamage DAMAGE_OnPlayerTakeDamage
#if defined DAMAGE_OnPlayerTakeDamage
    forward DAMAGE_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart);
#endif

const damage_PlayerSync = 207;
IPacket:damage_PlayerSync(playerid, BitStream:bs)
{
	BS_SetWriteOffset(bs, 280);
    BS_WriteValue(bs,
        PR_UINT8, Player_Health(playerid),
        PR_UINT8, Player_Armor(playerid)
    );
	return 1;
}

public OnPlayerDamage(playerid, issuerid, amount, weaponid, bodypart)
{
    printf("playerid: %d, issuerid: %d, amount: %d, weaponid: %d, bodypart: %d", playerid, issuerid, amount, weaponid, bodypart);
    //new str_text[144];
    //format(str_text, sizeof(str_text), "playerid: %d, issuerid: %d, amount: %d, weaponid: %d, bodypart: %d", playerid, issuerid, amount, weaponid, bodypart);
    //SendClientMessageToAll(-1, str_text);
    return 1;
}