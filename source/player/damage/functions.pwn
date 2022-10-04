#if defined _damage_functions_
    #endinput
#endif
#define _damage_functions_

Player_SetArmor(playerid, amount)
{
	Player_Armor(playerid) = amount;
	SetPlayerArmour(playerid, amount);
	return 1;
}

Player_SetHealth(playerid, amount)
{
	Player_Health(playerid) = clamp(amount, 0, 100);

	if (amount <= 0)
	{
		if (GetTickCount() < g_rgiLastDeathTick[playerid] || Bit_Get(Player_Flags(playerid), PFLAG_HOSPITAL))
			return 0;

		SetPlayerDrunkLevel(playerid, 4000);
		ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.1, false, false, true, false, 0, false);
		PlayerPlaySound(playerid, 1163);
		CallLocalFunction(!"OnPlayerDeath", !"iid", playerid, INVALID_PLAYER_ID, 54);
		g_rgiLastDeathTick[playerid] = GetTickCount() + 1000;
	}
	else SetPlayerHealth(playerid, amount);

	return 1;
}

Damage_Send(to, from, Float:amount, weaponid)
{
	if (GetTickCount() < g_rgiLastDamageTick[to][weaponid])
		return 0;

	new armour, damage = floatround(amount);

	if ((armour = Player_Armor(to)) >= 1)
	{
		if ((Player_Armor(to) - damage) <= 0)
		{
			Player_SetArmor(to, 0);
			Damage_Send(to, from, -(armour - amount), weaponid);
		}
		else Player_SetArmor(to, Player_Armor(to) - damage);
	}
	else
	{
		if ((Player_Health(to) - damage) <= 5)
		{
			Player_SetHealth(to, 0);
		}
		else Player_SetHealth(to, Player_Health(to) - damage);
	}

	g_rgiLastDamageTick[to][weaponid] = GetTickCount() + g_rgiWeaponsShootRate[weaponid];
	return 1;
}

Weapon_SetDamage(weapon_id, damage)
{
	g_rgiWeaponsDamage[weapon_id] = damage;
	return 1;
}

Damage_Validate(playerid, damagedid, weaponid, bodypart)
{
    if (GetTickCount() > g_rgiLastBulletTick[playerid])
    {
        printf("damage without bullet sync");
        return 0;
    }

	// Calculate distance
	new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2;
	GetPlayerPos(playerid, x1, y1, z1);
	GetPlayerPos(damagedid, x2, y2, z2);

	// Check distance
    new Float:distance = VectorSize(x1 - x2, y1 - y2, z1 - z2);
    if (distance < g_rgfWeaponsRange[weaponid])
    {
		// Gun butt blows
        if (distance <= 1.5)
        {
            CallLocalFunction(!"OnPlayerDamage", !"iidii", damagedid, playerid, 1, weaponid, bodypart);
            Damage_Send(damagedid, playerid, 1, weaponid);
            g_rgiLastDamageTick[playerid][weaponid] = GetTickCount() + 1200;
            return 1;
        }

		// Verify that an object does not cross in between
        new Float:ray_x, Float:ray_y, Float:ray_z;
        new ray = CA_RayCastLine(
            x1, y1, z1,
            x2, y2, z2,
            ray_x, ray_y, ray_z
        );

        new bool:valid_collision = true;
        if (ray)
        {
            // Ignore specific objects
            switch(ray)
            {
                case WATER_OBJECT, 1411, 19837, 19838, 19839, 2247, 701, 702, 859, 677, 860, 631, 647, 8153, 1412:
                    valid_collision = true;
                
                default:
                    valid_collision = false;
            }
        }

        // Send damage
        if (valid_collision)
        {
            CallLocalFunction(!"OnPlayerDamage", !"iidii", damagedid, playerid, g_rgiWeaponsDamage[weaponid], weaponid, bodypart);
            Damage_Send(damagedid, playerid, g_rgiWeaponsDamage[weaponid], weaponid);
        }
		return 1;
    }
	return 0;
}

command setarmor(playerid, const params[], "Darle chaleco a un jugador")
{
    extract params -> new armor = 100, player:destination = 0xFFFF; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/setarmour {DADADA}[chaleco = 100] [jugador = tú]");
        return 1;
    }

	if (destination == INVALID_PLAYER_ID)
        destination = playerid;

	Player_SetArmor(destination, armor);

    if (playerid != destination)
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le diste {ED2B2B}%d{DADADA} puntos de chaleco a {ED2B2B}%s{DADADA}.", armor, Player_RPName(destination));
    }
    
    SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Se te asignó el chaleco a {ED2B2B}%d{DADADA}.", armor);

    return 1;
}
flags:setarmor(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command sethealth(playerid, const params[], "Darle salud a un jugador")
{
    extract params -> new health = 100, player:destination = 0xFFFF; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/sethealth {DADADA}[vida = 100] [jugador = tú]");
        return 1;
    }

	if (destination == INVALID_PLAYER_ID)
        destination = playerid;

	Player_SetHealth(destination, health);

    if (playerid != destination)
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le diste {ED2B2B}%d{DADADA} puntos de salud a {ED2B2B}%s{DADADA}.", health, Player_RPName(destination));
    }
    
    SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Se te asignó la salud a {ED2B2B}%d{DADADA}.", health);

    return 1;
}
flags:sethealth(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command revive(playerid, const params[], "Revivir a un jugador")
{
    extract params -> new player:destination = 0xFFFF, health = 100; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/revive {DADADA}[jugador = tú] [vida = 100]");
        return 1;
    }

	if (destination == INVALID_PLAYER_ID)
        destination = playerid;

	Player_SetHealth(destination, health);
	Player_Revive(destination);

    if (playerid != destination)
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Reviviste a {ED2B2B}%s{DADADA} con la vida a {ED2B2B}%d{DADADA}.", Player_RPName(destination), health);
    }
    
    SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Te reviviste con la vida a {ED2B2B}%d{DADADA}.", health);

    return 1;
}
flags:revive(CMD_FLAG<RANK_LEVEL_MODERATOR>)
alias:revive("rev")