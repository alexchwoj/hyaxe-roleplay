#if defined _auth_callbacks_
    #endinput
#endif
#define _auth_callbacks_

public OnPlayerDataLoaded(playerid)
{
    DEBUG_PRINT("[func] OnPlayerDataLoaded(playerid = %i)", playerid);

    SetPlayerVirtualWorld(playerid, 1337);

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

    new song_link[65];

    new year, month, day;
    getdate(year, month, day);

    if (month == 10 && day >= 14) // Halloween
    {
        format(song_link, sizeof(song_link), "https://samp.hyaxe.com/static/audio/halloween_%d.mp3", random(4));
    }
    else if ( (month == 11 && day >= 27) || (month == 12 && day >= 1) ) // Christmas
    {
        format(song_link, sizeof(song_link), "https://samp.hyaxe.com/static/audio/christmas_%d.mp3", random(3));
    }
    else if (month == 3 && day >= 13 && day <= 17) // Hyaxe's Birthday
    {
        format(song_link, sizeof(song_link), "https://samp.hyaxe.com/static/audio/happy_birthday.mp3");
    }
    else // Normal
        format(song_link, sizeof(song_link), "https://samp.hyaxe.com/static/audio/ost_intro%d.mp3", random(12));

    PlayAudioStreamForPlayer(playerid, song_link);

    if (!Bit_Get(Player_Flags(playerid), PFLAG_REGISTERED))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{E3E3E3}1. Contraseña\n\
            \t{5C5C5C}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese una contraseña de entre 6 y 18 caracteres de longitud.\
        ", Player_RPName(playerid));

        Dialog_ShowCallback(playerid, using public _hydg@register<iiiis>, DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
    }
    else
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta ya está registrada.\n\nContraseña:", Player_RPName(playerid));
        Dialog_ShowCallback(playerid, using public _hydg@login<iiiis>, DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Ingresa a tu cuenta", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
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

dialog register(playerid, dialogid, response, listitem, inputtext[])
{
    DEBUG_PRINT("Dialog: Register (%i, %i, %i, \"%s\")", playerid, response, listitem, inputtext);
    PlayerPlaySound(playerid, SOUND_BUTTON);

    if (!response)
    {
        DEBUG_PRINT("Kicking player");
        return Kick(playerid);
    }

    new pw_len = strlen(inputtext);
    if (!(6 <= pw_len <= 18))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{E3E3E3}1. Contraseña\n\
            \t{5C5C5C}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese una contraseña de entre 6 y 18 caracteres de longitud.\
        ", Player_RPName(playerid));
        Dialog_ShowCallback(playerid, using public _hydg@register<iiiis>, DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
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
    Dialog_ShowCallback(playerid, using public _hydg@register_email<iiiis>, DIALOG_STYLE_INPUT, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Atrás");

    return 1;
}

dialog register_email(playerid, dialogid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, SOUND_BUTTON);

    if (!response)
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{E3E3E3}1. Contraseña\n\
            \t{5C5C5C}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese una contraseña de entre 6 y 18 caracteres de longitud.\
        ", Player_RPName(playerid));
        Dialog_ShowCallback(playerid, using public _hydg@register<iiiis>, DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
        return 1;
    }

    if (isnull(inputtext))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{5C5C5C}1. Contraseña\n\
            \t{E3E3E3}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese su dirección de correo electrónico.\nEsto le va a servir para poder recuperar su contraseña\nen caso que se la olvide.\
        ", Player_RPName(playerid));
        Dialog_ShowCallback(playerid, using public _hydg@register_email<iiiis>, DIALOG_STYLE_INPUT, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Atrás");
        return 1;
    }

    if (!IsValidEmailAddress(inputtext))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{5C5C5C}1. Contraseña\n\
            \t{E3E3E3}2. Correo\n\
            \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
            Ingrese su dirección de correo electrónico válida.\
        ", Player_RPName(playerid));
        Dialog_ShowCallback(playerid, using public _hydg@register_email<iiiis>, DIALOG_STYLE_INPUT, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Atrás");
        return 1;
    }

    strcpy(Player_Email(playerid), inputtext);
    
    inline const QueryDone()
    {
        new exists;
        cache_get_value_index_int(0, 0, exists);
        if (exists)
        {
            Player_Email(playerid)[0] = '\0';
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
                \t{5C5C5C}1. Contraseña\n\
                \t{E3E3E3}2. Correo\n\
                \t{5C5C5C}3. Sexo del personaje{DADADA}\n\n\
                Ya hay una cuenta registrada con ese correo.\
            ", Player_RPName(playerid));
            Dialog_ShowCallback(playerid, using public _hydg@register_email<iiiis>, DIALOG_STYLE_INPUT, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Atrás");
            return 1;
        }

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Hola, {CB3126}%s{DADADA}. Esta cuenta no está registrada.\n\n\
            \t{5C5C5C}1. Contraseña\n\
            \t{5C5C5C}2. Correo\n\
            \t{E3E3E3}3. Sexo del personaje{DADADA}\n\n\
            Este va a ser el sexo inicial de su personaje.\
        ", Player_RPName(playerid));
        Dialog_ShowCallback(playerid, using public _hydg@register_sex<iiiis>, DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe{DADADA} - Registrar una cuenta nueva", HYAXE_UNSAFE_HUGE_STRING, "Hombre", "Mujer");
        return 1;
    }
    MySQL_TQueryInline(g_hDatabase, using inline QueryDone, "SELECT EXISTS(SELECT * FROM `ACCOUNT` WHERE `EMAIL` = '%e');", inputtext);

    return 1;
}

static AccountRegistered(playerid)
{
    SetSpawnInfo(playerid, NO_TEAM, Player_Skin(playerid), g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ], g_rgePlayerData[playerid][e_fPosAngle], 0, 0, 0, 0, 0, 0);
    Streamer_UpdateEx(playerid, g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ], 0, 0, .compensatedtime = 2000, .freezeplayer = 1);
    TogglePlayerSpectating(playerid, false);

    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, Player_Money(playerid));

    Player_SetHealth(playerid, Player_Health(playerid));
    Player_SetArmor(playerid, Player_Armor(playerid));

    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SetCameraBehindPlayer(playerid);

    SetPlayerScore(playerid, 1);
    StopAudioStreamForPlayer(playerid);

    Iter_Add(LoggedIn, playerid);
    
    Notification_Show(playerid, "Felicidades, te has registrado correctamente.", 3000, 0x64A752FF);

    Needs_ShowBars(playerid);
    Needs_StartUpdating(playerid);
    
    Player_Bonus(playerid) = false;
    SendClientMessage(playerid, 0xDAA838FF, "[Bonus] › {DADADA} ¡Una nueva bonificación está disponible!");
    SendClientMessage(playerid, 0xDAA838FF, "[Bonus] › {DADADA} Utilice el comando {DAA838}/bonus{DADADA} para recibirlo");
    return 1;
}

dialog register_sex(playerid, dialogid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, SOUND_BUTTON);

    Player_Sex(playerid) = response;
    Player_Skin(playerid) = (response ? 250 : 192);

    Account_Register(playerid, __addressof(AccountRegistered));
    return 1;
}

// - Login

dialog login(playerid, dialogid, response, listitem, inputtext[])
{
    PlayerPlaySound(playerid, SOUND_BUTTON);
    
    if (!response)
        return Kick(playerid);

    argon_check(inputtext, Player_Password(playerid), "AUTH_PasswordCheckDone", "i", playerid);

    return 1;
}

forward AUTH_PasswordCheckDone(playerid);
public AUTH_PasswordCheckDone(playerid)
{
    if (!argon_is_equal())
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}Contraseña {CB3126}incorrecta{DADADA}.\nIntroduce la contraseña correcta para entrar al servidor:", Player_RPName(playerid));
        Dialog_ShowCallback(playerid, using public _hydg@login<iiiis>, DIALOG_STYLE_PASSWORD, "{CB3126}Hyaxe{DADADA} - Ingresa a tu cuenta", HYAXE_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
        return 1;
    }

    Account_LoadFromCache(playerid);

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `CURRENT_PLAYERID` = %i, `CURRENT_CONNECTION` = UNIX_TIMESTAMP()", playerid);
    if (Player_VIP(playerid) == -1)
    {
        Player_VIP(playerid) = 0;
        strcat(HYAXE_UNSAFE_HUGE_STRING, ", `VIP_LEVEL` = 0, `VIP_EXPIRACY` = NULL", HYAXE_UNSAFE_HUGE_LENGTH);
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "%s WHERE `ID` = %i;", HYAXE_UNSAFE_HUGE_STRING, Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    Account_RegisterConnection(playerid);

    new text[116];
    format(text, sizeof(text), "Bienvenid%c a ~r~Hyaxe~w~, %s. Tu último inicio de sesión fue el ~r~%s~w~.", (Player_Sex(playerid) == SEX_MALE ? 'o' : 'a'), Player_Name(playerid), Player_LastConnection(playerid));
    Notification_Show(playerid, text, 6000);
    g_rgePlayerData[playerid][e_iCurrentConnectionTime] = gettime();

    CallLocalFunction(!"OnPlayerAuthenticate", !"i", playerid);
    
    if (Player_Health(playerid) == 0)
    {
        Player_SetArmor(playerid, 0);
        Player_SetHealth(playerid, 4);
        Player_GoToTheNearestHospital(playerid);
    }
    else
    {
        SetPlayerVirtualWorld(playerid, Player_VirtualWorld(playerid));
        SetPlayerInterior(playerid, Player_Interior(playerid));

        SetSpawnInfo(playerid, NO_TEAM, Player_Skin(playerid), g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ], g_rgePlayerData[playerid][e_fPosAngle], 0, 0, 0, 0, 0, 0);
        Streamer_UpdateEx(playerid, g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ], Player_VirtualWorld(playerid), Player_Interior(playerid), .compensatedtime = 2000, .freezeplayer = 1);
        TogglePlayerSpectating(playerid, false);

        Player_SetHealth(playerid, Player_Health(playerid));
        Player_SetArmor(playerid, Player_Armor(playerid));
    }

    GivePlayerMoney(playerid, Player_Money(playerid));
    Player_GiveAllWeapons(playerid);
    SetPlayerArmedWeapon(playerid, 0);
    
    SetPlayerScore(playerid, Player_Level(playerid));
    Iter_Add(LoggedIn, playerid);

    if (Player_AdminLevel(playerid) > 0)
        Iter_Add(Admin, playerid);

    Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, false);
    Bit_Set(Player_Flags(playerid), PFLAG_IN_GAME, true);
    printf("PFLAG_IN_GAME = true");

    Needs_ShowBars(playerid);
    Needs_StartUpdating(playerid);

    StopAudioStreamForPlayer(playerid);

    Player_SetImmunityForCheat(playerid, CHEAT_FLY, 3000);
    Player_SetImmunityForCheat(playerid, CHEAT_AIRBREAK, 3000);

    if (!Player_Bonus(playerid))
    {
        SendClientMessage(playerid, 0xDAA838FF, "[Bonus] › {DADADA} ¡Una nueva bonificación está disponible!");
        SendClientMessage(playerid, 0xDAA838FF, "[Bonus] › {DADADA} Utilice el comando {DAA838}/bonus{DADADA} para recibirlo");
    }

    if (Player_IsAndroid(playerid))
        Notification_Show(playerid, "~w~Hemos detectado que estás jugando desde Android, por favor, activa el soporte de android desde ~g~/config~w~ para una mejor experiencia.", 10000, 0x64A752FF);
    
    Player_SyncTime(playerid);
    return 1;
}