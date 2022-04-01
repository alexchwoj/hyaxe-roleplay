#if defined _inventory_header_
    #endinput
#endif
#define _inventory_header_

const HYAXE_MAX_INVENTORY_SLOTS = 21;
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
    ITEM_COFFE,
    ITEM_SANGUCHEDEMILANESA,

	ITEM_INVALID
};

enum eItemData 
{
    e_szName[64],
    e_iModelID,
    bool:e_bSingleSlot,
    e_iCallback
}

enum ePlayerInventory 
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
		{"Cafe", 19835, true, -1}, // ITEM_COFFE
		{"Sanguche de milanesa", 2703, true, -1}, // ITEM_SANGUCHEDEMILANESA

		{"Invalid item", 18631, false, -1} // ITEM_INVALID
	},
    g_rgePlayerInventory[MAX_PLAYERS + 1][HYAXE_MAX_INVENTORY_SLOTS][ePlayerInventory],
    Iterator:DroppedItems<HYAXE_MAX_DROPPED_ITEMS>
;

#define Item_Name(%0) (g_rgeItemData[%0][e_szName])
#define Item_ModelID(%0) (g_rgeItemData[%0][e_iModelID])
#define Item_SingleSlot(%0) (g_rgeItemData[%0][e_bSingleSlot])
#define Item_Callback(%0) (g_rgeItemData[%0][e_iCallback])
#define InventorySlot_ID(%0,%1) (g_rgePlayerInventory[%0][%1][e_iID])
#define InventorySlot_Amount(%0,%1) (g_rgePlayerInventory[%0][%1][e_iAmount])
#define InventorySlot_Type(%0,%1) (g_rgePlayerInventory[%0][%1][e_iType])
#define InventorySlot_Extra(%0,%1) (g_rgePlayerInventory[%0][%1][e_iExtra])
#define InventorySlot_IsValid(%0,%1) (g_rgePlayerInventory[%0][%1][e_bValid])