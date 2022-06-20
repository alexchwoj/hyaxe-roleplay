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