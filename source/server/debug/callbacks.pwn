#if defined _debug_callbacks_
    #endinput
#endif
#define _debug_callbacks_

public OnGameModeInit()
{
    amx_forked() threaded(sync_explicit)
    {
        static Float:t = 0.0;
        static const rainbow_colors[7] = {
            0xFF0000FF,
            0xFFA500FF,
            0xFFFF00FF,
            0x008000FF,
            0x0000FFFF,
            0x4B0082FF,
            0xEE82EEFF
        };

        static 
            current_color = 0xFF0000FF,
            next_color;

        new last_tick = GetTickCount();

        do
        {
            next_color = rainbow_colors[random(sizeof(rainbow_colors))];
        } while(next_color == current_color);

        new const bool:REALLY_TRUE = true;
        while(REALLY_TRUE)
        {
            if(GetTickCount() - last_tick < 100)
                continue;

            last_tick = GetTickCount();
            new td_color = InterpolateColourLinear(current_color, next_color, t);
            t += 0.05;
            if(t >= 1.0)
            {
                t = 0.0;
                current_color = next_color;
                do
                {
                    next_color = rainbow_colors[random(sizeof(rainbow_colors))];
                } while(next_color == current_color);
            }
            TextDrawBoxColor(g_tdDebugScreen[0], td_color);

            new 
                bytes_sent, bytes_recv, 
                msg_sent, msg_recv, 
                connected_players, Float:total_packet_loss, total_ping,
                valid_vehicles;

            for(new i, j = GetPlayerPoolSize(); i <= j; ++i)
            {
                if(!IsPlayerConnected(i))
                    continue;

                if(IsTextDrawVisibleForPlayer(i, g_tdDebugScreen[0]))
                {
                    TextDrawShowForPlayer(i, g_tdDebugScreen[0]);
                }

                bytes_sent += NetStats_BytesReceived(i);
                bytes_recv += NetStats_BytesSent(i);
                msg_sent += NetStats_MessagesReceived(i);
                msg_recv += NetStats_MessagesSent(i);
                total_packet_loss += NetStats_PacketLossPercent(i);
                total_ping += GetPlayerPing(i);
                connected_players++;
            }

            if(!connected_players)
                continue;

            new Float:avg_packet_loss = total_packet_loss / float(connected_players);
            new avg_ping = total_ping / connected_players; 

            for(new i, j = GetVehiclePoolSize(); i <= j; ++i)
            {
                if(IsValidVehicle(i))
                    valid_vehicles++;
            }

            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                Tickrate:_%i \
                Players:_%i \
                Vehicles:_%i \
                Sent_bytes:_%i \
                Recv._byes:_%i \
                Sent_msgs:_%i \
                Recv._msgs:_%i \
                Avg._ping:_%i \
                Avg._PL:_%.2f\
            ",
                GetServerTickRate(),
                connected_players,
                valid_vehicles,
                bytes_sent,
                bytes_recv,
                msg_sent,
                msg_recv,
                avg_ping,
                avg_packet_loss
            );
            TextDrawSetString(g_tdDebugScreen[3], HYAXE_UNSAFE_HUGE_STRING);
        }
    }

    #if defined DEBUG_OnGameModeInit
        return DEBUG_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit DEBUG_OnGameModeInit
#if defined DEBUG_OnGameModeInit
    forward DEBUG_OnGameModeInit();
#endif

command debug(playerid, const params[], "Activa la pantalla de debug")
{
    TextDrawShowForPlayer(playerid, g_tdDebugScreen[0]);
    TextDrawShowForPlayer(playerid, g_tdDebugScreen[1]);
    TextDrawShowForPlayer(playerid, g_tdDebugScreen[2]);
    TextDrawShowForPlayer(playerid, g_tdDebugScreen[3]);
    return 1;
}