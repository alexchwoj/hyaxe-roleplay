#if defined _HEADER_DATABASE_
    #endinput
#endif
#define _HEADER_DATABASE_

new 
    MySQL:g_hDatabase;

#define db_exec(%0,%1) db_free_result(db_query((%0),(%1)))