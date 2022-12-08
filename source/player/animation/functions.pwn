#if defined _animation_functions_
    #endinput
#endif
#define _animation_functions_

command parar(playerid, const params[], "Para la animación")
{
    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING) || Bit_Get(Player_Flags(playerid), PFLAG_ARRESTED))
        return 0;
        
    ClearAnimations(playerid, 1);
    return 1;
}

command mear(playerid, const params[], "Echa un meo")
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING) || Bit_Get(Player_Flags(playerid), PFLAG_ARRESTED))
        return Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes hacer eso");
        
    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return SendClientMessage(playerid, 0xDADADAFF, "No estas {CB3126}de pie{DADADA}.");

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_PISSING);
    Chat_SendAction(playerid, "echa un meo");
    return 1;
}

command paja(playerid, const params[], "Hazte una paja")
{
    ApplyAnimation(playerid, "PAULNMAC", "WANK_LOOP", 4.1, 1, 1, 1, 0, 0);
    return 1;
}

command dormir(playerid, const params[], "Duerme")
{
    ApplyAnimation(playerid, "INT_HOUSE", "BED_IN_L", 4.1, 0, 1, 1, 0, 0);
    return 1;
}

command sentarse(playerid, const params[], "Sentate bien mostro")
{
    extract params -> new idx; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/sentarse {DADADA}<anim: 0-8>");
        return 1;
    }

    switch(idx)
    {
        case 0: ApplyAnimation(playerid, "INT_HOUSE", "LOU_IN", 4.1, 0, 1, 1, 0, 0);
        case 1: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_BORED_LOOP", 4.1, 1, 1, 1, 0, 0);
        case 2: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_CRASH", 4.1, 1, 1, 1, 0, 0);
        case 3: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_DRINK", 4.1, 1, 1, 1, 0, 0);
        case 4: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_IDLE_LOOP", 4.1, 1, 1, 1, 0, 0);
        case 5: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_IN", 4.1, 1, 1, 1, 0, 0);
        case 6: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_READ", 4.1, 1, 1, 1, 0, 0);
        case 7: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_TYPE_LOOP", 4.1, 1, 1, 1, 0, 0);
        case 8: ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_WATCH", 4.1, 1, 1, 1, 0, 0);
        default: SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/sentarse {DADADA}<anim: 0-8>");
    }

    return 1;
}

command bailar(playerid, const params[], "Baila")
{
    extract params -> new idx; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/bailar {DADADA}<anim: 1-4>");
        return 1;
    }

    switch(idx)
    {
        case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
        case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
        case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
        case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
        default: SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/bailar {DADADA}<anim: 1-4>");
    }

    return 1;
}

command borracho(playerid, const params[], "Camina borracho")
{
    ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 500);
    return 1;
}

command rendirse(playerid, const params[], "Levanta las manos")
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
    return 1;
}