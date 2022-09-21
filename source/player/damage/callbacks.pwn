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

const damage_BulletSync = 206;
IPacket:damage_BulletSync(playerid, BitStream:bs)
{
	new data[PR_BulletSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadBulletSync(bs, data);
    
    if (data[PR_hitType] == BULLET_HIT_TYPE_PLAYER)
    {
        new
            Float: getPlayerX,
            Float: getPlayerY,
            Float: getPlayerZ,
            Float: getLastPlayerZ
        ;

        GetPlayerPos(playerid, getPlayerX, getPlayerY, getPlayerZ);
        GetPlayerPos(data[PR_hitId], getLastPlayerZ, getLastPlayerZ, getLastPlayerZ);
        
        new Float:betweenDistance = floatabs(data[PR_origin][0] - getPlayerX) + floatabs(data[PR_origin][1] - getPlayerY);

        if (data[PR_offsets][0] == 0.0 && data[PR_offsets][1] == 0.0 && data[PR_offsets][2] == 0.0 || betweenDistance < 0.15 || floatabs(data[PR_origin][2] - getPlayerZ) < 0.01 || floatabs(getLastPlayerZ - data[PR_hitPos][2]) < 0.01)
        {
            return 0;
        }
    }
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