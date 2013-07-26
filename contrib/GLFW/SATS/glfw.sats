%{#
#include "contrib/GLFW/CATS/glfw.cats"
%}

fun glfwInit(): int = "mac#_glfwInit"
fun glfwTerminate(): void = "mac#_glfwTerminate"

fun glfwOpenWindow( width: int, height: int, redbits: int, 
                    greenbits: int, bluebits: int, alphabits: int, 
                    depthbits: int, stencilbits: int, mode : int): int = "mac#_glfwOpenWindow"
fun glfwSetWindowTitle( title: string ): void = "mac#_glfwSetWindowTitle"
fun glfwGetWindowSize ( pw: ptr, ph: ptr ): void = "mac#_glfwGetWindowSize"
fun glfwGetWindowParam( param: int ): int = "mac#_glfwGetWindowParam"

fun glfwPollEvents(): void = "mac#_glfwPollEvents"
fun glfwWaitEvents(): void = "mac#_glfwWaitEvents"
fun glfwGetKey(key: int): int = "mac#_glfwGetKey"

fun glfwEnable(token: int): void = "mac#_glfwEnable"
fun glfwDisable(token: int): void = "mac#_glfwDisable"

fun glfwSwapInterval(interval: int): void = "mac#_glfwSwapInterval"
fun glfwSwapBuffers(): void = "mac#_glfwSwapBuffers"

(*************************************************************************
 * GLFW version
 *************************************************************************)

#define GLFW_VERSION_MAJOR    2
#define GLFW_VERSION_MINOR    7
#define GLFW_VERSION_REVISION 7


(*************************************************************************
 * Input handling definitions
 *************************************************************************)

(* Key and button state/action definitions *)
macdef GLFW_RELEASE            = $extval (int, "GLFW_RELEASE")
macdef GLFW_PRESS              = $extval (int, "GLFW_PRESS")

(* Keyboard key definitions: 8-bit ISO-8859-1 (Latin 1) encoding is used
 * for printable keys (such as A-Z, 0-9 etc), and values above 256
 * represent special (non-printable) keys (e.g. F1, Page Up etc).
 *)
