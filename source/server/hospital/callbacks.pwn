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


forward HP_HealPlayer(playerid);
public HP_HealPlayer(playerid)
{
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Curando las heridas... ~r~%d%", Player_Health(playerid));
    Notification_ShowBeatingText(playerid, 1000, 0xF7F7F7, 100, 255, HYAXE_UNSAFE_HUGE_STRING);

    if (Player_Health(playerid) >= 100)
    {
        Notification_ShowBeatingText(playerid, 1000, 0xF7F7F7, 100, 255, "Curando las heridas... ~r~100%");
        
        SpawnPlayer(playerid);
        TogglePlayerSpectating(playerid, true);
        TogglePlayerSpectating(playerid, false);

        Player_SetPos(playerid, g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ]);
        SetPlayerFacingAngle(playerid, g_rgePlayerData[playerid][e_fPosAngle]);

        SetCameraBehindPlayer(playerid);

        Notification_Show(playerid, "Los médicos te han dado de alta.", 3000, 0x64A752FF);
        KillTimer(g_rgiHospitalHealthTimer[playerid]);

        Bit_Set(Player_Flags(playerid), PFLAG_HOSPITAL, false);
        return 1;
    }

    Player_SetHealth(playerid, Player_Health(playerid) + 6);
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

Menu:hospital_menu(playerid, response, listitem)
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

                if (Inventory_GetItemAmount(playerid, ITEM_MEDICINE) >= 100)
                    return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No puedes llevar más de 100 analgésicos.");

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

public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgeHospitalData); ++i)
    {
        new int = g_rgeHospitalData[i][e_iHospitalInteriorType];

        Actor_CreateRobbable(
            minrand(274, 276), 500, 800,
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosX], g_rgeHospitalInteriorData[int][e_fHospitalActorPosY], g_rgeHospitalInteriorData[int][e_fHospitalActorPosZ], g_rgeHospitalInteriorData[int][e_fHospitalActorPosAngle],
            .worldid = i, .interiorid = g_rgeHospitalInteriorData[int][e_iHospitalIntInterior]
        );

        CreateDynamic3DTextLabel("Hospital", 0xCB3126FF,
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosX],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosY],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosZ],
            10.0, .testlos = 1, .worldid = i, .interiorid = g_rgeHospitalInteriorData[int][e_iHospitalIntInterior]
        );

        Key_Alert(
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosX],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosY],
            g_rgeHospitalInteriorData[int][e_fHospitalActorPosZ],
            2.3, KEYNAME_YES, i, g_rgeHospitalInteriorData[int][e_iHospitalIntInterior], .callback_on_press = __addressof(HospitalShop_OnEnter)
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

    #if defined HP_OnGameModeInit
        return HP_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit HP_OnGameModeInit
#if defined HP_OnGameModeInit
    forward HP_OnGameModeInit();
#endif
