cmake_minimum_required (VERSION 3.20)

project ("hyaxe-plugin" LANGUAGES C CXX)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_package(Threads REQUIRED)

add_compile_definitions(
	$<$<BOOL:MSVC>:_CRT_SECURE_NO_WARNINGS>
	$<$<PLATFORM_ID:Linux>:LINUX>
	HAVE_STDINT_H
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib/cmake)
include(AddSAMPPlugin)
add_subdirectory(lib/botan)

if(MSVC)
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /MANIFEST:NO")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /MANIFEST:NO")
	set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} /MANIFEST:NO")
endif()

file(GLOB_RECURSE HYAXE_SRC
	"src/*.cpp"
)

add_library(hyaxe-plugin SHARED
	${HYAXE_SRC}
	"src/exports.def"
)

target_link_libraries(hyaxe-plugin PUBLIC botan)
target_include_directories(hyaxe-plugin PUBLIC "lib" "lib/botan/include")
target_precompile_headers(hyaxe-plugin PUBLIC "src/pch.h")
set_target_properties(hyaxe-plugin
	PROPERTIES
		RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../plugins"
		LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../plugins"
		UNITY_BUILD ON
		UNITY_BUILD_BATCH_SIZE 15
		PREFIX ""
)