macdef GLFW_KEY_UNKNOWN      = $extval (int, "GLFW_KEY_UNKNOWN")
macdef GLFW_KEY_SPACE        = $extval (int, "GLFW_KEY_SPACE")
macdef GLFW_KEY_SPECIAL      = $extval (int, "GLFW_KEY_SPECIAL")
macdef GLFW_KEY_ESC          = $extval (int, "GLFW_KEY_ESC")
macdef GLFW_KEY_F1           = $extval (int, "GLFW_KEY_F1")
macdef GLFW_KEY_F2           = $extval (int, "GLFW_KEY_F2")
macdef GLFW_KEY_F3           = $extval (int, "GLFW_KEY_F3")
macdef GLFW_KEY_F4           = $extval (int, "GLFW_KEY_F4")
macdef GLFW_KEY_F5           = $extval (int, "GLFW_KEY_F5")
macdef GLFW_KEY_F6           = $extval (int, "GLFW_KEY_F6")
macdef GLFW_KEY_F7           = $extval (int, "GLFW_KEY_F7")
macdef GLFW_KEY_F8           = $extval (int, "GLFW_KEY_F8")
macdef GLFW_KEY_F9           = $extval (int, "GLFW_KEY_F9")
macdef GLFW_KEY_F10          = $extval (int, "GLFW_KEY_F10")
macdef GLFW_KEY_F11          = $extval (int, "GLFW_KEY_F11")
macdef GLFW_KEY_F12          = $extval (int, "GLFW_KEY_F12")
macdef GLFW_KEY_F13          = $extval (int, "GLFW_KEY_F13")
macdef GLFW_KEY_F14          = $extval (int, "GLFW_KEY_F14")
macdef GLFW_KEY_F15          = $extval (int, "GLFW_KEY_F15")
macdef GLFW_KEY_F16          = $extval (int, "GLFW_KEY_F16")
macdef GLFW_KEY_F17          = $extval (int, "GLFW_KEY_F17")
macdef GLFW_KEY_F18          = $extval (int, "GLFW_KEY_F18")
macdef GLFW_KEY_F19          = $extval (int, "GLFW_KEY_F19")
macdef GLFW_KEY_F20          = $extval (int, "GLFW_KEY_F20")
macdef GLFW_KEY_F21          = $extval (int, "GLFW_KEY_F21")
macdef GLFW_KEY_F22          = $extval (int, "GLFW_KEY_F22")
macdef GLFW_KEY_F23          = $extval (int, "GLFW_KEY_F23")
macdef GLFW_KEY_F24          = $extval (int, "GLFW_KEY_F24")
macdef GLFW_KEY_F25          = $extval (int, "GLFW_KEY_F25")
macdef GLFW_KEY_UP           = $extval (int, "GLFW_KEY_UP")
macdef GLFW_KEY_DOWN         = $extval (int, "GLFW_KEY_DOWN")
macdef GLFW_KEY_LEFT         = $extval (int, "GLFW_KEY_LEFT")
macdef GLFW_KEY_RIGHT        = $extval (int, "GLFW_KEY_RIGHT")
macdef GLFW_KEY_LSHIFT       = $extval (int, "GLFW_KEY_LSHIFT")
macdef GLFW_KEY_RSHIFT       = $extval (int, "GLFW_KEY_RSHIFT")
macdef GLFW_KEY_LCTRL        = $extval (int, "GLFW_KEY_LCTRL")
macdef GLFW_KEY_RCTRL        = $extval (int, "GLFW_KEY_RCTRL")
macdef GLFW_KEY_LALT         = $extval (int, "GLFW_KEY_LALT")
macdef GLFW_KEY_RALT         = $extval (int, "GLFW_KEY_RALT")
macdef GLFW_KEY_TAB          = $extval (int, "GLFW_KEY_TAB")
macdef GLFW_KEY_ENTER        = $extval (int, "GLFW_KEY_ENTER")
macdef GLFW_KEY_BACKSPACE    = $extval (int, "GLFW_KEY_BACKSPACE")
macdef GLFW_KEY_INSERT       = $extval (int, "GLFW_KEY_INSERT")
macdef GLFW_KEY_DEL          = $extval (int, "GLFW_KEY_DEL")
macdef GLFW_KEY_PAGEUP       = $extval (int, "GLFW_KEY_PAGEUP")
macdef GLFW_KEY_PAGEDOWN     = $extval (int, "GLFW_KEY_PAGEDOWN")
macdef GLFW_KEY_HOME         = $extval (int, "GLFW_KEY_HOME")
macdef GLFW_KEY_END          = $extval (int, "GLFW_KEY_END")
macdef GLFW_KEY_KP_0         = $extval (int, "GLFW_KEY_KP_0")
macdef GLFW_KEY_KP_1         = $extval (int, "GLFW_KEY_KP_1")
macdef GLFW_KEY_KP_2         = $extval (int, "GLFW_KEY_KP_2")
macdef GLFW_KEY_KP_3         = $extval (int, "GLFW_KEY_KP_3")
macdef GLFW_KEY_KP_4         = $extval (int, "GLFW_KEY_KP_4")
macdef GLFW_KEY_KP_5         = $extval (int, "GLFW_KEY_KP_5")
macdef GLFW_KEY_KP_6         = $extval (int, "GLFW_KEY_KP_6")
macdef GLFW_KEY_KP_7         = $extval (int, "GLFW_KEY_KP_7")
macdef GLFW_KEY_KP_8         = $extval (int, "GLFW_KEY_KP_8")
macdef GLFW_KEY_KP_9         = $extval (int, "GLFW_KEY_KP_9")
macdef GLFW_KEY_KP_DIVIDE    = $extval (int, "GLFW_KEY_KP_DIVIDE")
macdef GLFW_KEY_KP_MULTIPLY  = $extval (int, "GLFW_KEY_KP_MULTIPLY")
macdef GLFW_KEY_KP_SUBTRACT  = $extval (int, "GLFW_KEY_KP_SUBTRACT")
macdef GLFW_KEY_KP_ADD       = $extval (int, "GLFW_KEY_KP_ADD")
macdef GLFW_KEY_KP_DECIMAL   = $extval (int, "GLFW_KEY_KP_DECIMAL")
macdef GLFW_KEY_KP_EQUAL     = $extval (int, "GLFW_KEY_KP_EQUAL")
macdef GLFW_KEY_KP_ENTER     = $extval (int, "GLFW_KEY_KP_ENTER")
macdef GLFW_KEY_KP_NUM_LOCK  = $extval (int, "GLFW_KEY_KP_NUM_LOCK")
macdef GLFW_KEY_CAPS_LOCK    = $extval (int, "GLFW_KEY_CAPS_LOCK")
macdef GLFW_KEY_SCROLL_LOCK  = $extval (int, "GLFW_KEY_SCROLL_LOCK")
macdef GLFW_KEY_PAUSE        = $extval (int, "GLFW_KEY_PAUSE")
macdef GLFW_KEY_LSUPER       = $extval (int, "GLFW_KEY_LSUPER")
macdef GLFW_KEY_RSUPER       = $extval (int, "GLFW_KEY_RSUPER")
macdef GLFW_KEY_MENU         = $extval (int, "GLFW_KEY_MENU")
macdef GLFW_KEY_LAST         = $extval (int, "GLFW_KEY_LAST")

