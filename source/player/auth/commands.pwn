#if defined _auth_commands_
    #endinput
#endif
#define _auth_commands_

command password(playerid, const params[], "Cambiar contraseña")
{
    Dialog_ShowCallback(playerid, using public _hydg@change_password<iiiis>, DIALOG_STYLE_INPUT, "{CB3126}Hyaxe{DADADA} - Cambiar contraseña", "{DADADA}Ingrese una contraseña de entre 6 y 18 caracteres de longitud.", !"Cambiar", !"Cerrar");
    PlayerPlaySound(playerid, SOUND_BUTTON);
    return 1;
}
alias:password("clave", "contrasena", "pass", "contraseña")

dialog change_password(playerid, dialogid, response, listitem, inputtext[])
{
    if (!response)
        return 1;
        
    new pw_len = strlen(inputtext);
    if (!(6 <= pw_len <= 18))
    {
        PC_EmulateCommand(playerid, "/password");
        return 1;
    }

    strcpy(Player_Password(playerid), inputtext);

    inline const PasswordHashed()
    {
        argon_get_hash(Player_Password(playerid));

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            UPDATE `ACCOUNT` SET `PASSWORD` = '%e' WHERE `ID` = %i;\
        ", 
            Player_Password(playerid), Player_AccountID(playerid)
        );
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
        MemSet(g_rgePlayerData[playerid][e_szPassword], '\0');

        Notification_Show(playerid, "Has cambiado tu contraseña.", 4000, 0x64A752FF);
    }
    argon_hash_inline(Player_Password(playerid), 64000, 1, 1, using inline PasswordHashed);
    return 1;
}