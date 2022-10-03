#if defined _vehicles_header_
    #endinput
#endif
#define _vehicles_header_

const MIN_VEHICLE_MODEL = 400;
const MAX_VEHICLE_MODEL = 611;
const MAX_VEHICLE_MODELS = MAX_VEHICLE_MODEL - MIN_VEHICLE_MODEL;
const Float:VEHICLE_FUEL_DIVISOR = 20000.0;

new
    Iterator:PlayerVehicles[MAX_PLAYERS]<MAX_VEHICLES>;
    
enum 
{
    VEHICLE_STATE_OFF = 0,
    VEHICLE_STATE_ON = 1,
    VEHICLE_STATE_DEFAULT = 2
};

enum eVehicleTimers
{
    VEHICLE_TIMER_TOGGLE_ENGINE,
    VEHICLE_TIMER_UPDATE
}

enum eVehicleType
{
    VEHICLE_TYPE_NONE,
    VEHICLE_TYPE_PERSONAL,
    VEHICLE_TYPE_WORK,
    VEHICLE_TYPE_DEALERSHIP,
    VEHICLE_TYPE_RENTAL,
    VEHICLE_TYPE_ADMIN,
    VEHICLE_TYPE_POLICE
};

enum eVehicleData 
{
    bool:e_bValid,

    e_iVehicleDbId,
    e_iVehicleOwnerId,

    Float:e_fPosX,
    Float:e_fPosY,
    Float:e_fPosZ,
    Float:e_fPosAngle,
    e_iVehInterior,
    e_iVehWorld,
    Float:e_fHealth,

    e_iColorOne,
    e_iColorTwo,
    e_iPaintjob,
    Float:e_fFuel,
    bool:e_bLocked,
    bool:e_bAlarm,
    e_iComponents[14],
    eVehicleType:e_iVehicleType,
    eJobs:e_iVehicleWork,

    e_iVehicleTimers[eVehicleTimers],
    bool:e_bSpawned,
    e_iSellIndex,
    bool:e_bRepairing
};

new g_rgeVehicles[MAX_VEHICLES][eVehicleData];

enum eTrunk
{
    bool:e_bValid,
    e_iID,
    e_iType,
    e_iAmount,
    e_iExtra
};
new g_rgeVehicleTrunk[MAX_VEHICLES][14][eTrunk];

enum eVehicleModelData
{
    e_szModelName[20],
    e_iMaxSpeed,
    Float:e_fMaxFuel,
    e_iPrice
};