(* Mouse button definitions *)
macdef GLFW_MOUSE_BUTTON_1      = $extval (int, "GLFW_MOUSE_BUTTON_1")
macdef GLFW_MOUSE_BUTTON_2      = $extval (int, "GLFW_MOUSE_BUTTON_2")
macdef GLFW_MOUSE_BUTTON_3      = $extval (int, "GLFW_MOUSE_BUTTON_3")
macdef GLFW_MOUSE_BUTTON_4      = $extval (int, "GLFW_MOUSE_BUTTON_4")
macdef GLFW_MOUSE_BUTTON_5      = $extval (int, "GLFW_MOUSE_BUTTON_5")
macdef GLFW_MOUSE_BUTTON_6      = $extval (int, "GLFW_MOUSE_BUTTON_6")
macdef GLFW_MOUSE_BUTTON_7      = $extval (int, "GLFW_MOUSE_BUTTON_7")
macdef GLFW_MOUSE_BUTTON_8      = $extval (int, "GLFW_MOUSE_BUTTON_8")
macdef GLFW_MOUSE_BUTTON_LAST   = $extval (int, "GLFW_MOUSE_BUTTON_LAST")

(* Mouse button aliases *)
macdef GLFW_MOUSE_BUTTON_LEFT   = $extval (int, "GLFW_MOUSE_BUTTON_LEFT")
macdef GLFW_MOUSE_BUTTON_RIGHT  = $extval (int, "GLFW_MOUSE_BUTTON_RIGHT")
macdef GLFW_MOUSE_BUTTON_MIDDLE = $extval (int, "GLFW_MOUSE_BUTTON_MIDDLE")


(* Joystick identifiers *)
macdef GLFW_JOYSTICK_1          = $extval (int, "GLFW_JOYSTICK_1")
macdef GLFW_JOYSTICK_2          = $extval (int, "GLFW_JOYSTICK_2")
macdef GLFW_JOYSTICK_3          = $extval (int, "GLFW_JOYSTICK_3")
macdef GLFW_JOYSTICK_4          = $extval (int, "GLFW_JOYSTICK_4")
macdef GLFW_JOYSTICK_5          = $extval (int, "GLFW_JOYSTICK_5")
macdef GLFW_JOYSTICK_6          = $extval (int, "GLFW_JOYSTICK_6")
macdef GLFW_JOYSTICK_7          = $extval (int, "GLFW_JOYSTICK_7")
macdef GLFW_JOYSTICK_8          = $extval (int, "GLFW_JOYSTICK_8")
macdef GLFW_JOYSTICK_9          = $extval (int, "GLFW_JOYSTICK_9")
macdef GLFW_JOYSTICK_10         = $extval (int, "GLFW_JOYSTICK_10")
macdef GLFW_JOYSTICK_11         = $extval (int, "GLFW_JOYSTICK_11")
macdef GLFW_JOYSTICK_12         = $extval (int, "GLFW_JOYSTICK_12")
macdef GLFW_JOYSTICK_13         = $extval (int, "GLFW_JOYSTICK_13")
macdef GLFW_JOYSTICK_14         = $extval (int, "GLFW_JOYSTICK_14")
macdef GLFW_JOYSTICK_15         = $extval (int, "GLFW_JOYSTICK_15")
macdef GLFW_JOYSTICK_16         = $extval (int, "GLFW_JOYSTICK_16")
macdef GLFW_JOYSTICK_LAST       = $extval (int, "GLFW_JOYSTICK_LAST")


(*************************************************************************
 * Other definitions
 *************************************************************************)

(* glfwOpenWindow modes *)
macdef GLFW_WINDOW               = $extval (int, "GLFW_WINDOW")
macdef GLFW_FULLSCREEN           = $extval (int, "GLFW_FULLSCREEN")

(* glfwGetWindowParam tokens *)
macdef GLFW_OPENED               = $extval (int, "GLFW_OPENED")
macdef GLFW_ACTIVE               = $extval (int, "GLFW_ACTIVE")
macdef GLFW_ICONIFIED            = $extval (int, "GLFW_ICONIFIED")
macdef GLFW_ACCELERATED          = $extval (int, "GLFW_ACCELERATED")
macdef GLFW_RED_BITS             = $extval (int, "GLFW_RED_BITS")
macdef GLFW_GREEN_BITS           = $extval (int, "GLFW_GREEN_BITS")
macdef GLFW_BLUE_BITS            = $extval (int, "GLFW_BLUE_BITS")
macdef GLFW_ALPHA_BITS           = $extval (int, "GLFW_ALPHA_BITS")
macdef GLFW_DEPTH_BITS           = $extval (int, "GLFW_DEPTH_BITS")
macdef GLFW_STENCIL_BITS         = $extval (int, "GLFW_STENCIL_BITS")

