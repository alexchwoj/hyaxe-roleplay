#if defined _admin_header_
    #endinput
#endif
#define _admin_header_

new
    Iterator:Admin<MAX_PLAYERS>;

forward Admins_SendMessage(level, color, const message[]);