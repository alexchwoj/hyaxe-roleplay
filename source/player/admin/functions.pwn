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

Admins_SendMessage_s(level, color, ConstString:message)
{
    print_s(message);
    new ConstAmxString:addr = str_addr_const(message);

    foreach(new i : Admin)
    {
        printf("admin: %i", i);

        if(Player_AdminLevel(i) >= level)
        {
            print("is higher");
            SendClientMessage_s(i, color, addr);
        }
    }

    return 1;
}