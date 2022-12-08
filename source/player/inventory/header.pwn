#if defined _inventory_header_
    #endinput
#endif
#define _inventory_header_

const HYAXE_MAX_INVENTORY_SLOTS = 21;
const HYAXE_MAX_TRUNK_SLOTS = 14;
const HYAXE_MAX_DROPPED_ITEMS = 2048;
const Float:EXP_BAR_MIN_X = 220.500;
const Float:EXP_BAR_MAX_X = 408.0;

enum _:eItems 
{
    ITEM_MEDIC_KIT,
    ITEM_MEDICINE,
    ITEM_CRACK,
    ITEM_PETROL_CAN,
    ITEM_PHONE,
    ITEM_REPAIR_KIT,
    ITEM_PORRETE,
    ITEM_BURRITO,
    ITEM_BURGER,
    ITEM_MEAT,
    ITEM_HAM,
    ITEM_ORANGE,
    ITEM_TOAST,
    ITEM_MILK,
    ITEM_ORANGE_JUICE,
    ITEM_APPLE_JUICE,
    ITEM_KETCHUP,
    ITEM_CHOCOLATE_ICE_CREAM,
    ITEM_STRAWBERRY_ICE_CREAM,
    ITEM_PIZZA,
    ITEM_CEPITA,
    ITEM_BEER,
    ITEM_WISKY,
    ITEM_CHAMPAGNE,
    ITEM_CRAFT_BEER,
    ITEM_CHICKEN,
    ITEM_COFFEE,
    ITEM_SANGUCHEDEMILANESA,
    ITEM_FISHING_ROD,
    ITEM_FISH,
    ITEM_BRASSKNUCKLE,
    ITEM_GOLFCLUB,
    ITEM_NITESTICK,
    ITEM_KNIFE,
    ITEM_BAT,
    ITEM_SHOVEL,
    ITEM_POOLSTICK,
    ITEM_KATANA,
    ITEM_CHAINSAW,
    ITEM_DILDO,
    ITEM_DILDO2,
    ITEM_VIBRATOR,
    ITEM_VIBRATOR2,
    ITEM_FLOWER,
    ITEM_CANE,
    ITEM_GRENADE,
    ITEM_TEARGAS,
    ITEM_MOLTOV,
    ITEM_COLT45,
    ITEM_SILENCED,
    ITEM_DEAGLE,
    ITEM_SHOTGUN,
    ITEM_SAWEDOFF,
    ITEM_SHOTGSPA,
    ITEM_UZI,
    ITEM_MP5,
    ITEM_AK47,
    ITEM_M4,
    ITEM_TEC9,
    ITEM_RIFLE,
    ITEM_SNIPER,
    ITEM_ROCKETLAUNCHER,
    ITEM_HEATSEEKER,
    ITEM_FLAMETHROWER,
    ITEM_MINIGUN,
    ITEM_SATCHEL,
    ITEM_BOMB,
    ITEM_SPRAYCAN,
    ITEM_FIREEXTINGUISHER,
    ITEM_CAMERA,
    ITEM_PARACHUTE,
    ITEM_FLAG,
    ITEM_HOTDOG,
    ITEM_PUMPKIN,
    ITEM_GIFT,
    ITEM_FIREWORK_LAUNCHER,
    ITEM_COCONUT_CHARGE,
    ITEM_STROBE_CHARGE,
    ITEM_COLORED_CHARGE,
    ITEM_FISH_CHARGE,
    ITEM_WAVE_CHARGE,
    ITEM_RING_CHARGE,
    ITEM_DYNAMITE,
    ITEM_MONEY,

	ITEM_INVALID
};

enum _:eRarityLevels {
    RARITY_COMMON,
    RARITY_RARE,
    RARITY_EPIC,
    RARITY_LEGENDARY,
    RARITY_MYTHIC
}

enum eItemData 
{
    // General parameters
    e_szName[64],
    e_iModelID,
    bool:e_bSingleSlot,
    e_iCallback,
    e_iRarityLevel,

    // Textdraw parameters
    Float:e_fRotX,
    Float:e_fRotY,
    Float:e_fRotZ,
    Float:e_fZoom,

    // Food parameters
    bool:e_bPuke,
    e_iDrunkLevel,
    Float:e_fHunger,
    Float:e_fThirst
}

enum eInventory 
{
    bool:e_bValid,
    e_iID,
    e_iType,
    e_iAmount,
    e_iExtra
};

