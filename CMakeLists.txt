CMAKE_MINIMUM_REQUIRED (VERSION 2.8)
PROJECT (ATS3D C)

set (CMAKE_C_FLAGS "-I. -I/usr/local/include -DATS_MEMALLOC_LIBC")

FIND_PACKAGE (PATS REQUIRED)
IF (NOT PATS_FOUND)
	MESSAGE (FATAL_ERROR ”PATS Not Found!”)
ENDIF ()

PATS_COMPILE (TEST_SRC 
             contrib/GL/SATS/gl.sats
             contrib/GLEXT/SATS/glext.sats
             contrib/GLFW/SATS/glfw.sats
             gl/SATS/glnum.sats
             gl/DATS/glnum.dats
             gl/SATS/matrix_vt.sats
             gl/DATS/gl_matrix_vt.dats
             util/SATS/rbtree.sats
             util/DATS/rbtree.dats
             gl/SATS/core.sats
             gl/DATS/core.dats
             core_example.dats)


             #util/SATS/cont.sats
             #util/SATS/number.sats
             #util/DATS/cont.dats
             #gl/SATS/matrix.sats
             #gl/DATS/matrix.dats
             #gl/SATS/engine.sats
             #gl/DATS/engine.dats
             #util/SATS/scene_zipper.sats
             #util/DATS/scene_zipper.dats

ADD_EXECUTABLE (ats3d_core_example ${TEST_SRC})
TARGET_LINK_LIBRARIES (ats3d_core_example pthread glfw)
