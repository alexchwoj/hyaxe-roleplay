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
    pawn_create_callback("OnPlayerConnect", expr_true());
    pawn_create_callback("OnPlayerDisconnect", expr_true());
    
    s_hConnectHook = pawn_register_callback("OnPlayerConnect", "NPC_HandleConnection", handler_return);
    s_hDisconnectHook = pawn_register_callback("OnPlayerDisconnect", "NPC_HandleDisconnection", handler_return);
    printf("[npcs] Installed connection hooks (C: %x - DC: %x)", _:s_hConnectHook, _:s_hDisconnectHook);
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
        printf("[npcs] Ignored player %i connection because it's a bot", playerid);
        return 1;
    }

    return 0;
}

forward NPC_HandleDisconnection(&ret, playerid, reason);
public NPC_HandleDisconnection(&ret, playerid, reason)
{
    if(FCNPC_IsValid(playerid) || IsPlayerNPC(playerid))
    {
        printf("[npcs] Ignored player %i disconnection because it's a bot", playerid);
        return 1;
    }

    return 0;
}
