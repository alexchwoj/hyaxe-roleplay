#if defined _clothing_callbacks_
    #endinput
#endif
#define _clothing_callbacks_

static Cosmetics_OnPress(playerid)
{
    GetPlayerPos(playerid, s_rgfPreviousPositions[playerid][0], s_rgfPreviousPositions[playerid][1], s_rgfPreviousPositions[playerid][2]);
    
    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING, true);
    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING_CLOTHES, true);

    Player_StoreCosmeticObject(playerid) = CreateDynamicObject(19482, 1290.0186, 1565.5777, 12.6356, -9.6999, -75.0998, -128.0998, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

    Cosmetics_ShowShop(playerid);

    Player_SetPos(playerid, 1289.789672, 1564.599121, 15.0);
    return 1;
}

public OnScriptInit()
{
    /* Binco */
    EnterExit_Create(19902, "{ED2B2B}Binco", "{DADADA}Salida", 2244.484863, -1665.22351, 15.476562, 0.0, 0, 0, 207.744949, -111.073318, 1005.132812, 0.0, 1, 15);
    CreateDynamicMapIcon(2244.484863, -1665.22351, 15.476562, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}Binco", "{DADADA}Salida", 2102.4263, 2257.575, 11.0234, 273.9107, 0, 0, 207.744949, -111.073318, 1005.132812, 0.0, 2, 15);
    CreateDynamicMapIcon(2102.4263, 2257.575, 11.0234, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}Binco", "{DADADA}Salida", 1656.5707, 1733.1418, 10.8281, 91.4768, 0, 0, 207.744949, -111.073318, 1005.132812, 0.0, 3, 15);
    CreateDynamicMapIcon(1656.5707, 1733.1418, 10.8281, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}Binco", "{DADADA}Salida", -2374.1768, 910.1226, 45.4317, 88.0863, 0, 0, 207.744949, -111.073318, 1005.132812, 0.0, 4, 15);
    CreateDynamicMapIcon(-2374.1768, 910.1226, 45.4317, 45, -1, .worldid = 0, .interiorid = 0);


    /* SubUrban */
    EnterExit_Create(19902, "{ED2B2B}SubUrban", "{DADADA}Salida", 2112.835205, -1211.456665, 23.962865, 180.0, 0, 0, 203.906326, -50.494247, 1001.804687, 0.0, 1, 1);
    CreateDynamicMapIcon(2112.835205, -1211.456665, 23.962865, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}SubUrban", "{DADADA}Salida", 2779.4438, 2453.6345, 11.0625, 133.9879, 0, 0, 203.906326, -50.494247, 1001.804687, 0.0, 2, 1);
    CreateDynamicMapIcon(2779.4438, 2453.6345, 11.0625, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}SubUrban", "{DADADA}Salida", -2490.3079, -28.9528, 25.6172, 87.1329, 0, 0, 203.906326, -50.494247, 1001.804687, 0.0, 3, 1);
    CreateDynamicMapIcon(-2490.3079, -28.9528, 25.6172, 45, -1, .worldid = 0, .interiorid = 0);


    /* ProLaps */
    EnterExit_Create(19902, "{ED2B2B}ProLaps", "{DADADA}Salida", 499.498168, -1360.616088, 16.368682, 340.0, 0, 0, 206.995925, -140.021163, 1003.507812, 0.0, 1, 3);
    CreateDynamicMapIcon(499.498168, -1360.616088, 16.368682, 45, -1, .worldid = 0, .interiorid = 0);


    /* Didier Sachs */
    EnterExit_Create(19902, "{ED2B2B}Didier Sachs", "{DADADA}Salida", 453.858032, -1478.098632, 30.813968, 111.110641, 0, 0, 204.348281, -168.678985, 1000.523437, 0.0, 1, 14);
    CreateDynamicMapIcon(453.858032, -1478.098632, 30.813968, 45, -1, .worldid = 0, .interiorid = 0);


    /* Victim */
    EnterExit_Create(19902, "{ED2B2B}Victim", "{DADADA}Salida", 461.54132, -1500.892333, 31.049194, 98.0, 0, 0, 227.35025, -8.188652, 1002.210937, 90.0, 1, 5);
    CreateDynamicMapIcon(461.54132, -1500.892333, 31.049194, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}Victim", "{DADADA}Salida", -1694.8934, 951.5375, 24.8906, 138.3028, 0, 0, 227.35025, -8.188652, 1002.210937, 90.0, 2, 5);
    CreateDynamicMapIcon(-1694.8934, 951.5375, 24.8906, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}Victim", "{DADADA}Salida", 2802.7219, 2430.3391, 11.0625, 133.3612, 0, 0, 227.35025, -8.188652, 1002.210937, 90.0, 3, 5);
    CreateDynamicMapIcon(2802.7219, 2430.3391, 11.0625, 45, -1, .worldid = 0, .interiorid = 0);


    /* ZIP */
    EnterExit_Create(19902, "{ED2B2B}ZIP", "{DADADA}Salida", 1456.611816, -1137.818969, 23.9614, 215.0, 0, 0, 161.401184, -96.887367, 1001.804687, 0.0, 1, 18);
    CreateDynamicMapIcon(1456.611816, -1137.818969, 23.9614, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}ZIP", "{DADADA}Salida", 2571.9072, 1904.4851, 11.0234, 191.6232, 0, 0, 161.401184, -96.887367, 1001.804687, 0.0, 2, 18);
    CreateDynamicMapIcon(2571.9072, 1904.4851, 11.0234, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}ZIP", "{DADADA}Salida", 2090.3845, 2224.2493, 11.0234, 179.2598, 0, 0, 161.401184, -96.887367, 1001.804687, 0.0, 3, 18);
    CreateDynamicMapIcon(2090.3845, 2224.2493, 11.0234, 45, -1, .worldid = 0, .interiorid = 0);

    EnterExit_Create(19902, "{ED2B2B}ZIP", "{DADADA}Salida", -1882.4941, 866.1361, 35.1719, 135.4828, 0, 0, 161.401184, -96.887367, 1001.804687, 0.0, 4, 18);
    CreateDynamicMapIcon(-1882.4941, 866.1361, 35.1719, 45, -1, .worldid = 0, .interiorid = 0);

    // Areas
    Clothing_CreateArea(CLOTHING_BINCO, 207.733657, -100.633468, 1005.257812, 15);
    Clothing_CreateArea(CLOTHING_SUBURBAN, 203.905395, -43.450450, 1001.804687, 1);
    Clothing_CreateArea(CLOTHING_PROLAPS, 207.049148, -129.177581, 1003.507812, 3);
    Clothing_CreateArea(CLOTHING_DIDIER_SACHS, 204.348281, -159.493728, 1000.523437, 14);
    Clothing_CreateArea(CLOTHING_VICTIM, 206.374328, -7.241514, 1001.210937, 5);
    Clothing_CreateArea(CLOTHING_ZIP, 161.443634, -83.589271, 1001.804687, 18);

    /* Cosmetics */

    // SubUrban
    Key_Alert(200.1253, -48.4479, 1001.8047, 1.5, KEYNAME_YES, -1, -1, .callback_on_press = __addressof(Cosmetics_OnPress));
    CreateDynamic3DTextLabel("{CB3126}Tienda de cosméticos{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 200.1253, -48.4479, 1001.8047, 12.0, .testlos = 1, .worldid = -1, .interiorid = -1);

    // ZIP
    Key_Alert(155.4514, -86.2295, 1001.8047, 1.5, KEYNAME_YES, -1, -1, .callback_on_press = __addressof(Cosmetics_OnPress));
    CreateDynamic3DTextLabel("{CB3126}Tienda de cosméticos{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 155.4514, -86.2295, 1001.8047, 12.0, .testlos = 1, .worldid = -1, .interiorid = -1);

    // DS
    Key_Alert(199.3463, -158.0032, 1000.5234, 1.5, KEYNAME_YES, -1, -1, .callback_on_press = __addressof(Cosmetics_OnPress));
    CreateDynamic3DTextLabel("{CB3126}Tienda de cosméticos{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 199.3463, -158.0032, 1000.5234, 12.0, .testlos = 1, .worldid = -1, .interiorid = -1);

    // Victim
    Key_Alert(212.3613, -4.7413, 1001.2109, 1.5, KEYNAME_YES, -1, -1, .callback_on_press = __addressof(Cosmetics_OnPress));
    CreateDynamic3DTextLabel("{CB3126}Tienda de cosméticos{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 212.3613, -4.7413, 1001.2109, 12.0, .testlos = 1, .worldid = -1, .interiorid = -1);

    // ProLaps
    Key_Alert(203.2294, -135.1013, 1002.8672, 1.5, KEYNAME_YES, -1, -1, .callback_on_press = __addressof(Cosmetics_OnPress));
    CreateDynamic3DTextLabel("{CB3126}Tienda de cosméticos{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 203.2294, -135.1013, 1002.8672, 12.0, .testlos = 1, .worldid = -1, .interiorid = -1);

    // Binco
    Key_Alert(211.6414, -102.2170, 1005.2578, 1.5, KEYNAME_YES, -1, -1, .callback_on_press = __addressof(Cosmetics_OnPress));
    CreateDynamic3DTextLabel("{CB3126}Tienda de cosméticos{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 211.6414, -102.2170, 1005.2578, 12.0, .testlos = 1, .worldid = -1, .interiorid = -1);

    #if defined CLOTH_OnScriptInit
        return CLOTH_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit CLOTH_OnScriptInit
#if defined CLOTH_OnScriptInit
    forward CLOTH_OnScriptInit();
#endif

player_menu cosmetics_shop(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        InterpolateCameraPos(playerid, 1289.789672, 1564.599121 - 1.0, 12.737116 + 1.0, 1289.789672, 1564.599121, 12.737116, 1000);
        InterpolateCameraLookAt(playerid, 1289.737304, 1569.565063, 12.156714, 1289.737304, 1569.565063, 12.156714, 1000);
        
        switch (listitem)
        {
            case 0:
            {
                Menu_Show(playerid, "cosmetics_hat", "Sombreros");
                
                Menu_AddItem(playerid, "Bombín negro", "Precio: ~g~$1000", .extra = 18947);
                Menu_AddItem(playerid, "Bombín amarillo", "Precio: ~g~$1000", .extra = 18951);
                Menu_AddItem(playerid, "Bombín blanco", "Precio: ~g~$1000", .extra = 19488);
                Menu_AddItem(playerid, "Bombín rojo", "Precio: ~g~$1000", .extra = 18950);
                Menu_AddItem(playerid, "Bombín verde", "Precio: ~g~$1000", .extra = 18949);
                Menu_AddItem(playerid, "Bombín celeste", "Precio: ~g~$1000", .extra = 18948);

                Menu_AddItem(playerid, "Piluso naranja", "Precio: ~g~$1000", .extra = 18969);
                Menu_AddItem(playerid, "Piluso celeste", "Precio: ~g~$1000", .extra = 18968);
                Menu_AddItem(playerid, "Piluso negro", "Precio: ~g~$1000", .extra = 18967);

                Menu_AddItem(playerid, "Gorra blanca", "Precio: ~g~$1000", .extra = 18933);
                Menu_AddItem(playerid, "Gorra verde", "Precio: ~g~$1000", .extra = 18929);
                Menu_AddItem(playerid, "Gorra camuflada", "Precio: ~g~$1000", .extra = 18926);
                Menu_AddItem(playerid, "Gorra celeste", "Precio: ~g~$1000", .extra = 18927);
                Menu_AddItem(playerid, "Gorra naranja", "Precio: ~g~$1000", .extra = 18932);
                Menu_AddItem(playerid, "Gorra amarilla", "Precio: ~g~$1000", .extra = 18935);
                Menu_AddItem(playerid, "Gorra roja", "Precio: ~g~$1000", .extra = 18934);
                Menu_AddItem(playerid, "Gorra rosa", "Precio: ~g~$1000", .extra = 18928);
                Menu_AddItem(playerid, "Gorra fuego", "Precio: ~g~$1000", .extra = 18930);
                Menu_AddItem(playerid, "Gorra de almas", "Precio: ~g~$1000", .extra = 18931);

                Menu_AddItem(playerid, "Gorro blanco", "Precio: ~g~$1000", .extra = 19068);
                Menu_AddItem(playerid, "Gorro negro", "Precio: ~g~$1000", .extra = 19069);
                Menu_AddItem(playerid, "Gorro de navidad", "Precio: ~g~$1000", .extra = 19064);

                Menu_AddItem(playerid, "Navegante naranja", "Precio: ~g~$1000", .extra = 18944);
                Menu_AddItem(playerid, "Navegante verde", "Precio: ~g~$1000", .extra = 18945);
                Menu_AddItem(playerid, "Cowboy negro", "Precio: ~g~$1000", .extra = 18962);
                Menu_AddItem(playerid, "Cowboy tierra", "Precio: ~g~$1000", .extra = 19098);
                Menu_AddItem(playerid, "Sombrero de bruja", "Precio: ~g~$1000", .extra = 19528);
                Menu_AddItem(playerid, "Sombrero leopardo", "Precio: ~g~$1000", .extra = 18973);
                Menu_AddItem(playerid, "Sombrero cebra", "Precio: ~g~$1000", .extra = 18971);
                Menu_AddItem(playerid, "Sombrero de marinero", "Precio: ~g~$1000", .extra = 18946);
                Menu_AddItem(playerid, "Sombrero de capitán", "Precio: ~g~$1000", .extra = 2054);
                Menu_AddItem(playerid, "Sombrero de paja", "Precio: ~g~$1000", .extra = 19553);
                Menu_AddItem(playerid, "Sombrero negro", "Precio: ~g~$1000", .extra = 18639);
                Menu_AddItem(playerid, "Sombrero tierra", "Precio: ~g~$1000", .extra = 19095);
                Menu_AddItem(playerid, "Sombrero rojo", "Precio: ~g~$1000", .extra = 19097);

                Menu_AddItem(playerid, "Casco militar", "Precio: ~g~$1000", .extra = 2053);
                Menu_AddItem(playerid, "Casco militar camuflado", "Precio: ~g~$1000", .extra = 19107);
                Menu_AddItem(playerid, "Auriculares", "Precio: ~g~$1000", .extra = 19424);

                Menu_AddItem(playerid, "Bandana weed", "Precio: ~g~$1000", .extra = 18894);
                Menu_AddItem(playerid, "Bandana violeta", "Precio: ~g~$1000", .extra = 18903);
                Menu_AddItem(playerid, "Bandana verde", "Precio: ~g~$1000", .extra = 18898);
                Menu_AddItem(playerid, "Bandana rosa", "Precio: ~g~$1000", .extra = 18899);
                Menu_AddItem(playerid, "Bandana negra", "Precio: ~g~$1000", .extra = 18891);
                Menu_AddItem(playerid, "Bandana cielo", "Precio: ~g~$1000", .extra = 18909);
                Menu_AddItem(playerid, "Bandana mar", "Precio: ~g~$1000", .extra = 18908);
                Menu_AddItem(playerid, "Bandana locura", "Precio: ~g~$1000", .extra = 18907);
                Menu_AddItem(playerid, "Bandana naranja", "Precio: ~g~$1000", .extra = 18906);
                Menu_AddItem(playerid, "Bandana pissed", "Precio: ~g~$1000", .extra = 18905);
                Menu_AddItem(playerid, "Bandana de almas", "Precio: ~g~$1000", .extra = 18904);
                Menu_AddItem(playerid, "Bandana leopardo", "Precio: ~g~$1000", .extra = 18901);
                Menu_AddItem(playerid, "Bandana sponge", "Precio: ~g~$1000", .extra = 18902);
                Menu_AddItem(playerid, "Bandana roja", "Precio: ~g~$1000", .extra = 18892);
                Menu_AddItem(playerid, "Bandana azul", "Precio: ~g~$1000", .extra = 18897);
                Menu_AddItem(playerid, "Bandana nigga", "Precio: ~g~$1000", .extra = 18896);
                Menu_AddItem(playerid, "Bandana skull", "Precio: ~g~$1000", .extra = 18895);
                Menu_AddItem(playerid, "Bandana marinero", "Precio: ~g~$1000", .extra = 18893);
                Menu_AddItem(playerid, "Bandana fuego", "Precio: ~g~$1000", .extra = 18910);

                Menu_UpdateListitems(playerid);
            }
            case 1:
            {
                Menu_Show(playerid, "cosmetics_glasses", "Gafas");
                
                Menu_AddItem(playerid, "Gafas rosa claro", "Precio: ~g~$500", .extra = 19025);
                Menu_AddItem(playerid, "Gafas naranja claro", "Precio: ~g~$500", .extra = 19026);
                Menu_AddItem(playerid, "Gafas sin color", "Precio: ~g~$500", .extra = 19031);
                Menu_AddItem(playerid, "Gafas amarillas", "Precio: ~g~$500", .extra = 19028);
                Menu_AddItem(playerid, "Gafas azules", "Precio: ~g~$500", .extra = 19023);
                Menu_AddItem(playerid, "Gafas rosas", "Precio: ~g~$500", .extra = 19024);
                Menu_AddItem(playerid, "Gafas oscuras", "Precio: ~g~$500", .extra = 19033);
                Menu_AddItem(playerid, "Gafas verdes", "Precio: ~g~$500", .extra = 19029);
                Menu_AddItem(playerid, "Gafas naranjas", "Precio: ~g~$500", .extra = 19027);
                Menu_AddItem(playerid, "Gafas gruesas", "Precio: ~g~$500", .extra = 19015);
                Menu_AddItem(playerid, "Gafas con reflejo", "Precio: ~g~$500", .extra = 19016);
                Menu_AddItem(playerid, "Gafas blancas", "Precio: ~g~$500", .extra = 19022);
                Menu_AddItem(playerid, "Gafas policiales", "Precio: ~g~$500", .extra = 19138);
                Menu_AddItem(playerid, "Gafas policiales rojas", "Precio: ~g~$500", .extra = 19139);
                Menu_AddItem(playerid, "Gafas policiales azules", "Precio: ~g~$500", .extra = 19140);
                Menu_AddItem(playerid, "Gafas de alma", "Precio: ~g~$500", .extra = 19035);
                Menu_AddItem(playerid, "Gafas X amarillas", "Precio: ~g~$500", .extra = 19007);
                Menu_AddItem(playerid, "Gafas X rosas", "Precio: ~g~$500", .extra = 19010);
                Menu_AddItem(playerid, "Gafas X rojas", "Precio: ~g~$500", .extra = 19006);
                Menu_AddItem(playerid, "Gafas X cebra", "Precio: ~g~$500", .extra = 19014);
                Menu_AddItem(playerid, "Gafas X verde", "Precio: ~g~$500", .extra = 19008);
                Menu_AddItem(playerid, "Gafas X azules", "Precio: ~g~$500", .extra = 19009);
                Menu_AddItem(playerid, "Gafas X locura", "Precio: ~g~$500", .extra = 19011);
                Menu_AddItem(playerid, "Gafas X negras", "Precio: ~g~$500", .extra = 19012);
                Menu_AddItem(playerid, "Gafas X blancas", "Precio: ~g~$500", .extra = 19013);
                
                

                Menu_UpdateListitems(playerid);
            }
            case 2:
            {
                Menu_Show(playerid, "cosmetics_watch", "Relojes");
                
                Menu_AddItem(playerid, "Reloj dorado claro", "Precio: ~g~$1500", .extra = 19039);
                Menu_AddItem(playerid, "Reloj dorado oscuro", "Precio: ~g~$1500", .extra = 19042);
                Menu_AddItem(playerid, "Reloj cocodrilo", "Precio: ~g~$1500", .extra = 19053);
                Menu_AddItem(playerid, "Reloj frog", "Precio: ~g~$1500", .extra = 19051);
                Menu_AddItem(playerid, "Reloj blue", "Precio: ~g~$1500", .extra = 19050);
                Menu_AddItem(playerid, "Reloj locura", "Precio: ~g~$1500", .extra = 19049);
                Menu_AddItem(playerid, "Reloj de almas", "Precio: ~g~$1500", .extra = 19048);
                Menu_AddItem(playerid, "Reloj violeta", "Precio: ~g~$1500", .extra = 19047);
                Menu_AddItem(playerid, "Reloj verde", "Precio: ~g~$1500", .extra = 19046);
                Menu_AddItem(playerid, "Reloj rojo", "Precio: ~g~$1500", .extra = 19045);
                Menu_AddItem(playerid, "Reloj rosa", "Precio: ~g~$1500", .extra = 19044);
                Menu_AddItem(playerid, "Reloj plata claro", "Precio: ~g~$1500", .extra = 19043);
                Menu_AddItem(playerid, "Reloj oscuro", "Precio: ~g~$1500", .extra = 19041);
                Menu_AddItem(playerid, "Reloj plata oscuro", "Precio: ~g~$1500", .extra = 19040);

                Menu_UpdateListitems(playerid);
            }
            case 3:
            {
                Menu_Show(playerid, "cosmetics_mask", "Máscaras");
                
                Menu_AddItem(playerid, "Bandana blanca", "Precio: ~g~$1000", .extra = 18919);
                Menu_AddItem(playerid, "Bandana negra", "Precio: ~g~$1000", .extra = 18912);
                Menu_AddItem(playerid, "Bandana verde", "Precio: ~g~$1000", .extra = 18913);
                Menu_AddItem(playerid, "Bandana camuflaje", "Precio: ~g~$1000", .extra = 18914);
                Menu_AddItem(playerid, "Bandana locura", "Precio: ~g~$1000", .extra = 18915);
                Menu_AddItem(playerid, "Bandana serpiente", "Precio: ~g~$1000", .extra = 18916);
                Menu_AddItem(playerid, "Bandana de almas", "Precio: ~g~$1000", .extra = 18917);
                Menu_AddItem(playerid, "Bandana verde", "Precio: ~g~$1000", .extra = 18918);
                Menu_AddItem(playerid, "Bandana skull", "Precio: ~g~$1000", .extra = 18911);
                Menu_AddItem(playerid, "Bandana gucci", "Precio: ~g~$1000", .extra = 18920);
                Menu_AddItem(playerid, "Máscara de hockey verde", "Precio: ~g~$1000", .extra = 19038);
                Menu_AddItem(playerid, "Máscara de hockey blanca", "Precio: ~g~$1000", .extra = 19036);
                Menu_AddItem(playerid, "Máscara de hockey roja", "Precio: ~g~$1000", .extra = 19037);
                Menu_AddItem(playerid, "Máscara gimp", "Precio: ~g~$1000", .extra = 19163);
                Menu_AddItem(playerid, "Máscara del diablo", "Precio: ~g~$1000", .extra = 11704);
                Menu_AddItem(playerid, "Máscara de gas", "Precio: ~g~$1000", .extra = 19472);

                Menu_UpdateListitems(playerid);
            }
        }
    }
    else if (response == MENU_RESPONSE_CLOSE)
        Player_StopShopping(playerid);

    return 1;
}

player_menu cosmetics_hat(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_DOWN || response == MENU_RESPONSE_UP)
    {
        Streamer_SetIntData(STREAMER_TYPE_OBJECT, Player_StoreCosmeticObject(playerid), E_STREAMER_MODEL_ID, Listitem_Extra(listitem));
        Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        if (Player_Money(playerid) < 1000)
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");
            Cosmetics_ShowShop(playerid);
            return 1;
        }

        Player_GiveMoney(playerid, -1000);

        new name[32];
        strunpack(name, Listitem_Text(listitem));
        Player_AddCosmetic(playerid, Listitem_Extra(listitem), COSMETIC_TYPE_HAT, name);
        Cosmetics_ShowShop(playerid);
    }
    else if (response == MENU_RESPONSE_CLOSE)
        Cosmetics_ShowShop(playerid);

    return 1;
}

player_menu cosmetics_glasses(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_DOWN || response == MENU_RESPONSE_UP)
    {
        Streamer_SetIntData(STREAMER_TYPE_OBJECT, Player_StoreCosmeticObject(playerid), E_STREAMER_MODEL_ID, Listitem_Extra(listitem));
        Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        if (Player_Money(playerid) < 500)
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");
            Cosmetics_ShowShop(playerid);
            return 1;
        }

        Player_GiveMoney(playerid, -500);

        new name[32];
        strunpack(name, Listitem_Text(listitem));
        Player_AddCosmetic(playerid, Listitem_Extra(listitem), COSMETIC_TYPE_GLASSES, name);
        Cosmetics_ShowShop(playerid);
    }
    else if (response == MENU_RESPONSE_CLOSE)
        Cosmetics_ShowShop(playerid);

    return 1;
}

player_menu cosmetics_watch(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_DOWN || response == MENU_RESPONSE_UP)
    {
        Streamer_SetIntData(STREAMER_TYPE_OBJECT, Player_StoreCosmeticObject(playerid), E_STREAMER_MODEL_ID, Listitem_Extra(listitem));
        Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        if (Player_Money(playerid) < 1500)
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");
            Cosmetics_ShowShop(playerid);
            return 1;
        }

        Player_GiveMoney(playerid, -1500);

        new name[32];
        strunpack(name, Listitem_Text(listitem));
        Player_AddCosmetic(playerid, Listitem_Extra(listitem), COSMETIC_TYPE_WATCH, name);
        Cosmetics_ShowShop(playerid);
    }
    else if (response == MENU_RESPONSE_CLOSE)
        Cosmetics_ShowShop(playerid);

    return 1;
}

