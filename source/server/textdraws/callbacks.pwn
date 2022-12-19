#if defined _textdraws_callbacks_
    #endinput
#endif
#define _textdraws_callbacks_

public OnScriptInit()
{
    // GANG EVENT
    g_tdGangEventText = TextDrawCreate(321.000000, 28.000000, "_");
    TextDrawFont(g_tdGangEventText, 3);
    TextDrawLetterSize(g_tdGangEventText, 0.300000, 1.500000);
    TextDrawTextSize(g_tdGangEventText, 168.500000, 237.000000);
    TextDrawSetOutline(g_tdGangEventText, 1);
    TextDrawSetShadow(g_tdGangEventText, 0);
    TextDrawAlignment(g_tdGangEventText, 2);
    TextDrawColor(g_tdGangEventText, -1);
    TextDrawBackgroundColor(g_tdGangEventText, 255);
    TextDrawBoxColor(g_tdGangEventText, 50);
    TextDrawUseBox(g_tdGangEventText, 0);
    TextDrawSetProportional(g_tdGangEventText, 1);
    TextDrawSetSelectable(g_tdGangEventText, 0);

    // SNEEDOMETER
    g_tdSpeedometer[0] = TextDrawCreate(562.000000, 425.000000, "_");
    TextDrawFont(g_tdSpeedometer[0], 1);
    TextDrawLetterSize(g_tdSpeedometer[0], 0.600000, -5.750007);
    TextDrawTextSize(g_tdSpeedometer[0], 294.000000, 86.500000);
    TextDrawSetOutline(g_tdSpeedometer[0], 1);
    TextDrawSetShadow(g_tdSpeedometer[0], 0);
    TextDrawAlignment(g_tdSpeedometer[0], 2);
    TextDrawColor(g_tdSpeedometer[0], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[0], 255);
    TextDrawBoxColor(g_tdSpeedometer[0], 454761471);
    TextDrawUseBox(g_tdSpeedometer[0], 1);
    TextDrawSetProportional(g_tdSpeedometer[0], 1);
    TextDrawSetSelectable(g_tdSpeedometer[0], 0);

    g_tdSpeedometer[1] = TextDrawCreate(503.000000, 426.000000, "_");
    TextDrawFont(g_tdSpeedometer[1], 1);
    TextDrawLetterSize(g_tdSpeedometer[1], 0.600000, -5.950006);
    TextDrawTextSize(g_tdSpeedometer[1], 285.000000, 17.500000);
    TextDrawSetOutline(g_tdSpeedometer[1], 1);
    TextDrawSetShadow(g_tdSpeedometer[1], 0);
    TextDrawAlignment(g_tdSpeedometer[1], 2);
    TextDrawColor(g_tdSpeedometer[1], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[1], 255);
    TextDrawBoxColor(g_tdSpeedometer[1], 454761471);
    TextDrawUseBox(g_tdSpeedometer[1], 1);
    TextDrawSetProportional(g_tdSpeedometer[1], 1);
    TextDrawSetSelectable(g_tdSpeedometer[1], 0);

    g_tdSpeedometer[2] = TextDrawCreate(503.000000, 424.000000, "_");
    TextDrawFont(g_tdSpeedometer[2], 1);
    TextDrawLetterSize(g_tdSpeedometer[2], 0.600000, -5.600007);
    TextDrawTextSize(g_tdSpeedometer[2], 282.500000, 15.500000);
    TextDrawSetOutline(g_tdSpeedometer[2], 1);
    TextDrawSetShadow(g_tdSpeedometer[2], 0);
    TextDrawAlignment(g_tdSpeedometer[2], 2);
    TextDrawColor(g_tdSpeedometer[2], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[2], 255);
    TextDrawBoxColor(g_tdSpeedometer[2], 791621631);
    TextDrawUseBox(g_tdSpeedometer[2], 1);
    TextDrawSetProportional(g_tdSpeedometer[2], 1);
    TextDrawSetSelectable(g_tdSpeedometer[2], 0);

    // Gas green box
    g_tdSpeedometer[3] = TextDrawCreate(503.000000, 424.000000, "_");
    TextDrawFont(g_tdSpeedometer[3], 1);
    TextDrawLetterSize(g_tdSpeedometer[3], 0.600000, -5.570001);
    TextDrawTextSize(g_tdSpeedometer[3], 282.500000, 15.500000);
    TextDrawSetOutline(g_tdSpeedometer[3], 1);
    TextDrawSetShadow(g_tdSpeedometer[3], 0);
    TextDrawAlignment(g_tdSpeedometer[3], 2);
    TextDrawColor(g_tdSpeedometer[3], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[3], 255);
    TextDrawBoxColor(g_tdSpeedometer[3], 1688687359);
    TextDrawUseBox(g_tdSpeedometer[3], 1);
    TextDrawSetProportional(g_tdSpeedometer[3], 1);
    TextDrawSetSelectable(g_tdSpeedometer[3], 0);

    g_tdSpeedometer[4] = TextDrawCreate(503.000000, 394.000000, "GAS~n~75");
    TextDrawFont(g_tdSpeedometer[4], 1);
    TextDrawLetterSize(g_tdSpeedometer[4], 0.208333, 0.899999);
    TextDrawTextSize(g_tdSpeedometer[4], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[4], 0);
    TextDrawSetShadow(g_tdSpeedometer[4], 0);
    TextDrawAlignment(g_tdSpeedometer[4], 2);
    TextDrawColor(g_tdSpeedometer[4], -134744065);
    TextDrawBackgroundColor(g_tdSpeedometer[4], 255);
    TextDrawBoxColor(g_tdSpeedometer[4], 50);
    TextDrawUseBox(g_tdSpeedometer[4], 0);
    TextDrawSetProportional(g_tdSpeedometer[4], 1);
    TextDrawSetSelectable(g_tdSpeedometer[4], 0);

    g_tdSpeedometer[5] = TextDrawCreate(466.000000, 426.000000, "_");
    TextDrawFont(g_tdSpeedometer[5], 1);
    TextDrawLetterSize(g_tdSpeedometer[5], 0.600000, -5.950006);
    TextDrawTextSize(g_tdSpeedometer[5], 285.000000, 40.500000);
    TextDrawSetOutline(g_tdSpeedometer[5], 1);
    TextDrawSetShadow(g_tdSpeedometer[5], 0);
    TextDrawAlignment(g_tdSpeedometer[5], 2);
    TextDrawColor(g_tdSpeedometer[5], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[5], 255);
    TextDrawBoxColor(g_tdSpeedometer[5], 454761471);
    TextDrawUseBox(g_tdSpeedometer[5], 1);
    TextDrawSetProportional(g_tdSpeedometer[5], 1);
    TextDrawSetSelectable(g_tdSpeedometer[5], 0);

    g_tdSpeedometer[6] = TextDrawCreate(466.000000, 424.000000, "_");
    TextDrawFont(g_tdSpeedometer[6], 1);
    TextDrawLetterSize(g_tdSpeedometer[6], 0.600000, -5.600007);
    TextDrawTextSize(g_tdSpeedometer[6], 282.500000, 36.500000);
    TextDrawSetOutline(g_tdSpeedometer[6], 1);
    TextDrawSetShadow(g_tdSpeedometer[6], 0);
    TextDrawAlignment(g_tdSpeedometer[6], 2);
    TextDrawColor(g_tdSpeedometer[6], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[6], 255);
    TextDrawBoxColor(g_tdSpeedometer[6], 791621631);
    TextDrawUseBox(g_tdSpeedometer[6], 1);
    TextDrawSetProportional(g_tdSpeedometer[6], 1);
    TextDrawSetSelectable(g_tdSpeedometer[6], 0);

    // Speed green box
    g_tdSpeedometer[7] = TextDrawCreate(466.000000, 424.000000, "_");
    TextDrawFont(g_tdSpeedometer[7], 1);
    TextDrawLetterSize(g_tdSpeedometer[7], 0.600000, -4.419996);
    TextDrawTextSize(g_tdSpeedometer[7], 285.500000, 36.500000);
    TextDrawSetOutline(g_tdSpeedometer[7], 1);
    TextDrawSetShadow(g_tdSpeedometer[7], 0);
    TextDrawAlignment(g_tdSpeedometer[7], 2);
    TextDrawColor(g_tdSpeedometer[7], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[7], 255);
    TextDrawBoxColor(g_tdSpeedometer[7], 1688687359);
    TextDrawUseBox(g_tdSpeedometer[7], 1);
    TextDrawSetProportional(g_tdSpeedometer[7], 1);
    TextDrawSetSelectable(g_tdSpeedometer[7], 0);

    g_tdSpeedometer[8] = TextDrawCreate(466.000000, 385.000000, "323");
    TextDrawFont(g_tdSpeedometer[8], 3);
    TextDrawLetterSize(g_tdSpeedometer[8], 0.412499, 1.899999);
    TextDrawTextSize(g_tdSpeedometer[8], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[8], 1);
    TextDrawSetShadow(g_tdSpeedometer[8], 0);
    TextDrawAlignment(g_tdSpeedometer[8], 2);
    TextDrawColor(g_tdSpeedometer[8], -134744065);
    TextDrawBackgroundColor(g_tdSpeedometer[8], 255);
    TextDrawBoxColor(g_tdSpeedometer[8], 50);
    TextDrawUseBox(g_tdSpeedometer[8], 0);
    TextDrawSetProportional(g_tdSpeedometer[8], 1);
    TextDrawSetSelectable(g_tdSpeedometer[8], 0);

    g_tdSpeedometer[9] = TextDrawCreate(466.000000, 402.000000, "KM/H");
    TextDrawFont(g_tdSpeedometer[9], 1);
    TextDrawLetterSize(g_tdSpeedometer[9], 0.200000, 0.949998);
    TextDrawTextSize(g_tdSpeedometer[9], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[9], 0);
    TextDrawSetShadow(g_tdSpeedometer[9], 0);
    TextDrawAlignment(g_tdSpeedometer[9], 2);
    TextDrawColor(g_tdSpeedometer[9], -134744065);
    TextDrawBackgroundColor(g_tdSpeedometer[9], 255);
    TextDrawBoxColor(g_tdSpeedometer[9], 50);
    TextDrawUseBox(g_tdSpeedometer[9], 0);
    TextDrawSetProportional(g_tdSpeedometer[9], 1);
    TextDrawSetSelectable(g_tdSpeedometer[9], 0);

    // BANK ATM
    g_tdBankATM[0] = TextDrawCreate(319.000000, 158.000000, "_");
    TextDrawFont(g_tdBankATM[0], 1);
    TextDrawLetterSize(g_tdBankATM[0], 0.600000, 15.650023);
    TextDrawTextSize(g_tdBankATM[0], 292.000000, 117.500000);
    TextDrawSetOutline(g_tdBankATM[0], 1);
    TextDrawSetShadow(g_tdBankATM[0], 0);
    TextDrawAlignment(g_tdBankATM[0], 2);
    TextDrawColor(g_tdBankATM[0], -1);
    TextDrawBackgroundColor(g_tdBankATM[0], 255);
    TextDrawBoxColor(g_tdBankATM[0], 454761471);
    TextDrawUseBox(g_tdBankATM[0], 1);
    TextDrawSetProportional(g_tdBankATM[0], 1);
    TextDrawSetSelectable(g_tdBankATM[0], 0);

    g_tdBankATM[1] = TextDrawCreate(303.000000, 161.000000, "BANCO");
    TextDrawFont(g_tdBankATM[1], 3);
    TextDrawLetterSize(g_tdBankATM[1], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[1], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdBankATM[1], 1);
    TextDrawSetShadow(g_tdBankATM[1], 0);
    TextDrawAlignment(g_tdBankATM[1], 1);
    TextDrawColor(g_tdBankATM[1], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[1], 255);
    TextDrawBoxColor(g_tdBankATM[1], 50);
    TextDrawUseBox(g_tdBankATM[1], 0);
    TextDrawSetProportional(g_tdBankATM[1], 1);
    TextDrawSetSelectable(g_tdBankATM[1], 0);

    g_tdBankATM[2] = TextDrawCreate(319.000000, 158.000000, "_");
    TextDrawFont(g_tdBankATM[2], 1);
    TextDrawLetterSize(g_tdBankATM[2], 0.600000, -0.999979);
    TextDrawTextSize(g_tdBankATM[2], 292.000000, 117.500000);
    TextDrawSetOutline(g_tdBankATM[2], 1);
    TextDrawSetShadow(g_tdBankATM[2], 0);
    TextDrawAlignment(g_tdBankATM[2], 2);
    TextDrawColor(g_tdBankATM[2], -1);
    TextDrawBackgroundColor(g_tdBankATM[2], 255);
    TextDrawBoxColor(g_tdBankATM[2], 1688687359);
    TextDrawUseBox(g_tdBankATM[2], 1);
    TextDrawSetProportional(g_tdBankATM[2], 1);
    TextDrawSetSelectable(g_tdBankATM[2], 0);

    g_tdBankATM[3] = TextDrawCreate(319.000000, 202.000000, "depositar");
    TextDrawFont(g_tdBankATM[3], 3);
    TextDrawLetterSize(g_tdBankATM[3], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[3], 10.500000, 111.000000);
    TextDrawSetOutline(g_tdBankATM[3], 1);
    TextDrawSetShadow(g_tdBankATM[3], 0);
    TextDrawAlignment(g_tdBankATM[3], 2);
    TextDrawColor(g_tdBankATM[3], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[3], 255);
    TextDrawBoxColor(g_tdBankATM[3], 202116351);
    TextDrawUseBox(g_tdBankATM[3], 1);
    TextDrawSetProportional(g_tdBankATM[3], 1);
    TextDrawSetSelectable(g_tdBankATM[3], 1);

    g_tdBankATM[4] = TextDrawCreate(319.000000, 226.000000, "retirar");
    TextDrawFont(g_tdBankATM[4], 3);
    TextDrawLetterSize(g_tdBankATM[4], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[4], 10.500000, 111.500000);
    TextDrawSetOutline(g_tdBankATM[4], 1);
    TextDrawSetShadow(g_tdBankATM[4], 0);
    TextDrawAlignment(g_tdBankATM[4], 2);
    TextDrawColor(g_tdBankATM[4], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[4], 255);
    TextDrawBoxColor(g_tdBankATM[4], 202116351);
    TextDrawUseBox(g_tdBankATM[4], 1);
    TextDrawSetProportional(g_tdBankATM[4], 1);
    TextDrawSetSelectable(g_tdBankATM[4], 1);

    g_tdBankATM[5] = TextDrawCreate(319.000000, 250.000000, "transferir");
    TextDrawFont(g_tdBankATM[5], 3);
    TextDrawLetterSize(g_tdBankATM[5], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[5], 10.500000, 111.500000);
    TextDrawSetOutline(g_tdBankATM[5], 1);
    TextDrawSetShadow(g_tdBankATM[5], 0);
    TextDrawAlignment(g_tdBankATM[5], 2);
    TextDrawColor(g_tdBankATM[5], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[5], 255);
    TextDrawBoxColor(g_tdBankATM[5], 202116351);
    TextDrawUseBox(g_tdBankATM[5], 1);
    TextDrawSetProportional(g_tdBankATM[5], 1);
    TextDrawSetSelectable(g_tdBankATM[5], 1);

    g_tdBankATM[6] = TextDrawCreate(318.000000, 174.000000, !"$100");
    TextDrawFont(g_tdBankATM[6], 3);
    TextDrawLetterSize(g_tdBankATM[6], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[6], 400.000000, 201.500000);
    TextDrawSetOutline(g_tdBankATM[6], 1);
    TextDrawSetShadow(g_tdBankATM[6], 0);
    TextDrawAlignment(g_tdBankATM[6], 2);
    TextDrawColor(g_tdBankATM[6], 1688687359);
    TextDrawBackgroundColor(g_tdBankATM[6], 255);
    TextDrawBoxColor(g_tdBankATM[6], 50);
    TextDrawUseBox(g_tdBankATM[6], 0);
    TextDrawSetProportional(g_tdBankATM[6], 1);
    TextDrawSetSelectable(g_tdBankATM[6], 0);

    g_tdBankATM[7] = TextDrawCreate(318.000000, 276.000000, !"ID: 1337");
    TextDrawFont(g_tdBankATM[7], 1);
    TextDrawLetterSize(g_tdBankATM[7], 0.262499, 1.350000);
    TextDrawTextSize(g_tdBankATM[7], 396.000000, 105.000000);
    TextDrawSetOutline(g_tdBankATM[7], 0);
    TextDrawSetShadow(g_tdBankATM[7], 0);
    TextDrawAlignment(g_tdBankATM[7], 2);
    TextDrawColor(g_tdBankATM[7], 909522687);
    TextDrawBackgroundColor(g_tdBankATM[7], 255);
    TextDrawBoxColor(g_tdBankATM[7], 50);
    TextDrawUseBox(g_tdBankATM[7], 0);
    TextDrawSetProportional(g_tdBankATM[7], 1);
    TextDrawSetSelectable(g_tdBankATM[7], 0);

    g_tdKeyGame[0] = TextDrawCreate(319.000000, 377.000000, "_");
	TextDrawFont(g_tdKeyGame[0], 1);
	TextDrawLetterSize(g_tdKeyGame[0], 0.600000, 0.700003);
	TextDrawTextSize(g_tdKeyGame[0], 298.500000, 118.000000);
	TextDrawSetOutline(g_tdKeyGame[0], 1);
	TextDrawSetShadow(g_tdKeyGame[0], 0);
	TextDrawAlignment(g_tdKeyGame[0], 2);
	TextDrawColor(g_tdKeyGame[0], -1);
	TextDrawBackgroundColor(g_tdKeyGame[0], 255);
	TextDrawBoxColor(g_tdKeyGame[0], 168430335);
	TextDrawUseBox(g_tdKeyGame[0], 1);
	TextDrawSetProportional(g_tdKeyGame[0], 1);
	TextDrawSetSelectable(g_tdKeyGame[0], 0);

    g_tdKeyGame[1] = TextDrawCreate(319.200012, 379.000000, "_");
	TextDrawFont(g_tdKeyGame[1], 1);
	TextDrawLetterSize(g_tdKeyGame[1], 0.600000, 0.270000);
	TextDrawTextSize(g_tdKeyGame[1], 298.500000, 115.000000);
	TextDrawSetOutline(g_tdKeyGame[1], 1);
	TextDrawSetShadow(g_tdKeyGame[1], 0);
	TextDrawAlignment(g_tdKeyGame[1], 2);
	TextDrawColor(g_tdKeyGame[1], -1);
	TextDrawBackgroundColor(g_tdKeyGame[1], 255);
	TextDrawBoxColor(g_tdKeyGame[1], -623191347);
	TextDrawUseBox(g_tdKeyGame[1], 1);
	TextDrawSetProportional(g_tdKeyGame[1], 1);
	TextDrawSetSelectable(g_tdKeyGame[1], 0);

	g_tdKeyGame[2] = TextDrawCreate(300.000000, 367.000000, "Preview_Model");
	TextDrawFont(g_tdKeyGame[2], 5);
	TextDrawLetterSize(g_tdKeyGame[2], 0.600000, 2.000000);
	TextDrawTextSize(g_tdKeyGame[2], 37.000000, 42.000000);
	TextDrawSetOutline(g_tdKeyGame[2], 0);
	TextDrawSetShadow(g_tdKeyGame[2], 0);
	TextDrawAlignment(g_tdKeyGame[2], 1);
	TextDrawColor(g_tdKeyGame[2], 255);
	TextDrawBackgroundColor(g_tdKeyGame[2], 0);
	TextDrawBoxColor(g_tdKeyGame[2], 255);
	TextDrawUseBox(g_tdKeyGame[2], 0);
	TextDrawSetProportional(g_tdKeyGame[2], 1);
	TextDrawSetSelectable(g_tdKeyGame[2], 0);
	TextDrawSetPreviewModel(g_tdKeyGame[2], 2252);
	TextDrawSetPreviewRot(g_tdKeyGame[2], -103.000000, 5.000000, -42.000000, 0.790000);
	TextDrawSetPreviewVehCol(g_tdKeyGame[2], 1, 1);

	g_tdKeyGame[3] = TextDrawCreate(300.000000, 367.000000, "Preview_Model");
	TextDrawFont(g_tdKeyGame[3], 5);
	TextDrawLetterSize(g_tdKeyGame[3], 0.600000, 2.000000);
	TextDrawTextSize(g_tdKeyGame[3], 37.000000, 42.000000);
	TextDrawSetOutline(g_tdKeyGame[3], 0);
	TextDrawSetShadow(g_tdKeyGame[3], 0);
	TextDrawAlignment(g_tdKeyGame[3], 1);
	TextDrawColor(g_tdKeyGame[3], 255);
	TextDrawBackgroundColor(g_tdKeyGame[3], 0);
	TextDrawBoxColor(g_tdKeyGame[3], 255);
	TextDrawUseBox(g_tdKeyGame[3], 0);
	TextDrawSetProportional(g_tdKeyGame[3], 1);
	TextDrawSetSelectable(g_tdKeyGame[3], 0);
	TextDrawSetPreviewModel(g_tdKeyGame[3], 2252);
	TextDrawSetPreviewRot(g_tdKeyGame[3], -103.000000, 5.000000, -16.000000, 0.790000);
	TextDrawSetPreviewVehCol(g_tdKeyGame[3], 1, 1);

    // Shops
    g_tdShops[0] = TextDrawCreate(445.000000, 200.000000, "HUD:skipicon");
	TextDrawFont(g_tdShops[0], 4);
	TextDrawLetterSize(g_tdShops[0], 0.600000, 2.000000);
	TextDrawTextSize(g_tdShops[0], 75.000000, 74.500000);
	TextDrawSetOutline(g_tdShops[0], 1);
	TextDrawSetShadow(g_tdShops[0], 0);
	TextDrawAlignment(g_tdShops[0], 1);
	TextDrawColor(g_tdShops[0], 111);
	TextDrawBackgroundColor(g_tdShops[0], 255);
	TextDrawBoxColor(g_tdShops[0], 50);
	TextDrawUseBox(g_tdShops[0], 1);
	TextDrawSetProportional(g_tdShops[0], 1);
	TextDrawSetSelectable(g_tdShops[0], 0);

	g_tdShops[1] = TextDrawCreate(196.000000, 200.000000, "HUD:skipicon");
	TextDrawFont(g_tdShops[1], 4);
	TextDrawLetterSize(g_tdShops[1], 0.600000, 2.000000);
	TextDrawTextSize(g_tdShops[1], -74.500000, 74.500000);
	TextDrawSetOutline(g_tdShops[1], 1);
	TextDrawSetShadow(g_tdShops[1], 0);
	TextDrawAlignment(g_tdShops[1], 1);
	TextDrawColor(g_tdShops[1], 111);
	TextDrawBackgroundColor(g_tdShops[1], 255);
	TextDrawBoxColor(g_tdShops[1], 50);
	TextDrawUseBox(g_tdShops[1], 1);
	TextDrawSetProportional(g_tdShops[1], 1);
	TextDrawSetSelectable(g_tdShops[1], 1);

	g_tdShops[2] = TextDrawCreate(176.000000, 337.000000, "Preview_Model");
	TextDrawFont(g_tdShops[2], 5);
	TextDrawLetterSize(g_tdShops[2], 0.600000, 2.000000);
	TextDrawTextSize(g_tdShops[2], 292.000000, 98.000000);
	TextDrawSetOutline(g_tdShops[2], 0);
	TextDrawSetShadow(g_tdShops[2], 0);
	TextDrawAlignment(g_tdShops[2], 1);
	TextDrawColor(g_tdShops[2], 111);
	TextDrawBackgroundColor(g_tdShops[2], 0);
	TextDrawBoxColor(g_tdShops[2], 255);
	TextDrawUseBox(g_tdShops[2], 0);
	TextDrawSetProportional(g_tdShops[2], 1);
	TextDrawSetSelectable(g_tdShops[2], 0);
	TextDrawSetPreviewModel(g_tdShops[2], 2729);
	TextDrawSetPreviewRot(g_tdShops[2], -180.000000, 0.000000, -3.000000, 0.910000);
	TextDrawSetPreviewVehCol(g_tdShops[2], 1, 1);

	g_tdShops[3] = TextDrawCreate(320.000000, 394.000000, "~l~Comprar");
	TextDrawFont(g_tdShops[3], 3);
	TextDrawLetterSize(g_tdShops[3], 0.283331, 1.149999);
	TextDrawTextSize(g_tdShops[3], 11.000000, 41.500000);
	TextDrawSetOutline(g_tdShops[3], 1);
	TextDrawSetShadow(g_tdShops[3], 0);
	TextDrawAlignment(g_tdShops[3], 2);
	TextDrawColor(g_tdShops[3], 156);
	TextDrawBackgroundColor(g_tdShops[3], 0);
	TextDrawBoxColor(g_tdShops[3], 50);
	TextDrawUseBox(g_tdShops[3], 0);
	TextDrawSetProportional(g_tdShops[3], 1);
	TextDrawSetSelectable(g_tdShops[3], 0);

	g_tdShops[4] = TextDrawCreate(320.000000, 390.000000, "_");
	TextDrawFont(g_tdShops[4], 1);
	TextDrawLetterSize(g_tdShops[4], 0.600000, 2.100003);
	TextDrawTextSize(g_tdShops[4], 298.500000, 75.000000);
	TextDrawSetOutline(g_tdShops[4], 1);
	TextDrawSetShadow(g_tdShops[4], 0);
	TextDrawAlignment(g_tdShops[4], 2);
	TextDrawColor(g_tdShops[4], -256);
	TextDrawBackgroundColor(g_tdShops[4], 255);
	TextDrawBoxColor(g_tdShops[4], -1094795731);
	TextDrawUseBox(g_tdShops[4], 1);
	TextDrawSetProportional(g_tdShops[4], 1);
	TextDrawSetSelectable(g_tdShops[4], 0);

	g_tdShops[5] = TextDrawCreate(323.000000, 14.000000, "MMGBO ENTERPRISES");
	TextDrawFont(g_tdShops[5], 3);
	TextDrawLetterSize(g_tdShops[5], 0.291666, 1.100000);
	TextDrawTextSize(g_tdShops[5], 400.000000, 634.500000);
	TextDrawSetOutline(g_tdShops[5], 0);
	TextDrawSetShadow(g_tdShops[5], 0);
	TextDrawAlignment(g_tdShops[5], 2);
	TextDrawColor(g_tdShops[5], -1094795600);
	TextDrawBackgroundColor(g_tdShops[5], 255);
	TextDrawBoxColor(g_tdShops[5], 50);
	TextDrawUseBox(g_tdShops[5], 0);
	TextDrawSetProportional(g_tdShops[5], 1);
	TextDrawSetSelectable(g_tdShops[5], 0);

	g_tdShops[6] = TextDrawCreate(217.000000, -13.000000, "Preview_Model");
	TextDrawFont(g_tdShops[6], 5);
	TextDrawLetterSize(g_tdShops[6], 0.600000, 2.000000);
	TextDrawTextSize(g_tdShops[6], 204.000000, 65.000000);
	TextDrawSetOutline(g_tdShops[6], 0);
	TextDrawSetShadow(g_tdShops[6], 0);
	TextDrawAlignment(g_tdShops[6], 1);
	TextDrawColor(g_tdShops[6], 78);
	TextDrawBackgroundColor(g_tdShops[6], 0);
	TextDrawBoxColor(g_tdShops[6], 255);
	TextDrawUseBox(g_tdShops[6], 0);
	TextDrawSetProportional(g_tdShops[6], 1);
	TextDrawSetSelectable(g_tdShops[6], 0);
	TextDrawSetPreviewModel(g_tdShops[6], 2580);
	TextDrawSetPreviewRot(g_tdShops[6], 3.000000, 2.000000, 181.000000, 0.980000);
	TextDrawSetPreviewVehCol(g_tdShops[6], 1, 1);

	g_tdShops[7] = TextDrawCreate(121.000000, 216.000000, "_");
	TextDrawFont(g_tdShops[7], 4);
	TextDrawLetterSize(g_tdShops[7], 0.600000, 2.000000);
	TextDrawTextSize(g_tdShops[7], 74.000000, 32.500000);
	TextDrawSetOutline(g_tdShops[7], 1);
	TextDrawSetShadow(g_tdShops[7], 0);
	TextDrawAlignment(g_tdShops[7], 1);
	TextDrawColor(g_tdShops[7], -1);
	TextDrawBackgroundColor(g_tdShops[7], 255);
	TextDrawBoxColor(g_tdShops[7], 50);
	TextDrawUseBox(g_tdShops[7], 0);
	TextDrawSetProportional(g_tdShops[7], 1);
	TextDrawSetSelectable(g_tdShops[7], 1);

	g_tdShops[8] = TextDrawCreate(445.000000, 216.000000, "_");
	TextDrawFont(g_tdShops[8], 4);
	TextDrawLetterSize(g_tdShops[8], 0.600000, 2.000000);
	TextDrawTextSize(g_tdShops[8], 74.000000, 32.500000);
	TextDrawSetOutline(g_tdShops[8], 1);
	TextDrawSetShadow(g_tdShops[8], 0);
	TextDrawAlignment(g_tdShops[8], 1);
	TextDrawColor(g_tdShops[8], -1);
	TextDrawBackgroundColor(g_tdShops[8], 255);
	TextDrawBoxColor(g_tdShops[8], 50);
	TextDrawUseBox(g_tdShops[8], 0);
	TextDrawSetProportional(g_tdShops[8], 1);
	TextDrawSetSelectable(g_tdShops[8], 1);

	g_tdShops[9] = TextDrawCreate(297.000000, 393.000000, "_");
	TextDrawFont(g_tdShops[9], 4);
	TextDrawLetterSize(g_tdShops[9], 0.600000, 2.000000);
	TextDrawTextSize(g_tdShops[9], 46.000000, 13.000000);
	TextDrawSetOutline(g_tdShops[9], 1);
	TextDrawSetShadow(g_tdShops[9], 0);
	TextDrawAlignment(g_tdShops[9], 1);
	TextDrawColor(g_tdShops[9], -1);
	TextDrawBackgroundColor(g_tdShops[9], 255);
	TextDrawBoxColor(g_tdShops[9], 50);
	TextDrawUseBox(g_tdShops[9], 0);
	TextDrawSetProportional(g_tdShops[9], 1);
	TextDrawSetSelectable(g_tdShops[9], 1);

    g_tdShops[10] = TextDrawCreate(320.000000, 370.000000, "$100");
	TextDrawFont(g_tdShops[10], 3);
	TextDrawLetterSize(g_tdShops[10], 0.287499, 1.049998);
	TextDrawTextSize(g_tdShops[10], 400.000000, 634.500000);
	TextDrawSetOutline(g_tdShops[10], 0);
	TextDrawSetShadow(g_tdShops[10], 0);
	TextDrawAlignment(g_tdShops[10], 2);
	TextDrawColor(g_tdShops[10], 1433087920);
	TextDrawBackgroundColor(g_tdShops[10], 255);
	TextDrawBoxColor(g_tdShops[10], 50);
	TextDrawUseBox(g_tdShops[10], 0);
	TextDrawSetProportional(g_tdShops[10], 1);
	TextDrawSetSelectable(g_tdShops[10], 0);

	g_tdShops[11] = TextDrawCreate(320.000000, 360.000000, "pipsa");
	TextDrawFont(g_tdShops[11], 2);
	TextDrawLetterSize(g_tdShops[11], 0.208332, 1.000000);
	TextDrawTextSize(g_tdShops[11], 400.000000, 186.000000);
	TextDrawSetOutline(g_tdShops[11], 0);
	TextDrawSetShadow(g_tdShops[11], 0);
	TextDrawAlignment(g_tdShops[11], 2);
	TextDrawColor(g_tdShops[11], -1094795600);
	TextDrawBackgroundColor(g_tdShops[11], 255);
	TextDrawBoxColor(g_tdShops[11], 50);
	TextDrawUseBox(g_tdShops[11], 0);
	TextDrawSetProportional(g_tdShops[11], 1);
	TextDrawSetSelectable(g_tdShops[11], 0);

    // (S)Need bars
    g_tdNeedBars[0] = TextDrawCreate(539.000000, 440.000000, "_");
    TextDrawFont(g_tdNeedBars[0], 1);
    TextDrawLetterSize(g_tdNeedBars[0], 0.600000, -1.850007);
    TextDrawTextSize(g_tdNeedBars[0], 285.000000, 40.500000);
    TextDrawSetOutline(g_tdNeedBars[0], 1);
    TextDrawSetShadow(g_tdNeedBars[0], 0);
    TextDrawAlignment(g_tdNeedBars[0], 2);
    TextDrawColor(g_tdNeedBars[0], -1);
    TextDrawBackgroundColor(g_tdNeedBars[0], 255);
    TextDrawBoxColor(g_tdNeedBars[0], 454761471);
    TextDrawUseBox(g_tdNeedBars[0], 1);
    TextDrawSetProportional(g_tdNeedBars[0], 1);
    TextDrawSetSelectable(g_tdNeedBars[0], 0);

    g_tdNeedBars[1] = TextDrawCreate(585.000000, 440.000000, "_");
    TextDrawFont(g_tdNeedBars[1], 1);
    TextDrawLetterSize(g_tdNeedBars[1], 0.600000, -1.850007);
    TextDrawTextSize(g_tdNeedBars[1], 285.000000, 40.500000);
    TextDrawSetOutline(g_tdNeedBars[1], 1);
    TextDrawSetShadow(g_tdNeedBars[1], 0);
    TextDrawAlignment(g_tdNeedBars[1], 2);
    TextDrawColor(g_tdNeedBars[1], -1);
    TextDrawBackgroundColor(g_tdNeedBars[1], 255);
    TextDrawBoxColor(g_tdNeedBars[1], 454761471);
    TextDrawUseBox(g_tdNeedBars[1], 1);
    TextDrawSetProportional(g_tdNeedBars[1], 1);
    TextDrawSetSelectable(g_tdNeedBars[1], 0);

    g_tdNeedBars[2] = TextDrawCreate(520.000000, 439.000000, "_");
    TextDrawFont(g_tdNeedBars[2], 1);
    TextDrawLetterSize(g_tdNeedBars[2], 0.600000, -1.549998);
    TextDrawTextSize(g_tdNeedBars[2], 558.000000, 75.000000);
    TextDrawSetOutline(g_tdNeedBars[2], 1);
    TextDrawSetShadow(g_tdNeedBars[2], 0);
    TextDrawAlignment(g_tdNeedBars[2], 1);
    TextDrawColor(g_tdNeedBars[2], -1);
    TextDrawBackgroundColor(g_tdNeedBars[2], 255);
    TextDrawBoxColor(g_tdNeedBars[2], 791621631);
    TextDrawUseBox(g_tdNeedBars[2], 1);
    TextDrawSetProportional(g_tdNeedBars[2], 1);
    TextDrawSetSelectable(g_tdNeedBars[2], 0);

    g_tdNeedBars[3] = TextDrawCreate(566.000000, 439.000000, "_");
    TextDrawFont(g_tdNeedBars[3], 1);
    TextDrawLetterSize(g_tdNeedBars[3], 0.600000, -1.549998);
    TextDrawTextSize(g_tdNeedBars[3], 604.500000, 75.000000);
    TextDrawSetOutline(g_tdNeedBars[3], 1);
    TextDrawSetShadow(g_tdNeedBars[3], 0);
    TextDrawAlignment(g_tdNeedBars[3], 1);
    TextDrawColor(g_tdNeedBars[3], -1);
    TextDrawBackgroundColor(g_tdNeedBars[3], 255);
    TextDrawBoxColor(g_tdNeedBars[3], 791621631);
    TextDrawUseBox(g_tdNeedBars[3], 1);
    TextDrawSetProportional(g_tdNeedBars[3], 1);
    TextDrawSetSelectable(g_tdNeedBars[3], 0);

    g_tdInventoryBG[3] = TextDrawCreate(316.000000, 377.000000, "_");
    TextDrawFont(g_tdInventoryBG[3], 1);
    TextDrawLetterSize(g_tdInventoryBG[3], 0.600000, -23.400000);
    TextDrawTextSize(g_tdInventoryBG[3], 364.000000, 195.500000);
    TextDrawSetOutline(g_tdInventoryBG[3], 1);
    TextDrawSetShadow(g_tdInventoryBG[3], 0);
    TextDrawAlignment(g_tdInventoryBG[3], 2);
    TextDrawColor(g_tdInventoryBG[3], -1);
    TextDrawBackgroundColor(g_tdInventoryBG[3], 255);
    TextDrawBoxColor(g_tdInventoryBG[3], 791621631);
    TextDrawUseBox(g_tdInventoryBG[3], 1);
    TextDrawSetProportional(g_tdInventoryBG[3], 1);
    TextDrawSetSelectable(g_tdInventoryBG[3], 0);
    
    g_tdInventoryBG[0] = TextDrawCreate(316.000000, 377.000000, "_");
    TextDrawFont(g_tdInventoryBG[0], 1);
    TextDrawLetterSize(g_tdInventoryBG[0], 0.600000, -36.699996);
    TextDrawTextSize(g_tdInventoryBG[0], 364.000000, 195.500000);
    TextDrawSetOutline(g_tdInventoryBG[0], 1);
    TextDrawSetShadow(g_tdInventoryBG[0], 0);
    TextDrawAlignment(g_tdInventoryBG[0], 2);
    TextDrawColor(g_tdInventoryBG[0], -1);
    TextDrawBackgroundColor(g_tdInventoryBG[0], 255);
    TextDrawBoxColor(g_tdInventoryBG[0], 791621631);
    TextDrawUseBox(g_tdInventoryBG[0], 1);
    TextDrawSetProportional(g_tdInventoryBG[0], 1);
    TextDrawSetSelectable(g_tdInventoryBG[0], 0);

    g_tdInventoryBG[1] = TextDrawCreate(316.000000, 372.000000, "_");
    TextDrawFont(g_tdInventoryBG[1], 1);
    TextDrawLetterSize(g_tdInventoryBG[1], 0.600000, -12.100027);
    TextDrawTextSize(g_tdInventoryBG[1], 362.000000, 188.500000);
    TextDrawSetOutline(g_tdInventoryBG[1], 1);
    TextDrawSetShadow(g_tdInventoryBG[1], 0);
    TextDrawAlignment(g_tdInventoryBG[1], 2);
    TextDrawColor(g_tdInventoryBG[1], -1);
    TextDrawBackgroundColor(g_tdInventoryBG[1], 255);
    TextDrawBoxColor(g_tdInventoryBG[1], 454761471);
    TextDrawUseBox(g_tdInventoryBG[1], 1);
    TextDrawSetProportional(g_tdInventoryBG[1], 1);
    TextDrawSetSelectable(g_tdInventoryBG[1], 0);

    g_tdInventoryBG[2] = TextDrawCreate(316.000000, 248.000000, "_");
    TextDrawFont(g_tdInventoryBG[2], 1);
    TextDrawLetterSize(g_tdInventoryBG[2], 0.600000, -21.850015);
    TextDrawTextSize(g_tdInventoryBG[2], 362.000000, 188.500000);
    TextDrawSetOutline(g_tdInventoryBG[2], 1);
    TextDrawSetShadow(g_tdInventoryBG[2], 0);
    TextDrawAlignment(g_tdInventoryBG[2], 2);
    TextDrawColor(g_tdInventoryBG[2], -1);
    TextDrawBackgroundColor(g_tdInventoryBG[2], 255);
    TextDrawBoxColor(g_tdInventoryBG[2], 454761471);
    TextDrawUseBox(g_tdInventoryBG[2], 1);
    TextDrawSetProportional(g_tdInventoryBG[2], 1);
    TextDrawSetSelectable(g_tdInventoryBG[2], 0);

    g_tdInventoryBG[4] = TextDrawCreate(316.000000, 310.000000, "_");
    TextDrawFont(g_tdInventoryBG[4], 1);
    TextDrawLetterSize(g_tdInventoryBG[4], 0.600000, -15.400000);
    TextDrawTextSize(g_tdInventoryBG[4], 362.000000, 188.500000);
    TextDrawSetOutline(g_tdInventoryBG[4], 1);
    TextDrawSetShadow(g_tdInventoryBG[4], 0);
    TextDrawAlignment(g_tdInventoryBG[4], 2);
    TextDrawColor(g_tdInventoryBG[4], -1);
    TextDrawBackgroundColor(g_tdInventoryBG[4], 255);
    TextDrawBoxColor(g_tdInventoryBG[4], 454761471);
    TextDrawUseBox(g_tdInventoryBG[4], 1);
    TextDrawSetProportional(g_tdInventoryBG[4], 1);
    TextDrawSetSelectable(g_tdInventoryBG[4], 0);

    g_tdInventoryExp[0] = TextDrawCreate(316.000000, 265.000000, "_");
    TextDrawFont(g_tdInventoryExp[0], 1);
    TextDrawLetterSize(g_tdInventoryExp[0], 0.600000, -2.100017);
    TextDrawTextSize(g_tdInventoryExp[0], 362.000000, 188.500000);
    TextDrawSetOutline(g_tdInventoryExp[0], 1);
    TextDrawSetShadow(g_tdInventoryExp[0], 0);
    TextDrawAlignment(g_tdInventoryExp[0], 2);
    TextDrawColor(g_tdInventoryExp[0], -1);
    TextDrawBackgroundColor(g_tdInventoryExp[0], 255);
    TextDrawBoxColor(g_tdInventoryExp[0], 454761471);
    TextDrawUseBox(g_tdInventoryExp[0], 1);
    TextDrawSetProportional(g_tdInventoryExp[0], 1);
    TextDrawSetSelectable(g_tdInventoryExp[0], 0);

    g_tdInventoryExp[1] = TextDrawCreate(224.000000, 263.000000, "_");
    TextDrawFont(g_tdInventoryExp[1], 1);
    TextDrawLetterSize(g_tdInventoryExp[1], 0.600000, -1.650017);
    TextDrawTextSize(g_tdInventoryExp[1], 408.500000, 188.500000);
    TextDrawSetOutline(g_tdInventoryExp[1], 1);
    TextDrawSetShadow(g_tdInventoryExp[1], 0);
    TextDrawAlignment(g_tdInventoryExp[1], 1);
    TextDrawColor(g_tdInventoryExp[1], -1);
    TextDrawBackgroundColor(g_tdInventoryExp[1], 255);
    TextDrawBoxColor(g_tdInventoryExp[1], 791621631);
    TextDrawUseBox(g_tdInventoryExp[1], 1);
    TextDrawSetProportional(g_tdInventoryExp[1], 1);
    TextDrawSetSelectable(g_tdInventoryExp[1], 0);

    g_tdInventoryUsername = TextDrawCreate(316.000000, 61.000000, "_");
    TextDrawFont(g_tdInventoryUsername, 1);
    TextDrawLetterSize(g_tdInventoryUsername, 0.191666, 1.000000);
    TextDrawTextSize(g_tdInventoryUsername, 400.000000, 302.500000);
    TextDrawSetOutline(g_tdInventoryUsername, 0);
    TextDrawSetShadow(g_tdInventoryUsername, 0);
    TextDrawAlignment(g_tdInventoryUsername, 2);
    TextDrawColor(g_tdInventoryUsername, -858993409);
    TextDrawBackgroundColor(g_tdInventoryUsername, 255);
    TextDrawBoxColor(g_tdInventoryUsername, 50);
    TextDrawUseBox(g_tdInventoryUsername, 0);
    TextDrawSetProportional(g_tdInventoryUsername, 1);
    TextDrawSetSelectable(g_tdInventoryUsername, 0);

    g_tdInveotrySections[0] = TextDrawCreate(223.000000, 259.000000, "Inventario");
    TextDrawFont(g_tdInveotrySections[0], 1);
    TextDrawLetterSize(g_tdInveotrySections[0], 0.191666, 1.000000);
    TextDrawTextSize(g_tdInveotrySections[0], 400.000000, 302.500000);
    TextDrawSetOutline(g_tdInveotrySections[0], 0);
    TextDrawSetShadow(g_tdInveotrySections[0], 0);
    TextDrawAlignment(g_tdInveotrySections[0], 1);
    TextDrawColor(g_tdInveotrySections[0], -858993409);
    TextDrawBackgroundColor(g_tdInveotrySections[0], 255);
    TextDrawBoxColor(g_tdInveotrySections[0], 50);
    TextDrawUseBox(g_tdInveotrySections[0], 0);
    TextDrawSetProportional(g_tdInveotrySections[0], 1);
    TextDrawSetSelectable(g_tdInveotrySections[0], 0);

    g_tdInveotrySections[1] = TextDrawCreate(223.000000, 177.000000, "_");
    TextDrawFont(g_tdInveotrySections[1], 1);
    TextDrawLetterSize(g_tdInveotrySections[1], 0.191666, 1.000000);
    TextDrawTextSize(g_tdInveotrySections[1], 400.000000, 302.500000);
    TextDrawSetOutline(g_tdInveotrySections[1], 0);
    TextDrawSetShadow(g_tdInveotrySections[1], 0);
    TextDrawAlignment(g_tdInveotrySections[1], 1);
    TextDrawColor(g_tdInveotrySections[1], -858993409);
    TextDrawBackgroundColor(g_tdInveotrySections[1], 255);
    TextDrawBoxColor(g_tdInveotrySections[1], 50);
    TextDrawUseBox(g_tdInveotrySections[1], 0);
    TextDrawSetProportional(g_tdInveotrySections[1], 1);
    TextDrawSetSelectable(g_tdInveotrySections[1], 0);

    // Leveling bar
    g_tdLevelingBar[0] = TextDrawCreate(317.000000, 19.000000, "_");
    TextDrawFont(g_tdLevelingBar[0], 1);
    TextDrawLetterSize(g_tdLevelingBar[0], 0.600000, 0.800000);
    TextDrawTextSize(g_tdLevelingBar[0], 400.000000, 165.500000);
    TextDrawSetOutline(g_tdLevelingBar[0], 1);
    TextDrawSetShadow(g_tdLevelingBar[0], 0);
    TextDrawAlignment(g_tdLevelingBar[0], 2);
    TextDrawColor(g_tdLevelingBar[0], -1);
    TextDrawBackgroundColor(g_tdLevelingBar[0], 255);
    TextDrawBoxColor(g_tdLevelingBar[0], 454761471);
    TextDrawUseBox(g_tdLevelingBar[0], 1);
    TextDrawSetProportional(g_tdLevelingBar[0], 1);
    TextDrawSetSelectable(g_tdLevelingBar[0], 0);

    g_tdLevelingBar[1] = TextDrawCreate(317.000000, 20.000000, "_");
    TextDrawFont(g_tdLevelingBar[1], 1);
    TextDrawLetterSize(g_tdLevelingBar[1], 0.600000, 0.550000);
    TextDrawTextSize(g_tdLevelingBar[1], 400.000000, 163.500000);
    TextDrawSetOutline(g_tdLevelingBar[1], 0);
    TextDrawSetShadow(g_tdLevelingBar[1], 0);
    TextDrawAlignment(g_tdLevelingBar[1], 2);
    TextDrawColor(g_tdLevelingBar[1], -1);
    TextDrawBackgroundColor(g_tdLevelingBar[1], 255);
    TextDrawBoxColor(g_tdLevelingBar[1], -885971201);
    TextDrawUseBox(g_tdLevelingBar[1], 1);
    TextDrawSetProportional(g_tdLevelingBar[1], 1);
    TextDrawSetSelectable(g_tdLevelingBar[1], 0);

    g_tdLevelingBar[2] = TextDrawCreate(317.000000, 21.000000, "_");
    TextDrawFont(g_tdLevelingBar[2], 1);
    TextDrawLetterSize(g_tdLevelingBar[2], 0.600000, 0.300000);
    TextDrawTextSize(g_tdLevelingBar[2], 400.000000, 161.000000);
    TextDrawSetOutline(g_tdLevelingBar[2], 1);
    TextDrawSetShadow(g_tdLevelingBar[2], 0);
    TextDrawAlignment(g_tdLevelingBar[2], 2);
    TextDrawColor(g_tdLevelingBar[2], -1);
    TextDrawBackgroundColor(g_tdLevelingBar[2], 255);
    TextDrawBoxColor(g_tdLevelingBar[2], 454761471);
    TextDrawUseBox(g_tdLevelingBar[2], 1);
    TextDrawSetProportional(g_tdLevelingBar[2], 1);
    TextDrawSetSelectable(g_tdLevelingBar[2], 0);

    g_tdLevelingBar[3] = TextDrawCreate(236.000000, 21.000000, !"_");
    TextDrawFont(g_tdLevelingBar[3], 1);
    TextDrawLetterSize(g_tdLevelingBar[3], 0.000000, 0.300000);
    TextDrawTextSize(g_tdLevelingBar[3], 332.500000, 75.500000);
    TextDrawSetOutline(g_tdLevelingBar[3], 1);
    TextDrawSetShadow(g_tdLevelingBar[3], 0);
    TextDrawAlignment(g_tdLevelingBar[3], 1);
    TextDrawColor(g_tdLevelingBar[3], -1);
    TextDrawBackgroundColor(g_tdLevelingBar[3], -1339152897);
    TextDrawBoxColor(g_tdLevelingBar[3], -1977015553);
    TextDrawUseBox(g_tdLevelingBar[3], 1);
    TextDrawSetProportional(g_tdLevelingBar[3], 1);
    TextDrawSetSelectable(g_tdLevelingBar[3], 0);

    g_tdLevelingBar[4] = TextDrawCreate(317.000000, 18.000000, "/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/");
    TextDrawFont(g_tdLevelingBar[4], 1);
    TextDrawLetterSize(g_tdLevelingBar[4], 0.275000, 0.800000);
    TextDrawTextSize(g_tdLevelingBar[4], 400.000000, 163.500000);
    TextDrawSetOutline(g_tdLevelingBar[4], 0);
    TextDrawSetShadow(g_tdLevelingBar[4], 0);
    TextDrawAlignment(g_tdLevelingBar[4], 2);
    TextDrawColor(g_tdLevelingBar[4], -885971201);
    TextDrawBackgroundColor(g_tdLevelingBar[4], 255);
    TextDrawBoxColor(g_tdLevelingBar[4], 50);
    TextDrawUseBox(g_tdLevelingBar[4], 0);
    TextDrawSetProportional(g_tdLevelingBar[4], 1);
    TextDrawSetSelectable(g_tdLevelingBar[4], 0);

    g_tdLevelingBar[5] = TextDrawCreate(317.000000, 28.000000, !"422/40224");
    TextDrawFont(g_tdLevelingBar[5], 2);
    TextDrawLetterSize(g_tdLevelingBar[5], 0.129166, 0.800000);
    TextDrawTextSize(g_tdLevelingBar[5], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdLevelingBar[5], 0);
    TextDrawSetShadow(g_tdLevelingBar[5], 1);
    TextDrawAlignment(g_tdLevelingBar[5], 2);
    TextDrawColor(g_tdLevelingBar[5], -1);
    TextDrawBackgroundColor(g_tdLevelingBar[5], 255);
    TextDrawBoxColor(g_tdLevelingBar[5], 50);
    TextDrawUseBox(g_tdLevelingBar[5], 0);
    TextDrawSetProportional(g_tdLevelingBar[5], 1);
    TextDrawSetSelectable(g_tdLevelingBar[5], 0);

    // Gang panel
    g_tdGangs[0] = TextDrawCreate(317.000000, 97.000000, "_");
    TextDrawFont(g_tdGangs[0], 1);
    TextDrawLetterSize(g_tdGangs[0], 0.600000, 30.949956);
    TextDrawTextSize(g_tdGangs[0], 307.000000, 138.500000);
    TextDrawSetOutline(g_tdGangs[0], 1);
    TextDrawSetShadow(g_tdGangs[0], 0);
    TextDrawAlignment(g_tdGangs[0], 2);
    TextDrawColor(g_tdGangs[0], -1);
    TextDrawBackgroundColor(g_tdGangs[0], 255);
    TextDrawBoxColor(g_tdGangs[0], 454761471);
    TextDrawUseBox(g_tdGangs[0], 1);
    TextDrawSetProportional(g_tdGangs[0], 1);
    TextDrawSetSelectable(g_tdGangs[0], 0);

    g_tdGangs[1] = TextDrawCreate(317.000000, 102.000000, "_");
    TextDrawFont(g_tdGangs[1], 1);
    TextDrawLetterSize(g_tdGangs[1], 0.870832, 2.900047);
    TextDrawTextSize(g_tdGangs[1], 307.500000, 131.000000);
    TextDrawSetOutline(g_tdGangs[1], 1);
    TextDrawSetShadow(g_tdGangs[1], 0);
    TextDrawAlignment(g_tdGangs[1], 2);
    TextDrawColor(g_tdGangs[1], -1);
    TextDrawBackgroundColor(g_tdGangs[1], 255);
    TextDrawBoxColor(g_tdGangs[1], 791621631);
    TextDrawUseBox(g_tdGangs[1], 1);
    TextDrawSetProportional(g_tdGangs[1], 1);
    TextDrawSetSelectable(g_tdGangs[1], 0);

    g_tdGangs[2] = TextDrawCreate(275.000000, 102.000000, "Los Abeja");
    TextDrawFont(g_tdGangs[2], 1);
    TextDrawLetterSize(g_tdGangs[2], 0.220833, 1.149999);
    TextDrawTextSize(g_tdGangs[2], 400.000000, 117.500000);
    TextDrawSetOutline(g_tdGangs[2], 0);
    TextDrawSetShadow(g_tdGangs[2], 0);
    TextDrawAlignment(g_tdGangs[2], 1);
    TextDrawColor(g_tdGangs[2], -624944385);
    TextDrawBackgroundColor(g_tdGangs[2], 255);
    TextDrawBoxColor(g_tdGangs[2], 50);
    TextDrawUseBox(g_tdGangs[2], 0);
    TextDrawSetProportional(g_tdGangs[2], 1);
    TextDrawSetSelectable(g_tdGangs[2], 0);

    g_tdGangs[3] = TextDrawCreate(275.000000, 114.000000, "Miembros: 422");
    TextDrawFont(g_tdGangs[3], 1);
    TextDrawLetterSize(g_tdGangs[3], 0.220833, 1.149999);
    TextDrawTextSize(g_tdGangs[3], 400.000000, 117.500000);
    TextDrawSetOutline(g_tdGangs[3], 0);
    TextDrawSetShadow(g_tdGangs[3], 0);
    TextDrawAlignment(g_tdGangs[3], 1);
    TextDrawColor(g_tdGangs[3], -993737473);
    TextDrawBackgroundColor(g_tdGangs[3], 255);
    TextDrawBoxColor(g_tdGangs[3], 50);
    TextDrawUseBox(g_tdGangs[3], 0);
    TextDrawSetProportional(g_tdGangs[3], 1);
    TextDrawSetSelectable(g_tdGangs[3], 0);

    g_tdGangs[4] = TextDrawCreate(252.000000, 103.000000, "ld_grav:bee1");
    TextDrawFont(g_tdGangs[4], 4);
    TextDrawLetterSize(g_tdGangs[4], 0.600000, 2.000000);
    TextDrawTextSize(g_tdGangs[4], 19.000000, 22.000000);
    TextDrawSetOutline(g_tdGangs[4], 1);
    TextDrawSetShadow(g_tdGangs[4], 4);
    TextDrawAlignment(g_tdGangs[4], 1);
    TextDrawColor(g_tdGangs[4], -1);
    TextDrawBackgroundColor(g_tdGangs[4], 255);
    TextDrawBoxColor(g_tdGangs[4], 50);
    TextDrawUseBox(g_tdGangs[4], 0);
    TextDrawSetProportional(g_tdGangs[4], 1);
    TextDrawSetSelectable(g_tdGangs[4], 0);

    g_tdGangs[5] = TextDrawCreate(317.000000, 137.000000, "_");
    TextDrawFont(g_tdGangs[5], 1);
    TextDrawLetterSize(g_tdGangs[5], 0.870832, 23.700054);
    TextDrawTextSize(g_tdGangs[5], 307.500000, 131.000000);
    TextDrawSetOutline(g_tdGangs[5], 1);
    TextDrawSetShadow(g_tdGangs[5], 0);
    TextDrawAlignment(g_tdGangs[5], 2);
    TextDrawColor(g_tdGangs[5], -1);
    TextDrawBackgroundColor(g_tdGangs[5], 255);
    TextDrawBoxColor(g_tdGangs[5], 791621631);
    TextDrawUseBox(g_tdGangs[5], 1);
    TextDrawSetProportional(g_tdGangs[5], 1);
    TextDrawSetSelectable(g_tdGangs[5], 0);

    g_tdGangs[6] = TextDrawCreate(317.000000, 360.000000, "Configurar banda");
    TextDrawFont(g_tdGangs[6], 1);
    TextDrawLetterSize(g_tdGangs[6], 0.237498, 1.149999);
    TextDrawTextSize(g_tdGangs[6], 10.000000, 131.000000);
    TextDrawSetOutline(g_tdGangs[6], 0);
    TextDrawSetShadow(g_tdGangs[6], 0);
    TextDrawAlignment(g_tdGangs[6], 2);
    TextDrawColor(g_tdGangs[6], -1);
    TextDrawBackgroundColor(g_tdGangs[6], 255);
    TextDrawBoxColor(g_tdGangs[6], 791621631);
    TextDrawUseBox(g_tdGangs[6], 1);
    TextDrawSetProportional(g_tdGangs[6], 1);
    TextDrawSetSelectable(g_tdGangs[6], 1);

    g_tdGangs[7] = TextDrawCreate(283.000000, 336.000000, "<");
    TextDrawFont(g_tdGangs[7], 3);
    TextDrawLetterSize(g_tdGangs[7], 0.237498, 1.149999);
    TextDrawTextSize(g_tdGangs[7], 7.000000, 57.500000);
    TextDrawSetOutline(g_tdGangs[7], 0);
    TextDrawSetShadow(g_tdGangs[7], 0);
    TextDrawAlignment(g_tdGangs[7], 2);
    TextDrawColor(g_tdGangs[7], -1);
    TextDrawBackgroundColor(g_tdGangs[7], 255);
    TextDrawBoxColor(g_tdGangs[7], 454761471);
    TextDrawUseBox(g_tdGangs[7], 1);
    TextDrawSetProportional(g_tdGangs[7], 1);
    TextDrawSetSelectable(g_tdGangs[7], 1);

    g_tdGangs[8] = TextDrawCreate(351.000000, 336.000000, ">");
    TextDrawFont(g_tdGangs[8], 3);
    TextDrawLetterSize(g_tdGangs[8], 0.237498, 1.149999);
    TextDrawTextSize(g_tdGangs[8], 7.000000, 57.500000);
    TextDrawSetOutline(g_tdGangs[8], 0);
    TextDrawSetShadow(g_tdGangs[8], 0);
    TextDrawAlignment(g_tdGangs[8], 2);
    TextDrawColor(g_tdGangs[8], -1);
    TextDrawBackgroundColor(g_tdGangs[8], 255);
    TextDrawBoxColor(g_tdGangs[8], 454761471);
    TextDrawUseBox(g_tdGangs[8], 1);
    TextDrawSetProportional(g_tdGangs[8], 1);
    TextDrawSetSelectable(g_tdGangs[8], 1);

    // Gang member slots
    g_tdGangMemberSlotBg[0] = TextDrawCreate(317.000000, 140.000000, "_");
    TextDrawFont(g_tdGangMemberSlotBg[0], 1);
    TextDrawLetterSize(g_tdGangMemberSlotBg[0], 0.600000, 2.149955);
    TextDrawTextSize(g_tdGangMemberSlotBg[0], 307.000000, 126.000000);
    TextDrawSetOutline(g_tdGangMemberSlotBg[0], 1);
    TextDrawSetShadow(g_tdGangMemberSlotBg[0], 0);
    TextDrawAlignment(g_tdGangMemberSlotBg[0], 2);
    TextDrawColor(g_tdGangMemberSlotBg[0], -1);
    TextDrawBackgroundColor(g_tdGangMemberSlotBg[0], 255);
    TextDrawBoxColor(g_tdGangMemberSlotBg[0], 454761471);
    TextDrawUseBox(g_tdGangMemberSlotBg[0], 1);
    TextDrawSetProportional(g_tdGangMemberSlotBg[0], 1);
    TextDrawSetSelectable(g_tdGangMemberSlotBg[0], 0);

    g_tdGangMemberSlotBg[1] = TextDrawCreate(317.000000, 168.000000, "_");
    TextDrawFont(g_tdGangMemberSlotBg[1], 1);
    TextDrawLetterSize(g_tdGangMemberSlotBg[1], 0.600000, 2.149955);
    TextDrawTextSize(g_tdGangMemberSlotBg[1], 307.000000, 126.000000);
    TextDrawSetOutline(g_tdGangMemberSlotBg[1], 1);
    TextDrawSetShadow(g_tdGangMemberSlotBg[1], 0);
    TextDrawAlignment(g_tdGangMemberSlotBg[1], 2);
    TextDrawColor(g_tdGangMemberSlotBg[1], -1);
    TextDrawBackgroundColor(g_tdGangMemberSlotBg[1], 255);
    TextDrawBoxColor(g_tdGangMemberSlotBg[1], 454761471);
    TextDrawUseBox(g_tdGangMemberSlotBg[1], 1);
    TextDrawSetProportional(g_tdGangMemberSlotBg[1], 1);
    TextDrawSetSelectable(g_tdGangMemberSlotBg[1], 0);

    g_tdGangMemberSlotBg[2] = TextDrawCreate(317.000000, 196.000000, "_");
    TextDrawFont(g_tdGangMemberSlotBg[2], 1);
    TextDrawLetterSize(g_tdGangMemberSlotBg[2], 0.600000, 2.149955);
    TextDrawTextSize(g_tdGangMemberSlotBg[2], 307.000000, 126.000000);
    TextDrawSetOutline(g_tdGangMemberSlotBg[2], 1);
    TextDrawSetShadow(g_tdGangMemberSlotBg[2], 0);
    TextDrawAlignment(g_tdGangMemberSlotBg[2], 2);
    TextDrawColor(g_tdGangMemberSlotBg[2], -1);
    TextDrawBackgroundColor(g_tdGangMemberSlotBg[2], 255);
    TextDrawBoxColor(g_tdGangMemberSlotBg[2], 454761471);
    TextDrawUseBox(g_tdGangMemberSlotBg[2], 1);
    TextDrawSetProportional(g_tdGangMemberSlotBg[2], 1);
    TextDrawSetSelectable(g_tdGangMemberSlotBg[2], 0);

    g_tdGangMemberSlotBg[3] = TextDrawCreate(317.000000, 224.000000, "_");
    TextDrawFont(g_tdGangMemberSlotBg[3], 1);
    TextDrawLetterSize(g_tdGangMemberSlotBg[3], 0.600000, 2.149955);
    TextDrawTextSize(g_tdGangMemberSlotBg[3], 307.000000, 126.000000);
    TextDrawSetOutline(g_tdGangMemberSlotBg[3], 1);
    TextDrawSetShadow(g_tdGangMemberSlotBg[3], 0);
    TextDrawAlignment(g_tdGangMemberSlotBg[3], 2);
    TextDrawColor(g_tdGangMemberSlotBg[3], -1);
    TextDrawBackgroundColor(g_tdGangMemberSlotBg[3], 255);
    TextDrawBoxColor(g_tdGangMemberSlotBg[3], 454761471);
    TextDrawUseBox(g_tdGangMemberSlotBg[3], 1);
    TextDrawSetProportional(g_tdGangMemberSlotBg[3], 1);
    TextDrawSetSelectable(g_tdGangMemberSlotBg[3], 0);

    g_tdGangMemberSlotBg[4] = TextDrawCreate(317.000000, 252.000000, "_");
    TextDrawFont(g_tdGangMemberSlotBg[4], 1);
    TextDrawLetterSize(g_tdGangMemberSlotBg[4], 0.600000, 2.149955);
    TextDrawTextSize(g_tdGangMemberSlotBg[4], 307.000000, 126.000000);
    TextDrawSetOutline(g_tdGangMemberSlotBg[4], 1);
    TextDrawSetShadow(g_tdGangMemberSlotBg[4], 0);
    TextDrawAlignment(g_tdGangMemberSlotBg[4], 2);
    TextDrawColor(g_tdGangMemberSlotBg[4], -1);
    TextDrawBackgroundColor(g_tdGangMemberSlotBg[4], 255);
    TextDrawBoxColor(g_tdGangMemberSlotBg[4], 454761471);
    TextDrawUseBox(g_tdGangMemberSlotBg[4], 1);
    TextDrawSetProportional(g_tdGangMemberSlotBg[4], 1);
    TextDrawSetSelectable(g_tdGangMemberSlotBg[4], 0);

    g_tdGangMemberSlotBg[5] = TextDrawCreate(317.000000, 280.000000, "_");
    TextDrawFont(g_tdGangMemberSlotBg[5], 1);
    TextDrawLetterSize(g_tdGangMemberSlotBg[5], 0.600000, 2.149955);
    TextDrawTextSize(g_tdGangMemberSlotBg[5], 307.000000, 126.000000);
    TextDrawSetOutline(g_tdGangMemberSlotBg[5], 1);
    TextDrawSetShadow(g_tdGangMemberSlotBg[5], 0);
    TextDrawAlignment(g_tdGangMemberSlotBg[5], 2);
    TextDrawColor(g_tdGangMemberSlotBg[5], -1);
    TextDrawBackgroundColor(g_tdGangMemberSlotBg[5], 255);
    TextDrawBoxColor(g_tdGangMemberSlotBg[5], 454761471);
    TextDrawUseBox(g_tdGangMemberSlotBg[5], 1);
    TextDrawSetProportional(g_tdGangMemberSlotBg[5], 1);
    TextDrawSetSelectable(g_tdGangMemberSlotBg[5], 0);

    g_tdGangMemberSlotBg[6] = TextDrawCreate(317.000000, 308.000000, "_");
    TextDrawFont(g_tdGangMemberSlotBg[6], 1);
    TextDrawLetterSize(g_tdGangMemberSlotBg[6], 0.600000, 2.149955);
    TextDrawTextSize(g_tdGangMemberSlotBg[6], 307.000000, 126.000000);
    TextDrawSetOutline(g_tdGangMemberSlotBg[6], 1);
    TextDrawSetShadow(g_tdGangMemberSlotBg[6], 0);
    TextDrawAlignment(g_tdGangMemberSlotBg[6], 2);
    TextDrawColor(g_tdGangMemberSlotBg[6], -1);
    TextDrawBackgroundColor(g_tdGangMemberSlotBg[6], 255);
    TextDrawBoxColor(g_tdGangMemberSlotBg[6], 454761471);
    TextDrawUseBox(g_tdGangMemberSlotBg[6], 1);
    TextDrawSetProportional(g_tdGangMemberSlotBg[6], 1);
    TextDrawSetSelectable(g_tdGangMemberSlotBg[6], 0);

    
    /*g_tdDebugScreen[0] = TextDrawCreate(561.000000, 110.000000, "_");
    TextDrawFont(g_tdDebugScreen[0], 1);
    TextDrawLetterSize(g_tdDebugScreen[0], 0.245833, 17.249998);
    TextDrawTextSize(g_tdDebugScreen[0], 400.000000, 117.500000);
    TextDrawSetOutline(g_tdDebugScreen[0], 1);
    TextDrawSetShadow(g_tdDebugScreen[0], 0);
    TextDrawAlignment(g_tdDebugScreen[0], 2);
    TextDrawColor(g_tdDebugScreen[0], -885971201);
    TextDrawBackgroundColor(g_tdDebugScreen[0], 255);
    TextDrawBoxColor(g_tdDebugScreen[0], -125);
    TextDrawUseBox(g_tdDebugScreen[0], 1);
    TextDrawSetProportional(g_tdDebugScreen[0], 1);
    TextDrawSetSelectable(g_tdDebugScreen[0], 0);

    g_tdDebugScreen[1] = TextDrawCreate(561.000000, 112.000000, "_");
    TextDrawFont(g_tdDebugScreen[1], 1);
    TextDrawLetterSize(g_tdDebugScreen[1], 0.245833, 16.850004);
    TextDrawTextSize(g_tdDebugScreen[1], 400.000000, 114.500000);
    TextDrawSetOutline(g_tdDebugScreen[1], 1);
    TextDrawSetShadow(g_tdDebugScreen[1], 0);
    TextDrawAlignment(g_tdDebugScreen[1], 2);
    TextDrawColor(g_tdDebugScreen[1], -885971201);
    TextDrawBackgroundColor(g_tdDebugScreen[1], 255);
    TextDrawBoxColor(g_tdDebugScreen[1], 640034559);
    TextDrawUseBox(g_tdDebugScreen[1], 1);
    TextDrawSetProportional(g_tdDebugScreen[1], 1);
    TextDrawSetSelectable(g_tdDebugScreen[1], 0);

    g_tdDebugScreen[2] = TextDrawCreate(561.000000, 111.000000, "DEBUG");
    TextDrawFont(g_tdDebugScreen[2], 2);
    TextDrawLetterSize(g_tdDebugScreen[2], 0.329166, 1.750000);
    TextDrawTextSize(g_tdDebugScreen[2], 400.000000, 114.000000);
    TextDrawSetOutline(g_tdDebugScreen[2], 1);
    TextDrawSetShadow(g_tdDebugScreen[2], 0);
    TextDrawAlignment(g_tdDebugScreen[2], 2);
    TextDrawColor(g_tdDebugScreen[2], -1);
    TextDrawBackgroundColor(g_tdDebugScreen[2], 255);
    TextDrawBoxColor(g_tdDebugScreen[2], 50);
    TextDrawUseBox(g_tdDebugScreen[2], 0);
    TextDrawSetProportional(g_tdDebugScreen[2], 1);
    TextDrawSetSelectable(g_tdDebugScreen[2], 0);

    g_tdDebugScreen[3] = TextDrawCreate(509.000000, 138.000000, "_");
    TextDrawFont(g_tdDebugScreen[3], 1);
    TextDrawLetterSize(g_tdDebugScreen[3], 0.237500, 1.499999);
    TextDrawTextSize(g_tdDebugScreen[3], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdDebugScreen[3], 0);
    TextDrawSetShadow(g_tdDebugScreen[3], 1);
    TextDrawAlignment(g_tdDebugScreen[3], 1);
    TextDrawColor(g_tdDebugScreen[3], -1);
    TextDrawBackgroundColor(g_tdDebugScreen[3], 255);
    TextDrawBoxColor(g_tdDebugScreen[3], 50);
    TextDrawUseBox(g_tdDebugScreen[3], 0);
    TextDrawSetProportional(g_tdDebugScreen[3], 1);
    TextDrawSetSelectable(g_tdDebugScreen[3], 0);*/

    // Phone
    g_tdPhone[0] = TextDrawCreate(553.000000, 455.000000, "_");
    TextDrawFont(g_tdPhone[0], 1);
    TextDrawLetterSize(g_tdPhone[0], 0.670832, -23.699924);
    TextDrawTextSize(g_tdPhone[0], 295.000000, 98.500000);
    TextDrawSetOutline(g_tdPhone[0], 1);
    TextDrawSetShadow(g_tdPhone[0], 0);
    TextDrawAlignment(g_tdPhone[0], 2);
    TextDrawColor(g_tdPhone[0], -1);
    TextDrawBackgroundColor(g_tdPhone[0], 255);
    TextDrawBoxColor(g_tdPhone[0], 255);
    TextDrawUseBox(g_tdPhone[0], 1);
    TextDrawSetProportional(g_tdPhone[0], 1);
    TextDrawSetSelectable(g_tdPhone[0], 0);

    g_tdPhone[1] = TextDrawCreate(516.000000, 423.000000, "7");
    TextDrawFont(g_tdPhone[1], 2);
    TextDrawLetterSize(g_tdPhone[1], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[1], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[1], 0);
    TextDrawSetShadow(g_tdPhone[1], 0);
    TextDrawAlignment(g_tdPhone[1], 2);
    TextDrawColor(g_tdPhone[1], -1);
    TextDrawBackgroundColor(g_tdPhone[1], 255);
    TextDrawBoxColor(g_tdPhone[1], 50);
    TextDrawUseBox(g_tdPhone[1], 0);
    TextDrawSetProportional(g_tdPhone[1], 1);
    TextDrawSetSelectable(g_tdPhone[1], 0);

    g_tdPhone[2] = TextDrawCreate(575.000000, 423.000000, "9");
    TextDrawFont(g_tdPhone[2], 2);
    TextDrawLetterSize(g_tdPhone[2], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[2], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[2], 0);
    TextDrawSetShadow(g_tdPhone[2], 0);
    TextDrawAlignment(g_tdPhone[2], 2);
    TextDrawColor(g_tdPhone[2], -1);
    TextDrawBackgroundColor(g_tdPhone[2], 255);
    TextDrawBoxColor(g_tdPhone[2], 50);
    TextDrawUseBox(g_tdPhone[2], 0);
    TextDrawSetProportional(g_tdPhone[2], 1);
    TextDrawSetSelectable(g_tdPhone[2], 0);

    g_tdPhone[3] = TextDrawCreate(548.000000, 423.000000, "8");
    TextDrawFont(g_tdPhone[3], 2);
    TextDrawLetterSize(g_tdPhone[3], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[3], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[3], 0);
    TextDrawSetShadow(g_tdPhone[3], 0);
    TextDrawAlignment(g_tdPhone[3], 2);
    TextDrawColor(g_tdPhone[3], -1);
    TextDrawBackgroundColor(g_tdPhone[3], 255);
    TextDrawBoxColor(g_tdPhone[3], 50);
    TextDrawUseBox(g_tdPhone[3], 0);
    TextDrawSetProportional(g_tdPhone[3], 1);
    TextDrawSetSelectable(g_tdPhone[3], 0);

    g_tdPhone[4] = TextDrawCreate(520.000000, 428.000000, "PQRS");
    TextDrawFont(g_tdPhone[4], 2);
    TextDrawLetterSize(g_tdPhone[4], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[4], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[4], 0);
    TextDrawSetShadow(g_tdPhone[4], 0);
    TextDrawAlignment(g_tdPhone[4], 1);
    TextDrawColor(g_tdPhone[4], -1);
    TextDrawBackgroundColor(g_tdPhone[4], 255);
    TextDrawBoxColor(g_tdPhone[4], 50);
    TextDrawUseBox(g_tdPhone[4], 0);
    TextDrawSetProportional(g_tdPhone[4], 1);
    TextDrawSetSelectable(g_tdPhone[4], 0);

    g_tdPhone[5] = TextDrawCreate(552.000000, 428.000000, "TUV");
    TextDrawFont(g_tdPhone[5], 2);
    TextDrawLetterSize(g_tdPhone[5], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[5], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[5], 0);
    TextDrawSetShadow(g_tdPhone[5], 0);
    TextDrawAlignment(g_tdPhone[5], 1);
    TextDrawColor(g_tdPhone[5], -1);
    TextDrawBackgroundColor(g_tdPhone[5], 255);
    TextDrawBoxColor(g_tdPhone[5], 50);
    TextDrawUseBox(g_tdPhone[5], 0);
    TextDrawSetProportional(g_tdPhone[5], 1);
    TextDrawSetSelectable(g_tdPhone[5], 0);

    g_tdPhone[6] = TextDrawCreate(580.000000, 428.000000, "WXYZ");
    TextDrawFont(g_tdPhone[6], 2);
    TextDrawLetterSize(g_tdPhone[6], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[6], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[6], 0);
    TextDrawSetShadow(g_tdPhone[6], 0);
    TextDrawAlignment(g_tdPhone[6], 1);
    TextDrawColor(g_tdPhone[6], -1);
    TextDrawBackgroundColor(g_tdPhone[6], 255);
    TextDrawBoxColor(g_tdPhone[6], 50);
    TextDrawUseBox(g_tdPhone[6], 0);
    TextDrawSetProportional(g_tdPhone[6], 1);
    TextDrawSetSelectable(g_tdPhone[6], 0);

    g_tdPhone[7] = TextDrawCreate(516.000000, 406.000000, "4");
    TextDrawFont(g_tdPhone[7], 2);
    TextDrawLetterSize(g_tdPhone[7], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[7], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[7], 0);
    TextDrawSetShadow(g_tdPhone[7], 0);
    TextDrawAlignment(g_tdPhone[7], 2);
    TextDrawColor(g_tdPhone[7], -1);
    TextDrawBackgroundColor(g_tdPhone[7], 255);
    TextDrawBoxColor(g_tdPhone[7], 50);
    TextDrawUseBox(g_tdPhone[7], 0);
    TextDrawSetProportional(g_tdPhone[7], 1);
    TextDrawSetSelectable(g_tdPhone[7], 0);

    g_tdPhone[8] = TextDrawCreate(548.000000, 406.000000, "5");
    TextDrawFont(g_tdPhone[8], 2);
    TextDrawLetterSize(g_tdPhone[8], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[8], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[8], 0);
    TextDrawSetShadow(g_tdPhone[8], 0);
    TextDrawAlignment(g_tdPhone[8], 2);
    TextDrawColor(g_tdPhone[8], -1);
    TextDrawBackgroundColor(g_tdPhone[8], 255);
    TextDrawBoxColor(g_tdPhone[8], 50);
    TextDrawUseBox(g_tdPhone[8], 0);
    TextDrawSetProportional(g_tdPhone[8], 1);
    TextDrawSetSelectable(g_tdPhone[8], 0);

    g_tdPhone[9] = TextDrawCreate(575.000000, 406.000000, "6");
    TextDrawFont(g_tdPhone[9], 2);
    TextDrawLetterSize(g_tdPhone[9], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[9], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[9], 0);
    TextDrawSetShadow(g_tdPhone[9], 0);
    TextDrawAlignment(g_tdPhone[9], 2);
    TextDrawColor(g_tdPhone[9], -1);
    TextDrawBackgroundColor(g_tdPhone[9], 255);
    TextDrawBoxColor(g_tdPhone[9], 50);
    TextDrawUseBox(g_tdPhone[9], 0);
    TextDrawSetProportional(g_tdPhone[9], 1);
    TextDrawSetSelectable(g_tdPhone[9], 0);

    g_tdPhone[10] = TextDrawCreate(520.000000, 411.000000, "GHI");
    TextDrawFont(g_tdPhone[10], 2);
    TextDrawLetterSize(g_tdPhone[10], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[10], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[10], 0);
    TextDrawSetShadow(g_tdPhone[10], 0);
    TextDrawAlignment(g_tdPhone[10], 1);
    TextDrawColor(g_tdPhone[10], -1);
    TextDrawBackgroundColor(g_tdPhone[10], 255);
    TextDrawBoxColor(g_tdPhone[10], 50);
    TextDrawUseBox(g_tdPhone[10], 0);
    TextDrawSetProportional(g_tdPhone[10], 1);
    TextDrawSetSelectable(g_tdPhone[10], 0);

    g_tdPhone[11] = TextDrawCreate(552.000000, 411.000000, "JKL");
    TextDrawFont(g_tdPhone[11], 2);
    TextDrawLetterSize(g_tdPhone[11], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[11], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[11], 0);
    TextDrawSetShadow(g_tdPhone[11], 0);
    TextDrawAlignment(g_tdPhone[11], 1);
    TextDrawColor(g_tdPhone[11], -1);
    TextDrawBackgroundColor(g_tdPhone[11], 255);
    TextDrawBoxColor(g_tdPhone[11], 50);
    TextDrawUseBox(g_tdPhone[11], 0);
    TextDrawSetProportional(g_tdPhone[11], 1);
    TextDrawSetSelectable(g_tdPhone[11], 0);

    g_tdPhone[12] = TextDrawCreate(580.000000, 411.000000, "MNO");
    TextDrawFont(g_tdPhone[12], 2);
    TextDrawLetterSize(g_tdPhone[12], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[12], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[12], 0);
    TextDrawSetShadow(g_tdPhone[12], 0);
    TextDrawAlignment(g_tdPhone[12], 1);
    TextDrawColor(g_tdPhone[12], -1);
    TextDrawBackgroundColor(g_tdPhone[12], 255);
    TextDrawBoxColor(g_tdPhone[12], 50);
    TextDrawUseBox(g_tdPhone[12], 0);
    TextDrawSetProportional(g_tdPhone[12], 1);
    TextDrawSetSelectable(g_tdPhone[12], 0);

    g_tdPhone[13] = TextDrawCreate(516.000000, 388.000000, "1");
    TextDrawFont(g_tdPhone[13], 2);
    TextDrawLetterSize(g_tdPhone[13], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[13], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[13], 0);
    TextDrawSetShadow(g_tdPhone[13], 0);
    TextDrawAlignment(g_tdPhone[13], 2);
    TextDrawColor(g_tdPhone[13], -1);
    TextDrawBackgroundColor(g_tdPhone[13], 255);
    TextDrawBoxColor(g_tdPhone[13], 50);
    TextDrawUseBox(g_tdPhone[13], 0);
    TextDrawSetProportional(g_tdPhone[13], 1);
    TextDrawSetSelectable(g_tdPhone[13], 0);

    g_tdPhone[14] = TextDrawCreate(548.000000, 388.000000, "2");
    TextDrawFont(g_tdPhone[14], 2);
    TextDrawLetterSize(g_tdPhone[14], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[14], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[14], 0);
    TextDrawSetShadow(g_tdPhone[14], 0);
    TextDrawAlignment(g_tdPhone[14], 2);
    TextDrawColor(g_tdPhone[14], -1);
    TextDrawBackgroundColor(g_tdPhone[14], 255);
    TextDrawBoxColor(g_tdPhone[14], 50);
    TextDrawUseBox(g_tdPhone[14], 0);
    TextDrawSetProportional(g_tdPhone[14], 1);
    TextDrawSetSelectable(g_tdPhone[14], 0);

    g_tdPhone[15] = TextDrawCreate(575.000000, 388.000000, "3");
    TextDrawFont(g_tdPhone[15], 2);
    TextDrawLetterSize(g_tdPhone[15], 0.208333, 1.899999);
    TextDrawTextSize(g_tdPhone[15], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[15], 0);
    TextDrawSetShadow(g_tdPhone[15], 0);
    TextDrawAlignment(g_tdPhone[15], 2);
    TextDrawColor(g_tdPhone[15], -1);
    TextDrawBackgroundColor(g_tdPhone[15], 255);
    TextDrawBoxColor(g_tdPhone[15], 50);
    TextDrawUseBox(g_tdPhone[15], 0);
    TextDrawSetProportional(g_tdPhone[15], 1);
    TextDrawSetSelectable(g_tdPhone[15], 0);

    g_tdPhone[16] = TextDrawCreate(520.000000, 394.000000, ".,");
    TextDrawFont(g_tdPhone[16], 2);
    TextDrawLetterSize(g_tdPhone[16], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[16], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[16], 0);
    TextDrawSetShadow(g_tdPhone[16], 0);
    TextDrawAlignment(g_tdPhone[16], 1);
    TextDrawColor(g_tdPhone[16], -1);
    TextDrawBackgroundColor(g_tdPhone[16], 255);
    TextDrawBoxColor(g_tdPhone[16], 50);
    TextDrawUseBox(g_tdPhone[16], 0);
    TextDrawSetProportional(g_tdPhone[16], 1);
    TextDrawSetSelectable(g_tdPhone[16], 0);

    g_tdPhone[17] = TextDrawCreate(552.000000, 394.000000, "ABC");
    TextDrawFont(g_tdPhone[17], 2);
    TextDrawLetterSize(g_tdPhone[17], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[17], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[17], 0);
    TextDrawSetShadow(g_tdPhone[17], 0);
    TextDrawAlignment(g_tdPhone[17], 1);
    TextDrawColor(g_tdPhone[17], -1);
    TextDrawBackgroundColor(g_tdPhone[17], 255);
    TextDrawBoxColor(g_tdPhone[17], 50);
    TextDrawUseBox(g_tdPhone[17], 0);
    TextDrawSetProportional(g_tdPhone[17], 1);
    TextDrawSetSelectable(g_tdPhone[17], 0);

    g_tdPhone[18] = TextDrawCreate(580.000000, 394.000000, "DEF");
    TextDrawFont(g_tdPhone[18], 2);
    TextDrawLetterSize(g_tdPhone[18], 0.133332, 0.949999);
    TextDrawTextSize(g_tdPhone[18], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[18], 0);
    TextDrawSetShadow(g_tdPhone[18], 0);
    TextDrawAlignment(g_tdPhone[18], 1);
    TextDrawColor(g_tdPhone[18], -1);
    TextDrawBackgroundColor(g_tdPhone[18], 255);
    TextDrawBoxColor(g_tdPhone[18], 50);
    TextDrawUseBox(g_tdPhone[18], 0);
    TextDrawSetProportional(g_tdPhone[18], 1);
    TextDrawSetSelectable(g_tdPhone[18], 0);

    g_tdPhone[19] = TextDrawCreate(553.000000, 382.000000, "_");
    TextDrawFont(g_tdPhone[19], 0);
    TextDrawLetterSize(g_tdPhone[19], 0.625000, -14.549936);
    TextDrawTextSize(g_tdPhone[19], 81.000000, 83.000000);
    TextDrawSetOutline(g_tdPhone[19], 1);
    TextDrawSetShadow(g_tdPhone[19], 0);
    TextDrawAlignment(g_tdPhone[19], 2);
    TextDrawColor(g_tdPhone[19], -1);
    TextDrawBackgroundColor(g_tdPhone[19], -1378294017);
    TextDrawBoxColor(g_tdPhone[19], -944014849);
    TextDrawUseBox(g_tdPhone[19], 1);
    TextDrawSetProportional(g_tdPhone[19], 1);
    TextDrawSetSelectable(g_tdPhone[19], 0);

    g_tdPhone[20] = TextDrawCreate(553.000000, 272.000000, "_");
    TextDrawFont(g_tdPhone[20], 0);
    TextDrawLetterSize(g_tdPhone[20], 0.625000, -2.349930);
    TextDrawTextSize(g_tdPhone[20], 81.000000, 83.000000);
    TextDrawSetOutline(g_tdPhone[20], 1);
    TextDrawSetShadow(g_tdPhone[20], 0);
    TextDrawAlignment(g_tdPhone[20], 2);
    TextDrawColor(g_tdPhone[20], -1);
    TextDrawBackgroundColor(g_tdPhone[20], -1378294017);
    TextDrawBoxColor(g_tdPhone[20], 140);
    TextDrawUseBox(g_tdPhone[20], 1);
    TextDrawSetProportional(g_tdPhone[20], 1);
    TextDrawSetSelectable(g_tdPhone[20], 0);

    g_tdPhone[21] = TextDrawCreate(594.000000, 255.000000, "FRI 07:56");
    TextDrawFont(g_tdPhone[21], 1);
    TextDrawLetterSize(g_tdPhone[21], 0.224999, 1.250000);
    TextDrawTextSize(g_tdPhone[21], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdPhone[21], 0);
    TextDrawSetShadow(g_tdPhone[21], 0);
    TextDrawAlignment(g_tdPhone[21], 3);
    TextDrawColor(g_tdPhone[21], -993737473);
    TextDrawBackgroundColor(g_tdPhone[21], 255);
    TextDrawBoxColor(g_tdPhone[21], 50);
    TextDrawUseBox(g_tdPhone[21], 0);
    TextDrawSetProportional(g_tdPhone[21], 1);
    TextDrawSetSelectable(g_tdPhone[21], 0);

    g_tdPhone[22] = TextDrawCreate(513.000000, 267.000000, "_");
    TextDrawFont(g_tdPhone[22], 1);
    TextDrawLetterSize(g_tdPhone[22], 0.600000, -0.750000);
    TextDrawTextSize(g_tdPhone[22], 298.500000, -2.500000);
    TextDrawSetOutline(g_tdPhone[22], 1);
    TextDrawSetShadow(g_tdPhone[22], 0);
    TextDrawAlignment(g_tdPhone[22], 2);
    TextDrawColor(g_tdPhone[22], -1);
    TextDrawBackgroundColor(g_tdPhone[22], 255);
    TextDrawBoxColor(g_tdPhone[22], -993737473);
    TextDrawUseBox(g_tdPhone[22], 1);
    TextDrawSetProportional(g_tdPhone[22], 1);
    TextDrawSetSelectable(g_tdPhone[22], 0);

    g_tdPhone[23] = TextDrawCreate(515.000000, 267.000000, "_");
    TextDrawFont(g_tdPhone[23], 1);
    TextDrawLetterSize(g_tdPhone[23], 0.600000, -0.949999);
    TextDrawTextSize(g_tdPhone[23], 298.500000, -2.500000);
    TextDrawSetOutline(g_tdPhone[23], 1);
    TextDrawSetShadow(g_tdPhone[23], 0);
    TextDrawAlignment(g_tdPhone[23], 2);
    TextDrawColor(g_tdPhone[23], -1);
    TextDrawBackgroundColor(g_tdPhone[23], 255);
    TextDrawBoxColor(g_tdPhone[23], -993737473);
    TextDrawUseBox(g_tdPhone[23], 1);
    TextDrawSetProportional(g_tdPhone[23], 1);
    TextDrawSetSelectable(g_tdPhone[23], 0);

    g_tdPhone[24] = TextDrawCreate(517.000000, 267.000000, "_");
    TextDrawFont(g_tdPhone[24], 1);
    TextDrawLetterSize(g_tdPhone[24], 0.600000, -1.149999);
    TextDrawTextSize(g_tdPhone[24], 298.500000, -2.500000);
    TextDrawSetOutline(g_tdPhone[24], 1);
    TextDrawSetShadow(g_tdPhone[24], 0);
    TextDrawAlignment(g_tdPhone[24], 2);
    TextDrawColor(g_tdPhone[24], -1);
    TextDrawBackgroundColor(g_tdPhone[24], 255);
    TextDrawBoxColor(g_tdPhone[24], -993737473);
    TextDrawUseBox(g_tdPhone[24], 1);
    TextDrawSetProportional(g_tdPhone[24], 1);
    TextDrawSetSelectable(g_tdPhone[24], 0);

    g_tdPhone[25] = TextDrawCreate(519.000000, 267.000000, "_");
    TextDrawFont(g_tdPhone[25], 1);
    TextDrawLetterSize(g_tdPhone[25], 0.600000, -1.350000);
    TextDrawTextSize(g_tdPhone[25], 298.500000, -2.500000);
    TextDrawSetOutline(g_tdPhone[25], 1);
    TextDrawSetShadow(g_tdPhone[25], 0);
    TextDrawAlignment(g_tdPhone[25], 2);
    TextDrawColor(g_tdPhone[25], -1);
    TextDrawBackgroundColor(g_tdPhone[25], 255);
    TextDrawBoxColor(g_tdPhone[25], -993737473);
    TextDrawUseBox(g_tdPhone[25], 1);
    TextDrawSetProportional(g_tdPhone[25], 1);
    TextDrawSetSelectable(g_tdPhone[25], 0);

    g_tdPhone[26] = TextDrawCreate(553.000000, 382.000000, "_");
    TextDrawFont(g_tdPhone[26], 0);
    TextDrawLetterSize(g_tdPhone[26], 0.625000, -2.349930);
    TextDrawTextSize(g_tdPhone[26], 81.000000, 83.000000);
    TextDrawSetOutline(g_tdPhone[26], 1);
    TextDrawSetShadow(g_tdPhone[26], 0);
    TextDrawAlignment(g_tdPhone[26], 2);
    TextDrawColor(g_tdPhone[26], -1);
    TextDrawBackgroundColor(g_tdPhone[26], -1378294017);
    TextDrawBoxColor(g_tdPhone[26], 140);
    TextDrawUseBox(g_tdPhone[26], 1);
    TextDrawSetProportional(g_tdPhone[26], 1);
    TextDrawSetSelectable(g_tdPhone[26], 0);

    g_tdPhone[27] = TextDrawCreate(553.000000, 275.000000, "_");
    TextDrawFont(g_tdPhone[27], 0);
    TextDrawLetterSize(g_tdPhone[27], 0.625000, 9.200076);
    TextDrawTextSize(g_tdPhone[27], 82.000000, 79.000000);
    TextDrawSetOutline(g_tdPhone[27], 1);
    TextDrawSetShadow(g_tdPhone[27], 0);
    TextDrawAlignment(g_tdPhone[27], 2);
    TextDrawColor(g_tdPhone[27], -1);
    TextDrawBackgroundColor(g_tdPhone[27], -1378294017);
    TextDrawBoxColor(g_tdPhone[27], 140);
    TextDrawUseBox(g_tdPhone[27], 1);
    TextDrawSetProportional(g_tdPhone[27], 1);
    TextDrawSetSelectable(g_tdPhone[27], 0);

    g_tdPhone[28] = TextDrawCreate(512.000000, 366.000000, "_"); // Button 1
    TextDrawFont(g_tdPhone[28], 1);
    TextDrawLetterSize(g_tdPhone[28], 0.216666, 1.049999);
    TextDrawTextSize(g_tdPhone[28], 550.500000, 114.000000);
    TextDrawSetOutline(g_tdPhone[28], 0);
    TextDrawSetShadow(g_tdPhone[28], 0);
    TextDrawAlignment(g_tdPhone[28], 1);
    TextDrawColor(g_tdPhone[28], 1300904959);
    TextDrawBackgroundColor(g_tdPhone[28], 255);
    TextDrawBoxColor(g_tdPhone[28], 50);
    TextDrawUseBox(g_tdPhone[28], 0);
    TextDrawSetProportional(g_tdPhone[28], 1);
    TextDrawSetSelectable(g_tdPhone[28], 0);

    g_tdPhone[29] = TextDrawCreate(594.000000, 366.000000, "_"); // Button 2
    TextDrawFont(g_tdPhone[29], 1);
    TextDrawLetterSize(g_tdPhone[29], 0.216666, 1.049999);
    TextDrawTextSize(g_tdPhone[29], 628.000000, 114.000000);
    TextDrawSetOutline(g_tdPhone[29], 0);
    TextDrawSetShadow(g_tdPhone[29], 0);
    TextDrawAlignment(g_tdPhone[29], 3);
    TextDrawColor(g_tdPhone[29], -1237434625);
    TextDrawBackgroundColor(g_tdPhone[29], 255);
    TextDrawBoxColor(g_tdPhone[29], 50);
    TextDrawUseBox(g_tdPhone[29], 0);
    TextDrawSetProportional(g_tdPhone[29], 1);
    TextDrawSetSelectable(g_tdPhone[29], 0);

    // Android controller
    g_tdController[0] = TextDrawCreate(315.000000, 397.000000, "Seleccionar");
    TextDrawFont(g_tdController[0], 1);
    TextDrawLetterSize(g_tdController[0], 0.291666, 1.500000);
    TextDrawTextSize(g_tdController[0], 15.500000, 77.000000);
    TextDrawSetOutline(g_tdController[0], 0);
    TextDrawSetShadow(g_tdController[0], 0);
    TextDrawAlignment(g_tdController[0], 2);
    TextDrawColor(g_tdController[0], -1);
    TextDrawBackgroundColor(g_tdController[0], 255);
    TextDrawBoxColor(g_tdController[0], 454761471);
    TextDrawUseBox(g_tdController[0], 1);
    TextDrawSetProportional(g_tdController[0], 1);
    TextDrawSetSelectable(g_tdController[0], 1);

    g_tdController[1] = TextDrawCreate(315.000000, 419.000000, "Volver");
    TextDrawFont(g_tdController[1], 1);
    TextDrawLetterSize(g_tdController[1], 0.291666, 1.500000);
    TextDrawTextSize(g_tdController[1], 400.000000, 77.000000);
    TextDrawSetOutline(g_tdController[1], 0);
    TextDrawSetShadow(g_tdController[1], 0);
    TextDrawAlignment(g_tdController[1], 2);
    TextDrawColor(g_tdController[1], -1);
    TextDrawBackgroundColor(g_tdController[1], 255);
    TextDrawBoxColor(g_tdController[1], 454761471);
    TextDrawUseBox(g_tdController[1], 1);
    TextDrawSetProportional(g_tdController[1], 1);
    TextDrawSetSelectable(g_tdController[1], 1);

    g_tdController[2] = TextDrawCreate(315.000000, 347.000000, "W");
    TextDrawFont(g_tdController[2], 1);
    TextDrawLetterSize(g_tdController[2], 0.425000, 1.750000);
    TextDrawTextSize(g_tdController[2], 15.500000, 21.000000);
    TextDrawSetOutline(g_tdController[2], 0);
    TextDrawSetShadow(g_tdController[2], 0);
    TextDrawAlignment(g_tdController[2], 2);
    TextDrawColor(g_tdController[2], -1);
    TextDrawBackgroundColor(g_tdController[2], 255);
    TextDrawBoxColor(g_tdController[2], 454761471);
    TextDrawUseBox(g_tdController[2], 1);
    TextDrawSetProportional(g_tdController[2], 1);
    TextDrawSetSelectable(g_tdController[2], 1);

    g_tdController[3] = TextDrawCreate(315.000000, 372.000000, "S");
    TextDrawFont(g_tdController[3], 1);
    TextDrawLetterSize(g_tdController[3], 0.425000, 1.750000);
    TextDrawTextSize(g_tdController[3], 15.500000, 21.000000);
    TextDrawSetOutline(g_tdController[3], 0);
    TextDrawSetShadow(g_tdController[3], 0);
    TextDrawAlignment(g_tdController[3], 2);
    TextDrawColor(g_tdController[3], -1);
    TextDrawBackgroundColor(g_tdController[3], 255);
    TextDrawBoxColor(g_tdController[3], 454761471);
    TextDrawUseBox(g_tdController[3], 1);
    TextDrawSetProportional(g_tdController[3], 1);
    TextDrawSetSelectable(g_tdController[3], 1);

    g_tdController[4] = TextDrawCreate(287.000000, 372.000000, "A");
    TextDrawFont(g_tdController[4], 1);
    TextDrawLetterSize(g_tdController[4], 0.425000, 1.750000);
    TextDrawTextSize(g_tdController[4], 15.500000, 21.000000);
    TextDrawSetOutline(g_tdController[4], 0);
    TextDrawSetShadow(g_tdController[4], 0);
    TextDrawAlignment(g_tdController[4], 2);
    TextDrawColor(g_tdController[4], -1);
    TextDrawBackgroundColor(g_tdController[4], 255);
    TextDrawBoxColor(g_tdController[4], 454761471);
    TextDrawUseBox(g_tdController[4], 1);
    TextDrawSetProportional(g_tdController[4], 1);
    TextDrawSetSelectable(g_tdController[4], 1);

    g_tdController[5] = TextDrawCreate(343.000000, 372.000000, "D");
    TextDrawFont(g_tdController[5], 1);
    TextDrawLetterSize(g_tdController[5], 0.425000, 1.750000);
    TextDrawTextSize(g_tdController[5], 15.500000, 21.000000);
    TextDrawSetOutline(g_tdController[5], 0);
    TextDrawSetShadow(g_tdController[5], 0);
    TextDrawAlignment(g_tdController[5], 2);
    TextDrawColor(g_tdController[5], -1);
    TextDrawBackgroundColor(g_tdController[5], 255);
    TextDrawBoxColor(g_tdController[5], 454761471);
    TextDrawUseBox(g_tdController[5], 1);
    TextDrawSetProportional(g_tdController[5], 1);
    TextDrawSetSelectable(g_tdController[5], 1);
    
    #if defined TD_OnScriptInit
        return TD_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit TD_OnScriptInit
#if defined TD_OnScriptInit
    forward TD_OnScriptInit();
#endif

public OnPlayerConnect(playerid)
{
    // SPEEDOMETER
    p_tdSpeedometer[playerid]{0} = CreatePlayerTextDraw(playerid, 584.000000, 405.000000, "PUERTAS");
    PlayerTextDrawFont(playerid, p_tdSpeedometer[playerid]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdSpeedometer[playerid]{0}, 0.233333, 1.200000);
    PlayerTextDrawTextSize(playerid, p_tdSpeedometer[playerid]{0}, 400.000000, 37.000000);
    PlayerTextDrawSetOutline(playerid, p_tdSpeedometer[playerid]{0}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdSpeedometer[playerid]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdSpeedometer[playerid]{0}, 2);
    PlayerTextDrawColor(playerid, p_tdSpeedometer[playerid]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdSpeedometer[playerid]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{0}, 791621631);
    PlayerTextDrawUseBox(playerid, p_tdSpeedometer[playerid]{0}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdSpeedometer[playerid]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdSpeedometer[playerid]{0}, 0);

    p_tdSpeedometer[playerid]{1} = CreatePlayerTextDraw(playerid, 540.000000, 405.000000, "VENTANA");
    PlayerTextDrawFont(playerid, p_tdSpeedometer[playerid]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdSpeedometer[playerid]{1}, 0.233333, 1.200000);
    PlayerTextDrawTextSize(playerid, p_tdSpeedometer[playerid]{1}, 400.000000, 37.000000);
    PlayerTextDrawSetOutline(playerid, p_tdSpeedometer[playerid]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdSpeedometer[playerid]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdSpeedometer[playerid]{1}, 2);
    PlayerTextDrawColor(playerid, p_tdSpeedometer[playerid]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdSpeedometer[playerid]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{1}, 791621631);
    PlayerTextDrawUseBox(playerid, p_tdSpeedometer[playerid]{1}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdSpeedometer[playerid]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdSpeedometer[playerid]{1}, 0);

    p_tdSpeedometer[playerid]{2} = CreatePlayerTextDraw(playerid, 540.000000, 382.000000, "MOTOR");
    PlayerTextDrawFont(playerid, p_tdSpeedometer[playerid]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdSpeedometer[playerid]{2}, 0.233333, 1.200000);
    PlayerTextDrawTextSize(playerid, p_tdSpeedometer[playerid]{2}, 400.000000, 37.000000);
    PlayerTextDrawSetOutline(playerid, p_tdSpeedometer[playerid]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdSpeedometer[playerid]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdSpeedometer[playerid]{2}, 2);
    PlayerTextDrawColor(playerid, p_tdSpeedometer[playerid]{2}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdSpeedometer[playerid]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 791621631);
    PlayerTextDrawUseBox(playerid, p_tdSpeedometer[playerid]{2}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdSpeedometer[playerid]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdSpeedometer[playerid]{2}, 0);

    p_tdSpeedometer[playerid]{3} = CreatePlayerTextDraw(playerid, 584.000000, 382.000000, "LUCES");
    PlayerTextDrawFont(playerid, p_tdSpeedometer[playerid]{3}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdSpeedometer[playerid]{3}, 0.233333, 1.200000);
    PlayerTextDrawTextSize(playerid, p_tdSpeedometer[playerid]{3}, 400.000000, 37.000000);
    PlayerTextDrawSetOutline(playerid, p_tdSpeedometer[playerid]{3}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdSpeedometer[playerid]{3}, 0);
    PlayerTextDrawAlignment(playerid, p_tdSpeedometer[playerid]{3}, 2);
    PlayerTextDrawColor(playerid, p_tdSpeedometer[playerid]{3}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdSpeedometer[playerid]{3}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{3}, 791621631);
    PlayerTextDrawUseBox(playerid, p_tdSpeedometer[playerid]{3}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdSpeedometer[playerid]{3}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdSpeedometer[playerid]{3}, 0);

    // KEY
    p_tdKey_Text{playerid} = CreatePlayerTextDraw(playerid, 323.000000, 11.000000, !"_");
    PlayerTextDrawFont(playerid, p_tdKey_Text{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdKey_Text{playerid}, 0.233333, 1.200000);
    PlayerTextDrawTextSize(playerid, p_tdKey_Text{playerid}, 378.000000, 103.000000);
    PlayerTextDrawSetOutline(playerid, p_tdKey_Text{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdKey_Text{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdKey_Text{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdKey_Text{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdKey_Text{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdKey_Text{playerid}, 454761471);
    PlayerTextDrawUseBox(playerid, p_tdKey_Text{playerid}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdKey_Text{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdKey_Text{playerid}, 0);

    p_tdKey_BG{playerid} = CreatePlayerTextDraw(playerid, 323.000000, 9.000000, !"_");
    PlayerTextDrawFont(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdKey_BG{playerid}, 0.600000, -0.200000);
    PlayerTextDrawTextSize(playerid, p_tdKey_BG{playerid}, 302.000000, 103.000000);
    PlayerTextDrawSetOutline(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdKey_BG{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdKey_BG{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdKey_BG{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdKey_BG{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdKey_BG{playerid}, -626509569);
    PlayerTextDrawUseBox(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdKey_BG{playerid}, 0);

    // KeyGame
    p_tdKeyGame{playerid} = CreatePlayerTextDraw(playerid, 319.600006, 372.000000, "Y");
	PlayerTextDrawFont(playerid, p_tdKeyGame{playerid}, 2);
	PlayerTextDrawLetterSize(playerid, p_tdKeyGame{playerid}, 0.308333, 1.550000);
	PlayerTextDrawTextSize(playerid, p_tdKeyGame{playerid}, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, p_tdKeyGame{playerid}, 1);
	PlayerTextDrawSetShadow(playerid, p_tdKeyGame{playerid}, 0);
	PlayerTextDrawAlignment(playerid, p_tdKeyGame{playerid}, 2);
	PlayerTextDrawColor(playerid, p_tdKeyGame{playerid}, -1094795521);
	PlayerTextDrawBackgroundColor(playerid, p_tdKeyGame{playerid}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdKeyGame{playerid}, 50);
	PlayerTextDrawUseBox(playerid, p_tdKeyGame{playerid}, 0);
	PlayerTextDrawSetProportional(playerid, p_tdKeyGame{playerid}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdKeyGame{playerid}, 0);

    // (S)Need bars
    p_tdNeedBars[playerid]{0} = CreatePlayerTextDraw(playerid, 520.000000, 439.000000, "_");
    PlayerTextDrawFont(playerid, p_tdNeedBars[playerid]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdNeedBars[playerid]{0}, 0.554166, -1.549998);
    PlayerTextDrawTextSize(playerid, p_tdNeedBars[playerid]{0}, 549.000000, 75.000000);
    PlayerTextDrawSetOutline(playerid, p_tdNeedBars[playerid]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdNeedBars[playerid]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdNeedBars[playerid]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdNeedBars[playerid]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdNeedBars[playerid]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdNeedBars[playerid]{0}, 981925887);
    PlayerTextDrawUseBox(playerid, p_tdNeedBars[playerid]{0}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdNeedBars[playerid]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdNeedBars[playerid]{0}, 0);

    p_tdNeedBars[playerid]{1} = CreatePlayerTextDraw(playerid, 566.000000, 439.000000, "_");
    PlayerTextDrawFont(playerid, p_tdNeedBars[playerid]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdNeedBars[playerid]{1}, 0.554166, -1.549998);
    PlayerTextDrawTextSize(playerid, p_tdNeedBars[playerid]{1}, 572.000000, 75.000000);
    PlayerTextDrawSetOutline(playerid, p_tdNeedBars[playerid]{1}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdNeedBars[playerid]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdNeedBars[playerid]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdNeedBars[playerid]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdNeedBars[playerid]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdNeedBars[playerid]{1}, -511630849);
    PlayerTextDrawUseBox(playerid, p_tdNeedBars[playerid]{1}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdNeedBars[playerid]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdNeedBars[playerid]{1}, 0);

    // Inventory
    p_tdInventorySkin{playerid} = CreatePlayerTextDraw(playerid, 246.000000, 64.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, p_tdInventorySkin{playerid}, 5);
    PlayerTextDrawLetterSize(playerid, p_tdInventorySkin{playerid}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdInventorySkin{playerid}, 141.000000, 182.000000);
    PlayerTextDrawSetOutline(playerid, p_tdInventorySkin{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdInventorySkin{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdInventorySkin{playerid}, 1);
    PlayerTextDrawColor(playerid, p_tdInventorySkin{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdInventorySkin{playerid}, 0);
    PlayerTextDrawBoxColor(playerid, p_tdInventorySkin{playerid}, 0);
    PlayerTextDrawUseBox(playerid, p_tdInventorySkin{playerid}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdInventorySkin{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdInventorySkin{playerid}, 0);
    PlayerTextDrawSetPreviewModel(playerid, p_tdInventorySkin{playerid}, 5);
    PlayerTextDrawSetPreviewRot(playerid, p_tdInventorySkin{playerid}, -10.000000, 0.000000, -20.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, p_tdInventorySkin{playerid}, 1, 1);
    
    p_tdInventoryExpBar{playerid} = CreatePlayerTextDraw(playerid, 224.000000, 263.000000, "_");
    PlayerTextDrawFont(playerid, p_tdInventoryExpBar{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdInventoryExpBar{playerid}, 0.600000, -1.650017);
    PlayerTextDrawTextSize(playerid, p_tdInventoryExpBar{playerid}, 362.000000, 188.500000);
    PlayerTextDrawSetOutline(playerid, p_tdInventoryExpBar{playerid}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdInventoryExpBar{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdInventoryExpBar{playerid}, 1);
    PlayerTextDrawColor(playerid, p_tdInventoryExpBar{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdInventoryExpBar{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdInventoryExpBar{playerid}, -626509569);
    PlayerTextDrawUseBox(playerid, p_tdInventoryExpBar{playerid}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdInventoryExpBar{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdInventoryExpBar{playerid}, 0);

    p_tdInventoryExpText{playerid} = CreatePlayerTextDraw(playerid, 316.000000, 251.000000, "EXPERIENCIA: 65/100");
    PlayerTextDrawFont(playerid, p_tdInventoryExpText{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdInventoryExpText{playerid}, 0.187499, 0.949998);
    PlayerTextDrawTextSize(playerid, p_tdInventoryExpText{playerid}, 400.000000, 302.500000);
    PlayerTextDrawSetOutline(playerid, p_tdInventoryExpText{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdInventoryExpText{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdInventoryExpText{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdInventoryExpText{playerid}, -1989532417);
    PlayerTextDrawBackgroundColor(playerid, p_tdInventoryExpText{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdInventoryExpText{playerid}, 50);
    PlayerTextDrawUseBox(playerid, p_tdInventoryExpText{playerid}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdInventoryExpText{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdInventoryExpText{playerid}, 0);

    p_tdToyView[playerid]{0} = CreatePlayerTextDraw(playerid, 227.000000, 63.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, p_tdToyView[playerid]{0}, 5);
    PlayerTextDrawLetterSize(playerid, p_tdToyView[playerid]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdToyView[playerid]{0}, 38.000000, 44.500000);
    PlayerTextDrawSetOutline(playerid, p_tdToyView[playerid]{0}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdToyView[playerid]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdToyView[playerid]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdToyView[playerid]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdToyView[playerid]{0}, 791621631);
    PlayerTextDrawBoxColor(playerid, p_tdToyView[playerid]{0}, 255);
    PlayerTextDrawUseBox(playerid, p_tdToyView[playerid]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdToyView[playerid]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdToyView[playerid]{0}, 1);
    PlayerTextDrawSetPreviewModel(playerid, p_tdToyView[playerid]{0}, 19482);
    PlayerTextDrawSetPreviewRot(playerid, p_tdToyView[playerid]{0}, -100.000000, -15.000000, -103.000000, 0.740000);
    PlayerTextDrawSetPreviewVehCol(playerid, p_tdToyView[playerid]{0}, 1, 1);

    p_tdToyView[playerid]{1} = CreatePlayerTextDraw(playerid, 227.000000, 114.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, p_tdToyView[playerid]{1}, 5);
    PlayerTextDrawLetterSize(playerid, p_tdToyView[playerid]{1}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdToyView[playerid]{1}, 38.000000, 44.500000);
    PlayerTextDrawSetOutline(playerid, p_tdToyView[playerid]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdToyView[playerid]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdToyView[playerid]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdToyView[playerid]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdToyView[playerid]{1}, 791621631);
    PlayerTextDrawBoxColor(playerid, p_tdToyView[playerid]{1}, 255);
    PlayerTextDrawUseBox(playerid, p_tdToyView[playerid]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdToyView[playerid]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdToyView[playerid]{1}, 1);
    PlayerTextDrawSetPreviewModel(playerid, p_tdToyView[playerid]{1}, 19482);
    PlayerTextDrawSetPreviewRot(playerid, p_tdToyView[playerid]{1}, -100.000000, -15.000000, -103.000000, 0.740000);
    PlayerTextDrawSetPreviewVehCol(playerid, p_tdToyView[playerid]{1}, 1, 1);

    p_tdToyView[playerid]{2} = CreatePlayerTextDraw(playerid, 227.000000, 165.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, p_tdToyView[playerid]{2}, 5);
    PlayerTextDrawLetterSize(playerid, p_tdToyView[playerid]{2}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdToyView[playerid]{2}, 38.000000, 44.500000);
    PlayerTextDrawSetOutline(playerid, p_tdToyView[playerid]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdToyView[playerid]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdToyView[playerid]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdToyView[playerid]{2}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdToyView[playerid]{2}, 791621631);
    PlayerTextDrawBoxColor(playerid, p_tdToyView[playerid]{2}, 255);
    PlayerTextDrawUseBox(playerid, p_tdToyView[playerid]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdToyView[playerid]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdToyView[playerid]{2}, 1);
    PlayerTextDrawSetPreviewModel(playerid, p_tdToyView[playerid]{2}, 19482);
    PlayerTextDrawSetPreviewRot(playerid, p_tdToyView[playerid]{2}, -100.000000, -15.000000, -103.000000, 0.740000);
    PlayerTextDrawSetPreviewVehCol(playerid, p_tdToyView[playerid]{2}, 1, 1);

    p_tdToyView[playerid]{3} = CreatePlayerTextDraw(playerid, 368.000000, 63.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, p_tdToyView[playerid]{3}, 5);
    PlayerTextDrawLetterSize(playerid, p_tdToyView[playerid]{3}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdToyView[playerid]{3}, 38.000000, 44.500000);
    PlayerTextDrawSetOutline(playerid, p_tdToyView[playerid]{3}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdToyView[playerid]{3}, 0);
    PlayerTextDrawAlignment(playerid, p_tdToyView[playerid]{3}, 1);
    PlayerTextDrawColor(playerid, p_tdToyView[playerid]{3}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdToyView[playerid]{3}, 791621631);
    PlayerTextDrawBoxColor(playerid, p_tdToyView[playerid]{3}, 255);
    PlayerTextDrawUseBox(playerid, p_tdToyView[playerid]{3}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdToyView[playerid]{3}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdToyView[playerid]{3}, 1);
    PlayerTextDrawSetPreviewModel(playerid, p_tdToyView[playerid]{3}, 19482);
    PlayerTextDrawSetPreviewRot(playerid, p_tdToyView[playerid]{3}, -100.000000, -15.000000, -103.000000, 0.740000);
    PlayerTextDrawSetPreviewVehCol(playerid, p_tdToyView[playerid]{3}, 1, 1);

    p_tdToyView[playerid]{4} = CreatePlayerTextDraw(playerid, 368.000000, 115.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, p_tdToyView[playerid]{4}, 5);
    PlayerTextDrawLetterSize(playerid, p_tdToyView[playerid]{4}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdToyView[playerid]{4}, 38.000000, 44.500000);
    PlayerTextDrawSetOutline(playerid, p_tdToyView[playerid]{4}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdToyView[playerid]{4}, 0);
    PlayerTextDrawAlignment(playerid, p_tdToyView[playerid]{4}, 1);
    PlayerTextDrawColor(playerid, p_tdToyView[playerid]{4}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdToyView[playerid]{4}, 791621631);
    PlayerTextDrawBoxColor(playerid, p_tdToyView[playerid]{4}, 255);
    PlayerTextDrawUseBox(playerid, p_tdToyView[playerid]{4}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdToyView[playerid]{4}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdToyView[playerid]{4}, 1);
    PlayerTextDrawSetPreviewModel(playerid, p_tdToyView[playerid]{4}, 19482);
    PlayerTextDrawSetPreviewRot(playerid, p_tdToyView[playerid]{4}, -100.000000, -15.000000, -103.000000, 0.740000);
    PlayerTextDrawSetPreviewVehCol(playerid, p_tdToyView[playerid]{4}, 1, 1);

    p_tdToyView[playerid]{5} = CreatePlayerTextDraw(playerid, 368.000000, 167.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, p_tdToyView[playerid]{5}, 5);
    PlayerTextDrawLetterSize(playerid, p_tdToyView[playerid]{5}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdToyView[playerid]{5}, 38.000000, 44.500000);
    PlayerTextDrawSetOutline(playerid, p_tdToyView[playerid]{5}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdToyView[playerid]{5}, 0);
    PlayerTextDrawAlignment(playerid, p_tdToyView[playerid]{5}, 1);
    PlayerTextDrawColor(playerid, p_tdToyView[playerid]{5}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdToyView[playerid]{5}, 791621631);
    PlayerTextDrawBoxColor(playerid, p_tdToyView[playerid]{5}, 255);
    PlayerTextDrawUseBox(playerid, p_tdToyView[playerid]{5}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdToyView[playerid]{5}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdToyView[playerid]{5}, 1);
    PlayerTextDrawSetPreviewModel(playerid, p_tdToyView[playerid]{5}, 19482);
    PlayerTextDrawSetPreviewRot(playerid, p_tdToyView[playerid]{5}, -100.000000, -15.000000, -103.000000, 0.740000);
    PlayerTextDrawSetPreviewVehCol(playerid, p_tdToyView[playerid]{5}, 1, 1);

    // Inventory slots
    // 21 = 257 (count) - 336 (slot)
    new
        Float:slot_x = 223.000000,
        Float:slot_y = 336.000000,
        row, column
    ;  

    for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
        if (column >= 7)
        {
            column = 0;
            slot_x = 223.000000;
            ++row;
        }

        p_tdItemView[playerid]{i} = CreatePlayerTextDraw(playerid, slot_x + (27.0 * column), slot_y - (33.0 * row), "Preview_Model");
        PlayerTextDrawFont(playerid, p_tdItemView[playerid]{i}, 5);
        PlayerTextDrawLetterSize(playerid, p_tdItemView[playerid]{i}, 0.600000, 2.000000);
        PlayerTextDrawTextSize(playerid, p_tdItemView[playerid]{i}, 24.500000, 30.000000);
        PlayerTextDrawSetOutline(playerid, p_tdItemView[playerid]{i}, 0);
        PlayerTextDrawSetShadow(playerid, p_tdItemView[playerid]{i}, 0);
        PlayerTextDrawAlignment(playerid, p_tdItemView[playerid]{i}, 1);
        PlayerTextDrawColor(playerid, p_tdItemView[playerid]{i}, -1);
        PlayerTextDrawBackgroundColor(playerid, p_tdItemView[playerid]{i}, 791621631);
        PlayerTextDrawBoxColor(playerid, p_tdItemView[playerid]{i}, 255);
        PlayerTextDrawUseBox(playerid, p_tdItemView[playerid]{i}, 0);
        PlayerTextDrawSetProportional(playerid, p_tdItemView[playerid]{i}, 1);
        PlayerTextDrawSetSelectable(playerid, p_tdItemView[playerid]{i}, 1);
        PlayerTextDrawSetPreviewModel(playerid, p_tdItemView[playerid]{i}, 19482);
        PlayerTextDrawSetPreviewRot(playerid, p_tdItemView[playerid]{i}, 2.000000, 0.000000, -34.000000, 0.740000);
        PlayerTextDrawSetPreviewVehCol(playerid, p_tdItemView[playerid]{i}, 1, 1);

        p_tdItemCount[playerid]{i} = CreatePlayerTextDraw(playerid, slot_x + (27.0 * column), (slot_y + 21.0) - (33.0 * row), "_");
        PlayerTextDrawFont(playerid, p_tdItemCount[playerid]{i}, 1);
        PlayerTextDrawLetterSize(playerid, p_tdItemCount[playerid]{i}, 0.170833, 0.949998);
        PlayerTextDrawTextSize(playerid, p_tdItemCount[playerid]{i}, 400.000000, 17.000000);
        PlayerTextDrawSetOutline(playerid, p_tdItemCount[playerid]{i}, 0);
        PlayerTextDrawSetShadow(playerid, p_tdItemCount[playerid]{i}, 0);
        PlayerTextDrawAlignment(playerid, p_tdItemCount[playerid]{i}, 1);
        PlayerTextDrawColor(playerid, p_tdItemCount[playerid]{i}, -1);
        PlayerTextDrawBackgroundColor(playerid, p_tdItemCount[playerid]{i}, 255);
        PlayerTextDrawBoxColor(playerid, p_tdItemCount[playerid]{i}, 50);
        PlayerTextDrawUseBox(playerid, p_tdItemCount[playerid]{i}, 0);
        PlayerTextDrawSetProportional(playerid, p_tdItemCount[playerid]{i}, 1);
        PlayerTextDrawSetSelectable(playerid, p_tdItemCount[playerid]{i}, 0);

        ++column;
    }

    // Secondary slots
    row = 0;
    column = 0;
    slot_x = 223.000000;
    slot_y = 220.000000;

    for(new i; i < 14; ++i)
	{
        if (column >= 7)
        {
            column = 0;
            slot_x = 223.000000;
            ++row;
        }

        p_tdTrunkItemView[playerid]{i} = CreatePlayerTextDraw(playerid, slot_x + (27.0 * column), slot_y - (33.0 * row), "Preview_Model");
        PlayerTextDrawFont(playerid, p_tdTrunkItemView[playerid]{i}, 5);
        PlayerTextDrawLetterSize(playerid, p_tdTrunkItemView[playerid]{i}, 0.600000, 2.000000);
        PlayerTextDrawTextSize(playerid, p_tdTrunkItemView[playerid]{i}, 24.500000, 30.000000);
        PlayerTextDrawSetOutline(playerid, p_tdTrunkItemView[playerid]{i}, 0);
        PlayerTextDrawSetShadow(playerid, p_tdTrunkItemView[playerid]{i}, 0);
        PlayerTextDrawAlignment(playerid, p_tdTrunkItemView[playerid]{i}, 1);
        PlayerTextDrawColor(playerid, p_tdTrunkItemView[playerid]{i}, -1);
        PlayerTextDrawBackgroundColor(playerid, p_tdTrunkItemView[playerid]{i}, 791621631);
        PlayerTextDrawBoxColor(playerid, p_tdTrunkItemView[playerid]{i}, 255);
        PlayerTextDrawUseBox(playerid, p_tdTrunkItemView[playerid]{i}, 0);
        PlayerTextDrawSetProportional(playerid, p_tdTrunkItemView[playerid]{i}, 1);
        PlayerTextDrawSetSelectable(playerid, p_tdTrunkItemView[playerid]{i}, 1);
        PlayerTextDrawSetPreviewModel(playerid, p_tdTrunkItemView[playerid]{i}, 19482);
        PlayerTextDrawSetPreviewRot(playerid, p_tdTrunkItemView[playerid]{i}, 2.000000, 0.000000, -34.000000, 0.740000);
        PlayerTextDrawSetPreviewVehCol(playerid, p_tdTrunkItemView[playerid]{i}, 1, 1);

        p_tdTrunkItemCount[playerid]{i} = CreatePlayerTextDraw(playerid, slot_x + (27.0 * column), (slot_y + 21.0) - (33.0 * row), "_");
        PlayerTextDrawFont(playerid, p_tdTrunkItemCount[playerid]{i}, 1);
        PlayerTextDrawLetterSize(playerid, p_tdTrunkItemCount[playerid]{i}, 0.170833, 0.949998);
        PlayerTextDrawTextSize(playerid, p_tdTrunkItemCount[playerid]{i}, 400.000000, 17.000000);
        PlayerTextDrawSetOutline(playerid, p_tdTrunkItemCount[playerid]{i}, 0);
        PlayerTextDrawSetShadow(playerid, p_tdTrunkItemCount[playerid]{i}, 0);
        PlayerTextDrawAlignment(playerid, p_tdTrunkItemCount[playerid]{i}, 1);
        PlayerTextDrawColor(playerid, p_tdTrunkItemCount[playerid]{i}, -1);
        PlayerTextDrawBackgroundColor(playerid, p_tdTrunkItemCount[playerid]{i}, 255);
        PlayerTextDrawBoxColor(playerid, p_tdTrunkItemCount[playerid]{i}, 50);
        PlayerTextDrawUseBox(playerid, p_tdTrunkItemCount[playerid]{i}, 0);
        PlayerTextDrawSetProportional(playerid, p_tdTrunkItemCount[playerid]{i}, 1);
        PlayerTextDrawSetSelectable(playerid, p_tdTrunkItemCount[playerid]{i}, 0);

        ++column;
    }

    p_tdLevelingBar[playerid]{0} = CreatePlayerTextDraw(playerid, 230.500000, 16.500000, !"20");
    PlayerTextDrawFont(playerid, p_tdLevelingBar[playerid]{0}, 3);
    PlayerTextDrawLetterSize(playerid, p_tdLevelingBar[playerid]{0}, 0.233333, 1.250000);
    PlayerTextDrawTextSize(playerid, p_tdLevelingBar[playerid]{0}, 402.000000, 14.500000);
    PlayerTextDrawSetOutline(playerid, p_tdLevelingBar[playerid]{0}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdLevelingBar[playerid]{0}, 1);
    PlayerTextDrawAlignment(playerid, p_tdLevelingBar[playerid]{0}, 3);
    PlayerTextDrawColor(playerid, p_tdLevelingBar[playerid]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdLevelingBar[playerid]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdLevelingBar[playerid]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdLevelingBar[playerid]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdLevelingBar[playerid]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdLevelingBar[playerid]{0}, 0);

    p_tdLevelingBar[playerid]{1} = CreatePlayerTextDraw(playerid, 403.000000, 16.500000, !"21");
    PlayerTextDrawFont(playerid, p_tdLevelingBar[playerid]{1}, 3);
    PlayerTextDrawLetterSize(playerid, p_tdLevelingBar[playerid]{1}, 0.233333, 1.250000);
    PlayerTextDrawTextSize(playerid, p_tdLevelingBar[playerid]{1}, 402.000000, 14.500000);
    PlayerTextDrawSetOutline(playerid, p_tdLevelingBar[playerid]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdLevelingBar[playerid]{1}, 1);
    PlayerTextDrawAlignment(playerid, p_tdLevelingBar[playerid]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdLevelingBar[playerid]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdLevelingBar[playerid]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdLevelingBar[playerid]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdLevelingBar[playerid]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdLevelingBar[playerid]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdLevelingBar[playerid]{1}, 0);

    // Items options
    p_tdItemOptions[playerid]{0} = CreatePlayerTextDraw(playerid, 394.000000, 379.000000, "TIRAR");
	PlayerTextDrawFont(playerid, p_tdItemOptions[playerid]{0}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdItemOptions[playerid]{0}, 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, p_tdItemOptions[playerid]{0}, 8.500000, 40.500000);
	PlayerTextDrawSetOutline(playerid, p_tdItemOptions[playerid]{0}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdItemOptions[playerid]{0}, 0);
	PlayerTextDrawAlignment(playerid, p_tdItemOptions[playerid]{0}, 2);
	PlayerTextDrawColor(playerid, p_tdItemOptions[playerid]{0}, -1);
	PlayerTextDrawBackgroundColor(playerid, p_tdItemOptions[playerid]{0}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{0}, 454761471);
	PlayerTextDrawUseBox(playerid, p_tdItemOptions[playerid]{0}, 1);
	PlayerTextDrawSetProportional(playerid, p_tdItemOptions[playerid]{0}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdItemOptions[playerid]{0}, 1);

	p_tdItemOptions[playerid]{1} = CreatePlayerTextDraw(playerid, 346.000000, 379.000000, "USAR");
	PlayerTextDrawFont(playerid, p_tdItemOptions[playerid]{1}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdItemOptions[playerid]{1}, 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, p_tdItemOptions[playerid]{1}, 8.500000, 40.000000);
	PlayerTextDrawSetOutline(playerid, p_tdItemOptions[playerid]{1}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdItemOptions[playerid]{1}, 0);
	PlayerTextDrawAlignment(playerid, p_tdItemOptions[playerid]{1}, 2);
	PlayerTextDrawColor(playerid, p_tdItemOptions[playerid]{1}, -1);
	PlayerTextDrawBackgroundColor(playerid, p_tdItemOptions[playerid]{1}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{1}, 454761471);
	PlayerTextDrawUseBox(playerid, p_tdItemOptions[playerid]{1}, 1);
	PlayerTextDrawSetProportional(playerid, p_tdItemOptions[playerid]{1}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdItemOptions[playerid]{1}, 1);

	p_tdItemOptions[playerid]{2} = CreatePlayerTextDraw(playerid, 370.000000, 400.000000, "9999");
	PlayerTextDrawFont(playerid, p_tdItemOptions[playerid]{2}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdItemOptions[playerid]{2}, 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, p_tdItemOptions[playerid]{2}, 8.500000, 54.000000);
	PlayerTextDrawSetOutline(playerid, p_tdItemOptions[playerid]{2}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdItemOptions[playerid]{2}, 0);
	PlayerTextDrawAlignment(playerid, p_tdItemOptions[playerid]{2}, 2);
	PlayerTextDrawColor(playerid, p_tdItemOptions[playerid]{2}, -1);
	PlayerTextDrawBackgroundColor(playerid, p_tdItemOptions[playerid]{2}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{2}, 454761471);
	PlayerTextDrawUseBox(playerid, p_tdItemOptions[playerid]{2}, 1);
	PlayerTextDrawSetProportional(playerid, p_tdItemOptions[playerid]{2}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdItemOptions[playerid]{2}, 0);

	p_tdItemOptions[playerid]{3} = CreatePlayerTextDraw(playerid, 331.000000, 400.000000, "-");
	PlayerTextDrawFont(playerid, p_tdItemOptions[playerid]{3}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdItemOptions[playerid]{3}, 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, p_tdItemOptions[playerid]{3}, 400.000000, 10.500000);
	PlayerTextDrawSetOutline(playerid, p_tdItemOptions[playerid]{3}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdItemOptions[playerid]{3}, 0);
	PlayerTextDrawAlignment(playerid, p_tdItemOptions[playerid]{3}, 2);
	PlayerTextDrawColor(playerid, p_tdItemOptions[playerid]{3}, -1);
	PlayerTextDrawBackgroundColor(playerid, p_tdItemOptions[playerid]{3}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{3}, 454761471);
	PlayerTextDrawUseBox(playerid, p_tdItemOptions[playerid]{3}, 1);
	PlayerTextDrawSetProportional(playerid, p_tdItemOptions[playerid]{3}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdItemOptions[playerid]{3}, 1);

	p_tdItemOptions[playerid]{4} = CreatePlayerTextDraw(playerid, 409.000000, 400.000000, "+");
	PlayerTextDrawFont(playerid, p_tdItemOptions[playerid]{4}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdItemOptions[playerid]{4}, 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, p_tdItemOptions[playerid]{4}, 400.000000, 10.500000);
	PlayerTextDrawSetOutline(playerid, p_tdItemOptions[playerid]{4}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdItemOptions[playerid]{4}, 0);
	PlayerTextDrawAlignment(playerid, p_tdItemOptions[playerid]{4}, 2);
	PlayerTextDrawColor(playerid, p_tdItemOptions[playerid]{4}, -1);
	PlayerTextDrawBackgroundColor(playerid, p_tdItemOptions[playerid]{4}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{4}, 454761471);
	PlayerTextDrawUseBox(playerid, p_tdItemOptions[playerid]{4}, 1);
	PlayerTextDrawSetProportional(playerid, p_tdItemOptions[playerid]{4}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdItemOptions[playerid]{4}, 1);

    p_tdItemOptions[playerid]{5} = CreatePlayerTextDraw(playerid, 268.000000, 379.000000, "Kit de reparacion ~h~~p~(LEGENDARIO)");
	PlayerTextDrawFont(playerid, p_tdItemOptions[playerid]{5}, 1);
	PlayerTextDrawLetterSize(playerid, p_tdItemOptions[playerid]{5}, 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, p_tdItemOptions[playerid]{5}, 246.500000, 99.500000);
	PlayerTextDrawSetOutline(playerid, p_tdItemOptions[playerid]{5}, 0);
	PlayerTextDrawSetShadow(playerid, p_tdItemOptions[playerid]{5}, 0);
	PlayerTextDrawAlignment(playerid, p_tdItemOptions[playerid]{5}, 2);
	PlayerTextDrawColor(playerid, p_tdItemOptions[playerid]{5}, -1);
	PlayerTextDrawBackgroundColor(playerid, p_tdItemOptions[playerid]{5}, 255);
	PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{5}, 454761471);
	PlayerTextDrawUseBox(playerid, p_tdItemOptions[playerid]{5}, 1);
	PlayerTextDrawSetProportional(playerid, p_tdItemOptions[playerid]{5}, 1);
	PlayerTextDrawSetSelectable(playerid, p_tdItemOptions[playerid]{5}, 1);

    p_tdGangMemberSlots[playerid][0]{0} = CreatePlayerTextDraw(playerid, 255.000000, 133.000000, "~r~.");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][0]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][0]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][0]{0}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][0]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][0]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][0]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][0]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][0]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][0]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][0]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][0]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][0]{0}, 0);

    p_tdGangMemberSlots[playerid][0]{1} = CreatePlayerTextDraw(playerid, 263.000000, 140.000000, "Ra_Cist");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][0]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][0]{1}, 0.220833, 1.149999);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][0]{1}, 436.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][0]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][0]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][0]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][0]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][0]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][0]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][0]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][0]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][0]{1}, 1);

    p_tdGangMemberSlots[playerid][0]{2} = CreatePlayerTextDraw(playerid, 263.000000, 151.000000, "EL GORDO SUPREMO");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][0]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][0]{2}, 0.150000, 0.800000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][0]{2}, 440.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][0]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][0]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][0]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][0]{2}, -993737473);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][0]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][0]{2}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][0]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][0]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][0]{2}, 0);

    p_tdGangMemberSlots[playerid][1]{0} = CreatePlayerTextDraw(playerid, 255.000000, 162.000000, "~r~.");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][1]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][1]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][1]{0}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][1]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][1]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][1]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][1]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][1]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][1]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][1]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][1]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][1]{0}, 0);

    p_tdGangMemberSlots[playerid][1]{1} = CreatePlayerTextDraw(playerid, 263.000000, 168.000000, "Ra_Cist");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][1]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][1]{1}, 0.220833, 1.149999);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][1]{1}, 436.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][1]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][1]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][1]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][1]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][1]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][1]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][1]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][1]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][1]{1}, 1);

    p_tdGangMemberSlots[playerid][1]{2} = CreatePlayerTextDraw(playerid, 263.000000, 179.000000, "EL GORDO SUPREMO");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][1]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][1]{2}, 0.150000, 0.800000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][1]{2}, 440.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][1]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][1]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][1]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][1]{2}, -993737473);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][1]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][1]{2}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][1]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][1]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][1]{2}, 0);

    p_tdGangMemberSlots[playerid][2]{0} = CreatePlayerTextDraw(playerid, 255.000000, 189.000000, "~r~.");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][2]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][2]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][2]{0}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][2]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][2]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][2]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][2]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][2]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][2]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][2]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][2]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][2]{0}, 0);

    p_tdGangMemberSlots[playerid][2]{1} = CreatePlayerTextDraw(playerid, 263.000000, 196.000000, "Ra_Cist");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][2]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][2]{1}, 0.220833, 1.149999);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][2]{1}, 436.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][2]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][2]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][2]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][2]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][2]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][2]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][2]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][2]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][2]{1}, 1);

    p_tdGangMemberSlots[playerid][2]{2} = CreatePlayerTextDraw(playerid, 263.000000, 207.000000, "EL GORDO SUPREMO");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][2]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][2]{2}, 0.150000, 0.800000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][2]{2}, 440.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][2]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][2]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][2]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][2]{2}, -993737473);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][2]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][2]{2}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][2]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][2]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][2]{2}, 0);

    p_tdGangMemberSlots[playerid][3]{0} = CreatePlayerTextDraw(playerid, 255.000000, 217.000000, "~r~.");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][3]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][3]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][3]{0}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][3]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][3]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][3]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][3]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][3]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][3]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][3]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][3]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][3]{0}, 0);

    p_tdGangMemberSlots[playerid][3]{1} = CreatePlayerTextDraw(playerid, 263.000000, 224.000000, "Ra_Cist");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][3]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][3]{1}, 0.220833, 1.149999);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][3]{1}, 436.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][3]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][3]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][3]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][3]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][3]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][3]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][3]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][3]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][3]{1}, 1);

    p_tdGangMemberSlots[playerid][3]{2} = CreatePlayerTextDraw(playerid, 263.000000, 235.000000, "EL GORDO SUPREMO");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][3]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][3]{2}, 0.150000, 0.800000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][3]{2}, 440.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][3]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][3]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][3]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][3]{2}, -993737473);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][3]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][3]{2}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][3]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][3]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][3]{2}, 0);

    p_tdGangMemberSlots[playerid][4]{0} = CreatePlayerTextDraw(playerid, 255.000000, 245.000000, "~r~.");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][4]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][4]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][4]{0}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][4]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][4]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][4]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][4]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][4]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][4]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][4]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][4]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][4]{0}, 0);

    p_tdGangMemberSlots[playerid][4]{1} = CreatePlayerTextDraw(playerid, 263.000000, 252.000000, "Ra_Cist");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][4]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][4]{1}, 0.220833, 1.149999);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][4]{1}, 436.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][4]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][4]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][4]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][4]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][4]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][4]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][4]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][4]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][4]{1}, 1);

    p_tdGangMemberSlots[playerid][4]{2} = CreatePlayerTextDraw(playerid, 263.000000, 263.000000, "EL GORDO SUPREMO");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][4]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][4]{2}, 0.150000, 0.800000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][4]{2}, 440.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][4]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][4]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][4]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][4]{2}, -993737473);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][4]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][4]{2}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][4]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][4]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][4]{2}, 0);

    p_tdGangMemberSlots[playerid][5]{0} = CreatePlayerTextDraw(playerid, 255.000000, 273.000000, "~r~.");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][5]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][5]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][5]{0}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][5]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][5]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][5]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][5]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][5]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][5]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][5]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][5]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][5]{0}, 0);

    p_tdGangMemberSlots[playerid][5]{1} = CreatePlayerTextDraw(playerid, 263.000000, 280.000000, "Ra_Cist");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][5]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][5]{1}, 0.220833, 1.149999);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][5]{1}, 436.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][5]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][5]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][5]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][5]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][5]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][5]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][5]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][5]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][5]{1}, 1);

    p_tdGangMemberSlots[playerid][5]{2} = CreatePlayerTextDraw(playerid, 263.000000, 291.000000, "EL GORDO SUPREMO");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][5]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][5]{2}, 0.150000, 0.800000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][5]{2}, 440.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][5]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][5]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][5]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][5]{2}, -993737473);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][5]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][5]{2}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][5]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][5]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][5]{2}, 0);

    p_tdGangMemberSlots[playerid][6]{0} = CreatePlayerTextDraw(playerid, 255.000000, 301.000000, "~r~.");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][6]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][6]{0}, 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][6]{0}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][6]{0}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][6]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][6]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][6]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][6]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][6]{0}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][6]{0}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][6]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][6]{0}, 0);

    p_tdGangMemberSlots[playerid][6]{1} = CreatePlayerTextDraw(playerid, 263.000000, 308.000000, "Ra_Cist");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][6]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][6]{1}, 0.220833, 1.149999);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][6]{1}, 436.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][6]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][6]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][6]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][6]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][6]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][6]{1}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][6]{1}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][6]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][6]{1}, 1);

    p_tdGangMemberSlots[playerid][6]{2} = CreatePlayerTextDraw(playerid, 263.000000, 319.000000, "EL GORDO SUPREMO");
    PlayerTextDrawFont(playerid, p_tdGangMemberSlots[playerid][6]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdGangMemberSlots[playerid][6]{2}, 0.150000, 0.800000);
    PlayerTextDrawTextSize(playerid, p_tdGangMemberSlots[playerid][6]{2}, 440.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdGangMemberSlots[playerid][6]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdGangMemberSlots[playerid][6]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdGangMemberSlots[playerid][6]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdGangMemberSlots[playerid][6]{2}, -993737473);
    PlayerTextDrawBackgroundColor(playerid, p_tdGangMemberSlots[playerid][6]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdGangMemberSlots[playerid][6]{2}, 50);
    PlayerTextDrawUseBox(playerid, p_tdGangMemberSlots[playerid][6]{2}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdGangMemberSlots[playerid][6]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdGangMemberSlots[playerid][6]{2}, 0);

    // BEATING TEXT
    p_tdBeatingText{playerid} = CreatePlayerTextDraw(playerid, 319.000000, 369.000000, !"_");
    PlayerTextDrawFont(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdBeatingText{playerid}, 0.266667, 1.549999);
    PlayerTextDrawTextSize(playerid, p_tdBeatingText{playerid}, 417.500000, 178.000000);
    PlayerTextDrawSetOutline(playerid, p_tdBeatingText{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawAlignment(playerid, p_tdBeatingText{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdBeatingText{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdBeatingText{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdBeatingText{playerid}, 50);
    PlayerTextDrawUseBox(playerid, p_tdBeatingText{playerid}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdBeatingText{playerid}, 0);

    // Phone
    p_tdPhone[playerid]{0} = CreatePlayerTextDraw(playerid, 514.000000, 275.000000, "_"); // Option 1
    PlayerTextDrawFont(playerid, p_tdPhone[playerid]{0}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdPhone[playerid]{0}, 0.220833, 1.000000);
    PlayerTextDrawTextSize(playerid, p_tdPhone[playerid]{0}, 592.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdPhone[playerid]{0}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdPhone[playerid]{0}, 0);
    PlayerTextDrawAlignment(playerid, p_tdPhone[playerid]{0}, 1);
    PlayerTextDrawColor(playerid, p_tdPhone[playerid]{0}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdPhone[playerid]{0}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{0}, 0);
    PlayerTextDrawUseBox(playerid, p_tdPhone[playerid]{0}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdPhone[playerid]{0}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdPhone[playerid]{0}, 0);

    p_tdPhone[playerid]{1} = CreatePlayerTextDraw(playerid, 514.000000, 289.000000, "_"); // Option 2
    PlayerTextDrawFont(playerid, p_tdPhone[playerid]{1}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdPhone[playerid]{1}, 0.220833, 1.000000);
    PlayerTextDrawTextSize(playerid, p_tdPhone[playerid]{1}, 592.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdPhone[playerid]{1}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdPhone[playerid]{1}, 0);
    PlayerTextDrawAlignment(playerid, p_tdPhone[playerid]{1}, 1);
    PlayerTextDrawColor(playerid, p_tdPhone[playerid]{1}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdPhone[playerid]{1}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{1}, 0);
    PlayerTextDrawUseBox(playerid, p_tdPhone[playerid]{1}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdPhone[playerid]{1}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdPhone[playerid]{1}, 0);

    p_tdPhone[playerid]{2} = CreatePlayerTextDraw(playerid, 514.000000, 303.000000, "_"); // Option 3
    PlayerTextDrawFont(playerid, p_tdPhone[playerid]{2}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdPhone[playerid]{2}, 0.220833, 1.000000);
    PlayerTextDrawTextSize(playerid, p_tdPhone[playerid]{2}, 592.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdPhone[playerid]{2}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdPhone[playerid]{2}, 0);
    PlayerTextDrawAlignment(playerid, p_tdPhone[playerid]{2}, 1);
    PlayerTextDrawColor(playerid, p_tdPhone[playerid]{2}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdPhone[playerid]{2}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{2}, 0); // Selected (121)
    PlayerTextDrawUseBox(playerid, p_tdPhone[playerid]{2}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdPhone[playerid]{2}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdPhone[playerid]{2}, 0);

    p_tdPhone[playerid]{3} = CreatePlayerTextDraw(playerid, 514.000000, 317.000000, "_"); // Option 4
    PlayerTextDrawFont(playerid, p_tdPhone[playerid]{3}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdPhone[playerid]{3}, 0.220833, 1.000000);
    PlayerTextDrawTextSize(playerid, p_tdPhone[playerid]{3}, 592.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdPhone[playerid]{3}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdPhone[playerid]{3}, 0);
    PlayerTextDrawAlignment(playerid, p_tdPhone[playerid]{3}, 1);
    PlayerTextDrawColor(playerid, p_tdPhone[playerid]{3}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdPhone[playerid]{3}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{3}, 0);
    PlayerTextDrawUseBox(playerid, p_tdPhone[playerid]{3}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdPhone[playerid]{3}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdPhone[playerid]{3}, 0);

    p_tdPhone[playerid]{4} = CreatePlayerTextDraw(playerid, 514.000000, 331.000000, "_"); // Option 5
    PlayerTextDrawFont(playerid, p_tdPhone[playerid]{4}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdPhone[playerid]{4}, 0.220833, 1.000000);
    PlayerTextDrawTextSize(playerid, p_tdPhone[playerid]{4}, 592.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdPhone[playerid]{4}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdPhone[playerid]{4}, 0);
    PlayerTextDrawAlignment(playerid, p_tdPhone[playerid]{4}, 1);
    PlayerTextDrawColor(playerid, p_tdPhone[playerid]{4}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdPhone[playerid]{4}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{4}, 0);
    PlayerTextDrawUseBox(playerid, p_tdPhone[playerid]{4}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdPhone[playerid]{4}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdPhone[playerid]{4}, 0);

    p_tdPhone[playerid]{5} = CreatePlayerTextDraw(playerid, 514.000000, 345.000000, "_"); // Option 6
    PlayerTextDrawFont(playerid, p_tdPhone[playerid]{5}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdPhone[playerid]{5}, 0.220833, 1.000000);
    PlayerTextDrawTextSize(playerid, p_tdPhone[playerid]{5}, 592.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdPhone[playerid]{5}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdPhone[playerid]{5}, 0);
    PlayerTextDrawAlignment(playerid, p_tdPhone[playerid]{5}, 1);
    PlayerTextDrawColor(playerid, p_tdPhone[playerid]{5}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdPhone[playerid]{5}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{5}, 0);
    PlayerTextDrawUseBox(playerid, p_tdPhone[playerid]{5}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdPhone[playerid]{5}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdPhone[playerid]{5}, 0);

    #if defined TD_OnPlayerConnect
        return TD_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect TD_OnPlayerConnect
#if defined TD_OnPlayerConnect
    forward TD_OnPlayerConnect(playerid);
#endif
