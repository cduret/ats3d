/* ****** ****** */
//
// Author of the file: Artyom Shalkhakov
// Starting time: May 13, 2011
//
/* ****** ****** */
//
// License: GNU LESSER GENERAL PUBLIC LICENSE version 2.1
//
/* ****** ****** */

#ifndef ATSCTRB_GLEXT_GL_CATS
#define ATSCTRB_GLEXT_GL_CATS

#include <GL/gl.h>
#include <GL/glext.h>

typedef GLintptr ats_GLintptr_type;
typedef GLsizeiptr ats_GLsizeiptr_type;

ATSinline()
ats_GLsizeiptr_type
atsctrb_GLsizeiptr_of_uintptr (ats_uintptr_type x) { return (ats_GLsizeiptr_type) x ; }

//

ATSinline()
ats_GLsizeiptr_type
atsctrb_GLsizeiptr_of_int (ats_int_type x) { return x ; }

#define atsctrb_GLtexture_zero() ((GLuint)0)
#define atsctrb_GLtexture_is_zero(x) ((x) == ((GLuint)0))
#define atsctrb_GLtexture_isnot_zero(x) ((x) > ((GLuint)0))

#define atsctrb_glActiveTexture glActiveTexture
#define atsctrb_glAttachShader glAttachShader
#define atsctrb_glBindAttribLocation glBindAttribLocation
#define atsctrb_glBindBuffer glBindBuffer
#define atsctrb_glBindFramebuffer glBindFramebuffer
#define atsctrb_glBindRenderbuffer glBindRenderbuffer
#define atsctrb_glBindTexture glBindTexture
#define atsctrb_glBlendColor glBlendColor
#define atsctrb_glBlendEquation glBlendEquation
#define atsctrb_glBlendEquationSeparate glBlendEquationSeparate
#define atsctrb_glBlendFunc glBlendFunc
#define atsctrb_glBlendFuncSeparate glBlendFuncSeparate
#define atsctrb_glBufferData glBufferData
#define atsctrb_glBufferSubData glBufferSubData
#define atsctrb_glCheckFramebufferStatus glCheckFramebufferStatus
#define atsctrb_glClear glClear
#define atsctrb_glClearColor glClearColor
#define atsctrb_glClearDepthf glClearDepthf
#define atsctrb_glClearStencil glClearStencil
#define atsctrb_glColorMask glColorMask
#define atsctrb_glCompileShader glCompileShader
#define atsctrb_glCompressedTexImage2D glCompressedTexImage2D
#define atsctrb_glCompressedTexSubImage2D glCompressedTexSubImage2D
#define atsctrb_glCopyTexImage2D glCopyTexImage2D
#define atsctrb_glCopyTexSubImage2D glCopyTexSubImage2D
#define atsctrb_glCreateProgram glCreateProgram
#define atsctrb_glCreateShader glCreateShader
#define atsctrb_glCullFace glCullFace

ATSinline()
ats_void_type
atsctrb_glDeleteBuffer
  (ats_GLuint_type buffer) {
  glDeleteBuffers (1, (GLuint*)&buffer);
} // end of [atsctrb_glDeleteBuffer]

#define atsctrb_glDeleteBuffers glDeleteBuffers

ATSinline()
ats_void_type
atsctrb_glDeleteFramebuffer
  (ats_GLuint_type framebuffer) {
  glDeleteFramebuffers (1, (GLuint*)&framebuffer);
} // end of [atsctrb_glDeleteFramebuffer]

#define atsctrb_glDeleteFramebuffers glDeleteFramebuffers

#define atsctrb_glDeleteProgram glDeleteProgram

ATSinline()
ats_void_type
atsctrb_glDeleteRenderbuffer
  (ats_GLuint_type renderbuffer) {
  glDeleteRenderbuffers (1, (GLuint*)&renderbuffer);
} // end of [atsctrb_glDeleteRenderbuffer]