player_menu cosmetics_mask(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_DOWN || response == MENU_RESPONSE_UP)
    {
        Streamer_SetIntData(STREAMER_TYPE_OBJECT, Player_StoreCosmeticObject(playerid), E_STREAMER_MODEL_ID, Listitem_Extra(listitem));
        Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        if (Player_Money(playerid) < 1000)
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");
            Cosmetics_ShowShop(playerid);
            return 1;
        }

        Player_GiveMoney(playerid, -1000);

        new name[32];
        strunpack(name, Listitem_Text(listitem));
        Player_AddCosmetic(playerid, Listitem_Extra(listitem), COSMETIC_TYPE_MASK, name);
        Cosmetics_ShowShop(playerid);
    }
    else if (response == MENU_RESPONSE_CLOSE)
        Cosmetics_ShowShop(playerid);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(g_rgiRotateSkinTimer[playerid]);

    #if defined CLOTH_OnPlayerDisconnect
        return CLOTH_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect CLOTH_OnPlayerDisconnect
#if defined CLOTH_OnPlayerDisconnect
    forward CLOTH_OnPlayerDisconnect(playerid, reason);
#endif

forward CLOTH_RotatePlayerSkin(playerid, Float:delta);
public CLOTH_RotatePlayerSkin(playerid, Float:delta)
{
    if (!Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING_CLOTHES))
        return KillTimer(g_rgiRotateSkinTimer[playerid]);

    new Float:angle;
    GetPlayerFacingAngle(playerid, angle);
    angle += delta;
    if (angle < 0.0 || angle > 360.0)
        angle = 0.0;

    SetPlayerFacingAngle(playerid, angle);
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING_CLOTHES))
    {
        // Left button
        if (clickedid == g_tdShops[7])
        {
            --g_rgiPlayerSelectedSkin[playerid];
            if (g_rgiPlayerSelectedSkin[playerid] < 0)
                g_rgiPlayerSelectedSkin[playerid] = 0;

            Clothing_Select(playerid, g_rgiPlayerSelectedSkin[playerid]);
            PlayerPlaySound(playerid, SOUND_BACK);
        }
        // Right button
        else if (clickedid == g_tdShops[8])
        {
            ++g_rgiPlayerSelectedSkin[playerid];
            if (!g_rgiClothingSkins[ g_rgiPlayerClothingStore[playerid] ][ Player_Sex(playerid) ][ g_rgiPlayerSelectedSkin[playerid] ][0])
                g_rgiPlayerSelectedSkin[playerid] = 0;

            Clothing_Select(playerid, g_rgiPlayerSelectedSkin[playerid]);
            PlayerPlaySound(playerid, SOUND_NEXT);
        }
        // Buy button
        else if (clickedid == g_tdShops[9])
        {
            if (Player_Money(playerid) < g_rgiClothingSkins[ g_rgiPlayerClothingStore[playerid] ][ Player_Sex(playerid) ][ g_rgiPlayerSelectedSkin[playerid] ][1])
            {
                PlayerPlaySound(playerid, SOUND_ERROR);
                Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                return 0;
            }

            Notification_Show(playerid, "Ropa comprada.", 3000, 0x64A752FF);
            PlayerPlaySound(playerid, 1054);

            mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                UPDATE `ACCOUNT` SET `SKIN` = %i WHERE `ID` = %i;\
            ", 
                Player_Skin(playerid), Player_AccountID(playerid)
            );
            mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

            Player_GiveMoney(playerid, -g_rgiClothingSkins[ g_rgiPlayerClothingStore[playerid] ][ Player_Sex(playerid) ][ g_rgiPlayerSelectedSkin[playerid] ][1]);
            Player_Skin(playerid) = g_rgiClothingSkins[ g_rgiPlayerClothingStore[playerid] ][ Player_Sex(playerid) ][ g_rgiPlayerSelectedSkin[playerid] ][0];
            SetPlayerSkin(playerid, Player_Skin(playerid));

            Player_StopShopping(playerid);
            SetPlayerVirtualWorld(playerid, g_rgePlayerTempData[playerid][e_iPlayerLastWorld]);
        }
    }

    #if defined CLOTH_OnPlayerClickTextDraw
        return CLOTH_OnPlayerClickTextDraw(playerid, Text:clickedid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw CLOTH_OnPlayerClickTextDraw
#if defined CLOTH_OnPlayerClickTextDraw
    forward CLOTH_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif
