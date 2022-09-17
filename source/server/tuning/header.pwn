#if defined _tuning_header_
    #endinput
#endif
#define _tuning_header_

new 
    Float:s_rgfPreviusTuningPos[MAX_PLAYERS][4],
    s_rgiPreviusTuningInterior[MAX_PLAYERS],
    s_rgiPreviusTuningWorld[MAX_PLAYERS]
;

enum eRepairPosition
{
    Float:e_fRepairPosX,
    Float:e_fRepairPosY,
    Float:e_fRepairPosZ
};

new const
    g_rgeRepairPositions[][eRepairPosition] = {
        { -64.5548, -1162.2832, 1.6754 },
        { -70.2496, -1175.1454, 1.6754 },
        { -75.7055, -1185.3604, 1.6739 },
        { -94.6360, -1170.2373, 2.1841 }
    };

new
    g_rgiRepairSoundTimer[MAX_PLAYERS],
    g_rgiRepairFinishTimer[MAX_PLAYERS];

forward GARAGE_VehicleRepairPlaySound(playerid);
forward GARAGE_FinishRepairCar(playerid, vehicleid);