#if defined _fixes_bots_
    #endinput
#endif
#define _fixes_bots_

// Don't process bots as real players

static 
    CallbackHandler:s_hConnectHook,
    CallbackHandler:s_hDisconnectHook
;

on_init Fix_Bots()
{
    s_hConnectHook = pawn_register_callback("OnPlayerConnect", "NPC_HandleConnection", handler_return);
    s_hDisconnectHook = pawn_register_callback("OnPlayerDisconnect", "NPC_HandleDisconnection", handler_return);
    print("[npcs] Installed OnPlayer(Dis)Connect hooks");
}

on_exit Fix_Bots()
{
    pawn_unregister_callback(s_hConnectHook);
    pawn_unregister_callback(s_hDisconnectHook);
    print("[npcs] Unhooked callbacks");
}

forward NPC_HandleConnection(&ret, playerid);
public NPC_HandleConnection(&ret, playerid)
{    
    ret = 1;

    if(FCNPC_IsValid(playerid) || IsPlayerNPC(playerid))
    {
        SetPlayerColor(playerid, 0xF7F7F700);
        printf("[npcs] Player %i ignored because it's a bot", playerid);
        return 1;
    }

    return 0;
}

forward NPC_HandleDisconnection(&ret, playerid, reason);
public NPC_HandleDisconnection(&ret, playerid, reason)
{
    ret = 1;
    return FCNPC_IsValid(playerid) || IsPlayerNPC(playerid);
}
