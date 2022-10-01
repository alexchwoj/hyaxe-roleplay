#if defined _weapons_functions_
    #endinput
#endif
#define _weapons_functions_

// least significant byte is the weaponid, rest of the integer is the ammo
bool:Weapon_IsExplosive(weapon)
{
    switch(weapon)
    {
        case WEAPON_GRENADE: return true;
        case WEAPON_TEARGAS: return true;
        case WEAPON_MOLTOV: return true;
        case WEAPON_ROCKETLAUNCHER: return true;
        case WEAPON_HEATSEEKER: return true;
        case WEAPON_SATCHEL: return true;
        case WEAPON_BOMB: return true;
        case WEAPON_MINIGUN: return true;
        case WEAPON_FLAMETHROWER: return true;
    }
    return false;
}

Player_GiveWeapon(playerid, weaponid)
{
    new slot = GetWeaponSlot(weaponid);
    if(slot < 1)
        return 0;

    g_rgiPlayerWeapons[playerid][slot] = weaponid;
    GivePlayerWeapon(playerid, weaponid, 32767);

    mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "UPDATE `PLAYER_WEAPONS` SET `SLOT_%i` = %i WHERE `ACCOUNT_ID` = %i LIMIT 1;", slot, weaponid, Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);

    return 1;
}

Player_GiveAllWeapons(playerid)
{
    for(new i = 1; i < MAX_WEAPON_SLOTS; ++i)
    {
        if(g_rgiPlayerWeapons[playerid][i])
        {
            GivePlayerWeapon(playerid, g_rgiPlayerWeapons[playerid][i], 32767);
        }
    }

    return 1;
}

Player_LoadWeaponsFromCache(playerid)
{
    DEBUG_PRINT("[func] Player_LoadWeaponsFromCache(playerid = %i)", playerid);

    new slot[10];

    for(new i = 1; i < MAX_WEAPON_SLOTS; ++i)
    {
        format(slot, sizeof(slot), "SLOT_%d", i);
        DEBUG_PRINT("Loading slot %s", slot);
        cache_get_value_name_int(0, slot, g_rgiPlayerWeapons[playerid][i]);
        DEBUG_PRINT("Slot value: %i", g_rgiPlayerWeapons[playerid][i]);
    }

    return 1;
}

Player_RemoveAllWeapons(playerid)
{
    ResetPlayerWeapons(playerid);

    mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "UPDATE `PLAYER_WEAPONS` SET \
        SLOT_1 = 0, \
        SLOT_2 = 0, \
        SLOT_3 = 0, \
        SLOT_4 = 0, \
        SLOT_5 = 0, \
        SLOT_6 = 0, \
        SLOT_7 = 0, \
        SLOT_8 = 0, \
        SLOT_9 = 0, \
        SLOT_10 = 0, \
        SLOT_11 = 0, \
        SLOT_12 = 0 \
    WHERE `ACCOUNT_ID` = %i;", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);

    return 1;
}