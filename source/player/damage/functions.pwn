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
		CallLocalFunction(!"OnPlayerDeath", !"iid", playerid, INVALID_PLAYER_ID, 54);
	else
		SetPlayerHealth(playerid, amount);
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
		if ((Player_Health(to) - damage) <= 0)
		{
			Player_SetHealth(to, 0);
			//CallLocalFunction(!"OnPlayerDeath", !"iid", to, from, weaponid);
			//Player_SetHealth(to, 0);
			//Player_Health(to) = 0;
			//SetPlayerHealth(to, 0.0);
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