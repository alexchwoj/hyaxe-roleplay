#if defined _vehicles_header_
    #endinput
#endif
#define _vehicles_header_

const MIN_VEHICLE_MODEL = 400;
const MAX_VEHICLE_MODEL = 611;
const MAX_VEHICLE_MODELS = MAX_VEHICLE_MODEL - MIN_VEHICLE_MODEL;
const Float:VEHICLE_FUEL_DIVISOR = 100.0;

new
    IteratorArray:PlayerVehicles[MAX_PLAYERS]<MAX_VEHICLES>;
    
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
    VEHICLE_TYPE_DEALERSHIP
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

    e_iVehicleTimers[eVehicleTimers]
};

new g_rgeVehicles[MAX_VEHICLES][eVehicleData];

enum eVehicleModelData
{
    e_szModelName[20],
    e_iMaxSpeed,
    Float:e_fMaxFuel,
    e_iPrice
};

new const g_rgeVehicleModelData[MAX_VEHICLE_MODELS + 1][eVehicleModelData] = {
    { "Landstalker", 160, 100.0, 0 },           // 400
    { "Bravura", 160, 50.0, 0 },            // 401 - Bravura
    { "Buffalo", 200, 100.0, 0 },
    { "Linerunner", 120, 100.0, 0 },
    { "Pereniel", 150, 100.0, 0 },
    { "Sentinel", 165, 100.0, 0 },
    { "Dumper", 110, 100.0, 0 },
    { "Firetruck", 170, 100.0, 0 },
    { "Trashmaster", 110, 100.0, 0 },
    { "Stretch", 180, 100.0, 0 },
    { "Manana", 160, 55.0, 0 },            // 410 - Manana
    { "Infernus", 240, 100.0, 0 },
    { "Voodoo", 160, 45.0, 0 },            // 412 - Voodoo
    { "Pony", 160, 100.0, 0 },
    { "Mule", 140, 100.0, 0 },
    { "Cheetah", 230, 100.0, 0 },
    { "Ambulance", 155, 100.0, 0 },
    { "Leviathan", 200, 100.0, 0 },
    { "Moonbeam", 150, 75.0, 0 },            // 418 - Moonbeam
    { "Esperanto", 160, 50.0, 0 },            // 419 - Esperanto
    { "Taxi", 180, 100.0, 0 },
    { "Washington", 180, 100.0, 0 },
    { "Bobcat", 165, 100.0, 0 },
    { "Mr Whoopee", 145, 100.0, 0 },
    { "BF Injection", 170, 100.0, 0 },
    { "Hunter", 200, 100.0, 0 },
    { "Premier", 200, 50.0, 0 },            // 426 - Premier
    { "Enforcer", 170, 100.0, 0 },
    { "Securicar", 170, 100.0, 0 },
    { "Banshee", 200, 100.0, 0 },
    { "Predator", 190, 100.0, 0 },
    { "Bus", 130, 100.0, 0 },
    { "Rhino", 80, 100.0, 0 },
    { "Barracks", 180, 100.0, 0 },
    { "Hotknife", 200, 100.0, 0 },
    { "Trailer", 120, 100.0, 0 },
    { "Previon", 160, 100.0, 0 },           // 436 - Previon
    { "Coach", 160, 100.0, 0 },
    { "Cabbie", 160, 100.0, 0 },
    { "Stallion", 160, 100.0, 0 },
    { "Rumpo", 160, 100.0, 0 },
    { "RC Bandit", 75, 100.0, 0 },
    { "Romero", 150, 100.0, 0 },
    { "Packer", 150, 100.0, 0 },
    { "Monster", 110, 100.0, 0 },
    { "Admiral", 165, 100.0, 0 },
    { "Squalo", 280, 100.0, 0 },
    { "Seasparrow", 200, 100.0, 0 },
    { "Pizzaboy", 190, 100.0, 0 },
    { "Tram", 150, 100.0, 0 },
    { "Trailer", 120, 100.0, 0 },
    { "Turismo", 240, 100.0, 0 },
    { "Speeder", 190, 100.0, 0 },
    { "Reefer", 190, 100.0, 0 },
    { "Tropic", 190, 100.0, 0 },
    { "Flatbed", 140, 100.0, 0 },
    { "Yankee", 160, 100.0, 0 },
    { "Caddy", 160, 100.0, 0 },
    { "Solair", 165, 60.0, 0 },            // 458 - Solair
    { "Berkley's RC Van", 160, 100.0, 0 },
    { "Skimmer", 200, 100.0, 0 },
    { "PCJ-600", 190, 20.0, 0 },            // 461 - PCJ-600
    { "Faggio", 190, 25.0, 0 },            // 462 - Faggio
    { "Freeway", 190, 100.0, 0 },
    { "RC Baron", 75, 100.0, 0 },
    { "RC Raider", 75, 100.0, 0 },
    { "Glendale", 160, 100.0, 0 },
    { "Oceanic", 160, 100.0, 0 },
    { "Sanchez", 190, 100.0, 0 },
    { "Sparrow", 200, 100.0, 0 },
    { "Patriot", 170, 100.0, 0 },
    { "Quad", 160, 100.0, 0 },
    { "Coastguard", 190, 100.0, 0 },
    { "Dinghy", 190, 100.0, 0 },
    { "Hermes", 160, 100.0, 0 },
    { "Sabre", 160, 100.0, 0 },
    { "Rustler", 200, 100.0, 0 },
    { "ZR-350", 200, 100.0, 0 },
    { "Walton", 150, 100.0, 0 },
    { "Regina", 165, 100.0, 0 },
    { "Comet", 200, 100.0, 0 },
    { "BMX", 120, 100.0, 0 },
    { "Burrito", 150, 80.0, 0 },            // 482 - Burrito
    { "Camper", 120, 100.0, 0 },
    { "Marquis", 190, 100.0, 0 },
    { "Baggage", 160, 100.0, 0 },
    { "Dozer", 100, 100.0, 0 },
    { "Maverick", 200, 100.0, 0 },
    { "News Chopper", 200, 100.0, 0 },
    { "Rancher", 170, 100.0, 0 },
    { "FBI Rancher", 170, 100.0, 0 },
    { "Virgo", 160, 45.0, 0 },            // 491 - Virgo
    { "Greenwood", 160, 50.0, 0 },            // 492 - Greenwood
    { "Jetmax", 190, 100.0, 0 },
    { "Hotring", 220, 100.0, 0 },
    { "Sandking", 170, 100.0, 0 },
    { "Blista", 200, 100.0, 0 },
    { "Police Maverick", 200, 100.0, 0 },
    { "Boxville", 140, 100.0, 0 },
    { "Benson", 140, 100.0, 0 },
    { "Mesa", 160, 100.0, 0 },
    { "RC Goblin", 75, 100.0, 0 },
    { "Hotring-Racer", 220, 100.0, 0 },
    { "Hotring-Racer", 220, 100.0, 0 },
    { "Bloodring-Banger", 160, 100.0, 0 },
    { "Rancher", 170, 100.0, 0 },
    { "Super-GT", 230, 100.0, 0 },
    { "Elegant", 165, 55.0, 0 },            // 507 - Elegant
    { "Journey", 140, 100.0, 0 },
    { "Bike", 120, 100.0, 0 },
    { "Mountain Bike", 140, 100.0, 0 },
    { "Beagle", 200, 100.0, 0 },
    { "Cropdust", 200, 100.0, 0 },
    { "Stunt", 200, 100.0, 0 },
    { "Tanker", 120, 100.0, 0 },
    { "RoadTrain", 120, 100.0, 0 },
    { "Nebula", 165, 65.0, 0 },            // 516 - Nebula
    { "Majestic", 165, 50.0, 0 },            // 517 - Majestic
    { "Buccaneer", 160, 52.5, 0 },            // 518 - Buccaneer
    { "Shamal", 330, 100.0, 0 },
    { "Hydra", 330, 100.0, 0 },
    { "FCR-900", 190, 27.5, 0 },            // 521 - FCR-900
    { "NRG-500", 190, 30.0, 0 },            // 522 - NRG-500
    { "HPV1000", 190, 100.0, 0 },
    { "Cement Truck", 110, 100.0, 0 },
    { "Tow Truck", 160, 100.0, 0 },
    { "Fortune", 160, 100.0, 0 },
    { "Cadrona", 160, 100.0, 0 },
    { "FBI Truck", 170, 100.0, 0 },
    { "Willard", 160, 100.0, 0 },
    { "Forklift", 60, 100.0, 0 },
    { "Tractor", 70, 100.0, 0 },
    { "Combine", 140, 100.0, 0 },
    { "Feltzer", 200, 100.0, 0 },
    { "Remington", 160, 57.5, 0 },            // 534 - Remington
    { "Slamvan", 160, 65.0, 0 },            // 535 - Slamvan
    { "Blade", 160, 50.0, 0 },            // 536  Blade
    { "Freight", 110, 100.0, 0 },
    { "Streak", 110, 100.0, 0 },
    { "Vortex", 150, 100.0, 0 },
    { "Vincent", 160, 100.0, 0 },
    { "Bullet", 230, 100.0, 0 },
    { "Clover", 160, 100.0, 0 },
    { "Sadler", 165, 100.0, 0 },
    { "Firetruck", 170, 100.0, 0 },
    { "Hustler", 160, 100.0, 0 },
    { "Intruder", 160, 100.0, 0 },
    { "Primo", 160, 50.0, 0 },            // 547 - Primo
    { "Cargobob", 200, 100.0, 0 },
    { "Tampa", 160, 100.0, 0 },
    { "Sunrise", 160, 100.0, 0 },
    { "Merit", 165, 100.0, 0 },
    { "Utility", 160, 100.0, 0 },
    { "Nevada", 200, 100.0, 0 },
    { "Yosemite", 170, 100.0, 0 },
    { "Windsor", 180, 100.0, 0 },
    { "Monster Truck A", 110, 100.0, 0 },
    { "Monster Truck B", 110, 100.0, 0 },
    { "Uranus", 200, 100.0, 0 },
    { "Jester", 200, 100.0, 0 },
    { "Sultan", 200, 100.0, 0 },
    { "Stratum", 200, 100.0, 0 },
    { "Elegy", 200, 100.0, 0 },
    { "Raindance", 200, 100.0, 0 },
    { "RC Tiger", 75, 100.0, 0 },
    { "Flash", 200, 100.0, 0 },
    { "Tahoma", 160, 100.0, 0 },
    { "Savanna", 160, 45.0, 0 },            // 567 - Savanna
    { "Bandito", 170, 100.0, 0 },
    { "Freight", 110, 100.0, 0 },
    { "Trailer", 110, 100.0, 0 },
    { "Kart", 90, 100.0, 0 },
    { "Mower", 60, 100.0, 0 },
    { "Duneride", 110, 100.0, 0 },
    { "Sweeper", 60, 100.0, 0 },
    { "Broadway", 160, 100.0, 0 },
    { "Tornado", 160, 42.5, 0 },            // 576 - Tornado
    { "AT-400", 200, 100.0, 0 },
    { "DFT-30", 110, 100.0, 0 },
    { "Huntley", 160, 100.0, 0 },
    { "Stafford", 165, 100.0, 0 },
    { "BF-400", 190, 100.0, 0 },
    { "Newsvan", 160, 100.0, 0 },
    { "Tug", 170, 100.0, 0 },
    { "Trailer", 120, 100.0, 0 },
    { "Emperor", 165, 100.0, 0 },
    { "Wayfarer", 190, 100.0, 0 },
    { "Euros", 200, 100.0, 0 },
    { "Hotdog", 140, 100.0, 0 },
    { "Club", 200, 100.0, 0 },
    { "Trailer", 110, 100.0, 0 },
    { "Trailer", 120, 100.0, 0 },
    { "Andromada", 200, 100.0, 0 },
    { "Dodo", 200, 100.0, 0 },
    { "RC Cam", 60, 100.0, 0 },
    { "Launch", 190, 100.0, 0 },
    { "Police Car", 200, 100.0, 0 },
    { "Police Car", 200, 100.0, 0 },
    { "Police Car", 200, 100.0, 0 },
    { "Police Ranger", 160, 100.0, 0 },
    { "Picador", 165, 100.0, 0 },
    { "S.W.A.T. Van", 110, 100.0, 0 },
    { "Alpha", 200, 100.0, 0 },
    { "Phoenix", 200, 100.0, 0 },
    { "Glendale", 160, 100.0, 0 },
    { "Sadler", 165, 100.0, 0 },
    { "Luggage Trailer", 160, 100.0, 0 },
    { "Luggage Trailer", 160, 100.0, 0 },
    { "Stair Trailer", 160, 100.0, 0 },
    { "Boxville", 140, 100.0, 0 },
    { "Farm Plow", 160, 100.0, 0 },
    { "Utility Trailer", 160, 100.0, 0 }
};

