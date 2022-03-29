#if defined _async_header_
    #endinput
#endif
#define _async_header_

new tag_uid:tag_uid_mysql_cache;

native mysql_tquery_s(MySQL:handle, ConstAmxString:query, const callback[] = "", const format[] = "", {Float,_}:...) = mysql_tquery;