package sdl;

import haxe.io.Bytes;
import sdl.Renderer;
import sdl.Surface;
import sdl.Cursor;
import sdl.Texture;
import sdl.Joystick;
import sdl.Window;
import sdl.GLContext;
import sdl.Thread;
import sdl.RWops;
import sdl.Haptic;

@:include('./native_sdl.cpp')
@:buildXml("<include name='${NATIVE_SDL_LIB_PATH}/../sdl/native_sdl.xml'/>")
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

//SDL_events.h


    //void SDL_AddEventWatch(SDL_EventFilter filter,
    //                       void*           userdata)

    //void SDL_DelEventWatch(SDL_EventFilter filter,
    //                       void*           userdata)

    @:native('SDL_EventState')
    static function eventState( type:SDLEventType, state:SDLEventState ) : UInt;

    //void SDL_FilterEvents(SDL_EventFilter filter, void* userdata)

    @:native('SDL_FlushEvent')
    static function flushEvent( type:SDLEventType ) : Void;

    @:native('SDL_FlushEvents')
    static function flushEvents( min:SDLEventType, max:SDLEventType ) : Void;

    //SDL_bool SDL_GetEventFilter(SDL_EventFilter* filter,
    //                            void**           userdata)

    @:native('SDL_GetNumTouchDevices')
    static function getNumTouchDevices() : Int;

    @:native('SDL_GetNumTouchFingers')
    static function getNumTouchFingers(touchId:cpp.Int64) : Int;

    @:native('SDL_GetTouchDevice')
    static function getTouchDevice(index:Int) : cpp.Int64;

    @:native('SDL_GetTouchFinger')
    static function getTouchFinger(touchID:cpp.Int64, index:Int): sdl.Event.Finger;

        //:note: Not SDL API, this was added to work
        //better against pollEvent, see the comments there.
    static inline function hasAnEvent():Bool  {
        pumpEvents();
        return hasEvents( SDL_FIRSTEVENT, SDL_LASTEVENT );
    }

    @:native('SDL_HasEvent')
    static function hasEvent( type:SDLEventType ) : Bool;

    @:native('SDL_HasEvents')
    static function hasEvents( min:SDLEventType, max:SDLEventType ) : Bool;

    //int SDL_LoadDollarTemplates(SDL_TouchID touchId,
    //                             SDL_RWops*  src)

    //int SDL_PeepEvents(SDL_Event*      events,
                   // int             numevents,
                   // SDL_eventaction action,
                   // Uint32          minType,
                   // Uint32          maxType

    // static inline function peepEvents(numevents:Int, action:SDLEventAction, min:SDLEventType, max:SDLEventType) : Array<Event> {
    // } //peepEvents

    @:native('SDL_PumpEvents')
    static function pumpEvents():Void;

        //usually, pollEvent returns 0 in C, so that
        //while(SDL_PollEvent(&event)) is used on a stack variable,
        //however this notion in haxe doesn't apply, but we
        //can still keep the variable on the stack,
        //use hasAnEvent() to know if this is worth calling,
        //or call it and if event.type is 0 the queue was empty
    static inline function pollEvent() : Event {

            //:portability: this requires C99
            //this makes sure the memory is zeroed because
            //otherwise it can hold bogus event values.
            //since type=0 would be "invalid" as above,
            //it would be acceptable to only do type = 0
            //if pollevent returned 0, but at least during
            //heavy development the chance of error should be slimmed
            //down as much as possible - therefore the entire struct is cleared.
            //I would use SDL_zero(event), however haxe requires assignment on a local
        var event:Event = untyped __cpp__('(const union SDL_Event){0}');
        untyped SDL_PollEvent( untyped __cpp__('&event') );

        return event;

    } //pollEvent


    // int SDL_PushEvent(SDL_Event* event)

    @:native('SDL_QuitRequested')
    static function quitRequested(): Bool;

    @:native('SDL_RecordGesture')
    static function recordGesture(touchId:cpp.Int64): Int;

    @:native('SDL_RegisterEvents')
    static function registerEvents(numevents:Int):UInt;

    // int SDL_SaveAllDollarTemplates(SDL_RWops* dst)

    //void SDL_SetEventFilter(SDL_EventFilter filter,
    //                        void*           userdata)

    static inline function waitEvent() : Event {
        var event:Event = untyped __cpp__('(const union SDL_Event){0}');
        untyped SDL_WaitEvent( untyped __cpp__('&event') );
        return event;
    }

    static inline function waitEventTimeout(timeout_ms:Int) : Event {
        var event:Event = untyped __cpp__('(const union SDL_Event){0}');
        untyped SDL_WaitEventTimeout( untyped __cpp__('&event'), untyped timeout_ms );
        return event;
    }

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

    @:native('native_sdl::getVersion')
    static function getVersion(): SDLVersion;

    @:native('native_sdl::REVISION')
    static function REVISION() : String;

    @:native('SDL_VERSIONNUM')
    static function VERSIONNUM(major:Int, minor:Int, patch:Int): Int;

    @:native('native_sdl::VERSION')
    static function VERSION(): SDLVersion;

    @:native('SDL_VERSION_ATLEAST')
    static function VERSION_ATLEAST(major:Int, minor:Int, patch:Int) : Bool;



