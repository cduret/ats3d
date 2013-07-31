CMAKE_MINIMUM_REQUIRED (VERSION 2.8)
PROJECT (ATS3D C)

# add GC support
set (CMAKE_C_FLAGS "-I. -I/usr/local/include -O3 -IATS. -D_ATS_GCATS")

set (ATS_INCLUDE "-IATS.")

FIND_PACKAGE (ATS REQUIRED)
IF (NOT ATS_FOUND)
	MESSAGE (FATAL_ERROR ”ATS Not Found!”)
ENDIF ()



ATS_COMPILE (TEST_SRC 
             contrib/GL/SATS/gl.sats
             contrib/GLEXT/SATS/glext.sats
             contrib/GLFW/SATS/glfw.sats
             util/SATS/array_ptr.sats
             util/DATS/array_ptr.dats
             util/SATS/rbtree.sats
             util/DATS/rbtree.dats
             util/SATS/cont.sats
             util/SATS/number.sats
             util/DATS/cont.dats
             gl/SATS/matrix.sats
             gl/DATS/matrix.dats
             gl/SATS/core.sats
             gl/DATS/core.dats
             gl/SATS/engine.sats
             gl/DATS/engine.dats
             util/SATS/scene_zipper.sats
             util/DATS/scene_zipper.dats
             main.dats)

ADD_EXECUTABLE (ats3d_demo ${TEST_SRC})
TARGET_LINK_LIBRARIES (ats3d_demo pthread glfw)
