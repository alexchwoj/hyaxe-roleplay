#include "main.hpp"

void Script::ProcessWorkQueue()
{
	while (!_work_queue->empty())
	{
		if (_active_threads >= _max_worker_threads.load())
			break;

		std::unique_ptr<ArgonWork> work = std::move(_work_queue->front());
		_work_queue->pop();
		++_active_threads;

		std::thread([this](std::unique_ptr<ArgonWork> work) {
			work->Work();
			_result_queue->push(std::move(work));
			--_active_threads;
		}, std::move(work)).detach();
	}
}

void Script::ProcessResultQueue()
{
	while (!_result_queue->empty())
	{
		_result_queue->front()->TriggerCallback();
		_result_queue->pop();
	}
}