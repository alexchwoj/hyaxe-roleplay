#if defined _fireworks_functions_
    #endinput
#endif
#define _fireworks_functions_

RandomPointInSphere(Float:radius, &Float:x, &Float:y, &Float:z)
{
    new
        Float:u = RandomFloat(0.0, 1.0),
        Float:v = RandomFloat(0.0, 1.0),
        Float:theta = 2.0 * M_PI * u,
        Float:phi = acos(2.0 * v - 1.0)
    ;
    
    x = radius * floatsin(phi) * floatcos(theta);
    y = radius * floatsin(phi) * floatsin(theta);
    z = radius * floatcos(phi);
    return 1;
}

Firework_Coconut(Float:x, Float:y, Float:z, Float:height = 20.0)
{
    new bengal_id = CreateDynamicObject(19281, x, y, z, 0.0, 0.0, 0.0, 0, 0);
    MoveDynamicObject(bengal_id, x, y, z + height, 15.0, 0.0, 0.0, 0.0);

    SetTimerEx("FIRE_DelayedDestroyObject", 1000, false, "i", CreateDynamicObject(18716, x, y, z, 0.0, 0.0, 0.0, 0, 0));

    inline Explode()
	{
        CreateExplosion(x, y, z + height, 12, 0.5);
        DestroyDynamicObject(bengal_id);

        for(new i; i != 64; i++)
        {
            new Float:px, Float:py, Float:pz;
            RandomPointInSphere(10.0, px, py, pz);
            
            new particle_id = CreateDynamicObject(19294, x, y, z + height, 0.0, 0.0, 0.0, 0, 0);
            MoveDynamicObject(particle_id, x + px, y + py, z + pz + height, 20.0, 0.0, 0.0, 0.0);

            SetTimerEx("FIRE_DelayedDestroyObject", 1000, false, "i", particle_id);
        }
	}
    Timer_CreateCallback(using inline Explode, floatround(height * 50), 1);
    return 1;
}

Firework_Strobe(Float:x, Float:y, Float:z, Float:height = 20.0)
{
    new bengal_id = CreateDynamicObject(19281, x, y, z, 0.0, 0.0, 0.0, 0, 0);
    MoveDynamicObject(bengal_id, x, y, z + height, 15.0, 0.0, 0.0, 0.0);

    SetTimerEx("FIRE_DelayedDestroyObject", 1000, false, "i", CreateDynamicObject(18716, x, y, z, 0.0, 0.0, 0.0, 0, 0));

    inline Explode()
	{
        CreateExplosion(x, y, z + height, 12, 0.5);
        DestroyDynamicObject(bengal_id);

        for(new i; i != 64; i++)
        {
            new Float:px, Float:py, Float:pz;
            RandomPointInSphere(RandomFloat(2.0, 15.0), px, py, pz);
            
            new particle_id = CreateDynamicObject(Random_Rand(19295, 19299), x, y, z + height, 0.0, 0.0, 0.0, 0, 0);
            MoveDynamicObject(particle_id, x + px, y + py, z + pz + height, 20.0, 0.0, 0.0, 0.0);

            SetTimerEx("FIRE_DelayedDestroyObject", 1000, false, "i", particle_id);
        }
	}
    Timer_CreateCallback(using inline Explode, floatround(height * 50), 1);
    return 1;
}

Firework_ColoredSphere(Float:x, Float:y, Float:z, Float:height = 20.0)
{
    new bengal_id = CreateDynamicObject(19281, x, y, z, 0.0, 0.0, 0.0, 0, 0);
    MoveDynamicObject(bengal_id, x, y, z + height, 15.0, 0.0, 0.0, 0.0);

    SetTimerEx("FIRE_DelayedDestroyObject", 1000, false, "i", CreateDynamicObject(18716, x, y, z, 0.0, 0.0, 0.0, 0, 0));

    inline Explode()
	{
        CreateExplosion(x, y, z + height, 12, 0.5);
        DestroyDynamicObject(bengal_id);

        new modelid = Random_Rand(19281, 19285);
        for(new i; i != 64; i++)
        {
            new Float:px, Float:py, Float:pz;
            RandomPointInSphere(10.0, px, py, pz);
            
            new particle_id = CreateDynamicObject(modelid, x, y, z + height, 0.0, 0.0, 0.0, 0, 0);
            MoveDynamicObject(particle_id, x + px, y + py, z + pz + height, 20.0, 0.0, 0.0, 0.0);

            SetTimerEx("FIRE_DelayedDestroyObject", 1000, false, "i", particle_id);
        }
	}
    Timer_CreateCallback(using inline Explode, floatround(height * 50), 1);
    return 1;
}