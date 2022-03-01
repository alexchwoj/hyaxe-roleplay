#if defined _auth_callbacks_
    #endinput
#endif
#define _auth_callbacks_

public OnPlayerDataLoaded(playerid)
{
    DEBUG_PRINT("OnPlayerDataLoaded(%d)", playerid);

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

    return 1;
}

dialog register_sex(playerid, response, listitem, inputtext[])
{
    Player_Sex(playerid) = response;
    Player_Skin(playerid) = (response ? 250 : 192);

    Account_Register(playerid, __addressof(AccountRegistered));
    return 1;
}

// - Login

dialog login(playerid, response, listitem, inputtext[])
{
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

    Iter_Add(LoggedIn, playerid);

    if(Player_AdminLevel(playerid) > 0)
        Iter_Add(Admin, playerid);

    Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, false);
    Bit_Set(Player_Flags(playerid), PFLAG_IN_GAME, true);
    
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `CURRENT_CONNECTION` = UNIX_TIMESTAMP() WHERE `ID` = %d LIMIT 1;", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    Account_RegisterConnection(playerid);

    CallLocalFunction(!"OnPlayerAuthenticate", !"i", playerid);

    new text[128];
    format(text, sizeof(text), "Bienvenido a ~r~Hyaxe~w~, %s. Tu último inicio de sesión fue el ~r~%s~w~.", Player_Name(playerid), Player_LastConnection(playerid));
    Notification_Show(playerid, text, 6);

    return 1;
}