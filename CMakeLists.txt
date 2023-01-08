cmake_minimum_required(VERSION 3.14)

project(DonutFortran
LANGUAGES C Fortran)

if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  add_compile_options("$<$<COMPILE_LANGUAGE:C>:-Wall;-Wextra;-Wpedantic>"
  "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:C>>:-fsanitize=address>"
  )
elseif(CMAKE_C_COMPILER_ID MATCHES "Clang|^Intel")
  add_compile_options("$<$<COMPILE_LANGUAGE:C>:-Wall;-Wextra>")
elseif(CMAKE_C_COMPILER_ID MATCHES "MSVC")
  add_compile_options("$<$<COMPILE_LANGUAGE:C>:/W3>")
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none;-Wall;-Wextra;-Wpedantic>"
  "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:Fortran>>:-Werror=array-bounds;-fcheck=bounds>"
  "$<$<AND:$<CONFIG:Release>,$<COMPILE_LANGUAGE:Fortran>>:-fno-backtrace>"
  )
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-warn;-traceback>"
  "$<$<AND:$<CONFIG:Debug>,$<COMPILE_LANGUAGE:Fortran>>:-check>"
  )
endif()

add_executable(donut app/main.f90)

add_executable(donut_ref app/main.c)

# --- auto-ignore build directory
if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()