#define atsctrb_glDeleteRenderbuffers glDeleteRenderbuffers

#define atsctrb_glDeleteShader glDeleteShader

#define atsctrb_glDepthMask glDepthMask
#define atsctrb_glDepthRangef glDepthRangef
#define atsctrb_glDetachShader glDetachShader
#define atsctrb_glDisable glDisable
#define atsctrb_glDisableVertexAttribArray glDisableVertexAttribArray
#define atsctrb_glDrawArrays glDrawArrays
#define atsctrb_glDrawElements glDrawElements
#define atsctrb_glEnableVertexAttribArray glEnableVertexAttribArray
#define atsctrb_glFinish glFinish
#define atsctrb_glFlush glFlush
#define atsctrb_glFramebufferRenderbuffer glFramebufferRenderbuffer
#define atsctrb_glFramebufferTexture2D glFramebufferTexture2D
#define atsctrb_glFontFace glFontFace

ATSinline()
ats_void_type
atsctrb_glGenBuffer
  (ats_ref_type buffer) {
  glGenBuffers(1, (GLuint*)buffer);
} // end of [atsctrb_glGenBuffer]

#define atsctrb_glGenBuffers glGenBuffers
#define atsctrb_glGenerateMipmap glGenerateMipMap

ATSinline()
ats_void_type
atsctrb_glGenFramebuffer
  (ats_ref_type framebuffer) {
  glGenFramebuffers(1, (GLuint*)framebuffer);
} // end of [atsctrb_glGenFramebuffer]

#define atsctrb_glGenFramebuffers glGenFramebuffers

ATSinline()
ats_void_type
atsctrb_glGenRenderbuffer
  (ats_ref_type renderbuffer) {
  glGenRenderbuffers(1, (GLuint*)renderbuffer);
} // end of [atsctrb_glGenRenderbuffer]

#define atsctrb_glGenRenderbuffers glGenRenderbuffers

#define atsctrb_glGetActiveAttrib glGetActiveAttrib
#define atsctrb_glGetActiveUniform glGetActiveUniform
#define atsctrb_glGetAttachedShaders glGetAttachedShaders
#define atsctrb_glGetAttribLocation glGetAttribLocation
#define atsctrb_glGetBooleanv glGetBooleanv
#define atsctrb_glGetBufferParameteriv glGetBufferParameteriv
#define atsctrb_glGetError glGetError
#define atsctrb_glGetFloatv glGetFloatv
#define atsctrb_glGetFramebufferAttachmentParameteriv glGetFramebufferAttachmentParameteriv
#define atsctrb_glGetIntegerv glGetIntegerv
#define atsctrb_glGetProgramiv glGetProgramiv
#define atsctrb_glGetProgramInfoLog glGetProgramInfoLog
#define atsctrb_glGetRenderbufferParameteriv
#define atsctrb_glGetShaderiv glGetShaderiv
#define atsctrb_glGetShaderInfoLog glGetShaderInfoLog
#define atsctrb_glGetShaderPrecisionFormat glGetShaderPrecisionFormat
#define atsctrb_glGetShaderSource glGetShaderSource
#define atsctrb_glGetTexParameterfv glGetTexParameterfv
#define atsctrb_glGetTexParameteriv glGetTexParameteriv
#define atsctrb_glGetUniformfv glGetUniformfv
#define atsctrb_glGetUniformiv glGetUniformiv
#define atsctrb_glGetUniformLocation glGetUniformLocation
#define atsctrb_glGetVertexAttribfv glGetVertexAttribfv
#define atsctrb_glGetVertexAttribiv glGetVertexAttribiv
#define atsctrb_glGetVertexAttribPointerv glGetVertexAttribPointerv
#define atsctrb_glIsBuffer glIsBuffer
#define atsctrb_glIsEnabled glIsEnabled
#define atsctrb_glIsFramebuffer glIsFramebuffer
#define atsctrb_glIsProgram glIsProgram
#define atsctrb_glIsRenderbuffer glIsRenderbuffer
#define atsctrb_glIsShader glIsShader
#define atsctrb_glIsTexture glIsTexture
#define atsctrb_glLineWidth glLineWidth
#define atsctrb_glLinkProgram glLinkProgram
#define atsctrb_glPixelStorei glPixelStorei
#define atsctrb_glPolygonOffset glPolygonOffset
#define atsctrb_glReadPixels glReadPixels
#define atsctrb_glReleaseShaderCompiler glReleaseShaderCompiler
#define atsctrb_glRenderbufferStorage glRenderbufferStorage
#define atsctrb_glSampleCoverage glSampleCoverage
#define atsctrb_glScissor glScissor
#define atsctrb_glShaderBinary glShaderBinary

