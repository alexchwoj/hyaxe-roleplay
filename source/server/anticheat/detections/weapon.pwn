#if defined _detections_weapon_
    #endinput
#endif
#define _detections_weapon_

const __ac_weapon_WeaponUpdate = 204;
IPacket:__ac_weapon_WeaponUpdate(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_WEAPON))
        return 1;

    new data[PR_WeaponsUpdate];
    BS_IgnoreBits(bs, 8);
    BS_ReadWeaponsUpdate(bs, data);

    for (new i; i < sizeof(g_rgePlayerWeapons[]); ++i)
	{
		if (data[PR_slotWeaponId][i] > WEAPON_BRASSKNUCKLE)
		{
            if (g_rgePlayerWeapons[playerid][i][e_iWeaponId] != data[PR_slotWeaponId][i])
            {
                Anticheat_Trigger(playerid, CHEAT_WEAPON);
				return 0;
            }
        }
    }
    return 1;
}

const __ac_weapon_PlayerSync = 207;
IPacket:__ac_weapon_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_WEAPON))
        return 1;

    new data[PR_OnFootSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, data);
    
    new slot = GetWeaponSlot(data[PR_weaponId]);
    if (data[PR_weaponId] > WEAPON_BRASSKNUCKLE && g_rgePlayerWeapons[playerid][slot][e_iWeaponId] != data[PR_weaponId])
    {
        Anticheat_Trigger(playerid, CHEAT_WEAPON);
        return 0;
    }
    return 1;
}

const __ac_weapon_BulletSync = 206;
IPacket:__ac_weapon_BulletSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_WEAPON))
        return 1;

    new data[PR_BulletSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadBulletSync(bs, data);
    
    new slot = GetWeaponSlot(data[PR_weaponId]);
    if (data[PR_weaponId] > WEAPON_BRASSKNUCKLE && g_rgePlayerWeapons[playerid][slot][e_iWeaponId] != data[PR_weaponId])
    {
        Anticheat_Trigger(playerid, CHEAT_WEAPON);
        return 0;
    }
    return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    new slot = GetWeaponSlot(weaponid);
    if (weaponid > WEAPON_BRASSKNUCKLE && g_rgePlayerWeapons[playerid][slot][e_iWeaponId] != weaponid)
    {
        Anticheat_Trigger(playerid, CHEAT_WEAPON);
        return 0;
    }

    #if defined AC_WP_OnPlayerGiveDamage
        return AC_WP_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerGiveDamage
    #undef OnPlayerGiveDamage
#else
    #define _ALS_OnPlayerGiveDamage
#endif
#define OnPlayerGiveDamage AC_WP_OnPlayerGiveDamage
#if defined AC_WP_OnPlayerGiveDamage
    forward AC_WP_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart);
#endif
