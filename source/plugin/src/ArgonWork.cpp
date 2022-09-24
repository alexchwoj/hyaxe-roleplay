#include "main.hpp"

void ArgonWork::SetCallback(Script* script, const std::string& name, const char* format, const cell* params, std::size_t params_offset)
{
	_callback = script->MakePublic(name, true);
	if (!_callback->Exists())
		return;

	std::size_t params_idx{ 0 };

	do
	{
		switch (*format)
		{
			case 'i':
			case 'd':
			case 'f':
			{
				cell* value = script->GetPhysAddr(params[params_offset + params_idx++]);
				_params.push_back(*value);
				break;
			}
			case 's':
			{
				_params.push_back(script->GetString(params[params_offset + params_idx++]));
				break;
			}
		}
	} while (*(++format));

	std::reverse(_params.begin(), _params.end());
}

void ArgonWork::Work()
{
	if (_type == WorkType::Hash)
	{
		_hash = Botan::argon2_generate_pwhash(_password.data(), _password.size(), Botan::system_rng(), _parallelism, _memory, _passes, 2);
	}
	else
	{
		_check_result = Botan::argon2_check_pwhash(_password.data(), _password.size(), _hash);
	}

	_password.clear();
}

cell ArgonWork::TriggerCallback()
{
	for (auto&& p : _params)
	{
		if (std::holds_alternative<cell>(p))
		{
			_callback->Push(std::get<cell>(p));
		}
		else if (std::holds_alternative<std::string>(p))
		{
			_callback->Push(std::get<std::string>(p));
		}
	}

	return _callback->Exec();
}