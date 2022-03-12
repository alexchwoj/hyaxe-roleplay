#if defined _crawl_functions_
    #endinput
#endif
#define _crawl_functions_


command kill(playerid, const params[], "Suicidarse")
{
    Player_SetHealth(playerid, 0);
    return 1;
}