#if defined _garage_header_
    #endinput
#endif
#define _garage_header_

enum eRepairType
{
    REPAIR_POS_TYPE_VEHICLE,
    REPAIR_POS_TYPE_HELICOPTER,
    REPAIR_POS_TYPE_AIRPLANE,
    REPAIR_POS_TYPE_BOAT
};

enum eRepairPosition
{
    eRepairType:e_iRepairType,
    Float:e_fRepairPosX,
    Float:e_fRepairPosY,
    Float:e_fRepairPosZ
};

new const
    g_rgeRepairPositions[][eRepairPosition] = {
        { REPAIR_POS_TYPE_VEHICLE, -64.3401, -1162.6105, 3.6483 },
        { REPAIR_POS_TYPE_VEHICLE, -70.1450, -1175.3054, 3.6483 },
        { REPAIR_POS_TYPE_VEHICLE, -75.3205, -1185.4333, 3.6483 }
    };

new
    g_rgiRepairSoundTimer[MAX_PLAYERS],
    g_rgiRepairFinishTimer[MAX_PLAYERS];

forward GARAGE_VehicleRepairPlaySound(playerid);
forward GARAGE_FinishRepairCar(playerid, vehicleid);