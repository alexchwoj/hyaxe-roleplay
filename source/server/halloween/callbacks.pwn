#if defined _halloween_callbacks_
    #endinput
#endif
#define _halloween_callbacks_

static Witch_OnKeyPress(playerid)
{
    new amount = Inventory_GetItemAmount(playerid, ITEM_PUMPKIN);
    if (!Inventory_GetItemCount(playerid, ITEM_PUMPKIN) || !amount)
        return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes calabazas.");

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}¿Quieres vender %d %s por {64A752}$%d{DADADA}?", amount, (amount > 1 ? "calabazas" : "calabaza"), Job_ApplyPaycheckBenefits(playerid, 10 * amount));
    Dialog_ShowCallback(playerid, using public _hydg@sell_pumpkin<iiiis>, DIALOG_STYLE_MSGBOX, !"{CB3126}Bruja", HYAXE_UNSAFE_HUGE_STRING, !"Vender", !"Cerrar");

    return 1;
}

dialog sell_pumpkin(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        new amount = Inventory_GetItemAmount(playerid, ITEM_PUMPKIN);
        new pay = Job_ApplyPaycheckBenefits(playerid, 10 * amount);

        Player_AddXP(playerid, amount);
        Player_GiveMoney(playerid, pay);
        PlayerPlaySound(playerid, SOUND_SUCCESS);

        Inventory_DeleteItemByType(playerid, ITEM_PUMPKIN);

        if(amount > 1)
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Vendiste tus %d calabazas por $%d", amount, pay);
        else
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Vendiste una calabaza por $%d", pay);

        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    }
    return 1;
}

public OnScriptInit()
{
    new year, month, day;
    getdate(year, month, day);
	if (month == 10 && day >= 14) // Halloween
    {
        SetTimer("HLWE_SpawnPumpkins", 300000, true);
        Key_Alert(817.2799, -1103.3270, 25.7921, 1.5, KEYNAME_YES, .callback_on_press = __addressof(Witch_OnKeyPress));   

        for(new i; i < sizeof(g_rgfWitchPos); ++i)
        {
            GenerateRandomPumpkins(3 + random(4), g_rgfWitchPos[i][0], g_rgfWitchPos[i][1], g_rgfWitchPos[i][2] - 1.0, 20.0);

            CreateDynamicActor(g_rgiWitchSkins[random(sizeof(g_rgiWitchSkins))], g_rgfWitchPos[i][0], g_rgfWitchPos[i][1], g_rgfWitchPos[i][2], g_rgfWitchPos[i][3], .worldid = 0, .interiorid = 0);
            CreateDynamic3DTextLabel("{DADADA}Bruja", 0xDADADA00, g_rgfWitchPos[i][0], g_rgfWitchPos[i][1], g_rgfWitchPos[i][2] + 1.0, 5.0, .worldid = 0, .interiorid = 0);

            GetXYFromAngle(g_rgfWitchPos[i][0], g_rgfWitchPos[i][1], g_rgfWitchPos[i][3], 1.0);
            CreateDynamicObject(
                19527,
                g_rgfWitchPos[i][0], g_rgfWitchPos[i][1], g_rgfWitchPos[i][2] - 1.0,
                0.0, 0.0, g_rgfWitchPos[i][3] + 90.0, 0, 0
            );
        }
    }

    #if defined HLWE_OnScriptInit
        return HLWE_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit HLWE_OnScriptInit
#if defined HLWE_OnScriptInit
    forward HLWE_OnScriptInit();
#endif

forward HLWE_ResetGravity();
public HLWE_ResetGravity()
{
    SetGravity(0.008);
    return 1;
}

forward HLWE_SpawnPumpkins();
public HLWE_SpawnPumpkins()
{
    new year, month, day;
    getdate(year, month, day);
	if (month == 10 && day >= 14) // Halloween
    {
        for(new i; i < sizeof(g_rgfWitchPos); ++i)
        {
            GenerateRandomPumpkins(3 + random(4), g_rgfWitchPos[i][0], g_rgfWitchPos[i][1], g_rgfWitchPos[i][2] - 1.0, 20.0);
        }
    }
    return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if (g_rgePlayerTempData[playerid][e_bUFO])
    {
        CreateExplosion(fX, fY, fZ, 12, 1.0);
    }

    #if defined HLWE_OnPlayerWeaponShot
        return HLWE_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerWeaponShot
    #undef OnPlayerWeaponShot
#else
    #define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot HLWE_OnPlayerWeaponShot
#if defined HLWE_OnPlayerWeaponShot
    forward HLWE_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif
