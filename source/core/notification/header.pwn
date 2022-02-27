#if defined _notification_header_
    #endinput
#endif
#define _NOTIFICATION_HEADER_

const MAX_NOTIFICATIONS = 16;

enum eNotificationData 
{
    bool:notificationActive,
    notificationFrameCount,
    notificationFrameTimer,
    PlayerText:notificationTextdraw[3],
    notificationText[512],
    notificationSeconds,
    Float:notificationHeight
};

new NOTIFICATION_DATA[MAX_PLAYERS][MAX_NOTIFICATIONS][eNotificationData];