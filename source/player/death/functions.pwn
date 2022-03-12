#if defined _death_functions_
    #endinput
#endif
#define _death_functions_

command kill(playerid, const params[], "Suicidarse")
{
    Player_SetHealth(playerid, 0);
    return 1;
}