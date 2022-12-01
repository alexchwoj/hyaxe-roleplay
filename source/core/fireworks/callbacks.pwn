#if defined _fireworks_callbacks_
    #endinput
#endif
#define _fireworks_callbacks_

public OnScriptInit()
{
    CreateDynamicObject(19296, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);
    CreateDynamicObject(19290, 3.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);
    CreateDynamicObject(19282, 6.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);
    CreateDynamicObject(19286, 9.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, 0);

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
