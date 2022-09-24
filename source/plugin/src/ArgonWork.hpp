#pragma once

class Script;

class ArgonWork
{
public:
	enum class WorkType : std::uint8_t
	{
		Hash,
		Check
	};

private:
	std::shared_ptr<ptl::Public> _callback;
	std::vector<std::variant<cell, std::string>> _params;
	std::string _password;
	std::string _hash;
	bool _check_result;
	int _memory;
	int _parallelism;
	int _passes;
	WorkType _type;

public:
	ArgonWork(const std::string& password, int memory, int parallelism, int passes, WorkType type)
		: _password(password), _memory(memory), _parallelism(parallelism), _passes(passes), _type(type)
	{
	}

	inline void SetCheckHash(const std::string& hash) { _hash = hash; }
	void SetCallback(Script* script, const std::string& name, const char* format, const cell* params, std::size_t params_offset);
	void Work();
	cell TriggerCallback();

	const std::string& GetHash() const { return _hash; }
	bool IsEqual() const { return _check_result; }
	WorkType Type() const { return _type; }
};