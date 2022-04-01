#if defined _enter_exits_functions_
    #endinput
#endif
#define _enter_exits_functions_

static EnterExit_FindFreeIndex()
{
    for(new i; i < HYAXE_MAX_ENTER_EXITS; ++i)
    {
        if(!g_rgeEnterExits[i][e_bValid])
            return i;
    }

    return -1;
}

EnterExit_Create(pickup_model, const enter_text[], const exit_text[], Float:enter_x, Float:enter_y, Float:enter_z, Float:enter_ang, enter_world, enter_interior, Float:exit_x, Float:exit_y, Float:exit_z, Float:exit_ang, exit_world, exit_interior, extra_data = -1, callback_address = 0)
{
    new i = EnterExit_FindFreeIndex();
    if(i == -1)
    {
        print("[enterexit!] Failed to create enter-exit (pool out of space)");
        return -1;
    }

    DEBUG_PRINT("[enterexit] Creating with ID %d", i);
    new info[3];
    info[0] = 0x4545; // EE
    info[1] = i; // EnEx ID
    info[2] = 1; // Enter

    g_rgeEnterExits[i][e_bValid] = true;
    
    // Enter
    g_rgeEnterExits[i][e_fEnterX] = enter_x;
    g_rgeEnterExits[i][e_fEnterY] = enter_y;
    g_rgeEnterExits[i][e_fEnterZ] = enter_z;
    g_rgeEnterExits[i][e_fEnterAngle] = enter_ang;
    g_rgeEnterExits[i][e_iEnterWorld] = enter_world;
    g_rgeEnterExits[i][e_iEnterInterior] = enter_interior;
    g_rgeEnterExits[i][e_iEnterLabel] = CreateDynamic3DTextLabel(enter_text, -1, enter_x, enter_y, enter_z, 10.0, .testlos = 1, .worldid = enter_world, .interiorid = enter_interior);
    g_rgeEnterExits[i][e_iEnterPickup] = CreateDynamicPickup(pickup_model, 1, enter_x, enter_y, enter_z - 0.5, .worldid = enter_world, .interiorid = enter_interior);
    g_rgeEnterExits[i][e_iEnterArea] = CreateDynamicCircle(enter_x, enter_y, 1.0, .worldid = enter_world, .interiorid = enter_interior);
    Streamer_SetArrayData(STREAMER_TYPE_AREA, g_rgeEnterExits[i][e_iEnterArea], E_STREAMER_EXTRA_ID, info);
    Key_Alert(enter_x, enter_y, enter_z, 1.0, KEYNAME_CTRL_BACK, enter_world, enter_interior);

    // Exit
    info[2] = 0; // Exit
    g_rgeEnterExits[i][e_fExitX] = exit_x;
    g_rgeEnterExits[i][e_fExitY] = exit_y;
    g_rgeEnterExits[i][e_fExitZ] = exit_z;
    g_rgeEnterExits[i][e_fExitAngle] = exit_ang;
    g_rgeEnterExits[i][e_iExitWorld] = exit_world;
    g_rgeEnterExits[i][e_iExitInterior] = exit_interior;
    g_rgeEnterExits[i][e_iExitLabel] = CreateDynamic3DTextLabel(exit_text, -1, exit_x, exit_y, exit_z, 10.0, .testlos = 1, .worldid = exit_world, .interiorid = exit_interior);
    g_rgeEnterExits[i][e_iExitPickup] = CreateDynamicPickup(pickup_model, 1, exit_x, exit_y, exit_z - 0.5, .worldid = exit_world, .interiorid = exit_interior);
    g_rgeEnterExits[i][e_iExitArea] = CreateDynamicCircle(exit_x, exit_y, 1.0, .worldid = exit_world, .interiorid = exit_interior);
    Streamer_SetArrayData(STREAMER_TYPE_AREA, g_rgeEnterExits[i][e_iExitArea], E_STREAMER_EXTRA_ID, info);
    Key_Alert(exit_x, exit_y, exit_z, 1.0, KEYNAME_CTRL_BACK, exit_world, exit_interior);

    g_rgeEnterExits[i][e_iEnterExitData] = extra_data;
    g_rgeEnterExits[i][e_iEnterExitCallback] = callback_address;

    return i;
}