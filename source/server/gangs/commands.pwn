#if defined _gangs_commands_
    #endinput
#endif
#define _gangs_commands_

static 
    s_rgszGangCreationName[MAX_PLAYERS][64],
    s_rgiGangCreationIcon[MAX_PLAYERS char],
    s_rgiGangCreationColor[MAX_PLAYERS];

command banda(playerid, const params[], "Abre el panel de creación de una banda")
{
    if(Player_Level(playerid) < 2)
    {
        Dialog_Show(playerid, "", DIALOG_STYLE_MSGBOX, "{DADADA}Error - {CB3126}Creación de banda", "{DADADA}Necesitas ser al menos {CB3126}nivel 2{DADADA} para crear una banda.", "Entendido");
        return 1;
    }

    strcpy(s_rgszGangCreationName[playerid], "Mi banda");
    s_rgiGangCreationIcon{playerid} = 0;
    s_rgiGangCreationColor[playerid] = (math_random(0, 0xFFFFFF) << 8) | 0xFF;

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        {CB3126}>{DADADA} Nombre: Mi banda\n\
        {CB3126}>{DADADA} Icono: %s\n\
        {CB3126}>{DADADA} Color: #{%06x}%x\
        {CB3126}>{DADADA} Crear",
        g_rgszGangIcons[s_rgiGangCreationIcon{playerid}][0], s_rgiGangCreationColor[playerid] >>> 8
    );
    Dialog_Show(playerid, "gang_create", DIALOG_STYLE_LIST, "{DADADA}Crear una {CB3126}banda{DADADA}...", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Cancelar");

    return 1;
}

dialog gang_create(playerid, response, listitem, const inputtext[])
{
    return 1;
}