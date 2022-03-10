#if defined _auth_callbacks_
    #endinput
#endif
#define _auth_callbacks_

public OnPlayerDataLoaded(playerid)
{
    DEBUG_PRINT("OnPlayerDataLoaded(%d)", playerid);

    // Intro camera
    switch (random(6))
    {
		case 0:
		{
			InterpolateCameraPos(playerid, 155.601196, -1792.495605, 11.613841, 155.601196, -1792.495605, 11.613841, 6000);
            InterpolateCameraLookAt(playerid, 159.406951, -1794.349121, 14.274766, 159.338470, -1789.308227, 10.679175, 6000);
		}
		case 1: 
		{
            InterpolateCameraPos(playerid, 1229.691040, -1382.687744, 60.129634, 1229.691040, -1382.687744, 60.129634, 6000);
            InterpolateCameraLookAt(playerid, 1225.744873, -1384.168945, 62.819236, 1226.638183, -1379.644165, 57.596576, 6000);
		}
		case 2: 
		{
            InterpolateCameraPos(playerid, 2153.311035, -1309.602661, 36.734226, 2153.311035, -1309.602661, 36.734226, 6000);
            InterpolateCameraLookAt(playerid, 2155.732177, -1312.766967, 39.754898, 2157.684814, -1307.580200, 35.400230, 6000);
		}
		case 3: 
		{
            InterpolateCameraPos(playerid, 2023.361816, 1125.334472, 29.830821, 2023.361816, 1125.334472, 29.830821, 6000);
            InterpolateCameraLookAt(playerid, 2025.751708, 1121.992065, 32.679771, 2026.636230, 1129.055419, 29.172580, 6000);
		}
		case 4: 
		{
            InterpolateCameraPos(playerid, -64.515258, 1357.638549, 13.984993, -64.515258, 1357.638549, 13.984993, 6000);
            InterpolateCameraLookAt(playerid, -62.672924, 1361.461914, 16.628335, -68.500961, 1360.616577, 13.489713, 6000);
		}
		case 5: 
		{
            InterpolateCameraPos(playerid, -2611.593750, 754.044006, 66.853324, -2611.593750, 754.044006, 66.853324, 6000);
            InterpolateCameraLookAt(playerid, -2608.905029, 757.270751, 69.565940, -2614.431152, 758.083740, 66.059822, 6000);
		}
    }

    new song_link[144];
    format(song_link, sizeof(song_link), "https://github.com/RealAtom/hyaxe/raw/main/song/ost_intro%d.mp3", random(12));
    PlayAudioStreamForPlayer(playerid, song_link);

    if(!Bit_Get(Player_Flags(playerid), PFLAG_REGISTERED))
    {
        DEBUG_PRINT("Player is not registered");

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{E3E3E3}1. Contraseña\n\
            \t{5C5C5C}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese una contraseña de entre 6 y 18 caracteres de longitud.\
        ", Player_RPName(playerid));

        Dialog_Show(playerid, "register", DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
    }
    else
    {
        DEBUG_PRINT("Player is registered");

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta ya está registrada.\n\nContraseña:", Player_RPName(playerid));
        Dialog_Show(playerid, "login", DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Ingresa a tu cuenta", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
    }

    Chat_Clear(playerid);

    #if defined AUTH_OnPlayerDataLoaded
        return AUTH_OnPlayerDataLoaded(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDataLoaded
    #undef OnPlayerDataLoaded
#else
    #define _ALS_OnPlayerDataLoaded
#endif
#define OnPlayerDataLoaded AUTH_OnPlayerDataLoaded
#if defined AUTH_OnPlayerDataLoaded
    forward AUTH_OnPlayerDataLoaded(playerid);
#endif

dialog register(playerid, response, listitem, inputtext[])
{
    DEBUG_PRINT("Dialog: Register (%i, %i, %i, \"%s\")", playerid, response, listitem, inputtext);
    PlayerPlaySound(playerid, SOUND_BUTTON);

    if(!response)
    {
        DEBUG_PRINT("Kicking player");
        return Kick(playerid);
    }

    new pw_len = strlen(inputtext);
    if(NOT_IN_RANGE(pw_len, 6, 18))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{E3E3E3}1. Contraseña\n\
            \t{5C5C5C}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese una contraseña de entre 6 y 18 caracteres de longitud.\
        ", Player_RPName(playerid));
        Dialog_Show(playerid, "register", DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
        return 1;
    }

    strcpy(Player_Password(playerid), inputtext);
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
        \t{5C5C5C}1. Contraseña\n\
        \t{E3E3E3}2. Correo\n\
        \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
        Ingrese su dirección de correo electrónico.\nEsto le va a servir para poder recuperar su contraseña\nen caso que se la olvide.\
    ", Player_RPName(playerid));
    Dialog_Show(playerid, "register_email", DIALOG_STYLE_INPUT, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Atrás");

    return 1;
}

dialog register_email(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, SOUND_BUTTON);

    if(!response)
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{E3E3E3}1. Contraseña\n\
            \t{5C5C5C}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese una contraseña de entre 6 y 18 caracteres de longitud.\
        ", Player_RPName(playerid));
        Dialog_Show(playerid, "register", DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
        return 1;
    }

    if(isnull(inputtext))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{5C5C5C}1. Contraseña\n\
            \t{E3E3E3}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese su dirección de correo electrónico.\nEsto le va a servir para poder recuperar su contraseña\nen caso que se la olvide.\
        ", Player_RPName(playerid));
        Dialog_Show(playerid, "register_email", DIALOG_STYLE_INPUT, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Atrás");
        return 1;
    }

    strcpy(Player_Email(playerid), inputtext);
    
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
        \t{5C5C5C}1. Contraseña\n\
        \t{5C5C5C}2. Correo\n\
        \t{E3E3E3}3. Sexo del personaje{DADADA}\n\n\
        Este va a ser el sexo inicial de su personaje.\
    ", Player_RPName(playerid));
    Dialog_Show(playerid, "register_sex", DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Hombre", "Mujer");
    return 1;
}

static AccountRegistered(playerid)
{
    SetSpawnInfo(playerid, NO_TEAM, Player_Skin(playerid), g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ], g_rgePlayerData[playerid][e_fSpawnPosAngle], 0, 0, 0, 0, 0, 0);
    TogglePlayerSpectating(playerid, false);

    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, Player_Money(playerid));
    SetPlayerHealth(playerid, Player_Health(playerid));
    SetPlayerArmour(playerid, Player_Armor(playerid));
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SetCameraBehindPlayer(playerid);

    StopAudioStreamForPlayer(playerid);

    Iter_Add(LoggedIn, playerid);
    
    Notification_Show(playerid, "Felicidades, te has registrado correctamente.", 3000, 0x64A752FF);

    return 1;
}

dialog register_sex(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, SOUND_BUTTON);

    Player_Sex(playerid) = response;
    Player_Skin(playerid) = (response ? 250 : 192);

    Account_Register(playerid, __addressof(AccountRegistered));
    return 1;
}

// - Login

dialog login(playerid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, SOUND_BUTTON);
    
    if(!response)
        return Kick(playerid);

    new hash[65];
    SHA256_PassHash(inputtext, "", hash);

    DEBUG_PRINT("Login: Comparing hashes from %i", playerid);
    DEBUG_PRINT("Original: %s", Player_Password(playerid));
    DEBUG_PRINT("Input: %s", hash);

    if(strcmp(Player_Password(playerid), hash, .ignorecase = true))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}Contraseña {CB3126}incorrecta{DADADA}.\nIntroduce la contraseña correcta para entrar al servidor:", Player_RPName(playerid));
        Dialog_Show(playerid, "login", DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Ingresa a tu cuenta", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
        return 1;
    }

    Account_LoadFromCache(playerid);

    SetSpawnInfo(playerid, NO_TEAM, Player_Skin(playerid), g_rgePlayerData[playerid][e_fSpawnPosX], g_rgePlayerData[playerid][e_fSpawnPosY], g_rgePlayerData[playerid][e_fSpawnPosZ], g_rgePlayerData[playerid][e_fSpawnPosAngle], 0, 0, 0, 0, 0, 0);
    TogglePlayerSpectating(playerid, false);
    
    g_rgePlayerData[playerid][e_iCurrentConnectionTime] = gettime();
    SetPlayerVirtualWorld(playerid, Player_VirtualWorld(playerid));
    SetPlayerInterior(playerid, Player_Interior(playerid));
    SetPlayerHealth(playerid, Player_Health(playerid));
    SetPlayerArmour(playerid, Player_Armor(playerid));
    GivePlayerMoney(playerid, Player_Money(playerid));
    Player_GiveAllWeapons(playerid);
    SetPlayerArmedWeapon(playerid, 0);
    
    Iter_Add(LoggedIn, playerid);

    if (Player_AdminLevel(playerid) > 0)
        Iter_Add(Admin, playerid);

    Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, false);
    Bit_Set(Player_Flags(playerid), PFLAG_IN_GAME, true);
    
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `CURRENT_PLAYERID` = '%i', `CURRENT_CONNECTION` = UNIX_TIMESTAMP() WHERE `ID` = %d LIMIT 1;", playerid, Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    Account_RegisterConnection(playerid);

    CallLocalFunction(!"OnPlayerAuthenticate", !"i", playerid);

    new text[128];
    format(text, sizeof(text), "Bienvenido a ~r~Hyaxe~w~, %s. Tu último inicio de sesión fue el ~r~%s~w~.", Player_Name(playerid), Player_LastConnection(playerid));
    Notification_Show(playerid, text, 6000);

    StopAudioStreamForPlayer(playerid);

    return 1;
}