#if defined _hospital_callbacks_
    #endinput
#endif
#define _hospital_callbacks_


public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(g_rgiHospitalHealthTimer[playerid]);

    #if defined HP_OnPlayerDisconnect
        return HP_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect HP_OnPlayerDisconnect
#if defined HP_OnPlayerDisconnect
    forward HP_OnPlayerDisconnect(playerid, reason);
#endif


forward HP_HealPlayer(playerid, nearest_hospital);
public HP_HealPlayer(playerid, nearest_hospital)
{
    new const max_health = (Player_VIP(playerid) >= 3 ? 100 : 50);
    new progress = floatround(floatdiv(float(Player_Health(playerid)), float(max_health)) * 100.0);

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Curando las heridas... ~r~%d%", progress);
    Notification_ShowBeatingText(playerid, 1000, 0xF7F7F7, 100, 255, HYAXE_UNSAFE_HUGE_STRING);

    if (Player_Health(playerid) >= max_health)
    {
        Player_SetHealth(playerid, max_health);
        Notification_ShowBeatingText(playerid, 1000, 0xF7F7F7, 100, 255, "Curando las heridas... ~r~100%");
        
        TogglePlayerSpectating(playerid, false);

        SetSpawnInfo(
            playerid, NO_TEAM, Player_Skin(playerid),
            g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosX],
            g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosY],
            g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosZ],
            g_rgeHospitalData[ nearest_hospital ][e_fHospitalAngle],
            0, 0, 0, 0, 0, 0
        );

        Player_SetPos(playerid,
            g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosX],
            g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosY],
            g_rgeHospitalData[ nearest_hospital ][e_fHospitalPosZ]
        );
        
        SetPlayerFacingAngle(playerid, g_rgeHospitalData[ nearest_hospital ][e_fHospitalAngle]);
        SetCameraBehindPlayer(playerid);

        if(Player_VIP(playerid) >= 3)
            Player_SetArmor(playerid, 50);

        Notification_Show(playerid, "Los médicos te han dado de alta.", 3000, 0x64A752FF);
        KillTimer(g_rgiHospitalHealthTimer[playerid]);

        Bit_Set(Player_Flags(playerid), PFLAG_HOSPITAL, false);
        return 1;
    }

    Player_SetHealth(playerid, Player_Health(playerid) + (Player_VIP(playerid) >= 3 ? 10 : 5));
    return 1;
}

static HospitalShop_OnEnter(playerid)
{
    Menu_Show(playerid, "hospital_menu", "Hospital");
    Menu_AddItem(playerid, "Comprar 5 analgésicos", "Precio: ~g~$150");
    Menu_AddItem(playerid, "Compra un botiquín", "Precio: ~g~$500");
    Menu_UpdateListitems(playerid);
    return 1;
}

player_menu hospital_menu(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        switch(listitem)
        {
            case 0:
            {
                if (150 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                if (Inventory_AddItem(playerid, ITEM_MEDICINE, 5, 0))
                {
                    Player_GiveMoney(playerid, -150);
                    PlayerPlaySound(playerid, SOUND_SUCCESS);
                    Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste 5 analgésicos.");
                }
                else
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes el inventario lleno.");
                    return 1;
                }
            }

            case 1:
            {
                if (500 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                if (Inventory_GetItemCount(playerid, ITEM_MEDIC_KIT) >= 3)
                    return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No puedes llevar más de 3 botiquines.");

                if (Inventory_AddItem(playerid, ITEM_MEDIC_KIT, 1, 0))
                {
                    Player_GiveMoney(playerid, -500);
                    PlayerPlaySound(playerid, SOUND_SUCCESS);
                    Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un botiquín.");
                }
                else
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes el inventario lleno.");
                    return 1;
                }
            }
        }
    }
    return 1;
}

public OnScriptInit()
{
    for(new i; i < sizeof(g_rgeHospitalData); ++i)
    {
        new int = g_rgeHospitalData[i][e_iHospitalInteriorType];

        Actor_CreateRobbable(
            Random(274, 276), 500, 800,
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosX], g_rgeHospitalInteriorData[int][e_fHospitalActorPosY], g_rgeHospitalInteriorData[int][e_fHospitalActorPosZ], g_rgeHospitalInteriorData[int][e_fHospitalActorPosAngle],
            .worldid = i, .interiorid = g_rgeHospitalInteriorData[int][e_iHospitalIntInterior]
        );

        CreateDynamic3DTextLabel("Hospital\n{F7F7F7}Acércate para ver más opciones.", 0xCB3126FF,
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosX],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosY],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosZ] + 1.1,
            10.0, .testlos = 1, .worldid = i, .interiorid = g_rgeHospitalInteriorData[int][e_iHospitalIntInterior]
        );

        Key_Alert(
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosX],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosY],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosZ],
            2.5, KEYNAME_YES, i, g_rgeHospitalInteriorData[int][e_iHospitalIntInterior], .callback_on_press = __addressof(HospitalShop_OnEnter)
        );

        EnterExit_Create(
            19902,
            g_rgeHospitalData[i][e_szHospitalName], "Salida",
            g_rgeHospitalData[i][e_fHospitalPosX], g_rgeHospitalData[i][e_fHospitalPosY], g_rgeHospitalData[i][e_fHospitalPosZ], g_rgeHospitalData[i][e_fHospitalAngle], 0, 0,
            g_rgeHospitalInteriorData[int][e_fHospitalIntPosX], g_rgeHospitalInteriorData[int][e_fHospitalIntPosY], g_rgeHospitalInteriorData[int][e_fHospitalIntPosZ], g_rgeHospitalInteriorData[int][e_fHospitalIntAngle], i, g_rgeHospitalInteriorData[int][e_iHospitalIntInterior],
            -1,  0
        );

        // MapIcons
        CreateDynamicMapIcon(g_rgeHospitalData[i][e_fHospitalPosX], g_rgeHospitalData[i][e_fHospitalPosY], g_rgeHospitalData[i][e_fHospitalPosZ], 22, -1, .worldid = 0, .interiorid = 0);
    }

    #if defined HP_OnScriptInit
        return HP_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit HP_OnScriptInit
#if defined HP_OnScriptInit
    forward HP_OnScriptInit();
#endif
