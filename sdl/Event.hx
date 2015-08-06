package sdl;

import sdl.SDL.SDLEventType;

@:native("SDL_Finger")
@:include('linc_sdl.h')
@:structAccess
@:unreflective
extern private class SDL_Finger {
    var id:cpp.Int64;
    var x:Float;
    var y:Float;
    var pressure:Float;
}
typedef Finger = cpp.Pointer<SDL_Finger>;


@:include('linc_sdl.h')
@:native("cpp::Struct<SDL_Event>")
extern class Event {
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


@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_QuitEvent")
extern class QuitEvent {
    var type: SDLEventType;
    var timestamp: UInt;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_DropEvent")
extern class DropEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var file: cpp.ConstCharStar;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_TextEditingEvent")
extern class TextEditingEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var text: cpp.ConstCharStar;
    var start: cpp.Int64;
    var end: cpp.Int64;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_TextInputEvent")
extern class TextInputEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var text: cpp.ConstCharStar;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_WindowEvent")
extern class WindowEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var event: sdl.SDL.SDLWindowEventID;
    var data1: UInt;
    var data2: UInt;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_KeyboardEvent")
extern class KeyboardEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var state: UInt;
    var repeat: UInt;
    var keysym: SDLKeysym;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_Keysym")
extern class SDLKeysym {
    var scancode: UInt;
    var sym: UInt;
    var mod: UInt;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MouseMotionEvent")
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


@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyAxisEvent")
extern class JoyAxisEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var axis: UInt;
    var value: Int;
}


@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyBallEvent")
extern class JoyBallEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var ball: UInt;
    var xrel: cpp.Int64;
    var yrel: cpp.Int64;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyHatEvent")
extern class JoyHatEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var hat: UInt;
    var value: sdl.SDL.SDLHatValue;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyButtonEvent")
extern class JoyButtonEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var button: UInt;
    var state: UInt;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyDeviceEvent")
extern class JoyDeviceEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
}


@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_ControllerAxisEvent")
extern class ControllerAxisEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var axis: UInt;
    var value: Int;
}


@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_ControllerButtonEvent")
extern class ControllerButtonEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var button: UInt;
    var state: UInt;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_ControllerDeviceEvent")
extern class ControllerDeviceEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
}

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_AudioDeviceEvent")
extern class AudioDeviceEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var which: UInt;
    var iscapture: UInt;
}


@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_TouchFingerEvent")
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

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MultiGestureEvent")
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

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_DollarGestureEvent")
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

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MouseButtonEvent")
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

@:include('linc_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MouseWheelEvent")
extern class MouseWheelEvent {
    var type: SDLEventType;
    var timestamp: UInt;
    var windowID: UInt;
    var which: UInt;
    var x: UInt;
    var y: UInt;
    var direction: UInt;
}

