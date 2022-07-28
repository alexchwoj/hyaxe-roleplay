#if defined _animation_functions_
    #endinput
#endif
#define _animation_functions_

command mear(playerid, const params[], "Echa un meo")
{
    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return SendClientMessage(playerid, 0xDADADAFF, "No estas {CB3126}de pie{DADADA}.");

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_PISSING);
    Chat_SendAction(playerid, "echa un meo");
    return 1;
}