new 
    g_rgeItemData[eItems][eItemData] = {
		{"Botiquín", 11738, true, -1}, // ITEM_MEDIC_KIT
		{"Medicamento", 11736, false, -1}, // ITEM_MEDICINE
		{"Crack", 1575, false, -1}, // ITEM_CRACK
		{"Bidón de gasolina", 1650, true, -1}, // ITEM_PETROL_CAN
		{"Celular", 18866, true, -1}, // ITEM_PHONE
		{"Kit de reparación", 19921, true, -1}, // ITEM_REPAIR_KIT
		{"Porro", 3027, true, -1}, // ITEM_PORRETE
		{"Burrito", 2769, true, -1}, // ITEM_BURRITO
		{"Hamburguesa", 2703, true, -1}, // ITEM_BURGER
		{"Carne cruda", 2804, true, -1}, // ITEM_MEAT
		{"Jamon", 19847, true, -1}, // ITEM_HAM
		{"Naranja", 19574, true, -1}, // ITEM_ORANGE
		{"Tostada", 19883, true, -1}, // ITEM_TOAST
		{"Leche", 19569, true, -1}, // ITEM_MILK
		{"Jugo de naranja", 19563, true, -1}, // ITEM_ORANGE_JUICE
		{"Jugo de manzana", 19564, true, -1}, // ITEM_APPLE_JUICE
		{"Ketchup", 11722, true, -1}, // ITEM_KETCHUP
		{"Helado de chocolate", 19567, true, -1}, // ITEM_CHOCOLATE_ICE_CREAM
		{"Helado de frutilla", 19568, true, -1}, // ITEM_STRAWBERRY_ICE_CREAM
		{"Pizza", 2814, true, -1}, // ITEM_PIZZA
		{"Cepita", 19564, true, -1}, // ITEM_CEPITA
		{"Cerveza", 1484, true, -1}, // ITEM_BEER
		{"Wisky", 19823, true, -1}, // ITEM_WISKY
		{"Champagne", 19824, true, -1}, // ITEM_CHAMPAGNE
		{"Cerveza artesanal", 1544, true, -1}, // ITEM_CRAFT_BEER
		{"Pollo", 2768, true, -1}, // ITEM_CHICKEN
		{"Cafe", 19835, true, -1}, // ITEM_COFFEE
		{"Sanguche de milanesa", 2703, true, -1}, // ITEM_SANGUCHEDEMILANESA
        {"Caña de pescar", 18632, true, -1}, // ITEM_FISHING_ROD
        {"Pescado", 19630, false, -1}, // ITEM_FISH
        {"Manopla", 331, true, -1}, // ITEM_BRASSKNUCKLE
        {"Palo de golf", 333, true, -1}, // ITEM_GOLFCLUB
        {"Porra", 334, true, -1}, // ITEM_NITESTICK
        {"Cuchillo", 335, true, -1}, // ITEM_KNIFE
        {"Bate", 336, true, -1}, // ITEM_BAT
        {"Pala", 337, true, -1}, // ITEM_SHOVEL
        {"Palo de billas", 338, true, -1}, // ITEM_POOLSTICK
        {"Katana", 339, true, -1}, // ITEM_KATANA
        {"Motosierra", 341, true, -1}, // ITEM_CHAINSAW
        {"Dildo poderoso", 321, true, -1}, // ITEM_DILDO
        {"Dildo", 322, true, -1}, // ITEM_DILDO2
        {"Vibrador", 323, true, -1}, // ITEM_VIBRATOR
        {"Vibrador plateado", 324, true, -1}, // ITEM_VIBRATOR2
        {"Flores", 325, true, -1}, // ITEM_FLOWER
        {"Baston", 326, true, -1}, // ITEM_CANE
        {"Granada", 342, true, -1}, // ITEM_GRENADE
        {"Gas lacrimogeno", 343, true, -1}, // ITEM_TEARGAS
        {"Cocktail Molotov", 344, true, -1}, // ITEM_MOLTOV
        {"9mm", 346, true, -1}, // ITEM_COLT45
        {"9mm silenciada", 347, true, -1}, // ITEM_SILENCED
        {"Desert Eagle", 348, true, -1}, // ITEM_DEAGLE
        {"Escopeta", 349, true, -1}, // ITEM_SHOTGUN
        {"Escopeta recortada", 350, true, -1}, // ITEM_SAWEDOFF
        {"Escopeta de combate", 351, true, -1}, // ITEM_SHOTGSPA
        {"Uzi", 352, true, -1}, // ITEM_UZI
        {"MP5", 353, true, -1}, // ITEM_MP5
        {"Ak-47", 355, true, -1}, // ITEM_AK47
        {"M4", 356, true, -1}, // ITEM_M4
        {"Tec-9", 372, true, -1}, // ITEM_TEC9
        {"Rifle", 357, true, -1}, // ITEM_RIFLE
        {"Sniper", 358, true, -1}, // ITEM_SNIPER
        {"Lanzacohetes RPG", 359, true, -1}, // ITEM_ROCKETLAUNCHER
        {"Lanzacohetes HS", 360, true, -1}, // ITEM_HEATSEEKER
        {"Lanzallamas", 361, true, -1}, // ITEM_FLAMETHROWER
        {"Minigun", 362, true, -1}, // ITEM_MINIGUN
        {"Satchel", 363, true, -1}, // ITEM_SATCHEL
        {"Detonador", 364, true, -1}, // ITEM_BOMB
        {"Bote de spray", 365, true, -1}, // ITEM_SPRAYCAN
        {"Extintor", 366, true, -1}, // ITEM_FIREEXTINGUISHER
        {"Camara", 367, true, -1}, // ITEM_CAMERA
        {"Paracaidas", 371, true, -1}, // ITEM_PARACHUTE
        {"Bandera", 19306, true, -1}, // ITEM_FLAG
        {"Pancho", 19346, true, -1}, // ITEM_HOTDOG
        {"Calabaza", 19320, false, -1}, // ITEM_PUMPKIN
        {"Regalo", 19054, false, -1}, // ITEM_GIFT
        {"Lanzador", 3013, true, -1}, // ITEM_FIREWORK_LAUNCHER
        {"Carga Coconut", 1636, true, -1}, // ITEM_COCONUT_CHARGE
        {"Carga Strobe", 1636, true, -1}, // ITEM_STROBE_CHARGE
        {"Carga Colored Sphere", 1636, true, -1}, // ITEM_COLORED_CHARGE
        {"Carga Fish", 1636, true, -1}, // ITEM_FISH_CHARGE
        {"Carga Wave", 1636, true, -1}, // ITEM_WAVE_CHARGE
        {"Carga Ring", 1636, true, -1}, // ITEM_RING_CHARGE
        {"Dinamita", 1654, true, -1}, // ITEM_DYNAMITE
        {"Dinero", 1212, false, -1}, // ITEM_MONEY

		{"Invalid item", 18631, false, -1} // ITEM_INVALID
	},
    g_rgePlayerInventory[MAX_PLAYERS + 1][HYAXE_MAX_INVENTORY_SLOTS][eInventory],
    g_rgszRarityName[][] = {
        "~h~~g~COMÚN", "~h~~p~RARO", "~h~~b~ÉPICO", "~h~~y~LEGENDARIO", "~h~~r~MÍTICO"
    },
    Iterator:DroppedItems<HYAXE_MAX_DROPPED_ITEMS>
