#include "../main.hpp"

cell Script::n_memset(cell arr_addr, int value, int cell_count)
{
	cell* arr = GetPhysAddr(arr_addr);

	// Not memset
	for (size_t i{ 0u }; i < cell_count; ++i)
	{
		arr[i] = static_cast<cell>(value);
	}

	return 1;
}

cell Script::n_RandomFloat(float min, float max)
{
	std::random_device rd;
	std::mt19937 gen{ rd() };
	std::uniform_real_distribution<float> dis(std::min(min, max), std::max(min, max));
	
	float random_value = dis(gen);
	return amx_ftoc(random_value);
}