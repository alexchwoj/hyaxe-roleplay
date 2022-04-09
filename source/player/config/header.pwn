#if defined _player_config_header_
    #endinput
#endif
#define _player_config_header_

enum _:ePlayerConfig
{
    CONFIG_PERFORMANCE_MODE,
    CONFIG_MUSIC,
    CONFIG_DISPLAY_NEED_BARS,
    CONFIG_DISPLAY_SPEEDOMETER,
    CONFIG_SHOW_DOUBT_CHANNEL,
    CONFIG_DISABLE_NOTIFICATIONS,
    CONFIG_DISABLE_ADMIN_MESSAGES,
    
    CONFIG_MAX
};

new const 
    g_rgszConfigOptionNames[ePlayerConfig][] = 
    {
        "Modo de rendimiento",
        "Ambientación musical",
        "Mostrar barras de necesidades",
        "Mostrar velocímetro",
        "Mostrar canal de dudas",
        "Deshabilitar notificaciones",
        "Deshabilitar mensajes administrativos",
        ""
    },
    bool:g_rgbConfigOptionDefaults[ePlayerConfig char] =
    {
        // 00 = false
        // 01 = true
        0x00010101, // CONFIG_PERFORMANCE_MODE = false
                    // CONFIG_MUSIC = true
                    // CONFIG_DISPLAY_NEED_BARS = true
                    // CONFIG_DISPLAY_SPEEDOMETER = true
        0x01000000, // CONFIG_SHOW_DOUBT_CHANNEL = true
                    // CONFIG_DISABLE_NOTIFICATIONS = false
                    // CONFIG_DISABLE_ADMIN_MESSAGES = false
    };

new BitArray:g_rgbsPlayerConfig[MAX_PLAYERS]<CONFIG_MAX>;

forward Config_ToString(playerid);
forward Config_ResetDefaults(playerid);
forward Config_Save(playerid);
forward Config_LoadFromCache(playerid);

#define Player_Config(%0) Bit:(g_rgbsPlayerConfig[playerid])