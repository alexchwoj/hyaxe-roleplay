#if defined _account_commands_
    #endinput
#endif
#define _account_commands_

command bonus(playerid, const params[], "Recibir un bonus")
{
    if (Player_Bonus(playerid))
        return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Ya has recibido la bonificación.");

    Inventory_AddFixedItem(playerid, ITEM_PHONE, 1, 0);
    Inventory_AddFixedItem(playerid, ITEM_MEDIC_KIT, 1, 0);
    Inventory_AddFixedItem(playerid, ITEM_MEDIC_KIT, 1, 0);
    Inventory_AddFixedItem(playerid, ITEM_MEDICINE, 150, 0);
    Inventory_AddFixedItem(playerid, ITEM_CRACK, 75, 0);
    Inventory_AddFixedItem(playerid, ITEM_BURGER, 1, 0);
    Inventory_AddFixedItem(playerid, ITEM_BURGER, 1, 0);
    Inventory_AddFixedItem(playerid, ITEM_ORANGE_JUICE, 1, 0);
    Inventory_AddFixedItem(playerid, ITEM_APPLE_JUICE, 1, 0);
    Player_GiveMoney(playerid, 10000);
    Player_AddXP(playerid, 500);

    SendClientMessage(playerid, 0xDAA838FF, "[Bonus] › {DADADA} Bonificación recibida");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 1 Celular");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 1 Jugo de naranja");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 1 Jugo de manzana");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 2 Hamburguesas");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 75 gramos de crack");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 150 Medicamentos");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 500 XP");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} $10.000");

    Player_Bonus(playerid) = true;
    mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `BONUS` = %d WHERE `ID` = %d;", Player_Bonus(playerid), Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);

    PlayerPlaySound(playerid, SOUND_TRUMPET);
    ApplyAnimation(playerid, "OTB", "WTCHRACE_WIN", 4.1, false, false, false, false, 0, true);
    return 1;
}

command update(playerid, const params[], "Actualiza los objetos")
{
    Streamer_Update(playerid);
    return 1;
}

command ayuda(playerid, const params[], "Link de ayuda")
{
    SendClientMessage(playerid, 0xDADADAFF, "Toda la ayuda que necesitas la puedes encontrar en: {AE2012}http://hyaxe.help");
    return 1;
}
alias:ayuda("help", "ajuda")

command pagar(playerid, const params[], "Pagarle a un jugador")
{
    extract params -> new player:destination, money; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/pagar {DADADA}[jugador] [dinero]");
        return 1;
    }

	if (!IsPlayerConnected(destination) || playerid == destination)
        return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Jugador no encontrado");

    if (Player_Money(playerid) < money)
        return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");

    Player_GiveMoney(playerid, -money);
	Player_GiveMoney(destination, money);

    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le diste {ED2B2B}$%d{DADADA} a {ED2B2B}%s{DADADA}.", money, Player_Name(destination));
    SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Recibiste {ED2B2B}$%d{DADADA} de {ED2B2B}%s{DADADA}.", money, Player_Name(playerid));

    return 1;
}

command cuenta(playerid, const params[], "Ver los datos de una cuenta")
{
    extract params -> new player:destination = 0xFFFF; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/id {DADADA}[jugador = tú]");
        return 1;
    }

    if (destination == INVALID_PLAYER_ID)
        destination = playerid;

    if (!IsPlayerConnected(destination))
        return SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No hay un usuario que concuerde con el ID o nombre dados.");

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}\
        Nombre: {9C9C9C}%s{DADADA}\n\
        Rango: {9C9C9C}%s{DADADA}\n\
        Nivel: {9C9C9C}%d (Exp. %d/%d){DADADA}\n\
        Tiempo jugado: {9C9C9C}%.1f h registradas{DADADA}\n\
        Fecha de registro: {9C9C9C}%s{DADADA}\
    ",
        Player_RPName(destination),
        g_rgszRankLevelNames[ Player_AdminLevel(destination) ][ Player_Sex(destination) ],
        Player_Level(destination), Player_XP(destination), Level_GetRequiredXP(Player_Level(destination)),
        float(Player_SavedPlayedTime(destination)) / 3600,
        Player_RegistrationDate(destination)
    );

    Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe {DADADA}- Cuenta", HYAXE_UNSAFE_HUGE_STRING, "Cerrar");
    return 1;
}

command vip(playerid, const params[], "Ver el estado de la suscripción VIP")
{
    if (Player_VIP(playerid))
        return Notification_Show(playerid, "No tienes VIP. Dirígete a ~r~samp.hyaxe.com/store~w~ para comprarlo.", 10000);

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}\
        Tipo: {DAA838}VIP %s{DADADA}\n\
        Expira el: {9C9C9C}%s{DADADA}\
    ",
        g_rgszVIPNames[ Player_VIP(playerid) ],
        Player_Data(playerid, e_szVIPExpiracy)
    );

    Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe {DADADA}- Cuenta", HYAXE_UNSAFE_HUGE_STRING, "Cerrar");
    return 1;
}