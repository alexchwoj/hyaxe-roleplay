#if defined _animation_functions_
    #endinput
#endif
#define _animation_functions_

command mear(playerid, const params[], "Echa un meo")
{
    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return SendClientMessage(playerid, 0xDADADAFF, "No estas {CB3126}de pie{DADADA}.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    Sound_PlayInRange(
        14200,
        15.0, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)
    );

    SetPlayerSpecialAction(playerid, 68);
    Chat_SendAction(playerid, "echa un meo");
    return 1;
}