//SDL_RWops.h

    @:native('SDL_AllocRW')
    static function allocRW() : RWops;

    @:native('SDL_FreeRW')
    static function freeRW(area:RWops) : Void;

    @:native('SDL_RWFromFile')
    static function RWFromFile(file:String, mode:String) : RWops;

    @:native('SDL_RWFromMem')
    static function RWFromMem(source:Bytes, size:Int) : RWops;

    @:native('SDL_RWclose')
    static function RWclose(context:RWops) : RWops;

    @:native('SDL_RWread')
    static function RWread(context:RWops, into:Bytes, size:UInt, maxnum:UInt) : UInt;

    @:native('SDL_RWwrite')
    static function RWwrite(context:RWops, from:Bytes, size:UInt, num:UInt) : UInt;

    @:native('SDL_RWseek')
    static function RWseek(context:RWops, offset:cpp.Int64, whence:Int) : cpp.Int64;

    @:native('SDL_RWsize')
    static function RWsize(context:RWops) : cpp.Int64;

    @:native('SDL_RWtell')
    static function RWtell(context:RWops) : cpp.Int64;

    @:native('SDL_ReadBE16')
    static function ReadBE16(src:RWops) : cpp.Int16;

    @:native('SDL_ReadBE32')
    static function ReadBE32(src:RWops) : cpp.Int32;

    @:native('SDL_ReadBE64')
    static function ReadBE64(src:RWops) : cpp.Int64;

    @:native('SDL_ReadLE16')
    static function ReadLE16(src:RWops) : cpp.Int16;

    @:native('SDL_ReadLE32')
    static function ReadLE32(src:RWops) : cpp.Int32;

    @:native('SDL_ReadLE64')
    static function ReadLE64(src:RWops) : cpp.Int64;

    @:native('SDL_WriteBE16')
    static function WriteBE16(dst:RWops, value:cpp.Int16) : UInt;

    @:native('SDL_WriteBE32')
    static function WriteBE32(dst:RWops, value:cpp.Int32) : UInt;

    @:native('SDL_WriteBE64')
    static function WriteBE64(dst:RWops, value:cpp.Int64) : UInt;

    @:native('SDL_WriteLE16')
    static function WriteLE16(dst:RWops, value:cpp.Int16) : UInt;

    @:native('SDL_WriteLE32')
    static function WriteLE32(dst:RWops, value:cpp.Int32) : UInt;

    @:native('SDL_WriteLE64')
    static function WriteLE64(dst:RWops, value:cpp.Int64) : UInt;


//SDL_surface.h

    @:native('SDL_LoadBMP_RW')
    static function loadBMP_RW(src:RWops, freesrc:Int) : Surface;

    @:native('SDL_LoadBMP')
    static function loadBMP(file:String) : Surface;

    @:native('SDL_FreeSurface')
    static function freeSurface(surface:Surface) : Void;

    @:native('SDL_BlitSurface')
    static function blitSurface(src:Surface, srcrect:SDLRect, dst:Surface, dstrect:SDLRect ) : Int;

    @:native('SDL_GetWindowSurface')
    static function getWindowSurface(window:Window) : Surface;

    @:native('SDL_UpdateWindowSurface')
    static function updateWindowSurface(window:Window) : Int;


