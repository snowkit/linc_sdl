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
    var timestamp: Float;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_DropEvent>")
extern class DropEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var file: cpp.ConstCharStar;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_TextEditingEvent>")
extern class TextEditingEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var windowID: UInt;
    var text: cpp.ConstCharStar;
    var start: cpp.Int32;
    var length: cpp.Int32;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_TextInputEvent>")
extern class TextInputEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var windowID: UInt;
    var text: cpp.ConstCharStar;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_WindowEvent>")
extern class WindowEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var windowID: UInt;
    var event: sdl.SDL.SDLWindowEventID;
    var data1: Int;
    var data2: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_KeyboardEvent>")
extern class KeyboardEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var windowID: UInt;
    var state: Int;
    var repeat: Bool;
    var keysym: SDLKeysym;
}

@:structAccess
@:include('linc_sdl.h') @:native("SDL_Keysym")
extern class SDLKeysym {
    var scancode: Int;
    var sym: Int;
    var mod: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MouseMotionEvent>")
extern class MouseMotionEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var windowID: UInt;
    var which: Int;
    var state: Int;
    var x: Int;
    var y: Int;
    var xrel: Int;
    var yrel: Int;
}


@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyAxisEvent>")
extern class JoyAxisEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
    var axis: Int;
    var value: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyBallEvent>")
extern class JoyBallEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
    var ball: Int;
    var xrel: cpp.Int64;
    var yrel: cpp.Int64;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyHatEvent>")
extern class JoyHatEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
    var hat: Int;
    var value: sdl.SDL.SDLHatValue;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyButtonEvent>")
extern class JoyButtonEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
    var button: Int;
    var state: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_JoyDeviceEvent>")
extern class JoyDeviceEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
}


@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_ControllerAxisEvent>")
extern class ControllerAxisEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
    var axis: Int;
    var value: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_ControllerButtonEvent>")
extern class ControllerButtonEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
    var button: Int;
    var state: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_ControllerDeviceEvent>")
extern class ControllerDeviceEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_AudioDeviceEvent>")
extern class AudioDeviceEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var which: Int;
    var iscapture: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_TouchFingerEvent>")
extern class TouchFingerEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var touchId: cpp.Int64;
    var fingerId: cpp.Int64;
    var x: Float;
    var y: Float;
    var dx: Float;
    var dy: Float;
    var pressure: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MultiGestureEvent>")
extern class MultiGestureEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var touchId: cpp.Int64;
    var dTheta: Float;
    var dDist: Float;
    var x: Float;
    var y: Float;
    var numFingers: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_DollarGestureEvent>")
extern class DollarGestureEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var touchId: cpp.Int64;
    var gestureId: cpp.Int64;
    var numFingers: Int;
    var error: Float;
    var x: Float;
    var y: Float;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MouseButtonEvent>")
extern class MouseButtonEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var windowID: UInt;
    var which: Int;
    var button: Int;
    var state: Int;
    var clicks: Int;
    var x: Int;
    var y: Int;
}

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<SDL_MouseWheelEvent>")
extern class MouseWheelEvent {
    var type: SDLEventType;
    var timestamp: Float;
    var windowID: UInt;
    var which: Int;
    var x: Int;
    var y: Int;
    var direction: Int;
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

