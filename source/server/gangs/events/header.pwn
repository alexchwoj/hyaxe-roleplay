#if defined _events_header_
    #endinput
#endif
#define _events_header_

enum _:eGangEventType {
    EVENT_TRUCK_DEFENSE,
    EVENT_GRAFFITI,
    EVENT_INVALID
};

new Float:g_rgfTruckDefensePositions[][] =
{
	{2092.5991, -1557.1205, 12.8381, 179.7358}, 
    {2232.4336, -1621.8098, 15.4530, 155.9841}, 
    {2375.3430, -1639.1462, 13.2193, 178.6484}, 
    {2361.3394, -1474.1294, 23.5837, 90.3039}, 
    {2336.7566, -1368.8948, 23.7344, 178.3634}, 
    {2404.4585, -1379.9513, 23.9871, 92.7373}, 
    {2556.7280, -930.5746, 83.0224, 186.5477}, 
    {2599.9678, -1065.7911, 69.3077, 0.0766}, 
    {2684.1001, -1104.3225, 69.0908, 0.4428}, 
    {2810.8052, -1252.0560, 46.6802, 121.3643}, 
    {2783.0000, -1406.9369, 24.4724, 354.6505}, 
    {2435.0308, -2061.5813, 13.2771, 89.1642}, 
    {2390.3364, -2065.4766, 13.2252, 268.0051}, 
    {2396.1238, -2011.9196, 13.2807, 268.1526}, 
    {2236.5156, -1937.5461, 13.2691, 88.3561}
};

new 
    g_iGangEventType,
    g_iGangEventTick,
    g_iGangEventMapIcon,
    
    g_iGangTruckIndex,
    g_iGangTruckVehicleID,
    g_iGangTruckTimer,
    g_iGangTruckTimeCount,
    g_iGangTruckParticle
;