#if defined _async_callbacks_
    #endinput
#endif
#define _async_callbacks_

/*
forward hy@async_DeleteCache(Cache:c);
public hy@async_DeleteCache(Cache:c)
{
    log_function();

    if(cache_is_valid(c))
        cache_delete(c);
}

on_init RegisterAsyncTags()
{
    printf("[async] Registering tags...");
    tag_uid_mysql_cache = tag_uid(tagof(Cache:));
    tag_set_op(tag_uid_mysql_cache, tag_op_collect, "hy@async_DeleteCache");
    tag_set_op(tag_uid_mysql_cache, tag_op_delete, "hy@async_DeleteCache");
}
*/

forward hy@AsyncQueryDone(Handle<Task>:task_handle);
public hy@AsyncQueryDone(Handle<Task>:task_handle)
{
    if(handle_linked<Task>(task_handle))
    {
        new Task:t = handle_get<Task>(task_handle);

        new Cache:c = cache_save();
        #pragma nodestruct c

        cache_set_active(c);

        /*
        new Handle<Cache>:h = handle_new<Cache>(c);
        pawn_guard(_:h, tagof(h));
        */

        task_set_result(t, _:c);
    }

    handle_release<Task>(task_handle);

    return 1;
}

stock operator~(const Cache:caches[], len)
{
    log_function();
    
    for(new i; i < len; ++i)
    {
        if(cache_is_valid(caches[i]))
            cache_delete(caches[i]);
    }
}