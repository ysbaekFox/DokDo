cmake_minimum_required(VERSION 3.16)

project(DokDo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#add_definitions(-DQT_NO_DEBUG_OUTPUT)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_resources(RESOURCES resources.qrc)

qt_add_executable(appDokDo
    Utility/Network/Socket/TCPServerSocket.cpp
    Utility/Network/Socket/TCPServerSocket.hpp
    Utility/Network/Socket/TCPClientSocket.cpp
    Utility/Network/Socket/TCPClientSocket.hpp
    main.cpp
    ${RESOURCES}
)

qt_add_qml_module(appDokDo
    URI DokDo
    VERSION 1.0
    QML_FILES main.qml 
)

target_compile_definitions(appDokDo
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appDokDo
    PRIVATE Qt6::Quick)
