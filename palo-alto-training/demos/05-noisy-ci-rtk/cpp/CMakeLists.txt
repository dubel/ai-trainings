cmake_minimum_required(VERSION 3.16)
project(demo05_noisy_ci_rtk CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(noisy_ci src/noisy_ci.cpp)
