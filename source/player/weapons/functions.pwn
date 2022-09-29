#if defined _weapons_functions_
    #endinput
#endif
#define _weapons_functions_

// least significant byte is the weaponid, rest of the integer is the ammo
Weapon_PackIdAndAmmo(weaponid, ammo)
{
    return (clamp(ammo, 0, 32767) << 8) | weaponid;
}

stock Weapon_UnpackIdAndAmmo(weapon_and_ammo, &weapon, &ammo)
{
    ammo = (weapon_and_ammo >>> 8);
    weapon = (weapon_and_ammo & 0xFF);
}

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

/*
Weapon_GetSlot(weaponid)
{
    switch(weaponid)
    {
        case 0, 1:          return 0;
        case 2 .. 9:        return 1;
        case 10 .. 15:      return 10;
        case 16 .. 18:      return 8;
        case 22 .. 24:      return 2;
        case 25 .. 27:      return 3;
        case 28, 29, 32:    return 4;
        case 30, 31:        return 5;
        case 33, 34:        return 6;
        case 35 .. 38:      return 7;
        case 39:            return 8;
        case 40:            return 12;
        case 41 .. 43:      return 9;
        case 44 .. 46:      return 11;
    }

    return MAX_WEAPON_SLOTS;
}
*/

Player_GiveWeapon(playerid, weaponid, ammo)
{
    Player_SetImmunityForCheat(playerid, CHEAT_WEAPON, 1500 + GetPlayerPing(playerid));

    new slot = GetWeaponSlot(weaponid);
    printf("playerid = %d, weaponid = %d, ammo = %d, slot = %d", playerid, weaponid, ammo, slot);
    Player_WeaponSlot(playerid, slot)[e_iWeaponId] = weaponid;
    Player_WeaponSlot(playerid, slot)[e_iWeaponAmmo] = ammo;
    GivePlayerWeapon(playerid, weaponid, ammo);

    new weapon_and_ammo = Weapon_PackIdAndAmmo(weaponid, ammo);

    DEBUG_PRINT("[dbg:weapons] Saving weapon %i with %i ammo to player %i: %b", weaponid, ammo, playerid, weapon_and_ammo);

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH,
        "UPDATE `PLAYER_WEAPONS` SET \
            `SLOT_%i` = %i \
        WHERE `ACCOUNT_ID` = %i LIMIT 1;\
    ", slot, weapon_and_ammo, Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    return 1;
}

Player_RemoveWeapon(playerid, weaponid)
{
    Player_SetImmunityForCheat(playerid, CHEAT_WEAPON, 1000 + GetPlayerPing(playerid));

    new slot = GetWeaponSlot(weaponid);
    if(!Player_HasWeaponAtSlot(playerid, slot))
        return 0;
    
    Player_WeaponSlot(playerid, slot)[e_iWeaponId] = 
    Player_WeaponSlot(playerid, slot)[e_iWeaponAmmo] = 0;

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `PLAYER_WEAPONS` SET `SLOT_%i` = 0 WHERE `ACCOUNT_ID` = %i;", slot, Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    ResetPlayerWeapons(playerid);

    for(new i = 1; i < MAX_WEAPON_SLOTS; ++i)
    {
        if(Player_WeaponSlot(playerid, slot)[e_iWeaponId])
        {
            GivePlayerWeapon(playerid, Player_WeaponSlot(playerid, slot)[e_iWeaponId], Player_WeaponSlot(playerid, slot)[e_iWeaponAmmo]);
        }
    }

    return 1;
}

