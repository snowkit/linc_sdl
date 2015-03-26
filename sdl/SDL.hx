package sdl;

import sdl.Renderer;
import sdl.Surface;
import sdl.Texture;
import sdl.Joystick;
import sdl.Window;
import sdl.Thread;
import sdl.Haptic;

@:include('./snowkit_sdl.cpp')
@:buildXml("<include name='${SNOWKIT_SDL_LIB_PATH}/../sdl/snowkit_sdl.xml'/>")
@:keep
extern class SDL {


//:note:differences:
// - vargs type functions : use haxe string interpolation instead


//SDL.h

    @:native('SDL_Init')
    static function init(flags:SDLInitFlags):Int;

    @:native('SDL_InitSubSystem')
    static function initSubSystem(flags:SDLInitFlags):Int;

    @:native('SDL_QuitSubSystem')
    static function quitSubSystem(flags:SDLInitFlags):Void;

    @:native('SDL_WasInit')
    static function wasInit(flags:SDLInitFlags):UInt;

    @:native('SDL_Quit')
    static function quit():Void;

//SDL_error.h

    @:native('SDL_SetError')
    static function setError( error:String ):Int;

    @:native("SDL_GetError")
    private static function _getError() : cpp.ConstCharStar;
    static inline function getError() : String return cast _getError();

    @:native('SDL_clearError')
    static function clearError() : Void;

//SDL_log.h
 // - category must be int not strong typed because user can use custom
 //   priority values as well as the defaults, which are int abstracts so they work

    @:native('SDL_Log')
    static function log(value:String):Void;

    @:native('SDL_LogCritical')
    static function logCritical(category:Int, value:String):Void;

    @:native('SDL_LogDebug')
    static function logDebug(category:Int, value:String):Void;

    @:native('SDL_LogError')
    static function logError(category:Int, value:String):Void;

    // @:native('SDL_LogGetOutputFunction')
    //:skipped:todo:
    // static function logGetOutputFunction():

    @:native('SDL_LogGetPriority')
    static function logGetPriority(category:Int):SDLLogPriority;

    @:native('SDL_LogInfo')
    static function logInfo(category:Int, value:String):Void;

    @:native('SDL_LogMessage')
    static function logMessage(priority:SDLLogPriority, category:Int, value:String):Void;

    // @:native('SDL_LogMessageV')
    //:skipped: vargs
    // static function logMessageV():Void;

    @:native('SDL_LogResetPriorities')
    static function logResetPriorities():Void;

    @:native('SDL_LogSetAllPriority')
    static function logSetAllPriority(priority:SDLLogPriority):Void;

    // @:native('SDL_LogSetOutputFunction')
    //:skipped:todo:
    // static function logSetOutputFunction():

    @:native('SDL_LogSetPriority')
    static function logSetPriority(category:Int, priority:SDLLogPriority):Void;

    @:native('SDL_LogVerbose')
    static function logVerbose(category:Int, value:String):Void;

    @:native('SDL_LogWarn')
    static function logWarn(category:Int, value:String):Void;



//SDL_assert.h
 // - :todo:


//SDL_version.h
 // - the version macros in c side are patterned for c,
 //   so the usage patterns are replicated in a haxe way

    @:native('SDL_COMPILEDVERSION')
    static function COMPILEDVERSION(): Int;

    @:native("SDL_GetRevision")
    private static function _getRevision() : cpp.ConstCharStar;
    static inline function getRevision() : String return cast _getRevision();

    @:native('SDL_GetRevisionNumber')
    static function getRevisionNumber(): Int;

    @:native('snowkit_sdl::getVersion')
    static function getVersion(): SDLVersion;

    @:native('snowkit_sdl::REVISION')
    static function REVISION() : String;

    @:native('SDL_VERSIONNUM')
    static function VERSIONNUM(major:Int, minor:Int, patch:Int): Int;

    @:native('snowkit_sdl::VERSION')
    static function VERSION(): SDLVersion;

    @:native('SDL_VERSION_ATLEAST')
    static function VERSION_ATLEAST(major:Int, minor:Int, patch:Int) : Bool;



//SDL_render.h

    @:native('SDL_CreateRenderer')
    static function createRenderer(window:Window, index:Int, flags:SDLRendererFlags):Renderer;

    @:native('SDL_CreateSoftwareRenderer')
    static function createSoftwareRenderer(surface:Surface):Renderer;

    @:native('SDL_CreateTexture')
    static function createTexture(renderer:Renderer, format:SDLPixelFormat, access:SDLTextureAccess, w:Int, h:Int): Texture;

    @:native('SDL_CreateTextureFromSurface')
    static function createTextureFromSurface():Void;

    @:native('snowkit_sdl::createWindowAndRenderer')
    static function createWindowAndRenderer(w:Int, h:Int, flags:SDLWindowFlags) : { window:Window, renderer:Renderer };

    @:native('SDL_DestroyRenderer')
    static function destroyRenderer(renderer:Renderer):Void;

    @:native('SDL_DestroyTexture')
    static function destroyTexture(texture:Texture):Void;

    @:native('snowkit_sdl::GL_BindTexture')
    static function GL_BindTexture(texture:Texture): { texw:Float, texh:Float };

    @:native('SDL_GL_UnbindTexture')
    static function GL_UnbindTexture(texture:Texture):Void;

    @:native('SDL_GetNumRenderDrivers')
    static function getNumRenderDrivers():Int;

    @:native('snowkit_sdl::getRenderDrawBlendMode')
    static function getRenderDrawBlendMode(renderer:Renderer):SDLBlendMode;

    @:native('snowkit_sdl::getRenderDrawColor')
    static function getRenderDrawColor(renderer:Renderer, into:SDLColor) : SDLColor;

    @:native('snowkit_sdl::getRenderDriverInfo')
    static function getRenderDriverInfo(index:Int):SDLRendererInfo;

    @:native('SDL_GetRenderTarget')
    static function getRenderTarget(renderer:Renderer):Texture;

    @:native('SDL_GetRenderer')
    static function getRenderer(window:Window):Renderer;

    @:native('snowkit_sdl::getRendererInfo')
    static function getRendererInfo(renderer:Renderer):SDLRendererInfo;

    @:native('snowkit_sdl::getRendererOutputSize')
    static function getRendererOutputSize(renderer:Renderer, into:SDLSize):SDLSize;

    @:native('snowkit_sdl::getTextureAlphaMod')
    static function getTextureAlphaMod(texture:Texture):Int;

    @:native('snowkit_sdl::getTextureBlendMode')
    static function getTextureBlendMode(texture:Texture):SDLBlendMode;

    @:native('snowkit_sdl::getTextureColorMod')
    static function getTextureColorMod(texture:Texture, into:SDLColor):SDLColor;

    // @:native('SDL_LockTexture')
    // static function lockTexture():Void;

    // @:native('SDL_QueryTexture')
    // static function queryTexture():Void;

    @:native('SDL_RenderClear')
    static function renderClear(renderer:Renderer):Int;

    // @:native('SDL_RenderCopy')
    // static function renderCopy():Void;

    // @:native('SDL_RenderCopyEx')
    // static function renderCopyEx():Void;

    @:native('SDL_RenderDrawLine')
    static function renderDrawLine(renderer:Renderer, x1:Int, y1:Int, x2:Int, y2:Int):Int;

    static inline function renderDrawLines(renderer:Renderer, points:Array<SDLPoint>):Void {
        if(points.length % 2 != 0) throw "points not divisible by 2!";
        var half = Std.int(points.length/2);
        for(i in 0 ... half) {
            var cur = points[i*2+0];
            var nxt = points[i*2+1];
            renderDrawLine(renderer, cur.x, cur.y, nxt.x, nxt.y);
        }
    } //renderDrawLines

    @:native('SDL_RenderDrawPoint')
    static function renderDrawPoint(renderer:Renderer, x:Int, y:Int):Int;

    static inline function renderDrawPoints(renderer:Renderer, points:Array<SDLPoint>):Void {
        for(p in points) renderDrawPoint(renderer, p.x, p.y);
    } //renderDrawPoints

    @:native('snowkit_sdl::renderDrawRect')
    static function renderDrawRect(renderer:Renderer, rect:SDLRect):Int;

    static inline function renderDrawRects(renderer:Renderer, rects:Array<SDLRect>):Void {
        for(r in rects) renderDrawRect(renderer, r);
    }

    @:native('snowkit_sdl::renderFillRect')
    static function renderFillRect(renderer:Renderer, rect:SDLRect):Void;

    static inline function renderFillRects(renderer:Renderer, rects:Array<SDLRect>):Void {
        for(r in rects) renderFillRect(renderer, r);
    }

    @:native('snowkit_sdl::renderGetClipRect')
    static function renderGetClipRect(renderer:Renderer, into:SDLRect):SDLRect;

    @:native('snowkit_sdl::renderGetLogicalSize')
    static function renderGetLogicalSize(renderer:Renderer, into:SDLSize):SDLSize;

    @:native('snowkit_sdl::renderGetScale')
    static function renderGetScale(renderer:Renderer, into:SDLScale):SDLScale;

    @:native('snowkit_sdl::renderGetViewport')
    static function renderGetViewport(renderer:Renderer, into:SDLRect):SDLRect;

    @:native('SDL_RenderIsClipEnabled')
    static function renderIsClipEnabled(renderer:Renderer):Bool;

    @:native('SDL_RenderPresent')
    static function renderPresent(renderer:Renderer):Int;

    // @:native('SDL_RenderReadPixels')
    // static function renderReadPixels():Void;

    @:native('snowkit_sdl::renderSetClipRect')
    static function renderSetClipRect(renderer:Renderer, rect:SDLRect):Int;

    @:native('SDL_RenderSetLogicalSize')
    static function renderSetLogicalSize(renderer:Renderer, w:Int, h:Int):Int;

    @:native('SDL_RenderSetScale')
    static function renderSetScale(renderer:Renderer, x:Float, y:Float):Int;

    @:native('snowkit_sdl::renderSetViewport')
    static function renderSetViewport(renderer:Renderer, rect:SDLRect):Int;

    @:native('SDL_RenderTargetSupported')
    static function renderTargetSupported(renderer:Renderer):Bool;

    @:native('snowkit_sdl::setRenderDrawBlendMode')
    static function setRenderDrawBlendMode(renderer:Renderer, mode:SDLBlendMode):Int;

    @:native('SDL_SetRenderDrawColor')
    static function setRenderDrawColor(renderer:Renderer, r:UInt, g:UInt, b:UInt, a:UInt):Int;

    @:native('SDL_SetRenderTarget')
    static function setRenderTarget(renderer:Renderer, target:Texture):Int;

    @:native('SDL_SetTextureAlphaMod')
    static function setTextureAlphaMod(texture:Texture, alpha:UInt):Int;

    @:native('SDL_SetTextureBlendMode')
    static function setTextureBlendMode(texture:Texture, mode:SDLBlendMode):Int;

    @:native('SDL_SetTextureColorMod')
    static function setTextureColorMod(texture:Texture, r:UInt, g:UInt, b:UInt):Int;

    @:native('SDL_UnlockTexture')
    static function unlockTexture(texture:Texture):Void;

    // @:native('SDL_UpdateTexture')
    // static function updateTexture():Void;

    // @:native('SDL_UpdateYUVTexture')
    // static function updateYUVTexture():Void;


//SDL_cpuinfo.h

    @:native('SDL_GetCPUCacheLineSize')
    static function getCPUCacheLineSize():Int;
    @:native('SDL_GetCPUCount')
    static function getCPUCount():Int;
    @:native('SDL_GetSystemRAM')
    static function getSystemRAM():Int;
    @:native('SDL_Has3DNow')
    static function has3DNow():Bool;
    @:native('SDL_HasAVX')
    static function hasAVX():Bool;
    @:native('SDL_HasAVX2')
    static function hasAVX2():Bool;
    @:native('SDL_HasAltiVec')
    static function hasAltiVec():Bool;
    @:native('SDL_HasMMX')
    static function hasMMX():Bool;
    @:native('SDL_HasRDTSC')
    static function hasRDTSC():Bool;
    @:native('SDL_HasSSE')
    static function hasSSE():Bool;
    @:native('SDL_HasSSE2')
    static function hasSSE2():Bool;
    @:native('SDL_HasSSE3')
    static function hasSSE3():Bool;
    @:native('SDL_HasSSE41')
    static function hasSSE41():Bool;
    @:native('SDL_HasSSE42')
    static function hasSSE42():Bool;

//SDL_bits.h

    @:native('SDL_MostSignificantBitIndex32')
    static function mostSignificantBitIndex32(x:UInt):Int;

//SDL_platform.h

    @:native("SDL_GetPlatform")
    private static function _getPlatform() : cpp.ConstCharStar;
    static inline function getPlatform() : String return cast _getPlatform();

//SDL_timer.h

    // @:native('SDL_AddTimer')
    // static function addTimer():Void;

    // @:native('SDL_RemoveTimer')
    // static function removeTimer():Void;

    @:native('SDL_Delay')
    static function delay(ms:UInt): Void;

    @:native('SDL_GetTicks')
    static function getTicks(): UInt;

    @:native('SDL_GetPerformanceCounter')
    static function getPerformanceCounter(): cpp.UInt64;

    @:native('SDL_GetPerformanceFrequency')
    static function getPerformanceFrequency(): cpp.UInt64;

//SDL_filesystem.h

    @:native("snowkit_sdl::getBasePath")
    static function getBasePath() : String;

    @:native("snowkit_sdl::getPrefPath")
    static function getPrefPath(org:String, app:String) : String;

//SDL_haptic.h

    @:native('SDL_HapticClose')
    static function hapticClose(haptic:Haptic):Void;

    @:native('SDL_HapticDestroyEffect')
    static function hapticDestroyEffect(haptic:Haptic, effect:Int):Void;

    @:native('SDL_HapticEffectSupported')
    static function hapticEffectSupported(haptic:Haptic, effect:HapticEffect):Int;

    @:native('SDL_HapticGetEffectStatus')
    static function hapticGetEffectStatus(haptic:Haptic, effect:Int):Int;

    @:native('SDL_HapticIndex')
    static function hapticIndex(haptic:Haptic):Int;

    @:native('SDL_HapticName')
    private static function _hapticName(device_index:Int) : cpp.ConstCharStar;
    static inline function hapticName(device_index:Int):String return cast _hapticName(device_index);

    @:native('SDL_HapticNewEffect')
    static function hapticNewEffect(haptic:Haptic, effect:HapticEffect):Int;

    @:native('SDL_HapticNumAxes')
    static function hapticNumAxes(haptic:Haptic):Int;

    @:native('SDL_HapticNumEffects')
    static function hapticNumEffects(haptic:Haptic):Int;

    @:native('SDL_HapticNumEffectsPlaying')
    static function hapticNumEffectsPlaying(haptic:Haptic):Int;

    @:native('SDL_HapticOpen')
    static function hapticOpen(device_index:Int):Haptic;

    @:native('SDL_HapticOpenFromJoystick')
    static function hapticOpenFromJoystick(joystick:Joystick):Haptic;

    @:native('SDL_HapticOpenFromMouse')
    static function hapticOpenFromMouse():Haptic;

    @:native('SDL_HapticOpened')
    static function hapticOpened(device_index:Int):Int;

    @:native('SDL_HapticPause')
    static function hapticPause(haptic:Haptic):Int;

    @:native('SDL_HapticQuery')
    static function hapticQuery(haptic:Haptic):UInt;

    @:native('SDL_HapticRumbleInit')
    static function hapticRumbleInit(haptic:Haptic):Int;

    @:native('SDL_HapticRumblePlay')
    static function hapticRumblePlay(haptic:Haptic, strength:Float, length:UInt):Int;

    @:native('SDL_HapticRumbleStop')
    static function hapticRumbleStop(haptic:Haptic):Int;

    @:native('SDL_HapticRumbleSupported')
    static function hapticRumbleSupported(haptic:Haptic):Int;

    @:native('SDL_HapticRunEffect')
    static function hapticRunEffect(haptic:Haptic, effect:Int, iterations:UInt):Int;

    @:native('SDL_HapticSetAutocenter')
    static function hapticSetAutocenter(haptic:Haptic, value:Int):Int;

    @:native('SDL_HapticSetGain')
    static function hapticSetGain(haptic:Haptic, gain:Int):Int;

    @:native('SDL_HapticStopAll')
    static function hapticStopAll(haptic:Haptic):Int;

    @:native('SDL_HapticStopEffect')
    static function hapticStopEffect(haptic:Haptic, effect:Int):Int;

    @:native('SDL_HapticUnpause')
    static function hapticUnpause(haptic:Haptic):Int;

    @:native('SDL_HapticUpdateEffect')
    static function hapticUpdateEffect(haptic:Haptic, effect:Int, data:HapticEffect):Int;

    @:native('SDL_JoystickIsHaptic')
    static function joystickIsHaptic(joystick:Joystick):Int;

    @:native('SDL_MouseIsHaptic')
    static function mouseIsHaptic():Int;

    @:native('SDL_NumHaptics')
    static function numHaptics():Int;


//SDL_thread.h

 //management
    // @:native('SDL_CreateThread')
    // static function createThread(fn:Dynamic->Void, name:String, data:Dynamic) : Thread;

    @:native('SDL_DetachThread')
    static function detachThread(thread:Thread) : Void;

    @:native('SDL_GetThreadID')
    static function getThreadID(thread:Thread) : ThreadID;

    @:native('SDL_GetThreadName')
    private static function _getThreadName(thread:Thread) : cpp.ConstCharStar;
    static inline function getThreadName(thread:Thread) : String return cast _getThreadName(thread);

    @:native('SDL_SetThreadPriority')
    static function setThreadPriority(priority:SDLThreadPriority) : Int;

    @:native('SDL_TLSCreate')
    static function TLSCreate() : TLSID;

    @:native('SDL_TLSGet')
    static function TLSGet(id:TLSID) : Dynamic;

    // @:native('SDL_TLSSet')
    // static function TLSSet(id:TLSID, value:Dynamic, destructor:Dynamic->Void) : Int;

    @:native('SDL_ThreadID')
    static function threadID() : ThreadID;

    static inline function waitThread(thread:Thread) : Int {
        var result:Int = -1;
        untyped SDL_WaitThread(thread, untyped __cpp__(' &result'));
        return result;
    } //waitThread

 //sync primitives

    @:native('SDL_CondBroadcast')
    static function CondBroadcast(cond:Cond) : Int;

    @:native('SDL_CondSignal')
    static function CondSignal(cond:Cond) : Int;

    @:native('SDL_CondWait')
    static function CondWait(cond:Cond, mutex:Mutex) : Int;

    @:native('SDL_CondWaitTimeout')
    static function CondWaitTimeout(cond:Cond, mutex:Mutex, ms:UInt) : Int;

    @:native('SDL_CreateCond')
    static function CreateCond() : Cond;

    @:native('SDL_CreateMutex')
    static function CreateMutex() : Mutex;

    @:native('SDL_CreateSemaphore')
    static function CreateSemaphore(initial_value:UInt) : Sem;

    @:native('SDL_DestroyCond')
    static function DestroyCond(cond:Cond) : Void;

    @:native('SDL_DestroyMutex')
    static function DestroyMutex(mutex:Mutex) : Void;

    @:native('SDL_DestroySemaphore')
    static function DestroySemaphore(sem:Sem) : Void;

    @:native('SDL_LockMutex')
    static function LockMutex(mutex:Mutex) : Int;

    @:native('SDL_SemPost')
    static function SemPost(sem:Sem) : Int;

    @:native('SDL_SemTryWait')
    static function SemTryWait(sem:Sem) : Int;

    @:native('SDL_SemValue')
    static function SemValue(sem:Sem) : UInt;

    @:native('SDL_SemWait')
    static function SemWait(sem:Sem) : Int;

    @:native('SDL_SemWaitTimeout')
    static function SemWaitTimeout(sem:Sem, ms:UInt) : Int;

    @:native('SDL_TryLockMutex')
    static function TryLockMutex(mutex:Mutex) : Int;

    @:native('SDL_UnlockMutex')
    static function UnlockMutex(mutex:Mutex) : Int;




    @:native('SDL_CreateWindow')
    static function createWindow(title:String, x:Int, y:Int, w:Int, h:Int, flags:SDLWindowFlags):Window;

    @:native('SDL_DestroyWindow')
    static function destroyWindow(window:Window):Void;



}

