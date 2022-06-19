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
        {CB3126}>{DADADA} Color: #{%06x}%06x\n\
        {CB3126}>{DADADA} Crear",
        s_rgszGangCreationName[playerid], g_rgszGangIcons[s_rgiGangCreationIcon{playerid}][0], s_rgiGangCreationColor[playerid] >>> 8, s_rgiGangCreationColor[playerid] >>> 8
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
    s_rgiGangCreationColor[playerid] = math_random_unsigned(0, 0xFFFFFFFF) | 0xFF;

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
                    "{DADADA}Introduce el nombre de tu nueva banda. Tiene que tener entre {CB3126}1{DADADA} y {CB3126}64{DADADA} caracteres.",
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
        case 3:
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}Estás a punto de crear una banda de nombre {%06x}'%s'{DADADA}.\n{DADADA}Siempre podrás cambiar algun aspecto de tu banda desde el panel.", s_rgiGangCreationColor[playerid] >>> 8, s_rgszGangCreationName[playerid]);
            Dialog_Show(playerid, "gang_confirm_creation", DIALOG_STYLE_MSGBOX,
                "{CB3126}>{DADADA} Creación de tu nueva {CB3126}banda",
                HYAXE_UNSAFE_HUGE_STRING,
                "Crear", "Atrás"
            );
        }
    }

    return 1;
}

dialog gang_creation_name(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        GangCreation_ShowDialog(playerid);
        return 1;
    }

    if(isnull(inputtext) || strlen(inputtext) > 64)
    {
        Dialog_Show(playerid, "gang_creation_name", DIALOG_STYLE_INPUT, 
            "{CB3126}>{DADADA} Nombre de tu nueva {CB3126}banda{DADADA}",
                "{DADADA}Introduce el nombre de tu nueva banda. Tiene que tener entre {CB3126}1{DADADA} y {CB3126}64{DADADA} caracteres.",
            "Siguiente", "Atrás"
        );
        return 1;
    }

    strcpy(s_rgszGangCreationName[playerid], inputtext);
    GangCreation_ShowDialog(playerid);

    return 1;
}

dialog gang_creation_icon(playerid, response, listitem, const inputtext[])
{
    if(!response || !(0 <= listitem < sizeof(g_rgszGangIcons)))
    {
        GangCreation_ShowDialog(playerid);
        return 1;
    }

    s_rgiGangCreationIcon{playerid} = listitem;
    GangCreation_ShowDialog(playerid);

    return 1;
}

dialog gang_creation_color(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        GangCreation_ShowDialog(playerid);
        return 1;
    }

    new new_color;
    if(sscanf(inputtext, "?<SSCANF_COLOUR_FORMS=2>m", new_color))
    {
        Dialog_Show(playerid, "gang_creation_color", DIALOG_STYLE_INPUT, 
            "{CB3126}>{DADADA} Color de tu nueva {CB3126}banda",
                "{DADADA}Introduce el color de tu nueva banda en el formato #{FF0000}RR{00FF00}GG{0000FF}BB{DADADA}.",
            "Siguiente", "Atrás"
        );
        return 1;
    }

    s_rgiGangCreationColor[playerid] = new_color;
    GangCreation_ShowDialog(playerid);

    return 1;
}

dialog gang_confirm_creation(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        GangCreation_ShowDialog(playerid);
        return 1;
    }

    new idx = Gangs_FindFreeIndex();
    if(idx == -1)
    {
        Dialog_Show(playerid, "", DIALOG_STYLE_MSGBOX, "{CB3126}>{DADADA} ¡Uh, oh! Algo malio sal", "No se pudo crear tu banda. Contacta a un administrador. {969696}(0)", "Entendido");
        return 1;
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        START TRANSACTION;\
        INSERT INTO `GANGS` \
            (`CREATOR_ID`, `GANG_NAME`, `GANG_COLOR`, `GANG_ICON`) \
        VALUES \
            (%i, '%e', %i, %i);\
        SET @gangid = LAST_INSERT_ID();\
        INSERT INTO `GANG_RANKS` \
            (`GANG_ID`, `RANK_NAME`, `RANK_HIERARCHY`, `RANK_PERMISSIONS`) \
        VALUES \
            (@gangid, 'Lider', 10, 2147483647);\
        UPDATE `ACCOUNT` SET `GANG_ID` = @gangid, `GANG_RANK` = 10 WHERE `ID` = %i;\
        SET @rankid = LAST_INSERT_ID();\
        COMMIT;\
        ",
        Player_AccountID(playerid), 
        s_rgszGangCreationName[playerid], s_rgiGangCreationColor[playerid], s_rgiGangCreationIcon{playerid},
        Player_AccountID(playerid)
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    mysql_tquery(g_hDatabase, "SELECT @gangid AS `GANG_ID`, @rankid AS `RANK_ID`;", "GANG_Inserted", "i", playerid);

    return 1;
}

forward GANG_Inserted(playerid);
public GANG_Inserted(playerid)
{
    new gangid, rankid;
    cache_get_value_name_int(0, "GANG_ID", gangid);
    cache_get_value_name_int(0, "RANK_ID", rankid);
    printf("[c] gangid = %i", gangid);
    printf("[c] rankid = %i", rankid);

    new idx = Gangs_FindFreeIndex();
    g_rgeGangs[idx][e_iGangDbId] = gangid;
    strcpy(g_rgeGangs[idx][e_szGangName], s_rgszGangCreationName[playerid]);
    g_rgeGangs[idx][e_iGangColor] = s_rgiGangCreationColor[playerid];
    g_rgeGangs[idx][e_iGangIcon] = s_rgiGangCreationIcon{playerid};
    g_rgeGangs[idx][e_iGangOwnerId] = Player_AccountID(playerid);
    map_add(g_mapGangIds, gangid, idx);

    g_rgeGangRanks[idx][9][e_iRankId] = rankid;
    strcpy(g_rgeGangRanks[idx][9][e_szRankName], "Lider");
    g_rgeGangRanks[idx][9][e_iRankPermisionFlags] = cellmax;

    Player_Gang(playerid) = idx;
    Player_GangRank(playerid) = 9;

    Dialog_Show(playerid, "", DIALOG_STYLE_MSGBOX, "{CB3126}>{DADADA} ¡Tu banda fue creada con éxito!", "{DADADA}Como líder de la banda, puedes empezar por abrir el panel de configuración presionando las teclas {CB3126}ESPACIO{DADADA} y {CB3126}Y{DADADA} simultáneamente.", "Entendido");
    return 1;
}