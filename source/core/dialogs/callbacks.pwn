#if defined _dialogs_callbacks_
    #endinput
#endif
#define _dialogs_callbacks_

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    DEBUG_PRINT("OnDialogResponse(%i, %i, %i, %i, \"%s\")", playerid, dialogid, response, listitem, inputtext);

    for(new i, j = strlen(inputtext); i < j; ++i)
    {
        if(inputtext[i] == '%')
            inputtext[i] = '#';
    }

    if(dialogid == 422 && Dialog_Shown(playerid))
    {
        new pubname[32];
        format(pubname, sizeof(pubname), "_hydg@%s", g_rgszPlayerDialogName[playerid]);
        CallLocalFunction(pubname, !"iiis", playerid, response, listitem, (isnull(inputtext) ? "\1" : inputtext));
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