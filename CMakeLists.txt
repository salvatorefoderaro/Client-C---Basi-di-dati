cmake_minimum_required(VERSION 3.13)
project(example_3)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(example_3
        config.json
        inout.c
        jsmn.c
        jsmn.h
        list.h
        main.c
        Makefile
        parse.c
        program.h)
