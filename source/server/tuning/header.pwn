#if defined _tuning_header_
    #endinput
#endif
#define _tuning_header_

#define TOTAL_TUNING_PARTS 14
#define MAX_TUNING_PARTS_COMPONENTS 20

enum eTuningMenu
{
    e_iID,
	e_szName[24],
    e_iPrice,
    e_iCameraType
};
new g_rgeTuningMenu[MAX_PLAYERS + 1][MAX_TUNING_PARTS_COMPONENTS][eTuningMenu];

new 
    Float:s_rgfPreviusTuningPos[MAX_PLAYERS][4],
    s_rgiPreviusTuningInterior[MAX_PLAYERS],
    s_rgiPreviusTuningWorld[MAX_PLAYERS],
    g_rgiActualTuningComponent[MAX_PLAYERS],
    g_rgiTuningCamera[MAX_PLAYERS]
;

enum eRepairPosition
{
    Float:e_fRepairPosX,
    Float:e_fRepairPosY,
    Float:e_fRepairPosZ
};

enum eTuningCamera
{
    Float:e_fPosX,
    Float:e_fPosY,
    Float:e_fPosZ,
    Float:e_fLookX,
    Float:e_fLookY,
    Float:e_fLookZ
};

new const
    g_rgeRepairPositions[][eRepairPosition] = {
        { -64.5548, -1162.2832, 1.6754 },
        { -70.2496, -1175.1454, 1.6754 },
        { -75.7055, -1185.3604, 1.6739 },
        { -94.6360, -1170.2373, 2.1841 }
    },
    g_rgeTuningCameras[][eTuningCamera] = {
        { 606.906799, 2.143145, 1002.159118, 611.030334, -0.317962, 1000.766418 }, // 0 = Normal
        { 608.043457, 0.611119, 1001.116088, 612.273315, -1.969170, 1000.445007 }, // 1 = Adelante
        { 609.041198, -1.115129, 1002.483154, 613.489196, -0.181294, 1000.399108 }, // 2 = Arriba
        { 616.893127, 0.972757, 1002.145385, 613.846191, -2.529295, 1000.287475 }, // 3 = Atras
        { 609.474670, 1.573151, 1000.936645, 612.700805, -2.129092, 999.995788 } // 4 = Abajo
    };

new
    g_rgiRepairSoundTimer[MAX_PLAYERS],
    g_rgiRepairFinishTimer[MAX_PLAYERS],
    g_rgiSelectedColorType[MAX_PLAYERS];

forward GARAGE_VehicleRepairPlaySound(playerid);
forward GARAGE_FinishRepairCar(playerid, vehicleid, bool:show_tuning);