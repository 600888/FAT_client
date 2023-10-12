cmake_minimum_required(VERSION 3.16)
project(FAT-Client LANGUAGES CXX)

include(qt.cmake)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(taoQuick.cmake)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR}
    COMPONENTS
        Quick
)

qt_standard_project_setup()

set(PROJECT_SOURCES
    main.cpp
)

if(QT_VERSION VERSION_LESS 6.2)
    list(APPEND PROJECT_SOURCES qml.qrc)
endif()

qt_add_executable(FAT-Client ${PROJECT_SOURCES} ${TaoQuickRes})

if(QT_VERSION VERSION_GREATER_EQUAL 6.2)
    qt_add_qml_module(FAT-Client
        URI fat-client
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml/"
        QML_FILES
            main.qml
    )
endif()

set_target_properties(FAT-Client
    PROPERTIES
        WIN32_EXECUTABLE TRUE
)

target_link_libraries(FAT-Client
    PUBLIC
        Qt::Quick
)

target_compile_definitions(FAT-Client
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(FAT-Client
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)

if(Qt6_FOUND)
    qt_import_qml_plugins(FAT-Client)
endif()
