package sdl;

import sdl.SDL.SDLEventType;

@:keep @:include('linc_sdl.h') @:native("SDL_Event")
private extern class SDLEvent {
    var type:SDLEventType;
    var window:WindowEvent;
    var key:KeyboardEvent;
    var edit:TextEditingEvent;
    var text:TextInputEvent;
    var motion:MouseMotionEvent;
    var button:MouseButtonEvent;
    var wheel:MouseWheelEvent;
    var jaxis:JoyAxisEvent;
    var jball:JoyBallEvent;
    var jhat:JoyHatEvent;
    var jbutton:JoyButtonEvent;
    var jdevice:JoyDeviceEvent;
    var caxis:ControllerAxisEvent;
    var cbutton:ControllerButtonEvent;
    var cdevice:ControllerDeviceEvent;
    var adevice:AudioDeviceEvent;
    var quit:QuitEvent;
    // var user:UserEvent;
    // var syswm:SysWMEvent;
    var tfinger:TouchFingerEvent;
    var mgesture:MultiGestureEvent;
    var dgesture:DollarGestureEvent;
    var drop:DropEvent;
}


@:include('linc_sdl.h') @:native("::cpp::Reference<SDL_Event>")
@:keep extern class EventRef extends SDLEvent {}
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_Event>")
@:keep extern class Event extends EventRef {}


@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_QuitEvent>")
extern class QuitEvent {
    var type: SDLEventType;
    var timestamp: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_DropEvent>")
extern class DropEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var file: cpp.ConstCharStar;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_TextEditingEvent>")
extern class TextEditingEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var text: cpp.ConstCharStar;
    var start: cpp.Int64;
    var end: cpp.Int64;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_TextInputEvent>")
extern class TextInputEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var text: cpp.ConstCharStar;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_WindowEvent>")
extern class WindowEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var event: sdl.SDL.SDLWindowEventID;
    var data1: UInt;
    var data2: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_KeyboardEvent>")
extern class KeyboardEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var state: UInt;
    var repeat: UInt;
    var keysym: SDLKeysym;
}

@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_Keysym>")
extern class SDLKeysym {
    var scancode: UInt;
    var sym: UInt;
    var mod: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MouseMotionEvent>")
extern class MouseMotionEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var which: UInt;
    var state: UInt;
    var x: UInt;
    var y: UInt;
    var xrel: UInt;
    var yrel: UInt;
}


@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyAxisEvent>")
extern class JoyAxisEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var axis: UInt;
    var value: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyBallEvent>")
extern class JoyBallEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var ball: UInt;
    var xrel: cpp.Int64;
    var yrel: cpp.Int64;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyHatEvent>")
extern class JoyHatEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var hat: UInt;
    var value: sdl.SDL.SDLHatValue;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyButtonEvent>")
extern class JoyButtonEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var button: UInt;
    var state: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyDeviceEvent>")
extern class JoyDeviceEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
}


@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_ControllerAxisEvent>")
extern class ControllerAxisEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var axis: UInt;
    var value: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_ControllerButtonEvent>")
extern class ControllerButtonEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var button: UInt;
    var state: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_ControllerDeviceEvent>")
extern class ControllerDeviceEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_AudioDeviceEvent>")
extern class AudioDeviceEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var iscapture: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_TouchFingerEvent>")
extern class TouchFingerEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var touchId: cpp.Int64;
    var fingerId: cpp.Int64;
    var x: UInt;
    var y: UInt;
    var dx: UInt;
    var dy: UInt;
    var pressure: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MultiGestureEvent>")
extern class MultiGestureEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var touchId: cpp.Int64;
    var dTheta: Float;
    var dDist: Float;
    var x: Float;
    var y: Float;
    var numFingers: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_DollarGestureEvent>")
extern class DollarGestureEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var touchId: cpp.Int64;
    var gestureId: cpp.Int64;
    var numFingers: UInt;
    var error: Float;
    var x: Float;
    var y: Float;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MouseButtonEvent>")
extern class MouseButtonEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var which: UInt;
    var button: UInt;
    var state: UInt;
    var clicks: UInt;
    var x: UInt;
    var y: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MouseWheelEvent>")
extern class MouseWheelEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var which: UInt;
    var x: UInt;
    var y: UInt;
    var direction: UInt;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_Finger>")
private extern class SDLFinger {
    var id:cpp.Int64;
    var x:Float;
    var y:Float;
    var pressure:Float;
}
typedef Finger = cpp.Pointer<SDLFinger>;

