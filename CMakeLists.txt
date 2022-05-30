cmake_minimum_required(VERSION 3.14)

project(DonutFortran
LANGUAGES C Fortran)

if(CMAKE_CXX_COMPILER_ID MATCHES "(Clang|Intel)")
  add_compile_options("$<$<COMPILE_LANGUAGE:C,CXX>:-Wall;-Wextra>")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
  add_compile_options("$<$<COMPILE_LANGUAGE:C,CXX>:/W3>")
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none;-Wall;-Wextra;-Wpedantic;-Werror=array-bounds;-fcheck=bounds>"
  "$<$<AND:$<CONFIG:Release>,$<COMPILE_LANGUAGE:Fortran>>:-fno-backtrace>"
  )
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options("$<$<COMPILE_LANGUAGE:Fortran>:-warn;-traceback;-check>")
endif()

add_executable(donut app/main.f90)

add_executable(donut_ref app/main.c)
