if(BUILD_LIB)
    target_compile_definitions(${PAR2_LIBRARY} PRIVATE UNICODE)
endif()

if(BUILD_TOOL)
    target_compile_definitions(${PACKAGE} PRIVATE UNICODE)
    target_compile_definitions(${PACKAGE} PRIVATE CONSOLE)
endif()
