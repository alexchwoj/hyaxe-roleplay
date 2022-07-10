#if defined _async_header_
    #endinput
#endif
#define _async_header_

//new tag_uid:tag_uid_mysql_cache;

stock operator~(const Cache:caches[], len)
{
    for(new i; i < len; ++i)
    {
        if(cache_is_valid(caches[i]))
            cache_delete(caches[i]);
    }
}

forward Task<Cache>:MySQL_QueryAsync(MySQL:handle, const query[]);
forward Task<Cache>:MySQL_QueryAsync_s(MySQL:handle, ConstString:query);
forward Task:wait_for_callback(const public_name[], Expression:expr);