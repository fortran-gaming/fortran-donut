cmake_minimum_required(VERSION 3.14)

project(DonutFortran
LANGUAGES C)

option(fortran "enable Fortran language" on)

if(fortran)
  enable_language(Fortran)
endif()

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED on)

if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  add_compile_options("$<$<COMPILE_LANGUAGE:C>:-Wall;-Wextra;-Wpedantic>"
  "$<$<AND:$<CONFIG:Debug>,$<BOOL:${UNIX}>,$<COMPILE_LANGUAGE:C>>:-fsanitize=address>"
  )
elseif(CMAKE_C_COMPILER_ID MATCHES "Clang|^Intel")
  add_compile_options("$<$<COMPILE_LANGUAGE:C>:-Wall;-Wextra>")
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

if(fortran)
add_executable(donut app/main.f90)
endif()

add_executable(donut_ref app/main.c)
target_link_libraries(donut_ref PRIVATE $<$<BOOL:${UNIX}>:m>)

# --- auto-ignore build directory
if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()
