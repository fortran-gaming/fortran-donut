cmake_minimum_required(VERSION 3.14)

project(DonutFortran
LANGUAGES C Fortran)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-Wall -Wextra -Wpedantic
  "$<$<COMPILE_LANGUAGE:Fortran>:-Werror=array-bounds;-fcheck=bounds>"
  "$<$<AND:$<CONFIG:Release>,$<COMPILE_LANGUAGE:Fortran>>:-fno-backtrace>"
  )
endif()

add_executable(donut app/main.f90)

add_executable(donut_ref app/main.c)
