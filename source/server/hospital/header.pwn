#if defined _hospital_header_
    #endinput
#endif
#define _hospital_header_

const HYAXE_MAX_HOSPITALS = 8;

enum {
    HOSPITAL_MODERN_INTERIOR,
    HOSPITAL_NORMAL_INTERIOR,
    HOSPITAL_DIRTY_INTERIOR,

    MAX_HOSPITAL_INTERIOR
}

enum eHospitalData
{
    e_szHospitalName[64],
    Float:e_fHospitalPosX,
    Float:e_fHospitalPosY,
    Float:e_fHospitalPosZ,
    Float:e_fHospitalAngle,
    e_iHospitalInteriorType,
    Float:e_fHospitalCamDistance,
    Float:e_fHospitalCamZ,
};

new g_rgeHospitalData[HYAXE_MAX_HOSPITALS][eHospitalData] = {
    {"All Saints General Hospital",  1172.3912, -1323.3804, 15.4031, 264.9666,  HOSPITAL_MODERN_INTERIOR,  40.0, 10.0},
    {"Jefferson Hospital",  2034.0781, -1402.0480, 17.2939, 182.0191,  HOSPITAL_NORMAL_INTERIOR,  40.0, 10.0},
    {"Montgomery Medical Center",  1373.8051, 405.0927, 19.9555, 70.0187,  HOSPITAL_DIRTY_INTERIOR,  40.0, 10.0},
    {"Las venturas Hospital",  1607.3539, 1815.6157, 10.8203, 358.3978,  HOSPITAL_MODERN_INTERIOR,  40.0, 10.0},
    {"Fort Carson Medical Center",  -320.2063, 1048.5966, 20.3403, 5.2510,  HOSPITAL_NORMAL_INTERIOR,  40.0, 10.0},
    {"Sex & Sex Salud",  -227.3847, 2711.6177, 62.9766, 181.2122,  HOSPITAL_DIRTY_INTERIOR,  40.0, 10.0},
    {"El Quebrados Medical Center",  -1514.8617, 2519.2656, 56.0703, 8.0619,  HOSPITAL_DIRTY_INTERIOR,  40.0, 10.0},
    {"San Fierro Medical Center",  -2655.0667, 639.9373, 14.4545, 179.5295,  HOSPITAL_MODERN_INTERIOR, 50.0, 15.0}
};

enum eHospitalInteriorData
{
    Float:e_fHospitalIntPosX,
    Float:e_fHospitalIntPosY,
    Float:e_fHospitalIntPosZ,
    Float:e_fHospitalIntAngle,

    Float:e_fHospitalIntActPosX,
    Float:e_fHospitalIntActPosY,
    Float:e_fHospitalIntActPosZ,

    e_iHospitalIntInterior,

    Float:e_fHospitalActorPosX,
    Float:e_fHospitalActorPosY,
    Float:e_fHospitalActorPosZ,
    Float:e_fHospitalActorPosAngle
};

new g_rgeHospitalInteriorData[MAX_HOSPITAL_INTERIOR][eHospitalInteriorData] = {
    {1170.9252, -1323.7070, 1001.0900, 92.0433,  1151.4563, -1323.7501, 1001.0910,  1,  1148.6044, -1323.7937, 1001.0829, 273.0493}, // HOSPITAL_MODERN_INTERIOR
    {673.5997, -339.6249, -94.7842, 91.1266,  645.6650, -339.6078, -94.7842,  1,  643.2076, -339.6404, -94.7842, 269.3699}, // HOSPITAL_NORMAL_INTERIOR
    {-229.9913, 193.2143, 122.6495, 210.8916,  -233.4046, 189.6813, 122.6821, 200,  -236.0936, 188.6919, 122.6729, 299.3552} // HOSPITAL_DIRTY_INTERIOR
};

new g_rgiHospitalHealthTimer[MAX_PLAYERS];