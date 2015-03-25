package sdl;

@:native("SDL_Window")
@:include('./snowkit_sdl.h')
extern class SDL_Window {}
typedef Window = cpp.Pointer<SDL_Window>;

@:native("SDL_Renderer")
@:include('./snowkit_sdl.h')
extern class SDL_Renderer {}
typedef Renderer = cpp.Pointer<SDL_Renderer>;

@:include('./snowkit_sdl.cpp')
@:buildXml("<include name='${SNOWKIT_SDL_LIB_PATH}/../sdl/snowkit_sdl.xml'/>")
extern class SDL {


    @:native('SDL_Init')
    static function init(flags:SDLInitFlags):Int;
    @:native('SDL_InitSubSystem')
    static function initSubSystem(flags:SDLInitFlags):Int;

    @:native('SDL_Quit')
    static function quit():Void;

    @:native('SDL_CreateWindow')
    static function createWindow(title:String, x:Int, y:Int, w:Int, h:Int, flags:SDLWindowFlags):Window;

    @:native('snowkit_sdl::createWindowAndRenderer')
    static function createWindowAndRenderer(w:Int, h:Int, flags:SDLWindowFlags) : { window:Window, renderer:Renderer };

    @:native('SDL_DestroyWindow')
    static function destroyWindow(window:Window):Void;

    @:native('SDL_DestroyRenderer')
    static function destroyRenderer(renderer:Renderer):Void;

    @:native('SDL_RenderDrawLine')
    static function renderDrawLine(renderer:Renderer, x1:Int, y1:Int, x2:Int, y2:Int):Int;

    @:native('SDL_RenderClear')
    static function renderClear(renderer:Renderer):Int;
    @:native('SDL_RenderPresent')
    static function renderPresent(renderer:Renderer):Int;

    @:native('SDL_SetRenderDrawBlendMode')
    static function setRenderDrawBlendMode(renderer:Renderer, blend:SDLBlendMode):Int;
    @:native('SDL_SetRenderDrawColor')
    static function setRenderDrawColor(renderer:Renderer, r:UInt, g:UInt, b:UInt, a:UInt):Int;

}

@:enum
abstract SDLInitFlags(Int)
from Int to Int {

    var SDL_INIT_TIMER             = 0x00000001;
    var SDL_INIT_AUDIO             = 0x00000010;
    var SDL_INIT_VIDEO             = 0x00000020;  /**< SDL_INIT_VIDEO implies SDL_INIT_EVENTS */
    var SDL_INIT_JOYSTICK          = 0x00000200;  /**< SDL_INIT_JOYSTICK implies SDL_INIT_EVENTS */
    var SDL_INIT_HAPTIC            = 0x00001000;
    var SDL_INIT_GAMECONTROLLER    = 0x00002000;  /**< SDL_INIT_GAMECONTROLLER implies SDL_INIT_JOYSTICK */
    var SDL_INIT_EVENTS            = 0x00004000;
    var SDL_INIT_EVERYTHING        = 0x00000001 | 0x00000010 | 0x00000020 | 0x00004000 | 0x00000200 | 0x00001000 | 0x00002000;

} //SDLInitFlags

@:enum
abstract SDLWindowPos(Int)
from Int to Int {
    var SDL_WINDOWPOS_UNDEFINED = 0|0x1FFF0000;
    var SDL_WINDOWPOS_CENTERED = 0|0x2FFF0000;
} //SDLWindowPos

@:enum
abstract SDLBlendMode(Int)
from Int to Int {

    var SDL_BLENDMODE_NONE = 0x00000000;     /**< no blending
                                              dstRGBA = srcRGBA */
    var SDL_BLENDMODE_BLEND = 0x00000001;    /**< alpha blending
                                              dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA))
                                              dstA = srcA + (dstA * (1-srcA)) */
    var SDL_BLENDMODE_ADD = 0x00000002;      /**< additive blending
                                              dstRGB = (srcRGB * srcA) + dstRGB
                                              dstA = dstA */
    var SDL_BLENDMODE_MOD = 0x00000004;      /**< color modulate
                                              dstRGB = srcRGB * dstRGB
                                              dstA = dstA */
}

@:enum
abstract SDLWindowFlags(Int)
from Int to Int {
    var NONE                            = 0;                /**< fullscreen window */
    var SDL_WINDOW_FULLSCREEN           = 0x00000001;       /**< fullscreen window */
    var SDL_WINDOW_OPENGL               = 0x00000002;       /**< window usable with OpenGL context */
    var SDL_WINDOW_SHOWN                = 0x00000004;       /**< window is visible */
    var SDL_WINDOW_HIDDEN               = 0x00000008;       /**< window is not visible */
    var SDL_WINDOW_BORDERLESS           = 0x00000010;       /**< no window decoration */
    var SDL_WINDOW_RESIZABLE            = 0x00000020;       /**< window can be resized */
    var SDL_WINDOW_MINIMIZED            = 0x00000040;       /**< window is minimized */
    var SDL_WINDOW_MAXIMIZED            = 0x00000080;       /**< window is maximized */
    var SDL_WINDOW_INPUT_GRABBED        = 0x00000100;       /**< window has grabbed input focus */
    var SDL_WINDOW_INPUT_FOCUS          = 0x00000200;       /**< window has input focus */
    var SDL_WINDOW_MOUSE_FOCUS          = 0x00000400;       /**< window has mouse focus */
    var SDL_WINDOW_FULLSCREEN_DESKTOP   = 0x00000001 | 0x00001000;
    var SDL_WINDOW_FOREIGN              = 0x00000800;       /**< window not created by SDL */
    var SDL_WINDOW_ALLOW_HIGHDPI        = 0x00002000;       /**< window should be created in high-DPI mode if supported */
    var SDL_WINDOW_MOUSE_CAPTURE        = 0x00004000;       /**< window has mouse captured (unrelated to INPUT_GRABBED) */
} //SDLWindowFlags

