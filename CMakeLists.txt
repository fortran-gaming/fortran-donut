cmake_minimum_required(VERSION 3.14)

project(DonutFortran LANGUAGES Fortran)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-Wall -Werror=array-bounds -fcheck=bounds
  "$<$<CONFIG:Debug,RelWithDebInfo>:-Wextra;-Wpedantic>"
  "$<$<CONFIG:Release>:-fno-backtrace>"
  )
endif()

add_executable(donut app/main.f90)
