#include "../main.hpp"

cell Script::n_argon_hash(cell* params)
{
	AssertMinParams(5, params);

	auto work = std::make_unique<ArgonWork>(GetString(params[1]), params[2], params[3], params[4], ArgonWork::WorkType::Hash);
	work->SetCallback(this, GetString(params[5]), GetString(params[6]).c_str(), params, 7);
	_work_queue->push(std::move(work));

	return 1;
}

cell Script::n_argon_check(cell* params)
{
	AssertMinParams(3, params);

	auto work = std::make_unique<ArgonWork>(GetString(params[1]), 0, 0, 0, ArgonWork::WorkType::Check);
	work->SetCheckHash(GetString(params[2]));
	work->SetCallback(this, GetString(params[3]), GetString(params[4]).c_str(), params, 5);
	_work_queue->push(std::move(work));

	return 1;
}

cell Script::n_argon_set_thread_count(int max_threads)
{
	_max_worker_threads = (max_threads == -1 ? std::thread::hardware_concurrency() : max_threads);
	Plugin::Log("[argon] Set max thread count to %i", _max_worker_threads.load());
	return 1;
}

cell Script::n_argon_get_hash(cell* params)
{
	AssertParams(2, params);

	if (_result_queue->front()->Type() != ArgonWork::WorkType::Hash)
	{
		Plugin::Log("[argon:error] used argon_is_equal on incorrect hash task type");
		return 0;
	}

	cell* addr = GetPhysAddr(params[1]);
	SetString(addr, _result_queue->front()->GetHash(), params[2]);

	return 1;
}

cell Script::n_argon_is_equal()
{
	if (_result_queue->front()->Type() != ArgonWork::WorkType::Check)
	{
		Plugin::Log("[argon:error] used argon_is_equal on incorrect hash task type");
		return 0;
	}
	return _result_queue->front()->IsEqual();
}