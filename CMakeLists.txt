cmake_minimum_required(VERSION 3.16)

project(plasma-tiledscreen)
 
find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(KF6Plasma REQUIRED)

# TODO: adapt "org.kde.plasma" here & elsewhere if needed (see README)
plasma_install_package(package whjjackwhite.tiledscreen)
