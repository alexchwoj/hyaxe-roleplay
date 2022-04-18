#if defined _church_callbacks_
    #endinput
#endif
#define _church_callbacks_

public OnGameModeInit()
{
    g_rgiPriestNPC = FCNPC_Create("Padre");
    EnterExit_Create(19902, "{CB3126}Parroquia de San Cipriano", "{DADADA}Salida", 2233.164306, -1333.295043, 23.981561, 90.0, 0, 0, 387.479644, 2324.503906, 1889.583374, 88.438690, 2, 17);
    CreateDynamic3DTextLabel("Usa {CB3126}/misa{DADADA} para empezar una misa", 0xDADADAFF, 366.7139, 2330.5049, 1890.6047, 5.0, .worldid = 2, .interiorid = 17);
    
    #if defined CHURCH_OnGameModeInit
        return CHURCH_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit CHURCH_OnGameModeInit
#if defined CHURCH_OnGameModeInit
    forward CHURCH_OnGameModeInit();
#endif

public FCNPC_OnFinishPlayback(npcid)
{
    if(npcid == g_rgiPriestNPC)
    {
        switch(g_rgeMassState)
        {
            case MASS_STATE_ENTRANCE:
            {
                Chat_SendMessageToRange(npcid, 0xB39B6BFF, 50.0, "* El padre se prepara para dar la monición de entrada");

                task_yield(1);    
                wait_ms(2000);

                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, "sample text");
                g_rgeMassState = MASS_STATE_PENITENTIAL_ACT;

                wait_ms(10000);

                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, 
                    "Padre: Yo confieso ante Dios todopoderoso, y ante ustedes, hermanos, que he pecado mucho de pensamiento, palabra, \
                    obra y omisión. Por mi culpa, por mi culpa, por mi gran culpa. Por eso ruego a Santa María, siempre Virgen, \
                    a los ángeles, a los santos y a ustedes, hermanos, que intercedan por mí ante Dios, nuestro Señor. Amén."
                );

                wait_ms(20000);
                
                g_rgeMassState = MASS_STATE_FIRST_READING;
                Chat_SendMessageToRange(npcid, 0xB39B6BFF, 50.0, "* El padre abre la biblia en el Antiguo Testamento para la primera lectura");

                wait_ms(2000);

                new reading = random(sizeof(g_rgszOldTestamentReadings));
                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, g_rgszOldTestamentReadings[reading][0]);
                wait_ms(1000);
                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, g_rgszOldTestamentReadings[reading][1]);

                wait_ms(60000);
                
                g_rgeMassState = MASS_STATE_PSALMS;
                Chat_SendMessageToRange(npcid, 0xB39B6BFF, 50.0, "* El padre cambia la página de la biblia al libro de Salmos");

                wait_ms(2000);

                new psalm = random(sizeof(g_rgszPsalms));
                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, g_rgszPsalms[psalm][0]);
                wait_ms(2000);
                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, g_rgszPsalms[psalm][1]);

                wait_ms(15000);

                g_rgeMassState = MASS_STATE_SECOND_READING;
                Chat_SendMessageToRange(npcid, 0xB39B6BFF, 50.0, "* El padre prepara la segunda lectura del Nuevo Testamento");

                wait_ms(2000);

                reading = random(sizeof(g_rgszVerses));
                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, g_rgszVerses[reading][0]);
                wait_ms(2000);
                Chat_SendMessageToRange(npcid, 0xDADADAFF, 50.0, g_rgszVerses[reading][1]);

                wait_ms(30000);

                Chat_SendMessageToRange(npcid, 0xB39B6BFF, 50.0, "* El padre cierra la biblia y anuncia el fin de la misa.");

                wait_ms(5000);

                g_rgeMassState = MASS_STATE_PRIEST_LEAVE;
                FCNPC_StartPlayingPlayback(g_rgiPriestNPC, "mass_walk_out");
            }
            case MASS_STATE_PRIEST_LEAVE:
            {
                FCNPC_SetPosition(npcid, 2000.0, 2000.0, 2000.0);
                FCNPC_SetVirtualWorld(npcid, 422);

                g_rgiLastMassTick = GetTickCount();
                Mass_End();
            }
        }

        return 1;
    }

    #if defined CHURCH_FCNPC_OnFinishPlayback
        return CHURCH_FCNPC_OnFinishPlayback(npcid);
    #else
        return 1;
    #endif
}

#if defined _ALS_FCNPC_OnFinishPlayback
    #undef FCNPC_OnFinishPlayback
#else
    #define _ALS_FCNPC_OnFinishPlayback
#endif
#define FCNPC_OnFinishPlayback CHURCH_FCNPC_OnFinishPlayback
#if defined CHURCH_FCNPC_OnFinishPlayback
    forward CHURCH_FCNPC_OnFinishPlayback(npcid);
#endif