;

#define Item_Name(%0) (g_rgeItemData[(%0)][e_szName])
#define Item_ModelID(%0) (g_rgeItemData[(%0)][e_iModelID])
#define Item_SingleSlot(%0) (g_rgeItemData[(%0)][e_bSingleSlot])
#define Item_Callback(%0) (g_rgeItemData[(%0)][e_iCallback])
#define Item_Hunger(%0) (g_rgeItemData[(%0)][e_fHunger])
#define Item_Thirst(%0) (g_rgeItemData[(%0)][e_fThirst])
#define Item_Puke(%0) (g_rgeItemData[(%0)][e_bPuke])
#define Item_DrunkLevel(%0) (g_rgeItemData[(%0)][e_iDrunkLevel])
#define Item_RarityName(%0) (g_rgszRarityName[(%0)])
#define Item_Rarity(%0) (g_rgeItemData[(%0)][e_iRarityLevel])

#define InventorySlot_ID(%0,%1) (g_rgePlayerInventory[(%0)][(%1)][e_iID])
#define InventorySlot_Amount(%0,%1) (g_rgePlayerInventory[(%0)][(%1)][e_iAmount])
#define InventorySlot_Type(%0,%1) (g_rgePlayerInventory[(%0)][(%1)][e_iType])
#define InventorySlot_Extra(%0,%1) (g_rgePlayerInventory[(%0)][(%1)][e_iExtra])
#define InventorySlot_IsValid(%0,%1) (g_rgePlayerInventory[(%0)][(%1)][e_bValid])

#define TrunkSlot_ID(%0,%1) (g_rgeVehicleTrunk[(%0)][(%1)][e_iID])
#define TrunkSlot_Amount(%0,%1) (g_rgeVehicleTrunk[(%0)][(%1)][e_iAmount])
#define TrunkSlot_Type(%0,%1) (g_rgeVehicleTrunk[(%0)][(%1)][e_iType])
#define TrunkSlot_Extra(%0,%1) (g_rgeVehicleTrunk[(%0)][(%1)][e_iExtra])
#define TrunkSlot_IsValid(%0,%1) (g_rgeVehicleTrunk[(%0)][(%1)][e_bValid])

forward Inventory_GetItemAmount(playerid, type);
forward Inventory_AddFixedItem(playerid, type, amount, extra);
