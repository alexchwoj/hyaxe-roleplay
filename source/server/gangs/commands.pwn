#if defined _gangs_commands_
    #endinput
#endif
#define _gangs_commands_

static 
    s_rgszGangCreationName[MAX_PLAYERS][64],
    s_rgiGangCreationIcon[MAX_PLAYERS char],
    s_rgiGangCreationColor[MAX_PLAYERS];

static GangCreation_ShowDialog(playerid)
{
    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        {CB3126}>{DADADA} Nombre: %s\n\
        {CB3126}>{DADADA} Icono: %s\n\
        {CB3126}>{DADADA} Color: #{%06x}%x\
        {CB3126}>{DADADA} Crear",
        s_rgszGangCreationName[playerid], g_rgszGangIcons[s_rgiGangCreationIcon{playerid}][0], s_rgiGangCreationColor[playerid] >>> 8
    );
    Dialog_Show(playerid, "gang_create", DIALOG_STYLE_LIST, "{DADADA}Crear una {CB3126}banda{DADADA}...", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Cancelar");
    return 1;
}

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

    GangCreation_ShowDialog(playerid);

    return 1;
}

dialog gang_create(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        s_rgszGangCreationName[playerid][0] = '\0';
        s_rgiGangCreationIcon{playerid} = 0;
        return 1;
    }

    switch(listitem)
    {
        case 0:
        {
            Dialog_Show(playerid, "gang_creation_name", DIALOG_STYLE_INPUT, 
                "{CB3126}>{DADADA} Nombre de tu nueva {CB3126}banda{DADADA}",
                    "{DADADA}Introduce el nombre de tu nueva banda. Tiene que tener entre {CB3126}1{DADADA} y {CB3126}32{DADADA} caracteres.",
                "Siguiente", "Atrás"
            );
        }
        case 1:
        {
            HYAXE_UNSAFE_HUGE_STRING[0] = '\0';

            for(new i = 0; i < sizeof(g_rgszGangIcons); ++i)
            {
                strcat(HYAXE_UNSAFE_HUGE_STRING, g_rgszGangIcons[i][0]);
                strcat(HYAXE_UNSAFE_HUGE_STRING, "\n");
            }

            Dialog_Show(playerid, "gang_creation_icon", DIALOG_STYLE_LIST, "{CB3126}>{DADADA} Ícono de tu nueva {CB3126}banda", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Atrás");
        }
        case 2:
        {
            Dialog_Show(playerid, "gang_creation_color", DIALOG_STYLE_INPUT, 
                "{CB3126}>{DADADA} Color de tu nueva {CB3126}banda",
                    "{DADADA}Introduce el color de tu nueva banda en el formato #{FF0000}RR{00FF00}GG{0000FF}BB{DADADA}.",
                "Siguiente", "Atrás"
            );
        }
    }

    return 1;
}