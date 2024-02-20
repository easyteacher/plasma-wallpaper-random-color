# SPDX-FileCopyrightText: 2022 Fushan Wen <qydwhotmail@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.5)

project(plasma-wallpaper-random-color)
set(PROJECT_VERSION "1.1.0")
set(PROJECT_VERSION_MAJOR 1)

set(KF6_MIN_VERSION "5.240.0")
set(QT_MIN_VERSION "6.6.0")

################# Disallow in-source build #################
if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
   message(FATAL_ERROR "plasma requires an out of source build. Please create a separate build directory and run 'cmake path_to_plasma [options]' there.")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FeatureSummary)

find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMFindQmlModule)

find_package(Plasma 6.0 REQUIRED)

ecm_find_qmlmodule(QtQuick 2.0)
ecm_find_qmlmodule(org.kde.kquickcontrolsaddons 2.0)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)

plasma_install_package(package com.github.easyteacher.randomcolor wallpapers wallpaper)
