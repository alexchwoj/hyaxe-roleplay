#if defined _inventory_header_
    #endinput
#endif
#define _inventory_header_

const HYAXE_MAX_INVENTORY_SLOTS = 21;
const Float:EXP_BAR_MIN_X = 220.500;
const Float:EXP_BAR_MAX_X = 408.0;

enum _:eItems {
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
}

enum eItemData {
    e_szName[64],
    e_iModelID,
    bool:e_bSingleSlot
}

enum ePlayerInventory {
    bool:e_bValid,
    e_iID,
    e_iType,
    e_iAmount,
    e_iExtra
};

new 
    g_rgeItemData[eItems][eItemData] = {
		{"Botiquín", 11738, true}, // ITEM_MEDIC_KIT
		{"Medicamento", 11736, false}, // ITEM_MEDICINE
		{"Crack", 1575, false}, // ITEM_CRACK
		{"Bidón de gasolina", 1650, true}, // ITEM_PETROL_CAN
		{"Celular", 18866, true}, // ITEM_PHONE
		{"Kit de reparación", 19921, true}, // ITEM_REPAIR_KIT
		{"Porro", 3027, false}, // ITEM_PORRETE
		{"Burrito", 2769, false}, // ITEM_BURRITO
		{"Hamburguesa", 2703, false}, // ITEM_BURGER
		{"Carne cruda", 2804, false}, // ITEM_MEAT
		{"Jamon", 19847, false}, // ITEM_HAM
		{"Naranja", 19574, false}, // ITEM_ORANGE
		{"Tostada", 19883, false}, // ITEM_TOAST
		{"Leche", 19569, false}, // ITEM_MILK
		{"Jugo de naranja", 19563, false}, // ITEM_ORANGE_JUICE
		{"Jugo de manzana", 19564, false}, // ITEM_APPLE_JUICE
		{"Ketchup", 11722, false}, // ITEM_KETCHUP
		{"Helado de chocolate", 19567, true}, // ITEM_CHOCOLATE_ICE_CREAM
		{"Helado de frutilla", 19568, true}, // ITEM_STRAWBERRY_ICE_CREAM
		{"Pizza", 2814, true}, // ITEM_PIZZA
		{"Cepita", 19564, false}, // ITEM_CEPITA
		{"Cerveza", 1484, false}, // ITEM_BEER
		{"Wisky", 19823, false}, // ITEM_WISKY
		{"Champagne", 19824, false}, // ITEM_CHAMPAGNE
		{"Cerveza artesanal", 1544, false}, // ITEM_CRAFT_BEER
		{"Pollo", 2768, false}, // ITEM_CHICKEN
		{"Cafe", 19835, false}, // ITEM_COFFE
		{"Sanguche de milanesa", 2703, false}, // ITEM_SANGUCHEDEMILANESA

		{"Invalid item", 18631, false} // ITEM_INVALID
	},
    g_rgePlayerInventory[MAX_PLAYERS + 1][HYAXE_MAX_INVENTORY_SLOTS][ePlayerInventory]
;

#define Item_Name(%0) (g_rgeItemData[%0][e_szName])
#define Item_ModelID(%0) (g_rgeItemData[%0][e_iModelID])
#define Item_SingleSlot(%0) (g_rgeItemData[%0][e_bSingleSlot])
#define InventorySlot_Amount(%0,%1) (g_rgePlayerInventory[%0][%1][e_iAmount])
#define InventorySlot_Type(%0,%1) (g_rgePlayerInventory[%0][%1][e_iType])
#define InventorySlot_Extra(%0,%1) (g_rgePlayerInventory[%0][%1][e_iExtra])
#define InventorySlot_IsValid(%0,%1) (g_rgePlayerInventory[%0][%1][e_bValid])