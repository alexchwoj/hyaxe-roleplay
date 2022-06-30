#if defined _dialogs_callbacks_
    #endinput
#endif
#define _dialogs_callbacks_

public OnPlayerDisconnect(playerid, reason)
{
    if(g_rgtPlayerDialogs[playerid])
    {
        task_delete(g_rgtPlayerDialogs[playerid]);
        g_rgtPlayerDialogs[playerid] = Task:0;
    }
    
    #if defined DIALOG_OnPlayerDisconnect
        return DIALOG_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect DIALOG_OnPlayerDisconnect
#if defined DIALOG_OnPlayerDisconnect
    forward DIALOG_OnPlayerDisconnect(playerid, reason);
#endif

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    DEBUG_PRINT("OnDialogResponse(playerid = %i, dialogid = %i, response = %i, listitem = %i, inputtext[] = \"%s\")", playerid, dialogid, response, listitem, inputtext);

    for(new i, j = strlen(inputtext); i < j; ++i)
    {
        if(inputtext[i] == '%')
            inputtext[i] = '#';
    }

    if(dialogid == 422 && Dialog_Shown(playerid))
    {
        new pubname[32];
        format(pubname, sizeof(pubname), "_hydg@%s", g_rgszPlayerDialogName[playerid]);
        g_rgszPlayerDialogName[playerid][0] = '\0';

        CallLocalFunction(pubname, !"iiis", playerid, response, listitem, (isnull(inputtext) ? "\1" : inputtext));

        return 1;
    }
    else if(dialogid == 423 && task_valid(g_rgtPlayerDialogs[playerid]))
    {
        g_rgszPlayerDialogName[playerid][0] = '\0';
        
        new info[eDialogResponse];
        info[e_bResponse] = response;
        info[e_iListItem] = listitem;
        strcat(info[e_szInputText], inputtext);

        new Task:t = g_rgtPlayerDialogs[playerid];
        g_rgtPlayerDialogs[playerid] = Task:0;

        task_set_result_arr(Task:t, _:info, .tag_id = tagof(info));

        return 1;
    }

    #if defined DIALOGS_OnDialogResponse
        return DIALOGS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse DIALOGS_OnDialogResponse
#if defined DIALOGS_OnDialogResponse
    forward DIALOGS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif