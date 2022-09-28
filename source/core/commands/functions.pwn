#if defined _commands_functions_
    #endinput
#endif
#define _commands_functions_

Commands_GetFreeIndex()
{
    for(new i; i < HYAXE_MAX_COMMANDS; ++i)
    {
        if(g_rgeCommandStore[i][e_szCommandName][0] == '\0')
        {
            return i;
        }
    }
    
    // Assume no free index found

    new name[32], est_new;

    new hdr[AMX_HDR];
    GetAmxHeader(hdr);

    for(new i = GetNumPublics(hdr) - 1; i != -1; --i)
    {
        GetPublicNameFromIndex(i, name);

        if(!strcmp("hy@cmd_", name, true, 7))
            est_new++;
    }

    printf("[cmd!] Store out of space. Increase HYAXE_MAX_COMMANDS to %i (currently %i).", est_new, HYAXE_MAX_COMMANDS);

    SendRconCommand(!"exit");
    
    return -1;
}

Commands_GetByName(const cmd_name[])
{
    for(new i; i < HYAXE_MAX_COMMANDS; ++i)
    {
        if(!isnull(g_rgeCommandStore[i][e_szCommandName]) && !strcmp(g_rgeCommandStore[i][e_szCommandName], cmd_name, .ignorecase = true))
            return i;
    }

    return 1;
}

Commands_ShowSuggestions(playerid, const command[])
{
    new CmdArray:arr = PC_GetCommandArray();
    new cmd_size = PC_GetArraySize(arr);
    static distances[HYAXE_MAX_COMMANDS][3];

    new cmd_name[32], distances_length;
    for(new i; i < cmd_size && distances_length < 20; ++i)
    {
        PC_GetCommandName(arr, i, cmd_name);

        new cmd_flags = PC_GetFlags(cmd_name);
        if((cmd_flags & CMD_HIDDEN) != 0)
            continue;

        new cmd_admin_level = (cmd_flags >>> 24);
        if(cmd_admin_level > Player_AdminLevel(playerid))
            continue;

        new cmdid = Commands_GetByName(cmd_name);
        if(cmdid == -1)
            continue;

        new distance = levenshtein(command, cmd_name);
        if(distance >= 6)
            continue;

        distances[distances_length][0] = i;
        distances[distances_length][1] = distance;
        distances[distances_length][2] = cmdid;
        distances_length++;
    }

    PC_FreeArray(arr);
    
    if(!distances_length)
    {
        SendClientMessagef(playerid, 0xDADADAFF, "({ED2B2B}/%s{DADADA}) Comando desconocido.", command);
        return 1;
    }

    SortDeepArray(distances, 1, .order = SORT_DESC);
    
    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Sugerencias:\t \n");

    new line[128];
    for(new i = distances_length - 1; i != -1; --i)
    {
        new cmdid = distances[i][2];
        new cmd_flags = PC_GetFlags(g_rgeCommandStore[cmdid][e_szCommandName]);
                
        g_rgiPlayerCommandsDialog[playerid][(distances_length - 1) - i] = cmdid;

        new description[50] = "Sin descripción";
        if(!isnull(g_rgeCommandStore[cmdid][e_szCommandDescription]))
            strcpy(description, g_rgeCommandStore[cmdid][e_szCommandDescription]);
        
        format(
            line, 
            sizeof(line), 
            "{%x}› {DADADA}/%s\t%s\n", 
            ((cmd_flags >>> 24) > RANK_LEVEL_USER ? 0x3A86FF : 0xCB3126), 
            g_rgeCommandStore[cmdid][e_szCommandName],
            description
        );

        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    new header[64];
    format(header, sizeof(header), "{DADADA}Comando {ED2B2B}/%s{DADADA} desconocido", command);
    Dialog_ShowCallback(playerid, using public _hydg@unknown_command<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, header, HYAXE_UNSAFE_HUGE_STRING, !"Ejecutar", !"Cerrar");

    return 1;
}

dialog unknown_command(playerid, dialogid, response, listitem, inputtext[])
{
    DEBUG_PRINT("dialog unknown_command(playerid = %i, response = %i, listitem = %i, inputtext = \"%s\")", playerid, response, listitem, inputtext);

    if(response && (0 <= listitem < 20))
    {      
        new cmdid = g_rgiPlayerCommandsDialog[playerid][listitem];
        if(cmdid != -1)
        {
            new cmd_str[25];
            format(cmd_str, sizeof(cmd_str), "/%s", g_rgeCommandStore[cmdid][e_szCommandName]);
            DEBUG_PRINT("cmd_str = \"%s\"", cmd_str);

            PC_EmulateCommand(playerid, cmd_str);
        }
    }

    MemSet(g_rgiPlayerCommandsDialog[playerid], -1);

    return 1;
}
