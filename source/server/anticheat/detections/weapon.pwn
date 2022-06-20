#if defined _detections_weapon_
    #endinput
#endif
#define _detections_weapon_

const __ac_weapon_WeaponUpdate = 204;
IPacket:__ac_weapon_WeaponUpdate(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_WEAPON))
        return 1;

    new weaponsUpdate[PR_WeaponsUpdate];
    BS_IgnoreBits(bs, 8);
    BS_ReadWeaponsUpdate(bs, weaponsUpdate);

    for (new i; i < sizeof(g_rgePlayerWeapons[]); ++i)
	{
		if (weaponsUpdate[PR_slotWeaponId][i] && weaponsUpdate[PR_slotWeaponId][i] != WEAPON_PARACHUTE)
		{
            if (g_rgePlayerWeapons[playerid][i][e_iWeaponId] != weaponsUpdate[PR_slotWeaponId][i])
            {
                SetPlayerArmedWeapon(playerid, 0);
                Anticheat_Trigger(playerid, CHEAT_WEAPON);
				return 0;
            }
        }
    }
    return 1;
}