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
		if (data[PR_slotWeaponId][i] > WEAPON_BRASSKNUCKLE && data[PR_slotWeaponId][i] != WEAPON_PARACHUTE)
		{
            if (g_rgePlayerWeapons[playerid][i][e_iWeaponId] != data[PR_slotWeaponId][i])
            {
                Anticheat_Trigger(playerid, CHEAT_WEAPON, 0);
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

    new weapon_id;
    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8 + 16 + 16 + 16 + (32 * 7) + 8 + 8 + 2,
        PR_BITS, weapon_id, 6
    );
    
    new slot = GetWeaponSlot(weapon_id);
    if (weapon_id > WEAPON_BRASSKNUCKLE && g_rgePlayerWeapons[playerid][slot][e_iWeaponId] != weapon_id)
    {
        Anticheat_Trigger(playerid, CHEAT_WEAPON, 1);
        return 0;
    }
    return 1;
}

const __ac_weapon_BulletSync = 206;
IPacket:__ac_weapon_BulletSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_WEAPON))
        return 1;
    
    new weapon_id;
    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8 + 8 + 16 + (32 * 9),
        PR_UINT8, weapon_id
    );
    
    new slot = GetWeaponSlot(weapon_id);
    if (weapon_id > WEAPON_BRASSKNUCKLE && g_rgePlayerWeapons[playerid][slot][e_iWeaponId] != weapon_id)
    {
        Anticheat_Trigger(playerid, CHEAT_WEAPON, 2);
        return 0;
    }
    return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_WEAPON))
        return 1;
        
    new slot = GetWeaponSlot(weaponid);
    if (weaponid > WEAPON_BRASSKNUCKLE && g_rgePlayerWeapons[playerid][slot][e_iWeaponId] != weaponid)
    {
        Anticheat_Trigger(playerid, CHEAT_WEAPON, 3);
        return 0;
    }

    #if defined AC_WP_OnPlayerGiveDamage
        return AC_WP_OnPlayerGiveDamage(playerid, damagedid, amount, weaponid, bodypart);
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
