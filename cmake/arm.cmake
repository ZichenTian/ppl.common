option(PPLCOMMON_USE_ARMV8_2 "build pplcommon with armv8.2-a support." OFF)

file(GLOB_RECURSE PPLCOMMON_ARM_SRC src/ppl/common/arm/*.cc)
list(APPEND PPLCOMMON_ARM_SRC src/ppl/common/arm/fp16fp32_cvt.S)

list(APPEND PPLCOMMON_DEFINITIONS PPLCOMMON_USE_ARM)

if (PPLCOMMON_USE_ARMV8_2)
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set_property(SOURCE src/ppl/common/half.cc PROPERTY COMPILE_FLAGS "-march=armv8.2-a+fp16")
        set_property(SOURCE src/ppl/common/arm/sysinfo.cc APPEND PROPERTY COMPILE_FLAGS "-march=armv8.2-a+fp16")
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
        set_property(SOURCE src/ppl/common/half.cc PROPERTY COMPILE_FLAGS "-march=armv8.2a+fp16")
        set_property(SOURCE src/ppl/common/arm/sysinfo.cc APPEND PROPERTY COMPILE_FLAGS "-march=armv8.2a+fp16")
    endif()
    list(APPEND PPLCOMMON_DEFINITIONS PPLCOMMON_USE_ARMV8_2)
endif()

list(APPEND PPLCOMMON_SRC ${PPLCOMMON_ARM_SRC})

# ----- installation ----- #

file(GLOB PPLCOMMON_ARM_HEADERS
    src/ppl/common/arm/*.h)
install(FILES ${PPLCOMMON_ARM_HEADERS}
    DESTINATION include/ppl/common/arm)