Player_RemoveAllWeapons(playerid)
{
    Player_SetImmunityForCheat(playerid, CHEAT_WEAPON, 1000 + GetPlayerPing(playerid));
    
    ResetPlayerWeapons(playerid);
    g_rgePlayerWeapons[playerid] = g_rgePlayerWeapons[MAX_PLAYERS];

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `PLAYER_WEAPONS` SET \
            `SLOT_1` = 0, \
            `SLOT_2` = 0, \
            `SLOT_3` = 0, \
            `SLOT_4` = 0, \
            `SLOT_5` = 0, \
            `SLOT_6` = 0, \
            `SLOT_7` = 0, \
            `SLOT_8` = 0, \
            `SLOT_9` = 0, \
            `SLOT_10` = 0, \
            `SLOT_11` = 0, \
            `SLOT_12` = 0 \
        WHERE `ACCOUNT_ID` = %i;\
    ", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
}

bool:Player_HasWeaponAtSlot(playerid, weaponslot)
{
    return (g_rgePlayerWeapons[playerid][weaponslot][e_iWeaponId] != 0);
}

bool:Player_HasWeapon(playerid, weaponid)
{
    new slot = GetWeaponSlot(weaponid);
    return g_rgePlayerWeapons[playerid][slot][e_iWeaponId] == weaponid;
}

Player_GiveAllWeapons(playerid)
{
    Player_SetImmunityForCheat(playerid, CHEAT_WEAPON, 1000 + GetPlayerPing(playerid));
    
    for(new i = 1; i < MAX_WEAPON_SLOTS; ++i)
    {
        if(!Player_HasWeaponAtSlot(playerid, i))
            continue;

        Player_WeaponSlot(playerid, i)[e_bWeaponDisabled] = false;
        GivePlayerWeapon(playerid, Player_WeaponSlot(playerid, i)[e_iWeaponId], Player_WeaponSlot(playerid, i)[e_iWeaponAmmo]);
    }

    return 1;
}

Player_RemoveLocalWeapons(playerid)
{
    ResetPlayerWeapons(playerid);
    for(new i = 1; i < MAX_WEAPON_SLOTS; ++i)
    {
        if(!Player_HasWeaponAtSlot(playerid, i))
            continue;

        Player_WeaponSlot(playerid, i)[e_bWeaponDisabled] = true;
    }
}

Player_LoadWeaponsFromCache(playerid)
{
    new szSlot[9];

    for(new i = 1; i < MAX_WEAPON_SLOTS; ++i)
    {
        format(szSlot, sizeof(szSlot), "SLOT_%i", i);

        new weapon_and_ammo;
        cache_get_value_name_int(0, szSlot, weapon_and_ammo);

        if(weapon_and_ammo)
        {
            new weaponid, ammo;
            Weapon_UnpackIdAndAmmo(weapon_and_ammo, weaponid, ammo);

            new iSlot = GetWeaponSlot(weaponid);
            Player_WeaponSlot(playerid, iSlot)[e_iWeaponId] = weaponid;
            Player_WeaponSlot(playerid, iSlot)[e_iWeaponAmmo] = ammo;
        }
    }

    return 1;
}

command giveweapon(playerid, const params[], "Le da un arma a un jugador")
{
    new weaponid, ammo, destination;
    if (sscanf(params, "p<,>k<weapon>I(32767)R(-1)", weaponid, ammo, destination) || weaponid == -1)
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/giveweapon {DADADA}<arma>, {969696}[munición = máx.], [jugador = tú]");
        return 1;
    }

    if (destination == INVALID_PLAYER_ID || destination == -1)
        destination = playerid;

    Player_GiveWeapon(destination, weaponid, ammo);

    new weapon_name[20];
    GetWeaponName(weaponid, weapon_name);

    if (playerid != destination)
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le diste un(a) {ED2B2B}%s{DADADA} con {ED2B2B}%i balas{DADADA} a {ED2B2B}%s{DADADA}.", weapon_name, ammo, Player_RPName(destination));
    }
    
    SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Se te asignó un(a) {ED2B2B}%s{DADADA} con {ED2B2B}%i balas{DADADA}.", weapon_name, ammo);

    return 1;
}
flags:giveweapon(CMD_FLAG<RANK_LEVEL_MODERATOR>)
