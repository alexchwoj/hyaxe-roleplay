#if defined _church_header_
    #endinput
#endif
#define _church_header_

/*

    Jews and neopagans btfo
*/

new const g_rgszVerses[][2][512] = {
    { 
        "Jeremías capítulo 2, versículo 11", 
        "Porque yo sé los pensamientos que tengo acerca de vosotros, dice Jehová, pensamientos de paz, y no de mal, para daros el \
        fin que esperáis." 
    },
    {
        "1 Corintios capítulo 4, versículos 4 al 5",
        "Porque aunque de nada tengo mala conciencia, no por eso soy justificado; pero el que me juzga es el Señor. Así que, no \
        juzguéis nada antes de tiempo, hasta que venga el Señor, el cual aclarará también lo oculto de las tinieblas, y manifestará \
        las intenciones de los corazones; y entonces cada uno recibirá su alabanza de Dios."
    },
    {
        "Filipenses capítulo 4, versículos 4 al 7",
        "Regocijaos en el Señor siempre. Otra vez digo: ¡Regocijaos! Vuestra gentileza sea conocida de todos los hombres. \
        El Señor está cerca. Por nada estéis afanosos, sino sean conocidas vuestras peticiones delante de Dios en toda oración y \
        ruego, con acción de gracias. Y la paz de Dios, que sobrepasa todo entendimiento, guardará vuestros corazones y vuestros \
        pensamientos en Cristo Jesús."
    },
    {
        "Juan capítulo 3, versículo 16",
        "Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, \
        mas tenga vida eterna."
    },
    {
        "Romanos capítulo 8, versículos 28 al 30",
        "Y sabemos que a los que aman a Dios, todas las cosas les ayudan a bien, esto es, a los que conforme a su propósito son \
        llamados. Porque a los que antes conoció, también los predestinó para que fuesen hechos conformes a la imagen de su \
        Hijo, para que él sea el primogénito entre muchos hermanos. Y a los que predestinó, a estos también llamó; y a los que \
        llamó, a estos también justificó; y a los que justificó, a estos también glorificó."
    },
    {
        "Isaías 41:10",
        "No temas, porque yo estoy contigo; no desmayes, porque yo soy tu Dios que te esfuerzo; siempre te ayudaré, siempre te \
        sustentaré con la diestra de mi justicia."
    },
    {
        "Gálatas 5:22-23",
        "Mas el fruto del Espíritu es amor, gozo, paz, paciencia, benignidad, bondad, fe, mansedumbre, templanza; contra tales \
        cosas no hay ley."
    },
    {
        "Hebreos 11:1",
        "Es, pues, la fe la certeza de lo que se espera, la convicción de lo que no se ve."
    },
    {
        "2 Timoteo 1:7",
        "Porque no nos ha dado Dios espíritu de cobardía, sino de poder, de amor y de dominio propio."
    },
    {
        "1 Corintios 10:13",
        "No os ha sobrevenido ninguna tentación que no sea humana; pero fiel es Dios, que no os dejará ser tentados más de lo que \
        podéis resistir, sino que dará también juntamente con la tentación la salida, para que podáis soportar."
    },
    {
        "Isaías 40:29-31",
        "Él da esfuerzo al cansado, y multiplica las fuerzas al que no tiene ningunas. Los muchachos se fatigan y se cansan, \
        los jóvenes flaquean y caen; pero los que esperan a Jehová tendrán nuevas fuerzas; levantarán alas como las águilas; \
        correrán, y no se cansarán; caminarán, y no se fatigarán."
    },
    {
        "Josué 1:8-9",
        "Nunca se apartará de tu boca este libro de la ley, sino que de día y de noche meditarás en él, para que guardes y hagas \
        conforme a todo lo que en él está escrito; porque entonces harás prosperar tu camino, y todo te saldrá bien. Mira que te \
        mando que te esfuerces y seas valiente; no temas ni desmayes, porque Jehová tu Dios estará contigo en dondequiera que vayas."
    }
};

new const g_rgszOldTestamentReadings[][2][600] = {
    {
        "Lectura del libro de Jeremías",
        "Mirad que llegan días en que haré con la casa de Israel y la casa de Judá una alianza nueva. No como \
        la alianza que hice con mis padres, cuando los tomé de la mano, para sacarlos de Egipto. Sino que así será la alianza que \
        haré con ellos, después de aquellos días: Meteré mi ley en su pecho, la escribiré en sus corazones: \
        yo seré su Dios, y ellos serán mi pueblo. Y no tendrá que enseñar uno a su prójimo, el otro a su hermano, diciendo: \
        \"Reconoce al Señor\". Porque todos me conocerán, desde el pequeño al grande. Palabra de Dios."
    },
    {
        "Lectura del Libro de Rut",
        "Rut respondió: -\"No insistas en que te abandone y me separe de ti, porque donde tú vayas, yo iré, donde habites, \
        habitaré. Tu pueblo será mi pueblo y tu Dios será mi Dios. Donde tú mueras moriré y allí seré enterrada. Que Yahveh \
        me dé este mal y añada este otro todavía si no es tan sólo la muerte lo que nos ha de separar.\". Palabra de Dios."
    }
};

new const g_rgszPsalms[][2][256] = {
    {
        "Salmos 23: Salmo de David",
        "Jehová es mi pastor; nada me faltará. \
        En lugares de delicados pastos me hará descansar; Junto a aguas de reposo me pastoreará. [Respuesta]; \
        Confortará mi alma; Me guiará por sendas de justicia por amor de su nombre. [Respuesta]"
    }
};

enum eMassState
{
    MASS_STATE_NONE,
    MASS_STATE_ENTRANCE,
    MASS_STATE_PENITENTIAL_ACT,
    MASS_STATE_FIRST_READING,
    MASS_STATE_PSALMS,
    MASS_STATE_SECOND_READING,
    MASS_STATE_PRIEST_LEAVE
};

new
    bool:g_rgbMassStarted = false,
    g_rgiLastMassTick,
    g_rgiPriestNPC = INVALID_PLAYER_ID,
    eMassState:g_rgeMassState = MASS_STATE_NONE;