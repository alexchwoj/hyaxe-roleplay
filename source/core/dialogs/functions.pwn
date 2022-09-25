#if defined _dialogs_functions_
    #endinput
#endif
#define _dialogs_functions_

Dialog_Show(playerid, const dialogname[], style, const caption[], const info[], const button1[], const button2[] = "")
{
    if(!isnull(dialogname))
        strcpy(g_rgszPlayerDialogName[playerid], dialogname);

    return ShowPlayerDialog(playerid, 422, style, caption, info, button1, button2);
}

Dialog_Hide(playerid)
{
    g_rgszPlayerDialogName[playerid][0] = '\0';
    return ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, !" ", !" ", !" ", "");
}