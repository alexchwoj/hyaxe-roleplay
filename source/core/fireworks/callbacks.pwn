#if defined _fireworks_callbacks_
    #endinput
#endif
#define _fireworks_callbacks_

public OnScriptInit()
{
    /*CreateDynamicObject(19296, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);
    CreateDynamicObject(19290, 3.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);
    CreateDynamicObject(19282, 6.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);
    CreateDynamicObject(19286, 9.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);*/

    /*new
        Float:x = 0.0,
        Float:y = 0.0,
        Float:z = 10.0
    ;

    for(new i; i != 256 / 4; i++)
	{
        new Float:px, Float:py, Float:pz;
        RandomPointInSphere(RandomFloat(4.0, 4.2), px, py, pz);
        CreateDynamicObject(19294, x + px, y + py, z + pz, 0.0, 0.0, 0.0, 0, 0);
    }

    for(new i; i != 256 / 4; i++)
	{
        new Float:px, Float:py, Float:pz;
        RandomPointInSphere(RandomFloat(3.0, 3.5), px, py, pz);
        CreateDynamicObject(19282, x + px, y + py, z + pz, 0.0, 0.0, 0.0, 0, 0);
    }

    for(new i; i != 128 / 4; i++)
	{
        new Float:px, Float:py, Float:pz;
        RandomPointInSphere(RandomFloat(1.0, 1.5), px, py, pz);
        CreateDynamicObject(19281, x + px, y + py, z + pz, 0.0, 0.0, 0.0, 0, 0);
    }*/

    #if defined FIRE_OnScriptInit
        return FIRE_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit FIRE_OnScriptInit
#if defined FIRE_OnScriptInit
    forward FIRE_OnScriptInit();
#endif

forward FIRE_DelayedDestroyObject(objectid);
public FIRE_DelayedDestroyObject(objectid)
{
    DestroyDynamicObject(objectid);
    return 1;
}

/*command firework1(playerid, const params[], "")
{
    Firework_Coconut(0.0, 0.0, 0.0, 50.0);
    Streamer_Update(playerid);
    return 1;
}

command firework2(playerid, const params[], "")
{
    Firework_Strobe(0.0, 0.0, 0.0, 50.0);
    Streamer_Update(playerid);
    return 1;
}

command firework3(playerid, const params[], "")
{
    Firework_ColoredSphere(0.0, 0.0, 0.0, 50.0);
    Streamer_Update(playerid);
    return 1;
}

command firework4(playerid, const params[], "")
{
    Firework_Fish(0.0, 0.0, 0.0, 50.0);
    Streamer_Update(playerid);
    return 1;
}

command firework5(playerid, const params[], "")
{
    Firework_Wave(0.0, 0.0, 0.0, 50.0);
    Streamer_Update(playerid);
    return 1;
}

command firework6(playerid, const params[], "")
{
    Firework_Ring(0.0, 0.0, 0.0, 50.0);
    Streamer_Update(playerid);
    return 1;
}*/