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

Dialog_Show_s(playerid, const dialogname[], style, ConstString:caption, ConstString:info, const button1[], const button2[] = "")
{
    if(!isnull(dialogname))
        strcpy(g_rgszPlayerDialogName[playerid], dialogname);
        
    return ShowPlayerDialog_s(playerid, 422, style, caption, info, button1, button2);
}

Task:Dialog_ShowAsync(playerid, style, const caption[], const info[], const button1[], const button2[] = "")
{
    if(g_rgtPlayerDialogs[playerid])
        task_delete(g_rgtPlayerDialogs[playerid]);

    g_rgtPlayerDialogs[playerid] = task_new();
    return ShowPlayerDialog(playerid, 423, style, caption, info, button1, button2);
}

Dialog_Hide(playerid)
{
    g_rgszPlayerDialogName[playerid][0] = '\0';
    if(task_valid(g_rgtPlayerDialogs[playerid]))
    {
        task_delete(g_rgtPlayerDialogs[playerid]);
        g_rgtPlayerDialogs[playerid] = Task:0;
    }

    return ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, !" ", !" ", !" ", "");
}