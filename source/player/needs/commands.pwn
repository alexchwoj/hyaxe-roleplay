#if defined _needs_commands_
    #endinput
#endif
#define _needs_commands_

command cagar(playerid, const params[], "Echa un cago")
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING) || Bit_Get(Player_Flags(playerid), PFLAG_ARRESTED))
        return Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes hacer eso");

    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No estás de pie");

    if (GetPlayerSurfingObjectID(playerid) != INVALID_OBJECT_ID)
        return Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes cagar encima de un objeto");

    if (GetPlayerSurfingVehicleID(playerid) != INVALID_VEHICLE_ID)
        return Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes cagar encima de un vehículo");

    if (!CA_IsPlayerOnSurface(playerid, 2.0))
        return Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes cagar en el aire");

    new diff = GetTickCount() - g_rgePlayerTempData[playerid][e_iPlayerShitTick];
    if (120000 > diff)
    {
        SendClientMessagef(playerid, 0xDADADAFF, "Cagaste hace poco. Espera {CB3126}%i minutos{DADADA} antes de volver a cagar.", ((120000 - diff) / 60000));
        return 0;
    }
    
    g_rgePlayerTempData[playerid][e_iPlayerShitTick] = GetTickCount();

    ApplyAnimation(playerid, "PED", "SEAT_IDLE", 4.1, false, false, false, true, 0, false);
    Player_Timer(playerid, e_iPlayerShitTimer) = SetTimerEx("SHIT_StepOne", 2000, false, "i", playerid);

    Chat_SendAction(playerid, "echa un cago");
    return 1;
}

forward SHIT_StepOne(playerid);
public SHIT_StepOne(playerid)
{
    Player_Timer(playerid, e_iPlayerShitTimer) = 0;
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new
        vw = GetPlayerVirtualWorld(playerid),
        int = GetPlayerInterior(playerid);

    if (int != 0)
        z -= 1.0;
    else
        CA_FindZ_For2DCoord(x, y, z);

    Sound_PlayInRange(20803, 10.0, x, y, z, vw, int);

    new fx = CreateDynamicObject(18678, x, y, z, 0.0, 0.0, 0.0, .worldid = vw, .interiorid = int); // fart effect
    new object_one = CreateDynamicObject(18894, x, y, z, 102.09998, 0.0, 0.0, .worldid = vw, .interiorid = int); // shit
    new object_two = CreateDynamicObject(18894, x, y + 0.037354, z + 0.01104, 55.699939, -0.3999, -5.6999, .worldid = vw, .interiorid = int); // shit
    SetDynamicObjectMaterialText(object_one, 0, "AAAAAAAAAAAAA", 10, "courier", 20, 0, 0xFF574336, 0xFF854C24, 0);
    SetDynamicObjectMaterialText(object_two, 0, "AAAAAAAAAAAAA", 10, "courier", 20, 0, 0xFF574336, 0xFF854C24, 0);
    new trash_object = CreateDynamicObject(1265, x, y, z - 0.4, 0.0, 0.0, 0.0, .worldid = vw, .interiorid = int);
    new odor_fx = CreateDynamicObject(18735, x, y, z - 1.2, 0.0, 0.0, 0.0, .worldid = vw, .interiorid = int);
    ClearAnimations(playerid);

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}Cago de {CB3126}%s", Player_RPName(playerid));
    new Text3D:label = CreateDynamic3DTextLabel(HYAXE_UNSAFE_HUGE_STRING, -1, x, y, z + 0.6, 5.0, .testlos = 1, .worldid = vw, .interiorid = int);

    foreach(new i : StreamedPlayer[playerid])
    {
        Streamer_Update(i);
    }

    Streamer_Update(playerid);

    SetTimerEx("SHIT_StepTwo", 30000, false, "iiiiiii", playerid, fx, object_one, object_two, odor_fx, trash_object, _:label);

    return 1;
}

forward SHIT_StepTwo(playerid, effect_one, shit_object_one, shit_object_two, effect_two, trash_object, Text3D:label);
public SHIT_StepTwo(playerid, effect_one, shit_object_one, shit_object_two, effect_two, trash_object, Text3D:label)
{
    DestroyDynamicObject(effect_one);
    DestroyDynamicObject(shit_object_one);
    DestroyDynamicObject(shit_object_two);
    DestroyDynamicObject(effect_two);
    DestroyDynamicObject(trash_object);
    DestroyDynamic3DTextLabel(label);
    return 1;
}