cmake_minimum_required(VERSION 3.16)
project(demo03_contract_vs_prompt CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (MSVC)
    add_compile_options(/W4 /WX /EHsc)
else()
    add_compile_options(-Wall -Wextra -Wconversion -Werror)
endif()

add_library(deployment_gate src/deployment_gate.cpp)
target_include_directories(deployment_gate PUBLIC include)

add_executable(deployment_gate_test tests/deployment_gate_test.cpp)
target_link_libraries(deployment_gate_test PRIVATE deployment_gate)

enable_testing()
add_test(NAME deployment_gate_test COMMAND deployment_gate_test)