//SDL_render.h

    @:native('SDL_CreateRenderer')
    static function createRenderer(window:Window, index:Int, flags:SDLRendererFlags):Renderer;

    @:native('SDL_CreateSoftwareRenderer')
    static function createSoftwareRenderer(surface:Surface):Renderer;

    @:native('SDL_CreateTexture')
    static function createTexture(renderer:Renderer, format:SDLPixelFormat, access:SDLTextureAccess, w:Int, h:Int): Texture;

    @:native('SDL_CreateTextureFromSurface')
    static function createTextureFromSurface(renderer:Renderer, surface:Surface):Texture;

    @:native('native_sdl::createWindowAndRenderer')
    static function createWindowAndRenderer(w:Int, h:Int, flags:SDLWindowFlags) : { window:Window, renderer:Renderer };

    @:native('SDL_DestroyRenderer')
    static function destroyRenderer(renderer:Renderer):Void;

    @:native('SDL_DestroyTexture')
    static function destroyTexture(texture:Texture):Void;

    @:native('native_sdl::GL_BindTexture')
    static function GL_BindTexture(texture:Texture): { texw:Float, texh:Float };

    @:native('SDL_GL_UnbindTexture')
    static function GL_UnbindTexture(texture:Texture):Void;

    @:native('SDL_GetNumRenderDrivers')
    static function getNumRenderDrivers():Int;

    @:native('native_sdl::getRenderDrawBlendMode')
    static function getRenderDrawBlendMode(renderer:Renderer):SDLBlendMode;

    @:native('native_sdl::getRenderDrawColor')
    static function getRenderDrawColor(renderer:Renderer, into:SDLColor) : SDLColor;

    @:native('native_sdl::getRenderDriverInfo')
    static function getRenderDriverInfo(index:Int):SDLRendererInfo;

    @:native('SDL_GetRenderTarget')
    static function getRenderTarget(renderer:Renderer):Texture;

    @:native('SDL_GetRenderer')
    static function getRenderer(window:Window):Renderer;

    @:native('native_sdl::getRendererInfo')
    static function getRendererInfo(renderer:Renderer):SDLRendererInfo;

    @:native('native_sdl::getRendererOutputSize')
    static function getRendererOutputSize(renderer:Renderer, into:SDLSize):SDLSize;

    @:native('native_sdl::getTextureAlphaMod')
    static function getTextureAlphaMod(texture:Texture):Int;

    @:native('native_sdl::getTextureBlendMode')
    static function getTextureBlendMode(texture:Texture):SDLBlendMode;

    @:native('native_sdl::getTextureColorMod')
    static function getTextureColorMod(texture:Texture, into:SDLColor):SDLColor;

    // @:native('SDL_LockTexture')
    // static function lockTexture():Void;

    // @:native('SDL_QueryTexture')
    // static function queryTexture():Void;

    @:native('SDL_RenderClear')
    static function renderClear(renderer:Renderer):Int;

    @:native('native_sdl::renderCopy')
    static function renderCopy(renderer:Renderer, texture:Texture, srcrect:SDLRect, dstrect:SDLRect) : Int;

    // @:native('SDL_RenderCopyEx')
    // static function renderCopyEx():Void;

    @:native('SDL_RenderDrawLine')
    static function renderDrawLine(renderer:Renderer, x1:Int, y1:Int, x2:Int, y2:Int):Int;

    static inline function renderDrawLines(renderer:Renderer, points:Array<SDLPoint>):Void {
        if(points.length % 2 != 0) throw "renderDrawLines: points not divisible by 2!";
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

    @:native('native_sdl::renderDrawRect')
    static function renderDrawRect(renderer:Renderer, rect:SDLRect):Int;

    static inline function renderDrawRects(renderer:Renderer, rects:Array<SDLRect>):Void {
        for(r in rects) renderDrawRect(renderer, r);
    }

    @:native('native_sdl::renderFillRect')
    static function renderFillRect(renderer:Renderer, rect:SDLRect):Void;

    static inline function renderFillRects(renderer:Renderer, rects:Array<SDLRect>):Void {
        for(r in rects) renderFillRect(renderer, r);
    }

    @:native('native_sdl::renderGetClipRect')
    static function renderGetClipRect(renderer:Renderer, into:SDLRect):SDLRect;

    @:native('native_sdl::renderGetLogicalSize')
    static function renderGetLogicalSize(renderer:Renderer, into:SDLSize):SDLSize;

    @:native('native_sdl::renderGetScale')
    static function renderGetScale(renderer:Renderer, into:SDLScale):SDLScale;

    @:native('native_sdl::renderGetViewport')
    static function renderGetViewport(renderer:Renderer, into:SDLRect):SDLRect;

    @:native('SDL_RenderIsClipEnabled')
    static function renderIsClipEnabled(renderer:Renderer):Bool;

    @:native('SDL_RenderPresent')
    static function renderPresent(renderer:Renderer):Int;

    // @:native('SDL_RenderReadPixels')
    // static function renderReadPixels():Void;

    @:native('native_sdl::renderSetClipRect')
    static function renderSetClipRect(renderer:Renderer, rect:SDLRect):Int;

    @:native('SDL_RenderSetLogicalSize')
    static function renderSetLogicalSize(renderer:Renderer, w:Int, h:Int):Int;

    @:native('SDL_RenderSetScale')
    static function renderSetScale(renderer:Renderer, x:Float, y:Float):Int;

    @:native('native_sdl::renderSetViewport')
    static function renderSetViewport(renderer:Renderer, rect:SDLRect):Int;

    @:native('SDL_RenderTargetSupported')
    static function renderTargetSupported(renderer:Renderer):Bool;

    @:native('native_sdl::setRenderDrawBlendMode')
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

    @:native("native_sdl::getBasePath")
    static function getBasePath() : String;

    @:native("native_sdl::getPrefPath")
    static function getPrefPath(org:String, app:String) : String;

//SDL_clipboard.h

    @:native('SDL_GetClipboardText')
    private static function _getClipboardText() : cpp.ConstCharStar;
    static inline function getClipboardText() : String return cast _getClipboardText();

    @:native('SDL_HasClipboardText')
    static function hasClipboardText():Bool;

    @:native('SDL_SetClipboardText')
    static function setClipboardText(text:String):Int;


//SDL_keyboard.h

    // @:native('SDL_GetKeyFromName')
    // static function getKeyFromName(name:String):SDLKeycode;

    // @:native('SDL_GetKeyFromScancode')
    // static function getKeyFromScancode(scan:SDLScancode):SDLKeycode;

    // @:native('SDL_GetKeyName')
    // static function getKeyName(key:SDLKeycode):String;

    @:native('SDL_GetKeyboardFocus')
    static function getKeyboardFocus():Window;

    // @:native('SDL_GetKeyboardState')
    // static function getKeyboardState():Int;

    @:native('SDL_GetModState')
    static function getModState():SDLKeymod;

    // @:native('SDL_GetScancodeFromKey')
    // static function getScancodeFromKey(key:SDLKeycode):SDLScancode;

    // @:native('SDL_GetScancodeFromName')
    // static function getScancodeFromName(name:String):SDLScancode;

    // @:native('SDL_GetScancodeName')
    // static function getScancodeName(scan:SDLScancode):String;

    @:native('SDL_HasScreenKeyboardSupport')
    static function hasScreenKeyboardSupport():Bool;

    @:native('SDL_IsScreenKeyboardShown')
    static function isScreenKeyboardShown(window:Window):Bool;

    @:native('SDL_IsTextInputActive')
    static function isTextInputActive():Bool;

    @:native('native_sdl::setModState')
    static function setModState(modstate:SDLKeymod):Void;

    @:native('native_sdl::setTextInputRect')
    static function setTextInputRect(rect:SDLRect):Void;

    @:native('SDL_StartTextInput')
    static function startTextInput():Void;

    @:native('SDL_StopTextInput')
    static function stopTextInput():Void;



//SDL_mouse.h

    @:native('SDL_CaptureMouse')
    static function captureMouse(enabled:Bool):Int;

    @:native('SDL_CreateColorCursor')
    static function createColorCursor(surface:Surface, hot_x:Int, hot_y:Int): Cursor;

    @:native('SDL_CreateCursor')
    static function createCursor(data:Bytes, mask:Bytes, w:Int, h:Int, hot_x:Int, hot_y:Int):Cursor;

    @:native('native_sdl::createSystemCursor')
    static function createSystemCursor(id:SDLSystemCursor):Cursor;

    @:native('SDL_FreeCursor')
    static function freeCursor(cursor:Cursor):Void;

    @:native('SDL_GetCursor')
    static function getCursor():Cursor;

    @:native('SDL_GetDefaultCursor')
    static function getDefaultCursor():Cursor;

    // @:native('SDL_GetGlobalMouseState')
    // static function getGlobalMouseState():Int;

    @:native('SDL_GetMouseFocus')
    static function getMouseFocus():Window;

    // @:native('SDL_GetMouseState')
    // static function getMouseState():Int;

    @:native('SDL_GetRelativeMouseMode')
    static function getRelativeMouseMode():Bool;

    // @:native('SDL_GetRelativeMouseState')
    // static function getRelativeMouseState():Int;

    @:native('SDL_SetCursor')
    static function setCursor(cursor:Cursor):Void;

    @:native('SDL_SetRelativeMouseMode')
    static function setRelativeMouseMode(enabled:Bool):Int;

    @:native('SDL_ShowCursor')
    static function showCursor(toggle:Int):Int;

    @:native('SDL_WarpMouseGlobal')
    static function warpMouseGlobal(x:Int, y:Int):Void;

    @:native('SDL_WarpMouseInWindow')
    static function warpMouseInWindow(window:Window, x:Int, y:Int):Void;

//SDL_gamecontroller.h

    @:native('SDL_GameControllerAddMapping')
    private static function _gameControllerAddMapping(mappingString:cpp.ConstCharStar):Int;
    static inline function gameControllerAddMapping(mappingString:String):Int return _gameControllerAddMapping(cast mappingString);

    // @:native('SDL_GameControllerAddMappingsFromFile')
    // static function gameControllerAddMappingsFromFile():Int;

    // @:native('SDL_GameControllerAddMappingsFromRW')
    // static function gameControllerAddMappingsFromRW():Int;

    @:native('SDL_GameControllerClose')
    static function gameControllerClose(gamecontroller:GameController):Void;

    @:native('SDL_GameControllerEventState')
    static function gameControllerEventState(state:SDLEventState):Int;

    @:native('SDL_GameControllerGetAttached')
    static function gameControllerGetAttached(gamecontroller:GameController):Bool;

    @:native('SDL_GameControllerGetAxis')
    static function gameControllerGetAxis(gamecontroller:GameController, axis:SDLGameControllerAxis):cpp.Int16;

    //:internal:
    // @:native('SDL_GameControllerGetAxisFromString')
    // static function gameControllerGetAxisFromString(SDLGameControllerAxis):Int;

    // @:native('SDL_GameControllerGetBindForAxis')
    // static function gameControllerGetBindForAxis(gamecontroller:GameController, axis:SDLGameControllerAxis):Int;

    // @:native('SDL_GameControllerGetBindForButton')
    // static function gameControllerGetBindForButton():Int;

    @:native('SDL_GameControllerGetButton')
    static function gameControllerGetButton(gamecontroller:GameController, button:SDLGameControllerButton):Int;

    //:internal:
    // @:native('SDL_GameControllerGetButtonFromString')
    // static function gameControllerGetButtonFromString():Int;

    @:native('SDL_GameControllerGetJoystick')
    static function gameControllerGetJoystick(gamecontroller:GameController):Joystick;

    //:internal:
    // @:native('SDL_GameControllerGetStringForAxis')
    // static function gameControllerGetStringForAxis():Int;

    //:internal:
    // @:native('SDL_GameControllerGetStringForButton')
    // static function gameControllerGetStringForButton():Int;

    @:native('SDL_GameControllerMapping')
    private static function _gameControllerMapping(gamecontroller:GameController):cpp.ConstCharStar;
    static function gameControllerMapping(gamecontroller:GameController):String return cast _gameControllerMapping(gamecontroller);

    // @:native('SDL_GameControllerMappingForGUID')
    // static function gameControllerMappingForGUID():Int;

    @:native('SDL_GameControllerName')
    private static function _gameControllerName(gamecontroller:GameController):cpp.ConstCharStar;
    static function gameControllerName(gamecontroller:GameController):String return cast _gameControllerName(gamecontroller);

    @:native('SDL_GameControllerNameForIndex')
    private static function _gameControllerNameForIndex(joystick_index:Int):cpp.ConstCharStar;
    static function gameControllerNameForIndex(joystick_index:Int):String return cast _gameControllerNameForIndex(joystick_index);

    @:native('SDL_GameControllerOpen')
    static function gameControllerOpen(joystick_index:Int):GameController;

    #if sdl_include_internal
    @:native('SDL_GameControllerUpdate')
    static function gameControllerUpdate():Void;
    #end

    @:native('SDL_IsGameController')
    static function isGameController(joystick_index:Int):Bool;


//SDL_Joystick.h

    @:native('SDL_JoystickClose')
    static function joystickClose(joystick:Joystick):Void;

    @:native('SDL_JoystickEventState')
    static function joystickEventState(state:SDLEventState):Int;

    @:native('SDL_JoystickGetAttached')
    static function joystickGetAttached(joystick:Joystick):Bool;

    @:native('SDL_JoystickGetAxis')
    static function joystickGetAxis(joystick:Joystick, axis:Int):cpp.Int64;

    @:native('native_sdl::joystickGetBall')
    static function joystickGetBall(joystick:Joystick, ball:Int, into:SDLPoint):SDLPoint;

    @:native('SDL_JoystickGetButton')
    static function joystickGetButton(joystick:Joystick, button:Int):UInt;

    @:native('SDL_JoystickGetDeviceGUID')
    static function joystickGetDeviceGUID(device_index:Int):String;

    @:native('SDL_JoystickGetGUID')
    static function joystickGetGUID(joystick:Joystick):String;

    // @:native('SDL_JoystickGetGUIDFromString')
    // static function joystickGetGUIDFromString(pchGUID:String):String;

    // @:native('native_sdl::joystickGetGUIDString')
    // static function joystickGetGUIDString(guid:haxe.io.Bytes):String;

    @:native('SDL_JoystickGetHat')
    static function joystickGetHat(joystick:Joystick, hat:SDLHatValue):Int;

    @:native('SDL_JoystickInstanceID')
    static function joystickInstanceID(joystick:Joystick):UInt;

    @:native('SDL_JoystickName')
    private static function _joystickName(device_index:Int) : cpp.ConstCharStar;
    static inline function joystickName(device_index:Int):String return cast _joystickName(device_index);

    @:native('SDL_JoystickNameForIndex')
    private static function _joystickNameForIndex(device_index:Int) : cpp.ConstCharStar;
    static inline function joystickNameForIndex(device_index:Int):String return cast _joystickNameForIndex(device_index);

    @:native('SDL_JoystickNumAxes')
    static function joystickNumAxes(joystick:Joystick):Int;

    @:native('SDL_JoystickNumBalls')
    static function joystickNumBalls(joystick:Joystick):Int;

    @:native('SDL_JoystickNumButtons')
    static function joystickNumButtons(joystick:Joystick):Int;

    @:native('SDL_JoystickNumHats')
    static function joystickNumHats(joystick:Joystick):Int;

    @:native('SDL_JoystickOpen')
    static function joystickOpen(device_index:Int):Joystick;

    @:native('SDL_JoystickUpdate')
    static function joystickUpdate():Void;

    @:native('SDL_NumJoysticks')
    static function numJoysticks():Int;


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


//SDL_video.h

    @:native('SDL_CreateWindow')
    static function createWindow(title:String, x:Int, y:Int, w:Int, h:Int, flags:SDLWindowFlags):Window;

    @:native('SDL_DestroyWindow')
    static function destroyWindow(window:Window):Void;

    @:native('SDL_HideWindow')
    static function hideWindow(window:Window):Void;

    @:native('SDL_ShowWindow')
    static function showWindow(window:Window):Void;

    @:native('SDL_ShowSimpleMessageBox')
    static function showSimpleMessageBox(flags:SDLMessageBoxFlags, title:String, message:String, window:Window):Void;

    @:native('SDL_GetWindowID')
    static function getWindowID(window:Window):UInt;

    @:native('SDL_GetNumVideoDisplays')
    static function getNumVideoDisplays():Int;

    @:native('SDL_GetNumDisplayModes')
    static function getNumDisplayModes(displayIndex:Int):Int;

    @:native("SDL_GetDisplayName")
    private static function _getDisplayName(displayIndex:Int) : cpp.ConstCharStar;
    static inline function getDisplayName(displayIndex:Int) : String return cast _getDisplayName(displayIndex);

    @:native('native_sdl::getDisplayBounds')
    static function getDisplayBounds(displayIndex:Int, into:SDLRect) : SDLRect;

    @:native('SDL_SetWindowSize')
    static function setWindowSize(window:Window, w:Int, h:Int) : Void;

    @:native('SDL_SetWindowMaximumSize')
    static function setWindowMaximumSize(window:Window, max_w:Int, max_h:Int) : Void;

    @:native('SDL_SetWindowMinimumSize')
    static function setWindowMinimumSize(window:Window, max_w:Int, max_h:Int) : Void;

    @:native('SDL_SetWindowFullscreen')
    static function setWindowFullscreen(window:Window, flags:UInt) : Void;

    @:native('SDL_SetWindowBordered')
    static function setWindowBordered(window:Window, bordered:Bool) : Void;

    @:native('SDL_SetWindowGrab')
    static function setWindowGrab(window:Window, grabbed:Bool) : Void;

    @:native('SDL_SetWindowTitle')
    static function setWindowTitle( title:String ) : Void;

    @:native('SDL_SetWindowPosition')
    static function setWindowPosition(window:Window, w:Int, h:Int) : Void;

    @:native('native_sdl::getWindowPosition')
    static function getWindowPosition(window:Window, into:SDLPoint) : SDLPoint;

    @:native('native_sdl::getWindowSize')
    static function getWindowSize(window:Window, into:SDLSize) : SDLSize;

    @:native('SDL_DisableScreenSaver')
    static function disableScreenSaver():Void;

    @:native('SDL_EnableScreenSaver')
    static function enableScreenSaver():Void;

    @:native('SDL_GL_CreateContext')
    static function GL_CreateContext(window:Window) : GLContext;

    @:native('SDL_GL_DeleteContext')
    static function GL_DeleteContext(context:GLContext) : Void;

    @:native('native_sdl::GL_GetDrawableSize')
    static function GL_GetDrawableSize(window:Window, into:SDLSize) : SDLSize;

    @:native('SDL_GL_GetCurrentContext')
    static function GL_GetCurrentContext() : GLContext;

    @:native('SDL_GL_GetCurrentWindow')
    static function GL_GetCurrentWindow() : Window;

    @:native('SDL_GL_ExtensionSupported')
    static function GL_ExtensionSupported(extension:String) : Bool;

    @:native('SDL_GL_SwapWindow')
    static function GL_SwapWindow(window:Window) : Void;

    @:native('SDL_GL_SetSwapInterval')
    static function GL_SetSwapInterval(interval:Int) : Int;

    @:native('SDL_GL_GetSwapInterval')
    static function GL_GetSwapInterval() : Int;

    @:native('SDL_GL_ResetAttributes')
    static function GL_ResetAttributes() : Void;

    @:native('SDL_GL_MakeCurrent')
    static function GL_MakeCurrent(window:Window, context:GLContext) : Int;

    @:native('SDL_GL_SetAttribute')
    static function GL_SetAttribute(attr:SDLGLAttr, value:Int) : Int;

    @:native('SDL_GL_GetAttribute')
    static function GL_GetAttribute(attr:SDLGLAttr) : Int;


    @:native('native_sdl::testfunc')
    static function testfunc( fn : cpp.Callable<String->Int> ):Int;

    @:native('native_sdl::run')
    static function run():Void;


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
    // SDL_LOG_CATEGORY_RESERVED1    = 9;
    // SDL_LOG_CATEGORY_RESERVED2    = 10;
    // SDL_LOG_CATEGORY_RESERVED3    = 11;
    // SDL_LOG_CATEGORY_RESERVED4    = 12;
    // SDL_LOG_CATEGORY_RESERVED5    = 13;
    // SDL_LOG_CATEGORY_RESERVED6    = 14;
    // SDL_LOG_CATEGORY_RESERVED7    = 15;
    // SDL_LOG_CATEGORY_RESERVED8    = 16;
    // SDL_LOG_CATEGORY_RESERVED9    = 17;
    // SDL_LOG_CATEGORY_RESERVED10   = 18;
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
abstract SDLEventState(Int)
from Int to Int {
    var SDL_QUERY = -1;
    var SDL_IGNORE = 0;
    var SDL_DISABLE = 0;
    var SDL_ENABLE = 1;
} //SDLEventState


@:enum
abstract SDLGLAttr(Int)
from Int to Int {
    var SDL_GL_RED_SIZE                     = 0;
    var SDL_GL_GREEN_SIZE                   = 1;
    var SDL_GL_BLUE_SIZE                    = 2;
    var SDL_GL_ALPHA_SIZE                   = 3;
    var SDL_GL_BUFFER_SIZE                  = 4;
    var SDL_GL_DOUBLEBUFFER                 = 5;
    var SDL_GL_DEPTH_SIZE                   = 6;
    var SDL_GL_STENCIL_SIZE                 = 7;
    var SDL_GL_ACCUM_RED_SIZE               = 8;
    var SDL_GL_ACCUM_GREEN_SIZE             = 9;
    var SDL_GL_ACCUM_BLUE_SIZE              = 10;
    var SDL_GL_ACCUM_ALPHA_SIZE             = 11;
    var SDL_GL_STEREO                       = 12;
    var SDL_GL_MULTISAMPLEBUFFERS           = 13;
    var SDL_GL_MULTISAMPLESAMPLES           = 14;
    var SDL_GL_ACCELERATED_VISUAL           = 15;
    var SDL_GL_RETAINED_BACKING             = 16;
    var SDL_GL_CONTEXT_MAJOR_VERSION        = 17;
    var SDL_GL_CONTEXT_MINOR_VERSION        = 18;
    var SDL_GL_CONTEXT_EGL                  = 19;
    var SDL_GL_CONTEXT_FLAGS                = 20;
    var SDL_GL_CONTEXT_PROFILE_MASK         = 21;
    var SDL_GL_SHARE_WITH_CURRENT_CONTEXT   = 22;
    var SDL_GL_FRAMEBUFFER_SRGB_CAPABLE     = 23;
} //SDLGLAttr


@:enum
abstract SDLGameControllerButton(Int)
from Int to Int {
    var SDL_CONTROLLER_BUTTON_INVALID       = -1;
    var SDL_CONTROLLER_BUTTON_A             = 0;
    var SDL_CONTROLLER_BUTTON_B             = 1;
    var SDL_CONTROLLER_BUTTON_X             = 2;
    var SDL_CONTROLLER_BUTTON_Y             = 3;
    var SDL_CONTROLLER_BUTTON_BACK          = 4;
    var SDL_CONTROLLER_BUTTON_GUIDE         = 5;
    var SDL_CONTROLLER_BUTTON_START         = 6;
    var SDL_CONTROLLER_BUTTON_LEFTSTICK     = 7;
    var SDL_CONTROLLER_BUTTON_RIGHTSTICK    = 8;
    var SDL_CONTROLLER_BUTTON_LEFTSHOULDER  = 9;
    var SDL_CONTROLLER_BUTTON_RIGHTSHOULDER = 10;
    var SDL_CONTROLLER_BUTTON_DPAD_UP       = 11;
    var SDL_CONTROLLER_BUTTON_DPAD_DOWN     = 12;
    var SDL_CONTROLLER_BUTTON_DPAD_LEFT     = 13;
    var SDL_CONTROLLER_BUTTON_DPAD_RIGHT    = 14;
    var SDL_CONTROLLER_BUTTON_MAX           = 15;
} //SDLGameControllerButton



@:enum
abstract SDLGameControllerAxis(Int)
from Int to Int {
    var SDL_CONTROLLER_AXIS_INVALID         = -1;
    var SDL_CONTROLLER_AXIS_LEFTX           = 0;
    var SDL_CONTROLLER_AXIS_LEFTY           = 1;
    var SDL_CONTROLLER_AXIS_RIGHTX          = 2;
    var SDL_CONTROLLER_AXIS_RIGHTY          = 3;
    var SDL_CONTROLLER_AXIS_TRIGGERLEFT     = 4;
    var SDL_CONTROLLER_AXIS_TRIGGERRIGHT    = 5;
    var SDL_CONTROLLER_AXIS_MAX             = 6;
} //SDLGameControllerAxis


@:enum
abstract SDLEventAction(Int)
from Int to Int {
    var SDL_ADDEVENT  = 0;
    var SDL_PEEKEVENT = 1;
    var SDL_GETEVENT  = 2;
} //SDLEventAction

@:enum
abstract SDLMessageBoxFlags(Int)
from Int to Int {
    var SDL_MESSAGEBOX_ERROR        = 0x00000010;
    var SDL_MESSAGEBOX_WARNING      = 0x00000020;
    var SDL_MESSAGEBOX_INFORMATION  = 0x00000040;
} //SDLMessageBoxFlags

@:enum
abstract SDLKeymod(Int)
from Int to Int {
    var KMOD_NONE       = 0x0000;
    var KMOD_LSHIFT     = 0x0001;
    var KMOD_RSHIFT     = 0x0002;
    var KMOD_LCTRL      = 0x0040;
    var KMOD_RCTRL      = 0x0080;
    var KMOD_LALT       = 0x0100;
    var KMOD_RALT       = 0x0200;
    var KMOD_LGUI       = 0x0400;
    var KMOD_RGUI       = 0x0800;
    var KMOD_NUM        = 0x1000;
    var KMOD_CAPS       = 0x2000;
    var KMOD_MODE       = 0x4000;
    var KMOD_RESERVED   = 0x8000;
    var KMOD_CTRL       = 0x0040|0x0080;
    var KMOD_SHIFT      = 0x0001|0x0002;
    var KMOD_ALT        = 0x0100|0x0200;
    var KMOD_GUI        = 0x0400|0x0800;
} //SDLKeymod



@:enum
abstract SDLHatValue(Int)
from Int to Int {
    var SDL_HAT_CENTERED =    0x00;
    var SDL_HAT_UP =          0x01;
    var SDL_HAT_RIGHT =       0x02;
    var SDL_HAT_DOWN =        0x04;
    var SDL_HAT_LEFT =        0x08;
    var SDL_HAT_RIGHTUP =     0x02|0x01;
    var SDL_HAT_RIGHTDOWN =   0x02|0x04;
    var SDL_HAT_LEFTUP =      0x08|0x01;
    var SDL_HAT_LEFTDOWN =    0x08|0x04;
} //SDLHatValue


@:enum
abstract SDLWindowEventID(Int)
from Int to Int {
    var SDL_WINDOWEVENT_NONE          = 0;/**< Never used */
    var SDL_WINDOWEVENT_SHOWN         = 1;/**< Window has been shown */
    var SDL_WINDOWEVENT_HIDDEN        = 2;/**< Window has been hidden */
    var SDL_WINDOWEVENT_EXPOSED       = 3;/**< Window has been exposed and should be redrawn */
    var SDL_WINDOWEVENT_MOVED         = 4;/**< Window has been moved to data1, data2 */
    var SDL_WINDOWEVENT_RESIZED       = 5;/**< Window has been resized to data1xdata2 */
    var SDL_WINDOWEVENT_SIZE_CHANGED  = 6;/**< The window size has changed, either as a result of an API call or through the system or user changing the window size. */
    var SDL_WINDOWEVENT_MINIMIZED     = 7;/**< Window has been minimized */
    var SDL_WINDOWEVENT_MAXIMIZED     = 8;/**< Window has been maximized */
    var SDL_WINDOWEVENT_RESTORED      = 9;/**< Window has been restored to normal size and position */
    var SDL_WINDOWEVENT_ENTER         = 10;/**< Window has gained mouse focus */
    var SDL_WINDOWEVENT_LEAVE         = 11;/**< Window has lost mouse focus */
    var SDL_WINDOWEVENT_FOCUS_GAINED  = 12;/**< Window has gained keyboard focus */
    var SDL_WINDOWEVENT_FOCUS_LOST    = 13;/**< Window has lost keyboard focus */
    var SDL_WINDOWEVENT_CLOSE         = 14;/**< The window manager requests that the window be closed */
} //SDLWindowEventID

@:enum
abstract SDLEventType(UInt)
from UInt to UInt {
    var SDL_FIRSTEVENT     = 0;     /**< Unused (do not remove) */

    /* Application events */
    var SDL_QUIT            = 0x100; /**< User-requested quit */

    /* These application events have special meaning on iOS, see README-ios.md for details */
    var SDL_APP_TERMINATING = 0x101;        /**< The application is being terminated by the OS
                                     Called on iOS in applicationWillTerminate()
                                     Called on Android in onDestroy()
                                */
    var SDL_APP_LOWMEMORY   = 0x102;          /**< The application is low on memory, free memory if possible.
                                     Called on iOS in applicationDidReceiveMemoryWarning()
                                     Called on Android in onLowMemory()
                                */
    var SDL_APP_WILLENTERBACKGROUND = 0x103; /**< The application is about to enter the background
                                     Called on iOS in applicationWillResignActive()
                                     Called on Android in onPause()
                                */
    var SDL_APP_DIDENTERBACKGROUND = 0x104; /**< The application did enter the background and may not get CPU for some time
                                     Called on iOS in applicationDidEnterBackground()
                                     Called on Android in onPause()
                                */
    var SDL_APP_WILLENTERFOREGROUND = 0x105; /**< The application is about to enter the foreground
                                     Called on iOS in applicationWillEnterForeground()
                                     Called on Android in onResume()
                                */
    var SDL_APP_DIDENTERFOREGROUND = 0x106; /**< The application is now interactive
                                     Called on iOS in applicationDidBecomeActive()
                                     Called on Android in onResume()
                                */

    /* Window events */
    var SDL_WINDOWEVENT    = 0x200; /**< Window state change */
    var SDL_SYSWMEVENT     = 0x201; /**< System specific event */

    /* Keyboard events */
    var SDL_KEYDOWN         = 0x300;  /**< Key pressed */
    var SDL_KEYUP           = 0x301; /**< Key released */
    var SDL_TEXTEDITING     = 0x302; /**< Keyboard text editing (composition) */
    var SDL_TEXTINPUT       = 0x303; /**< Keyboard text input */

    /* Mouse events */
    var SDL_MOUSEMOTION     = 0x400; /**< Mouse moved */
    var SDL_MOUSEBUTTONDOWN = 0x401; /**< Mouse button pressed */
    var SDL_MOUSEBUTTONUP   = 0x402; /**< Mouse button released */
    var SDL_MOUSEWHEEL      = 0x403; /**< Mouse wheel motion */

    /* Joystick events */
    var SDL_JOYAXISMOTION    = 0x600; /**< Joystick axis motion */
    var SDL_JOYBALLMOTION    = 0x601; /**< Joystick trackball motion */
    var SDL_JOYHATMOTION     = 0x602; /**< Joystick hat position change */
    var SDL_JOYBUTTONDOWN    = 0x603; /**< Joystick button pressed */
    var SDL_JOYBUTTONUP      = 0x604; /**< Joystick button released */
    var SDL_JOYDEVICEADDED   = 0x605; /**< A new joystick has been inserted into the system */
    var SDL_JOYDEVICEREMOVED = 0x606; /**< An opened joystick has been removed */

    /* Game controller events */
    var SDL_CONTROLLERAXISMOTION  = 0x650; /**< Game controller axis motion */
    var SDL_CONTROLLERBUTTONDOWN  = 0x651;          /**< Game controller button pressed */
    var SDL_CONTROLLERBUTTONUP    = 0x652;            /**< Game controller button released */
    var SDL_CONTROLLERDEVICEADDED = 0x653;         /**< A new Game controller has been inserted into the system */
    var SDL_CONTROLLERDEVICEREMOVED = 0x654;       /**< An opened Game controller has been removed */
    var SDL_CONTROLLERDEVICEREMAPPED = 0x655;      /**< The controller mapping was updated */

    /* Touch events */
    var SDL_FINGERDOWN      = 0x700;
    var SDL_FINGERUP        = 0x701;
    var SDL_FINGERMOTION    = 0x702;

    /* Gesture events */
    var SDL_DOLLARGESTURE   = 0x800;
    var SDL_DOLLARRECORD    = 0x801;
    var SDL_MULTIGESTURE    = 0x802;

    /* Clipboard events */
    var SDL_CLIPBOARDUPDATE = 0x900; /**< The clipboard changed */

    /* Drag and drop events */
    var SDL_DROPFILE        = 0x1000; /**< The system requests a file open */

    /* Render events */
    var SDL_RENDER_TARGETS_RESET = 0x2000; /**< The render targets have been reset and their contents need to be updated */
    var SDL_RENDER_DEVICE_RESET  = 0x2001; /**< The device has been reset and all textures need to be recreated */

    /** Events ::SDL_USEREVENT through ::SDL_LASTEVENT are for your use,
     *  and should be allocated with SDL_RegisterEvents()
     */
    var SDL_USEREVENT    = 0x8000;

    /**
     *  This last event is only for bounding internal arrays
     */
    var SDL_LASTEVENT    = 0xFFFF;

} //SDLEventType


@:enum
abstract SDLSystemCursor(Int)
from Int to Int {
    var SDL_SYSTEM_CURSOR_ARROW     = 0;   /**< Arrow */
    var SDL_SYSTEM_CURSOR_IBEAM     = 1;   /**< I-beam */
    var SDL_SYSTEM_CURSOR_WAIT      = 2;   /**< Wait */
    var SDL_SYSTEM_CURSOR_CROSSHAIR = 3;   /**< Crosshair */
    var SDL_SYSTEM_CURSOR_WAITARROW = 4;   /**< Small wait cursor (or Wait if not available) */
    var SDL_SYSTEM_CURSOR_SIZENWSE  = 5;   /**< Double arrow pointing northwest and southeast */
    var SDL_SYSTEM_CURSOR_SIZENESW  = 6;   /**< Double arrow pointing northeast and southwest */
    var SDL_SYSTEM_CURSOR_SIZEWE    = 7;   /**< Double arrow pointing west and east */
    var SDL_SYSTEM_CURSOR_SIZENS    = 8;   /**< Double arrow pointing north and south */
    var SDL_SYSTEM_CURSOR_SIZEALL   = 9;   /**< Four pointed arrow pointing north, south, east, and west */
    var SDL_SYSTEM_CURSOR_NO        = 10;  /**< Slashed circle or crossbones */
    var SDL_SYSTEM_CURSOR_HAND      = 11;  /**< Hand */
    var SDL_NUM_SYSTEM_CURSORS      = 12;
} //SDLSystemCursor

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




