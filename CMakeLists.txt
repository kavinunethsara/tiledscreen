cmake_minimum_required(VERSION 3.16)

project(plasma-tiledscreen)
 
find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(Plasma REQUIRED)

plasma_install_package(package com.github.kavinunethsara.tiledscreen)
