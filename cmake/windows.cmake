set_target_properties(${PACKAGE} PROPERTIES PRECOMPILED_HEADER_SOURCE ${CMAKE_SOURCE_DIR}/libpar2internal.h)
set_target_properties(${PACKAGE} PROPERTIES USE_PRECOMPILED_HEADER ON)
set_target_properties(${PACKAGE} PROPERTIES CHARACTER_SET "Unicode")