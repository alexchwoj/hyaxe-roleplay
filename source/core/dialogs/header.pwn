#if defined _dialogs_header_
    #endinput
#endif
#define _dialogs_header_

enum eDialogResponse
{
    e_bResponse,
    e_iListItem,
    e_szInputText[129]
};

new 
    g_rgszPlayerDialogName[MAX_PLAYERS][32],
    Task<eDialogResponse>:g_rgtPlayerDialogs[MAX_PLAYERS];

#define dialog%2\32;%0(%1) forward _hydg@%0(%1); public _hydg@%0(%1)
#define Dialog_Shown(%0) (g_rgszPlayerDialogName[(%0)][0] != '\0')
forward Dialog_Show(playerid, const dialogname[], style, const caption[], const info[], const button1[], const button2[] = "");
forward Dialog_Show_s(playerid, const dialogname[], style, ConstString:caption, ConstString:info, const button1[], const button2[] = "");
forward Dialog_Hide(playerid);
forward Task<eDialogResponse>:Dialog_ShowAsync(playerid, style, const caption[], const info[], const button1[], const button2[] = "");