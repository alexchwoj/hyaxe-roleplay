#if defined _weapons_commands_
    #endinput
#endif
#define _weapons_commands_

command giveweapon(playerid, const params[], "Dale un arma a alguien")
{
    extract params -> new kustom:weaponid<weapon>, player:destination = 0xFFFF; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/giveweapon{DADADA} <arma>{969696} [jugador = tú]");
        return 1;
    }

    if (weaponid == -1)
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} Arma inválida.");
        return 1;
    }
    
    if (destination == 0xFFFF)
        destination = playerid;

    Player_GiveWeapon(destination, weaponid);

    new weapon[40];
    GetWeaponName(weaponid, weapon);
    
    if (destination != playerid)
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Se le asignó un(a) {ED2B2B}%s{DADADA} a {ED2B2B}%s{DADADA}.", weapon, Player_RPName(destination));
        SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Un administrador te dio un(a) {ED2B2B}%s{DADADA}.", weapon);
    }
    else
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Se te asignó un(a) {ED2B2B}%s{DADADA}.", weapon);
    }

    return 1;
}
flags:giveweapon(CMD_FLAG<RANK_LEVEL_MODERATOR>)