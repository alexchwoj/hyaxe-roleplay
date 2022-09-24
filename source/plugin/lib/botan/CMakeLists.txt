if(WIN32)
	add_library(botan STATIC
		"./win/botan_all.cpp"
	)

	target_compile_options(botan PRIVATE /EHs /GR /bigobj)
elseif(UNIX)
	add_library(botan STATIC
		"./linux/botan_all.cpp"
	)

	target_compile_options(botan PRIVATE -fstack-protector)
	target_compile_definitions(botan PRIVATE _REENTRANT)
endif()

target_link_libraries(botan PRIVATE Threads::Threads)
target_include_directories(botan PRIVATE "./include")
target_compile_features(botan PRIVATE cxx_std_11)