typedef SDLColor = { r:UInt, g:UInt, b:UInt, a:UInt };
typedef SDLPoint = { x:Int, y:Int };
typedef SDLSize = { w:Int, h:Int };
typedef SDLScale = { x:Float, y:Float };
typedef SDLRect = { > SDLPoint, > SDLSize, } //comma is required at the end

typedef SDLVersion = { major:UInt, minor:UInt, patch:UInt };
typedef SDLRendererInfo = {
    var name:String;
    var flags:UInt;
    var num_texture_formats:UInt;
    var texture_formats:Array<UInt>;
    var max_texture_width:Int;
    var max_texture_height:Int;
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
abstract SDLLogPriority(Int)
from Int to Int {
    var SDL_LOG_PRIORITY_VERBOSE    = 1;
    var SDL_LOG_PRIORITY_DEBUG      = 2;
    var SDL_LOG_PRIORITY_INFO       = 3;
    var SDL_LOG_PRIORITY_WARN       = 4;
    var SDL_LOG_PRIORITY_ERROR      = 5;
    var SDL_LOG_PRIORITY_CRITICAL   = 6;
    var SDL_NUM_LOG_PRIORITIES      = 7;
} //SDLLogPriority

@:enum
abstract SDLLogCategory(Int)
from Int to Int {
    var SDL_LOG_CATEGORY_APPLICATION = 0;
    var SDL_LOG_CATEGORY_ERROR       = 1;
    var SDL_LOG_CATEGORY_ASSERT      = 2;
    var SDL_LOG_CATEGORY_SYSTEM      = 3;
    var SDL_LOG_CATEGORY_AUDIO       = 4;
    var SDL_LOG_CATEGORY_VIDEO       = 5;
    var SDL_LOG_CATEGORY_RENDER      = 6;
    var SDL_LOG_CATEGORY_INPUT       = 7;
    var SDL_LOG_CATEGORY_TEST        = 8;
    // SDL_LOG_CATEGORY_RESERVED1    = 9
    // SDL_LOG_CATEGORY_RESERVED2    = 10
    // SDL_LOG_CATEGORY_RESERVED3    = 11
    // SDL_LOG_CATEGORY_RESERVED4    = 12
    // SDL_LOG_CATEGORY_RESERVED5    = 13
    // SDL_LOG_CATEGORY_RESERVED6    = 14
    // SDL_LOG_CATEGORY_RESERVED7    = 15
    // SDL_LOG_CATEGORY_RESERVED8    = 16
    // SDL_LOG_CATEGORY_RESERVED9    = 17
    // SDL_LOG_CATEGORY_RESERVED10   = 18
    var SDL_LOG_CATEGORY_CUSTOM      = 19;
} //SDLLogCategory

@:enum
abstract SDLRendererFlags(Int)
from Int to Int {

    var SDL_RENDERER_SOFTWARE       = 0x00000001;       /**< The renderer is a software fallback */
    var SDL_RENDERER_ACCELERATED    = 0x00000002;       /**< The renderer uses hardware
                                                          acceleration */
    var SDL_RENDERER_PRESENTVSYNC   = 0x00000004;       /**< Present is synchronized
                                                          with the refresh rate */
    var SDL_RENDERER_TARGETTEXTURE  = 0x00000008;       /**< The renderer supports
                                                          rendering to texture */
} //SDLRendererFlags

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
} //SDLBlendMode

