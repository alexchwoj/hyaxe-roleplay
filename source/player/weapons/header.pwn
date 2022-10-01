#if defined _weapons_header_
    #endinput
#endif
#define _weapons_header_

const MAX_WEAPON_SLOTS = 13;

new g_rgiPlayerWeapons[MAX_PLAYERS][MAX_WEAPON_SLOTS];

forward Player_GiveWeapon(playerid, weaponid);
forward Player_GiveAllWeapons(playerid);
forward Player_LoadWeaponsFromCache(playerid);