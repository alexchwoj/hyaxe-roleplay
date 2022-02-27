#if defined _commands_functions_
    #endinput
#endif
#define _commands_functions_

Commands_GetFreeIndex()
{
    for(new i; i < HYAXE_MAX_COMMANDS; ++i)
    {
        if(isnull(g_rgeCommandStore[i][e_szCommandName]))
        {
            return i;
        }
    }
    
    // Assume no free index found

    new hdr[AMX_HDR], name[32], est_new;
    GetAmxHeader(hdr);

    for(new i = GetNumPublics(hdr); i != -1; --i)
    {
        if(!GetPublicNameFromIndex(i, name))
            continue;

        if(!strcmp("hy@cmd_", name, true, 7))
            est_new++;
    }

    printf("[cmd!] Store out of space. Increase HYAXE_MAX_COMMANDS to %i (currently %i).", est_new, HYAXE_MAX_COMMANDS);

    SendRconCommand(!"exit");
    
    return -1;
}