ATSinline()
ats_void_type
  atsctrb_glShaderSource__string
  (ats_GLuint_type shader, ats_ptr_type str) {
  glShaderSource (shader, 1, (const GLchar **)&str, NULL);
} // end of [atsctrb_glShaderSource__string]

#define atsctrb_glShaderSource glShaderSource
#define atsctrb_glStencilFunc glStencilFunc
#define atsctrb_glStencilFuncSeparate glStencilFuncSeparate
#define atsctrb_glStencilMask glStencilMask
#define atsctrb_glStencilMaskSeparate glStencilMaskSeparate
#define atsctrb_glStencilOp glStencilOp
#define atsctrb_glStencilOpSeparate glStencilOpSeparate
#define atsctrb_glTexImage2D glTexImage2D
#define atsctrb_glTexParameterf glTexParameterf
#define atsctrb_glTexParameterfv glTexParameterfv
#define atsctrb_glTexParameteri glTexParameteri
#define atsctrb_glTexParameteriv glTexParameteriv
#define atsctrb_glTexSubImage2D glTexSubImage2D
#define atsctrb_glUniform1f glUniform1f
#define atsctrb_glUniform1fv glUniform1fv
#define atsctrb_glUniform1i glUniform1i
#define atsctrb_glUniform1iv glUniform1iv
#define atsctrb_glUniform2f glUniform2f
#define atsctrb_glUniform2fv glUniform2fv
#define atsctrb_glUniform2i glUniform2i
#define atsctrb_glUniform2iv glUniform2iv
#define atsctrb_glUniform3f glUniform3f
#define atsctrb_glUniform3fv glUniform3fv
#define atsctrb_glUniform3i glUniform3i
#define atsctrb_glUniform3iv glUniform3iv
#define atsctrb_glUniform4f glUniform4f
#define atsctrb_glUniform4fv glUniform4fv
#define atsctrb_glUniform4i glUniform4i
#define atsctrb_glUniform4iv glUniform4iv
#define atsctrb_glUniformMatrix2fv glUniformMatrix2fv
#define atsctrb_glUniformMatrix3fv glUniformMatrix3fv
#define atsctrb_glUniformMatrix4fv glUniformMatrix4fv
#define atsctrb_glUseProgram glUseProgram
#define atsctrb_glValidateProgram glValidateProgram
#define atsctrb_glVertexAttrib1f glVertexAttrib1f
#define atsctrb_glVertexAttrib1fv glVertexAttrib1fv
#define atsctrb_glVertexAttrib2f glVertexAttrib2f
#define atsctrb_glVertexAttrib2fv glVertexAttrib2fv
#define atsctrb_glVertexAttrib3f glVertexAttrib3f
#define atsctrb_glVertexAttrib3fv glVertexAttrib3fv
#define atsctrb_glVertexAttrib4f glVertexAttrib4f
#define atsctrb_glVertexAttrib4fv glVertexAttrib4fv
#define atsctrb_glVertexAttribPointer glVertexAttribPointer
#define atsctrb_glViewport glViewport

#endif /* ATSCTRB_GLEXT_GL_CATS */

/* end of [glext.cats] */
