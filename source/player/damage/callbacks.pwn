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
    new
		Float:x1, Float:y1, Float:z1,
		Float:x2, Float:y2, Float:z2
	;

	GetPlayerPos(playerid, x1, y1, z1);
	GetPlayerPos(damagedid, x2, y2, z2);

    if (VectorSize(x1 - x2, y1 - y2, z1 - z2) > g_rgfWeaponsRange[weaponid])
        return 0;

    if (weaponid <= WEAPON_SNIPER)
        amount = g_rgiWeaponsDamage[weaponid];

    CallLocalFunction(!"OnPlayerDamage", !"iidii", damagedid, playerid, floatround(amount), weaponid, bodypart);
    Damage_Send(damagedid, playerid, amount, weaponid);

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
    if (issuerid == INVALID_PLAYER_ID)
    {
        Damage_Send(playerid, INVALID_PLAYER_ID, g_rgiWeaponsDamage[weaponid], weaponid);
	}
    else
    {
        if (issuerid != INVALID_PLAYER_ID && weaponid < 50 && weaponid != WEAPON_FLAMETHROWER)
	        return 0;

        CallLocalFunction(!"OnPlayerDamage", !"iidii", playerid, issuerid, floatround(amount), weaponid, bodypart);
        Damage_Send(playerid, issuerid, amount, weaponid);
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


IPacket:207(playerid, BitStream:bs)
{
	new onfoot_data[PR_OnFootSync];

	BS_IgnoreBits(bs, 8);
	BS_ReadOnFootSync(bs, onfoot_data);

	onfoot_data[PR_health] = Player_Health(playerid);
	onfoot_data[PR_armour] = Player_Armor(playerid);

	BS_SetWriteOffset(bs, 8);
	BS_WriteOnFootSync(bs, onfoot_data);
	return 1;
}

public OnPlayerDamage(playerid, issuerid, amount, weaponid, bodypart)
{
    printf("playerid: %d, issuerid: %d, amount: %d, weaponid: %d, bodypart: %d", playerid, issuerid, amount, weaponid, bodypart);
    return 1;
}