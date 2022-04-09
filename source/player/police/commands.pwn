#if defined _police_commands_
    #endinput
#endif
#define _police_commands_

command policias(playerid, const params[], "Muestra el panel de policías")
{
    if(!Player_IsPolice(playerid) && Player_AdminLevel(playerid) < RANK_LEVEL_ADMINISTRATOR)
    {
        SendClientMessagef(playerid, 0x3A86FFFF, "{DADADA}Solo la {3A86FF}policía{DADADA} puede acceder al panel de administración policial.");
        return 1;
    }

    memset(g_rgszSelectedOfficer[playerid], 0);

    new Task<Cache>:t = MySQL_QueryAsync(g_hDatabase, 
        "\
            SELECT `POLICE_OFFICERS`.*, `RECRUITEE`.`NAME` AS `OFFICER_NAME`, `RECRUITEE`.`CURRENT_PLAYERID`, `RECRUITER`.`NAME` AS `RECRUITER_NAME`, MAX(`CONNECTION_LOG`.`DATE`) AS `LAST_CONNECTION` \
            FROM `POLICE_OFFICERS` \
                LEFT JOIN `ACCOUNT` RECRUITER ON \
                    `POLICE_OFFICERS`.`RECRUITED_BY` = `RECRUITER`.`ID` \
                LEFT JOIN `ACCOUNT` RECRUITEE ON \
                    `POLICE_OFFICERS`.`ACCOUNT_ID` = `RECRUITEE`.`ID` \
                INNER JOIN `CONNECTION_LOG` \
                    ON `POLICE_OFFICERS`.`ACCOUNT_ID` = `CONNECTION_LOG`.`ACCOUNT_ID` \
            GROUP BY `POLICE_OFFICERS`.`ACCOUNT_ID` \
            ORDER BY `POLICE_OFFICERS`.`RANK` DESC;\
        "
    );

    new Cache:c = await<Cache> t;

    new rowc;
    cache_get_row_count(rowc);

    if(!rowc)
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} No hay ningún policía.");
        return 1;
    }

    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Oficial\t{DADADA}Rango\t{DADADA}Reclutado por\t{DADADA}Última conexión{DADADA}\n");

    new line[256];
    for(new i; i < rowc; ++i)
    {
        new officer_id, officer_name[25], rank, recruiter_id, recruiter_name[25], officer_current_playerid, last_connection[24];
        cache_get_value_name_int(i, "ACCOUNT_ID", officer_id);
        cache_get_value_name(i, "OFFICER_NAME", officer_name);
        cache_get_value_name_int(i, "RANK", rank);
        cache_get_value_name_int(i, "RECRUITED_BY", recruiter_id);

        new bool:isnt_recruited;
        cache_is_value_name_null(i, "RECRUITER_NAME", isnt_recruited);
        if(isnt_recruited)
        {
            strcat(recruiter_name, "Desconocido");
            recruiter_id = 0;
        }
        else
        {
            cache_get_value_name(i, "RECRUITER_NAME", recruiter_name);
        }

        cache_get_value_name_int(i, "CURRENT_PLAYERID", officer_current_playerid);
        cache_get_value_name(i, "LAST_CONNECTION", last_connection);
        
        format(line, sizeof(line), "{DADADA}%s ({3A86FF}%i{DADADA})\t{DADADA}%s\t{DADADA}%s ({3A86FF}%i{DADADA})\t{%x}%s\n", officer_name, officer_id, Police_GetRankName(rank), recruiter_name, recruiter_id, (officer_current_playerid == -1 ? 0xDADADA : 0x64A752), (officer_current_playerid == -1 ? last_connection : "En línea"));
        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_Show(playerid, "police_manage", DIALOG_STYLE_TABLIST_HEADERS, "{3A86FF}Hyaxe {DADADA}- Policía", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Salir");

    return 1;
}

dialog police_manage(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(sscanf(inputtext, "s[24]P<()>{s[2]}i", g_rgszSelectedOfficer[playerid], g_rgszSelectedOfficer[playerid][25]))
        return 1;

    g_rgszSelectedOfficer[playerid][24] = '\0';

    Dialog_Show_s(playerid, "police_manage_officer", DIALOG_STYLE_LIST, @f("Opciones para {3A86FF}%s", g_rgszSelectedOfficer[playerid]), @("{DADADA}Ascender o descender\n{A83225}Expulsar"), "Seleccionar", "Atrás");

    return 1;
}

dialog police_manage_officer(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        PC_EmulateCommand(playerid, "/policias");
        return 1;
    }

    switch(listitem)
    {
        case 0: // Ascender o descender
        {
            HYAXE_UNSAFE_HUGE_STRING[0] = '\0';
            
            new line[64];
            for(new i = sizeof(g_rgszPoliceRankNames) - 1; i != 0; --i)
            {
                format(line, sizeof(line), "%i. %s\n", i, g_rgszPoliceRankNames[i]);
                strcat(HYAXE_UNSAFE_HUGE_STRING, line);
            }

            format(line, sizeof(line), "Selecciona el nuevo rango de {3A86FF}%s", g_rgszSelectedOfficer[playerid]);
            Dialog_Show(playerid, "police_change_rank", DIALOG_STYLE_LIST, line, HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Atrás");
        }
        case 1: // Expulsar
        {

        }
    }

    return 1;
}

dialog police_change_rank(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new new_rank = _:POLICE_RANK_GEN_COMMISSIONER - listitem;

        mysql_tquery_s(g_hDatabase, @f("UPDATE `POLICE_OFFICERS` SET `RANK` = %i WHERE `ACCOUNT_ID` = %i;", new_rank, g_rgszSelectedOfficer[playerid][25]));
        
        new bool:reported = false;
        
        foreach(new i : LoggedIn)
        {
            if(g_rgszSelectedOfficer[playerid][25] == Player_AccountID(i))
            {
                if(Police_Rank(i) != new_rank)
                {
                    new const bool:is_lower = (Police_Rank(i) > new_rank);
                    Police_Rank(i) = new_rank;

                    new message[40];
                    format(message, sizeof(message), "Has sido %s a %s.", (is_lower ? "descendido" : "ascendido"), Police_GetRankName(new_rank));
                    Notification_Show(playerid, message, 10000, 0x3A86FFFF);
                    Police_SendMessage_s(POLICE_RANK_NONE, 0x3A86FFFF, @f("[Policía] ›{DADADA} %s ahora es {3A86FF}%s{DADADA}.", Player_RPName(i), Police_GetRankName(new_rank)));
                }

                reported = true;

                break;
            }
        }

        if(!reported)
        {
            Police_SendMessage_s(POLICE_RANK_NONE, 0x3A86FFFF, @f("[Policía] ›{DADADA} %s ahora es {415BA2}%s{DADADA}.", g_rgszSelectedOfficer[playerid], g_rgszPoliceRankNames[new_rank]));
        }
    }

    PC_EmulateCommand(playerid, "/policias");
    return 1;
}