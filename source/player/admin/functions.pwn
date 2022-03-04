#if defined _admin_functions_
    #endinput
#endif
#define _admin_functions_

Admins_SendMessage(level, color, const message[])
{
    foreach(new i : Admin)
    {
        if(Player_AdminLevel(i) >= level)
        {
            SendClientMessage(i, color, message);
        }
    }

    return 1;
}