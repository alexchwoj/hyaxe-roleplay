#if defined _weapons_header_
    #endinput
#endif
#define _weapons_header_

const MAX_WEAPON_SLOTS = 13;

enum eWeaponData
{
    e_iWeaponId,
    e_iWeaponAmmo,
    bool:e_bWeaponDisabled
};

new g_rgePlayerWeapons[MAX_PLAYERS + 1][MAX_WEAPON_SLOTS][eWeaponData];

forward Player_GiveWeapon(playerid, weaponid, ammo);
forward Player_RemoveWeapon(playerid, weaponid);
forward Player_GiveLocalWeapons(playerid);
forward Player_RemoveLocalWeapons(playerid);
forward Player_RemoveAllWeapons(playerid);
forward bool:Player_HasWeaponAtSlot(playerid, weaponslot);
forward bool:Player_HasWeapon(playerid, weaponid);
// forward Weapon_GetSlot(weaponid);
forward Player_LoadWeaponsFromCache(playerid);

#define Player_WeaponSlot(%0,%1) g_rgePlayerWeapons[(%0)][(%1)]
forward Weapon_PackIdAndAmmo(weaponid, ammo);
forward Weapon_UnpackIdAndAmmo(weapon_and_ammo, &weapon, &ammo);