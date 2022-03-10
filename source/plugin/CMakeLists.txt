cmake_minimum_required (VERSION 3.20)

project ("hyaxe-plugin" LANGUAGES C CXX)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_compile_definitions(
	$<$<BOOL:MSVC>:_CRT_SECURE_NO_WARNINGS>
	$<$<PLATFORM_ID:Linux>:LINUX>
	HAVE_STDINT_H
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib/cmake)
include(AddSAMPPlugin)

file(GLOB_RECURSE HYAXE_SRC
	"src/*.cpp"
)

add_library(hyaxe-plugin SHARED
	${HYAXE_SRC}
	"src/exports.def"
)

target_include_directories(hyaxe-plugin PUBLIC "lib")
target_precompile_headers(hyaxe-plugin PUBLIC "src/pch.h")
set_target_properties(hyaxe-plugin
	PROPERTIES
		RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../plugins"
		LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../plugins"
		UNITY_BUILD ON
		UNITY_BUILD_BATCH_SIZE 15
		PREFIX ""
)
