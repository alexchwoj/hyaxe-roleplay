#if defined _menu_header_
    #endinput
#endif
#define _menu_header_

#define player_menu%4\32;%0(%1) \
	forward menu_%0(%1); public menu_%0(%1)
	
#define MENU_COUNT_PAGES(%0,%1) \
	(((%0) - 1) / (%1) + 1)

// Limits
const MENU_MAX_LISTITEMS = 128;
const MENU_MAX_LISTITEMS_PERPAGE = 8;

// Response
enum {
	MENU_RESPONSE_UP,
	MENU_RESPONSE_DOWN,
	MENU_RESPONSE_SELECT,
	MENU_RESPONSE_CLOSE
};

// List items
enum eListitemInfo {
    e_szText[32],
	e_szInfo[32],
	e_iColor,
	e_iExtra
}

new g_rgeMenuListitem[MAX_PLAYERS + 1][MENU_MAX_LISTITEMS + 1][eListitemInfo];

// Player menu
enum ePlayerMenuInfo {
	bool:e_iEnabled,
    e_szID[32],
	e_iPage,
	e_iListitem,
	e_iTotalListitems,
	e_iLastTick,
	e_iTextdrawCount,
	e_iKeyProcessTimer,
	bool:e_bClearChat
}

new g_rgePlayerMenu[MAX_PLAYERS + 1][ePlayerMenuInfo];

// Menu textdraw
enum eMenuTextdraw
{
	e_tdListitemCount,
	e_tdListitems[MENU_MAX_LISTITEMS_PERPAGE],
	e_tdInfoBox,
	e_tdInfoIcon,
	e_tdInfoText
};

new
	g_rgiMenuTextDrawsID[MAX_PLAYERS + 1][eMenuTextdraw],
	PlayerText:g_rgiMenuTextDraws[MAX_PLAYERS + 1][50]
;