@:enum
abstract SDLPixelFormat(Int)
from Int to Int {
    var SDL_PIXELFORMAT_UNKNOWN     = 0x00000000;
    var SDL_PIXELFORMAT_INDEX1LSB   = 0x11100100;
    var SDL_PIXELFORMAT_INDEX1MSB   = 0x11200100;
    var SDL_PIXELFORMAT_INDEX4LSB   = 0x12100400;
    var SDL_PIXELFORMAT_INDEX4MSB   = 0x12200400;
    var SDL_PIXELFORMAT_INDEX8      = 0x13000801;
    var SDL_PIXELFORMAT_RGB332      = 0x14110801;
    var SDL_PIXELFORMAT_RGB444      = 0x15120C02;
    var SDL_PIXELFORMAT_RGB555      = 0x15130F02;
    var SDL_PIXELFORMAT_BGR555      = 0x15530F02;
    var SDL_PIXELFORMAT_ARGB4444    = 0x15321002;
    var SDL_PIXELFORMAT_RGBA4444    = 0x15421002;
    var SDL_PIXELFORMAT_ABGR4444    = 0x15721002;
    var SDL_PIXELFORMAT_BGRA4444    = 0x15821002;
    var SDL_PIXELFORMAT_ARGB1555    = 0x15331002;
    var SDL_PIXELFORMAT_RGBA5551    = 0x15441002;
    var SDL_PIXELFORMAT_ABGR1555    = 0x15731002;
    var SDL_PIXELFORMAT_BGRA5551    = 0x15841002;
    var SDL_PIXELFORMAT_RGB565      = 0x15151002;
    var SDL_PIXELFORMAT_BGR565      = 0x15551002;
    var SDL_PIXELFORMAT_RGB24       = 0x17101803;
    var SDL_PIXELFORMAT_BGR24       = 0x17401803;
    var SDL_PIXELFORMAT_RGB888      = 0x16161804;
    var SDL_PIXELFORMAT_RGBX8888    = 0x16261804;
    var SDL_PIXELFORMAT_BGR888      = 0x16561804;
    var SDL_PIXELFORMAT_BGRX8888    = 0x16661804;
    var SDL_PIXELFORMAT_ARGB8888    = 0x16362004;
    var SDL_PIXELFORMAT_RGBA8888    = 0x16462004;
    var SDL_PIXELFORMAT_ABGR8888    = 0x16762004;
    var SDL_PIXELFORMAT_BGRA8888    = 0x16862004;
    var SDL_PIXELFORMAT_ARGB2101010 = 0x16372004;
    var SDL_PIXELFORMAT_YV12        = 0x32315659;
    var SDL_PIXELFORMAT_IYUV        = 0x56555949;
    var SDL_PIXELFORMAT_YUY2        = 0x32595559;
    var SDL_PIXELFORMAT_UYVY        = 0x59565955;
    var SDL_PIXELFORMAT_YVYU        = 0x55595659;
    var SDL_PIXELFORMAT_NV12        = 0x3231564E;
    var SDL_PIXELFORMAT_NV21        = 0x3132564E;
} //SDLPixelFormat

@:enum
abstract SDLTextureAccess(Int)
from Int to Int {
    var SDL_TEXTUREACCESS_STATIC    = 0;  /**< Changes rarely, not lockable */
    var SDL_TEXTUREACCESS_STREAMING = 1;  /**< Changes frequently, lockable */
    var SDL_TEXTUREACCESS_TARGET    = 2;  /**< Texture can be used as a render target */
} //SDLTextureAccess


@:enum
abstract SDLThreadPriority(Int)
from Int to Int {
    var SDL_THREAD_PRIORITY_LOW = 0;
    var SDL_THREAD_PRIORITY_NORMAL = 1;
    var SDL_THREAD_PRIORITY_HIGH = 2;
} //SDLThreadPriority

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