new
    g_rgiSpeedometerUpdateTimer[MAX_PLAYERS];

#define Vehicle_GetModelName(%0) (g_rgeVehicleModelData[(%0) - 400][e_szModelName])
#define Vehicle_GetModelMaxSpeed(%0) (g_rgeVehicleModelData[(%0) - 400][e_iMaxSpeed])
#define Vehicle_GetModelMaxFuel(%0) (g_rgeVehicleModelData[(%0) - 400][e_fMaxFuel])
#define Vehicle_GetModelPrice(%0) (g_rgeVehicleModelData[(%0) - 400][e_iPrice])

#define Vehicle_Type(%0) (g_rgeVehicles[(%0)][e_iVehicleType])
#define Vehicle_Fuel(%0) (g_rgeVehicles[(%0)][e_fFuel])
#define Vehicle_Repair(%0) (g_rgeVehicles[(%0)][e_fHealth] = 1000.0, RepairVehicle(%0))
#define Vehicle_SetHealth(%0,%1) (g_rgeVehicles[(%0)][e_fHealth] = (%1), SetVehicleHealth((%0), (%1)))
#define Vehicle_GetHealth(%0) (g_rgeVehicles[(%0)][e_fHealth])
#define Vehicle_SetVirtualWorld(%0,%1) (g_rgeVehicles[(%0)][e_iVehWorld] = (%1), SetVehicleVirtualWorld((%0), (%1)))
#define Vehicle_GetVirtualWorld(%0) (g_rgeVehicles[(%0)][e_iVehWorld])
#define Vehicle_SetInterior(%0,%1) (g_rgeVehicles[(%0)][e_iVehInterior] = (%1), LinkVehicleToInterior((%0), (%1)))
#define Vehicle_GetInterior(%0) (g_rgeVehicles[(%0)][e_iVehInterior])

forward VEHICLE_Update(vehicleid);
forward VEHICLE_UpdateSpeedometer(playerid);
forward VEHICLE_ToggleEngineTimer(playerid, vehicleid);