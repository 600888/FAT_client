cmake_minimum_required(VERSION 3.16)
project(FAT-Client LANGUAGES CXX)

include(qt.cmake)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(taoQuick.cmake)

aux_source_directory(Src SRC1)
aux_source_directory(Src/DeviceAddTable SRC2)

add_compile_definitions(TaoCommon_NO_LIB)

add_subdirectory(${CMAKE_SOURCE_DIR}/3rdparty/TaoCommon/src/TaoCommon ${CMAKE_SOURCE_DIR}/build/3rdparty/TaoCommon)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR}
    COMPONENTS
        Quick Core QuickControls2
)

qt_standard_project_setup()

set(PROJECT_SOURCES
    Src/main.cpp
)

if(QT_VERSION VERSION_LESS 6.2)
    list(APPEND PROJECT_SOURCES qml.qrc)
endif()

set (Res Qml.qrc Contents.qrc Image.qrc)

#qt_add_executable(FAT-Client ${PROJECT_SOURCES} ${TaoQuickRes} ${Res})
# …Ë÷√øÁ∆ΩÃ®±‡“Î
if (CMAKE_BUILD_TYPE MATCHES "Release")
    if(WIN32)
        add_executable(FAT-Client
            ${SRC1}
            ${SRC2}
            ${TaoCommonFiles}
            ${Res}
            ${TaoQuickRes}
            App.rc
            )
    elseif(APPLE)
        add_executable(FAT-Client
            ${SRC1}
            ${SRC2}
            ${TaoCommonFiles}
            ${Res}
            milk.icns
            ${TaoQuickRes}
            )
    else()
        add_executable(FAT-Client
            ${SRC1}
            ${SRC2}
            ${TaoCommonFiles}
            ${Res}
            ${TaoQuickRes}
            )
    endif()
    add_compile_definitions(FatClientPath="qrc:/")
else()
    add_executable(FAT-Client
        ${SRC1}
        ${SRC2}
        ${TaoCommonFiles}
        )
    add_compile_definitions(TAODEBUG)
    add_compile_definitions(FatClientPath="file:///${CMAKE_CURRENT_SOURCE_DIR}/")
endif()

target_include_directories(FAT-Client PUBLIC . ./Src ${TaoCommonPath})

target_compile_definitions(FAT-Client
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(FAT-Client
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::QuickControls2)

 configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Trans/language_zh.json ${EXECUTABLE_OUTPUT_PATH}/Trans/language_zh.json COPYONLY)

if(Qt6_FOUND)
    qt_import_qml_plugins(FAT-Client)
endif()
