#if defined _notification_header_
    #endinput
#endif
<<<<<<< HEAD
#define _NOTIFICATION_HEADER_

const MAX_NOTIFICATIONS = 16;
=======
#define _notification_header_
>>>>>>> 37e3f22a61aa0e76f3d418509aa840df5ce551a1

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