#if defined _clothing_functions_
    #endinput
#endif
#define _clothing_functions_

Clothing_CreateArea(store_type, Float:x, Float:y, Float:z, interior)
{
    new info[2];
    info[0] = 0x434c53; // CLS
    info[1] = store_type; // Store type

    new area = CreateDynamicSphere(
        x, y, z, 1.8,
        .worldid = -1, .interiorid = interior
    );
    Streamer_SetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_EXTRA_ID, info);

    Key_Alert(
        x, y, z, 1.2,
        KEYNAME_YES, -1, interior
    );

    CreateDynamic3DTextLabel("{CB3126}Tienda de ropa{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, x, y, z, 10.0, .testlos = 1, .worldid = -1, .interiorid = interior);
    return 1;
}