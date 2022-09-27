#if defined _async_header_
    #endinput
#endif
#define _async_header_

stock operator~(const Cache:caches[], len)
{
    for(new i; i < len; ++i)
    {
        if(cache_is_valid(caches[i]))
            cache_delete(caches[i]);
    }
}
