cmake_minimum_required(VERSION 3.14...3.22)

project(DonutFortran LANGUAGES Fortran)

enable_testing()

add_executable(donut donut.f90)
