#if defined _phone_header_
    #endinput
#endif
#define _phone_header_

#define phone_menu%4\32;%0(%1) \
	forward phone_%0(%1); public phone_%0(%1)

forward Phone_Response(playerid, response, listitem);