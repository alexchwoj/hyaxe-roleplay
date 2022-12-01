#if defined _pyroctenia_callbacks_
    #endinput
#endif
#define _pyroctenia_callbacks_

static PYRO_OnPress(playerid)
{
    Menu_Show(playerid, "pyro_buy", "Comprar");
    Menu_AddItem(playerid, "Pancho", "Precio: ~g~$50");
    Menu_AddItem(playerid, "Cepita del Valle", "Precio: ~g~$75");
    Menu_UpdateListitems(playerid);
    return 1;
}

public OnScriptInit()
{
    new year, month, day;
    getdate(year, month, day);
    if ( (month == 11 && day >= 27) || (month == 12 && day >= 1) ) // Christmas
    {
        Key_Alert(
            1746.9813, -1130.0811, 24.0781, 2.5,
            KEYNAME_YES, 0, 0,
            .callback_on_press = __addressof(PYRO_OnPress)
        );

        new area = CreateDynamicSphere(1746.9813, -1130.0811, 24.0781, 20.0, 0, 0);
        Streamer_SetIntData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x5059524f), 1); // PYRO
    }

    #if defined PYRO_OnScriptInit
        return PYRO_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit PYRO_OnScriptInit
#if defined PYRO_OnScriptInit
    forward PYRO_OnScriptInit();
#endif

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if (Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x5059524f)))
    {
        if (Bit_Get(Player_Config(playerid), CONFIG_MUSIC))
            StopAudioStreamForPlayer(playerid);
    }

    #if defined PYRO_OnPlayerLeaveDynamicArea
        return PYRO_OnPlayerLeaveDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea PYRO_OnPlayerLeaveDynamicArea
#if defined PYRO_OnPlayerLeaveDynamicArea
    forward PYRO_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif


public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if (Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x5059524f)))
    {
        if (Bit_Get(Player_Config(playerid), CONFIG_MUSIC))
            PlayAudioStreamForPlayer(playerid, "https://samp.hyaxe.com/static/audio/pyro_store.mp3", 1746.9813, -1130.0811, 24.0781, 10.0, 1);
    }

    #if defined PYRO_OnPlayerEnterDynamicArea
        return PYRO_OnPlayerEnterDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea PYRO_OnPlayerEnterDynamicArea
#if defined PYRO_OnPlayerEnterDynamicArea
    forward PYRO_OnPlayerEnterDynamicArea(playerid, areaid);
#endif