new const g_rgeVehicleModelData[MAX_VEHICLE_MODELS + 1][eVehicleModelData] = {
    { "Landstalker", 160, 100.0, 35000 },           // 400
    { "Bravura", 160, 50.0, 15000 },            // 401 - Bravura
    { "Buffalo", 200, 100.0, 2400000 },
    { "Linerunner", 120, 100.0, 6000000 },
    { "Pereniel", 150, 100.0, 6000 },
    { "Sentinel", 165, 100.0, 20000 },
    { "Dumper", 110, 100.0, 42000000 },
    { "Firetruck", 170, 100.0, 36000000 },
    { "Trashmaster", 110, 100.0, 18000000 },
    { "Stretch", 180, 100.0, 4200000 },
    { "Manana", 160, 55.0, 5400},            // 410 - Manana
    { "Infernus", 240, 100.0, 3000000 },
    { "Voodoo", 160, 45.0, 50000 },            // 412 - Voodoo
    { "Pony", 160, 100.0, 2000},
    { "Mule", 140, 100.0, 480000 },
    { "Cheetah", 230, 100.0, 1800000 },
    { "Ambulance", 155, 100.0, 24000000 },
    { "Leviathan", 200, 100.0, 12000000 },
    { "Moonbeam", 150, 75.0, 75000 },            // 418 - Moonbeam
    { "Esperanto", 160, 50.0, 25000 },            // 419 - Esperanto
    { "Taxi", 180, 100.0, 4200000 },
    { "Washington", 180, 100.0, 35000 },
    { "Bobcat", 165, 100.0, 8500 },
    { "Mr Whoopee", 145, 100.0, 1800000 },
    { "BF Injection", 170, 100.0, 32000 },
    { "Hunter", 200, 100.0, 90000000 },
    { "Premier", 200, 50.0, 45000 },            // 426 - Premier
    { "Enforcer", 170, 100.0, 30000000 },
    { "Securicar", 170, 100.0, 9000000 },
    { "Banshee", 200, 100.0, 1800000},
    { "Predator", 190, 100.0, 0 },
    { "Bus", 130, 100.0, 3000000 },
    { "Rhino", 80, 100.0, 120000000 },
    { "Barracks", 180, 100.0, 27000000 },
    { "Hotknife", 200, 100.0, 1200000 },
    { "Trailer", 120, 100.0, 0 },
    { "Previon", 160, 100.0, 32000 },           // 436 - Previon
    { "Coach", 160, 100.0, 8400000 },
    { "Cabbie", 160, 100.0, 2400000 },
    { "Stallion", 160, 100.0, 8500 },
    { "Rumpo", 160, 100.0, 100000},
    { "RC Bandit", 75, 100.0, 36000000 },
    { "Romero", 150, 100.0, 80000},
    { "Packer", 150, 100.0, 7200000 },
    { "Monster", 110, 100.0, 3500000 },
    { "Admiral", 165, 100.0, 5750 },
    { "Squalo", 280, 100.0, 0 },
    { "Seasparrow", 200, 100.0, 9000000 },
    { "Pizzaboy", 190, 100.0, 8500 },
    { "Tram", 150, 100.0, 120000000 },
    { "Trailer", 120, 100.0, 0 },
    { "Turismo", 240, 100.0, 1800000 },
    { "Speeder", 190, 100.0, 1800000 },
    { "Reefer", 190, 100.0, 1200000 },
    { "Tropic", 190, 100.0, 600000 },
    { "Flatbed", 140, 100.0, 4200000 },
    { "Yankee", 160, 100.0, 960000 },
    { "Caddy", 160, 100.0, 600000 },
    { "Solair", 165, 60.0, 45000 },            // 458 - Solair
    { "Berkley's RC Van", 160, 100.0, 150000 },
    { "Skimmer", 200, 100.0, 16200000 },
    { "PCJ-600", 190, 20.0, 120000 },            // 461 - PCJ-600
    { "Faggio", 190, 25.0, 5000 },            // 462 - Faggio
    { "Freeway", 190, 100.0, 60000 },
    { "RC Baron", 75, 100.0, 36000000 },
    { "RC Raider", 75, 100.0, 36000000 },
    { "Glendale", 160, 100.0, 9500 },
    { "Oceanic", 160, 100.0, 55000 },
    { "Sanchez", 190, 100.0, 160000 },
    { "Sparrow", 200, 100.0, 9000000 },
    { "Patriot", 170, 100.0, 3600000 },
    { "Quad", 160, 100.0, 20000 },
    { "Coastguard", 190, 100.0, 0 },
    { "Dinghy", 190, 100.0, 1200000 },
    { "Hermes", 160, 100.0, 12000 },
    { "Sabre", 160, 100.0, 7500 },
    { "Rustler", 200, 100.0, 18000000 },
    { "ZR-350", 200, 100.0, 360000 },
    { "Walton", 150, 100.0, 6000 },
    { "Regina", 165, 100.0, 6000 },
    { "Comet", 200, 100.0, 600000 },
    { "BMX", 120, 100.0, 600 },
    { "Burrito", 150, 80.0, 200000 },            // 482 - Burrito
    { "Camper", 120, 100.0, 40000 },
    { "Marquis", 190, 100.0, 0 },
    { "Baggage", 160, 100.0, 360000 },
    { "Dozer", 100, 100.0, 6000000 },
    { "Maverick", 200, 100.0, 6000000},
    { "News Chopper", 200, 100.0, 7800000 },
    { "Rancher", 170, 100.0, 100000 },
    { "FBI Rancher", 170, 100.0, 24000000 },
    { "Virgo", 160, 45.0, 35000 },            // 491 - Virgo
    { "Greenwood", 160, 50.0, 40000 },            // 492 - Greenwood
    { "Jetmax", 190, 100.0, 3600000 },
    { "Hotring", 220, 100.0, 2400000 },
    { "Sandking", 170, 100.0, 4200000 },
    { "Blista", 200, 100.0, 35000 },
    { "Police Maverick", 200, 100.0, 19200000 },
    { "Boxville", 140, 100.0, 3000000 },
    { "Benson", 140, 100.0, 360000 },
    { "Mesa", 160, 100.0, 30000 },
    { "RC Goblin", 75, 100.0, 90000000 },
    { "Hotring-Racer", 220, 100.0, 2400000 },
    { "Hotring-Racer", 220, 100.0, 2400000 },
    { "Bloodring-Banger", 160, 100.0, 5000000  },
    { "Rancher", 170, 100.0, 200000 },
    { "Super-GT", 230, 100.0, 250000 },
    { "Elegant", 165, 55.0, 30000 },            // 507 - Elegant
    { "Journey", 140, 100.0, 3600000 },
    { "Bike", 120, 100.0, 1000 },
    { "Mountain Bike", 140, 100.0, 2000 },
    { "Beagle", 200, 100.0, 0 },
    { "Crop Dust", 200, 100.0, 0 },
    { "Stunt", 200, 100.0, 0 },
    { "Tanker", 120, 100.0, 6000000 },
    { "RoadTrain", 120, 100.0, 7200000 },
    { "Nebula", 165, 65.0, 15000 },            // 516 - Nebula
    { "Majestic", 165, 50.0, 75000 },            // 517 - Majestic
    { "Buccaneer", 160, 52.5, 45000  },            // 518 - Buccaneer
    { "Shamal", 330, 100.0, 30000000 },
    { "Hydra", 330, 100.0, 120000000 },
    { "FCR-900", 190, 27.5, 80000 },            // 521 - FCR-900
    { "NRG-500", 190, 30.0, 3600000 },            // 522 - NRG-500
    { "HPV1000", 190, 100.0, 18000000 },
    { "Cement Truck", 110, 100.0, 5400000 },
    { "Tow Truck", 160, 100.0, 36000000 },
    { "Fortune", 160, 100.0, 120000},
    { "Cadrona", 160, 100.0, 19000 },
    { "FBI Truck", 170, 100.0, 36000000 },
    { "Willard", 160, 100.0, 20000 },
    { "Forklift", 60, 100.0, 1200000 },
    { "Tractor", 70, 100.0, 1200000 },
    { "Combine", 140, 100.0, 0 },
    { "Feltzer", 200, 100.0, 30000 },
    { "Remington", 160, 57.5, 35000 },            // 534 - Remington
    { "Slamvan", 160, 65.0, 30000 },            // 535 - Slamvan
    { "Blade", 160, 50.0, 25000 },            // 536  Blade
    { "Freight", 110, 100.0, 180000000 },
    { "Streak", 110, 100.0, 180000000 },
    { "Vortex", 150, 100.0, 9600000 },
    { "Vincent", 160, 100.0, 30000 },
    { "Bullet", 230, 100.0, 3600000 },
    { "Clover", 160, 100.0, 5600 },
    { "Sadler", 165, 100.0, 5500 },
    { "Firetruck", 170, 100.0, 21000000 },
    { "Hustler", 160, 100.0, 25000 },
    { "Intruder", 160, 100.0, 15000 },
    { "Primo", 160, 50.0, 8000 },            // 547 - Primo
    { "Cargobob", 200, 100.0, 14400000 },
    { "Tampa", 160, 100.0, 6500 },
    { "Sunrise", 160, 100.0, 30000 },
    { "Merit", 165, 100.0, 35000 },
    { "Utility", 160, 100.0, 36000000 },
    { "Nevada", 200, 100.0, 42000000 },
    { "Yosemite", 170, 100.0, 20000 },
    { "Windsor", 180, 100.0, 75000 },
    { "Monster Truck A", 110, 100.0, 7200000 },
    { "Monster Truck B", 110, 100.0, 7200000 },
    { "Uranus", 200, 100.0, 1200000 },
    { "Jester", 200, 100.0, 60000 },
    { "Sultan", 200, 100.0, 450000 },
    { "Stratum", 200, 100.0, 20000 },
    { "Elegy", 200, 100.0, 60000 },
    { "Raindance", 200, 100.0, 12000000 },
    { "RC Tiger", 75, 100.0, 36000000 },
    { "Flash", 200, 100.0, 40000 },
    { "Tahoma", 160, 100.0, 33000 },
    { "Savanna", 160, 45.0, 25000 },            // 567 - Savanna
    { "Bandito", 170, 100.0, 3600000 },
    { "Freight", 110, 100.0, 180000000 },
    { "Trailer", 110, 100.0, 0 },
    { "Kart", 90, 100.0, 2500000 },
    { "Mower", 60, 100.0, 1200000 },
    { "Duneride", 110, 100.0, 3000000 },
    { "Sweeper", 60, 100.0, 1200000 },
    { "Broadway", 160, 100.0, 27000 },
    { "Tornado", 160, 42.5, 37000 },            // 576 - Tornado
    { "AT-400", 200, 100.0, 42000000 },
    { "DFT-30", 110, 100.0, 4800000 },
    { "Huntley", 160, 100.0, 85000 },
    { "Stafford", 165, 100.0, 135000 },
    { "BF-400", 190, 100.0, 50000 },
    { "Newsvan", 160, 100.0, 2400000 },
    { "Tug", 170, 100.0, 1200000 },
    { "Trailer", 120, 100.0, 0 },
    { "Emperor", 165, 100.0, 25000 },
    { "Wayfarer", 190, 100.0, 80000 },
    { "Euros", 200, 100.0, 130000 },
    { "Hotdog", 140, 100.0, 1800000 },
    { "Club", 200, 100.0, 35000 },
    { "Trailer", 110, 100.0, 0 },
    { "Trailer", 120, 100.0, 0 },
    { "Andromada", 200, 100.0, 42000000 },
    { "Dodo", 200, 100.0, 18000000 },
    { "RC Cam", 60, 100.0, 36000000 },
    { "Launch", 190, 100.0, 0 },
    { "Police Car", 200, 100.0, 18000000 },
    { "Police Car", 200, 100.0, 18000000 },
    { "Police Car", 200, 100.0, 18000000 },
    { "Police Ranger", 160, 100.0, 18000000 },
    { "Picador", 165, 100.0, 21000 },
    { "S.W.A.T. Van", 110, 100.0, 60000000 },
    { "Alpha", 200, 100.0, 120000 },
    { "Phoenix", 200, 100.0, 180000 },
    { "Glendale", 160, 100.0, 19000 },
    { "Sadler", 165, 100.0, 7000 },
    { "Luggage Trailer", 160, 100.0, 0 },
    { "Luggage Trailer", 160, 100.0, 0 },
    { "Stair Trailer", 160, 100.0, 0 },
    { "Boxville", 140, 100.0, 90000 },
    { "Farm Plow", 160, 100.0, 0 },
    { "Utility Trailer", 160, 100.0, 0 }
};