(* The following constants are used for both glfwGetWindowParam
 * and glfwOpenWindowHint
 *)
macdef GLFW_REFRESH_RATE         = $extval (int, "GLFW_REFRESH_RATE")
macdef GLFW_ACCUM_RED_BITS       = $extval (int, "GLFW_ACCUM_RED_BITS")
macdef GLFW_ACCUM_GREEN_BITS     = $extval (int, "GLFW_ACCUM_GREEN_BITS")
macdef GLFW_ACCUM_BLUE_BITS      = $extval (int, "GLFW_ACCUM_BLUE_BITS")
macdef GLFW_ACCUM_ALPHA_BITS     = $extval (int, "GLFW_ACCUM_ALPHA_BITS")
macdef GLFW_AUX_BUFFERS          = $extval (int, "GLFW_AUX_BUFFERS")
macdef GLFW_STEREO               = $extval (int, "GLFW_STEREO")
macdef GLFW_WINDOW_NO_RESIZE     = $extval (int, "GLFW_WINDOW_NO_RESIZE")
macdef GLFW_FSAA_SAMPLES         = $extval (int, "GLFW_FSAA_SAMPLES")
macdef GLFW_OPENGL_VERSION_MAJOR = $extval (int, "GLFW_OPENGL_VERSION_MAJOR")
macdef GLFW_OPENGL_VERSION_MINOR = $extval (int, "GLFW_OPENGL_VERSION_MINOR")
macdef GLFW_OPENGL_FORWARD_COMPAT = $extval (int, "GLFW_OPENGL_FORWARD_COMPAT")
macdef GLFW_OPENGL_DEBUG_CONTEXT = $extval (int, "GLFW_OPENGL_DEBUG_CONTEXT")
macdef GLFW_OPENGL_PROFILE       = $extval (int, "GLFW_OPENGL_PROFILE")

(* GLFW_OPENGL_PROFILE tokens *)
macdef GLFW_OPENGL_CORE_PROFILE  = $extval (int, "GLFW_OPENGL_CORE_PROFILE")
macdef GLFW_OPENGL_COMPAT_PROFILE = $extval (int, "GLFW_OPENGL_COMPAT_PROFILE")

(* glfwEnable/glfwDisable tokens *)
macdef GLFW_MOUSE_CURSOR         = $extval (int, "GLFW_MOUSE_CURSOR")
macdef GLFW_STICKY_KEYS          = $extval (int, "GLFW_STICKY_KEYS")
macdef GLFW_STICKY_MOUSE_BUTTONS = $extval (int, "GLFW_STICKY_MOUSE_BUTTONS")
macdef GLFW_SYSTEM_KEYS          = $extval (int, "GLFW_SYSTEM_KEYS")
macdef GLFW_KEY_REPEAT           = $extval (int, "GLFW_KEY_REPEAT")
macdef GLFW_AUTO_POLL_EVENTS     = $extval (int, "GLFW_AUTO_POLL_EVENTS")

(* glfwWaitThread wait modes *)
macdef GLFW_WAIT                 = $extval (int, "GLFW_WAIT")
macdef GLFW_NOWAIT               = $extval (int, "GLFW_NOWAIT")

(* glfwGetJoystickParam tokens *)
macdef GLFW_PRESENT              = $extval (int, "GLFW_PRESENT")
macdef GLFW_AXES                 = $extval (int, "GLFW_AXES")
macdef GLFW_BUTTONS              = $extval (int, "GLFW_BUTTONS")

(* glfwReadImage/glfwLoadTexture2D flags *)
macdef GLFW_NO_RESCALE_BIT       = $extval (int, "GLFW_NO_RESCALE_BIT")
macdef GLFW_ORIGIN_UL_BIT        = $extval (int, "GLFW_ORIGIN_UL_BIT")
macdef GLFW_BUILD_MIPMAPS_BIT    = $extval (int, "GLFW_BUILD_MIPMAPS_BIT")
macdef GLFW_ALPHA_MAP_BIT        = $extval (int, "GLFW_ALPHA_MAP_BIT")

(* Time spans longer than this (seconds) are considered to be infinity *)
macdef GLFW_INFINITY = $extval (int, "GLFW_INFINITY")
