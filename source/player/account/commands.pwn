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
    Player_GiveMoney(playerid, 25000);
    Player_AddXP(playerid, 500);

    SendClientMessage(playerid, 0xDAA838FF, "[Bonus] › {DADADA} Bonificación recibida");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 1 Celular");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 1 Jugo de naranja");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 1 Jugo de manzana");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 2 Hamburguesas");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 75 gramos de crack");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 150 Medicamentos");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} 500 XP");
    SendClientMessage(playerid, 0x64A752FF, "+{DADADA} $25.000");

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