new const g_rgiVehicleColoursTableRGBA[256] = {
    // The existing colours from San Andreas
    0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
    0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
    0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
    0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
    0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
    0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
    0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
    0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
    0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
    0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
    0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
    0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
    0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
    // SA-MP extended colours (0.3x)
    0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
    0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
    0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
    0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
    0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
    0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
    0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
    0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
    0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
    0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
    0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
    0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
    0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

new
    g_rgiSpeedometerUpdateTimer[MAX_PLAYERS];
    
#define Vehicle_GetModelName(%0) (g_rgeVehicleModelData[(%0) - 400][e_szModelName])
#define Vehicle_GetModelMaxSpeed(%0) (g_rgeVehicleModelData[(%0) - 400][e_iMaxSpeed])
#define Vehicle_GetModelMaxFuel(%0) (g_rgeVehicleModelData[(%0) - 400][e_fMaxFuel])
#define Vehicle_GetModelPrice(%0) (g_rgeVehicleModelData[(%0) - 400][e_iPrice])

forward Vehicle_Create(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, bool:addsiren = false, bool:static_veh = false);
#define Vehicle_ID(%0) (g_rgeVehicles[(%0)][e_iVehicleDbId])
#define Vehicle_OwnerId(%0) (g_rgeVehicles[(%0)][e_iVehicleOwnerId])
#define Vehicle_Type(%0) (g_rgeVehicles[(%0)][e_iVehicleType])
#define Vehicle_Job(%0) (g_rgeVehicles[(%0)][e_iVehicleWork])
#define Vehicle_Fuel(%0) (g_rgeVehicles[(%0)][e_fFuel])
#define Vehicle_Locked(%0) (g_rgeVehicles[(%0)][e_bLocked])
forward Vehicle_SetHealth(vehicleid, Float:health);
forward Vehicle_Repair(vehicleid);
#define Vehicle_GetHealth(%0) (g_rgeVehicles[(%0)][e_fHealth])
#define Vehicle_SetVirtualWorld(%0,%1) (g_rgeVehicles[(%0)][e_iVehWorld] = (%1), SetVehicleVirtualWorld((%0), (%1)))
#define Vehicle_GetVirtualWorld(%0) (g_rgeVehicles[(%0)][e_iVehWorld])
#define Vehicle_SetInterior(%0,%1) (g_rgeVehicles[(%0)][e_iVehInterior] = (%1), LinkVehicleToInterior((%0), (%1)))
#define Vehicle_GetInterior(%0) (g_rgeVehicles[(%0)][e_iVehInterior])
#define Vehicle_Repairing(%0) (g_rgeVehicles[(%0)][e_bRepairing])
forward Vehicle_Respawn(vehicleid);

#define Speedometer_Shown(%0) (IsTextDrawVisibleForPlayer(playerid, g_tdSpeedometer[0]))

forward VEHICLE_Update(vehicleid);
forward Speedometer_Update(playerid);
forward VEHICLE_ToggleEngineTimer(playerid, vehicleid);