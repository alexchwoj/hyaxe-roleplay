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