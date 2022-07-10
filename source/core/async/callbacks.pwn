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

forward HandleTaskedCallback(CallbackHandler:cb_handle, Handle<Task>:th, Handle<Expression>:eh);
public HandleTaskedCallback(CallbackHandler:cb_handle, Handle<Task>:th, Handle<Expression>:eh)
{
    DEBUG_PRINT("HandleTaskedCallback called");
    DEBUG_PRINT("Handle<Task> is linked: %i", handle_linked<Task>(th));
    DEBUG_PRINT("Handle<Expression> is linked: %i", handle_linked<Expression>(eh));

    if(!handle_linked<Task>(th))
    {
        handle_release<Expression>(eh);
        handle_release<Task>(th);
        pawn_unregister_callback(cb_handle);
        return 0;
    }

    new Expression:expr = handle_get<Expression>(eh);

    new stack[32];
    for(new i = 3, j = GetCurrentFrameParameterCount(); i < j; ++i)
    {
        stack[i - 3] = GetCurrentFrameParameter(i);
        expr = expr_bind(expr, expr_const(stack[i - 3]));
    }

    new result = expr_get(expr);
    DEBUG_PRINT("result = %i", result);
    expr_delete(expr);

    if(result)
    {
        task_set_result_arr(handle_get<Task>(th), stack);
        handle_release<Expression>(eh);
        handle_release<Task>(th);
        pawn_unregister_callback(cb_handle);
    }

    return 0;
}