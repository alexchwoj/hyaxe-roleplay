#if defined _async_functions_
    #endinput
#endif
#define _async_functions_

Task<Cache>:MySQL_QueryAsync(MySQL:handle, const query[])
{
    new Task<Cache>:t = task_new<Cache>();
    new Handle<Task>:h = handle_new<Task>(Task:t, .weak = true);

    new cb_name[3];
    cb_name = amx_encode_value_public_name("hy@AsyncQueryDone", _:h);
    new CallbackHandler:error_cb_handler = pawn_register_callback("OnQueryError", "hy@Async_OnQueryError", handler_default, "ei", _:h);

    new const ret = mysql_tquery(handle, query, cb_name, "ii", _:h, _:error_cb_handler);
    if(ret)
    {
        handle_acquire<Task>(h);
    }
    else
    {
        pawn_unregister_callback(error_cb_handler);
        task_set_error_ticks<Cache>(t, amx_err_native, 1);
    }

    return t;
}

Task<Cache>:MySQL_QueryAsync_s(MySQL:handle, ConstString:query)
{
    new Task<Cache>:t = task_new<Cache>();
    new Handle<Task>:h = handle_new<Task>(Task:t, .weak = true);

    new cb_name[3];
    cb_name = amx_encode_value_public_name("hy@AsyncQueryDone", _:h);
    new CallbackHandler:error_cb_handler = pawn_register_callback("OnQueryError", "hy@Async_OnQueryError", handler_default, "ed", _:h);

    new const ret = mysql_tquery_s(handle, query, cb_name, "ii", _:h, _:error_cb_handler);
    if(ret)
    {
        handle_acquire<Task>(h);
    }
    else
    {
        pawn_unregister_callback(error_cb_handler);
        task_set_error_ticks<Cache>(t, amx_err_native, 1);
    }

    return t;
}

Task:wait_for_callback(const public_name[], Expression:expr)
{
    new Handle<Expression>:eh = handle_new<Expression>(expr);
    handle_acquire<Expression>(eh);

    new Task:result = task_new();
    new Handle<Task>:th = handle_new<Task>(result, .weak = true);
    handle_acquire<Task>(th);

    pawn_register_callback(public_name, "HandleTaskedCallback", handler_default, "edd", _:th, _:eh);

    return result;
}