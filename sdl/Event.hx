package sdl;

import sdl.SDL.SDLEventType;

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_Event")
extern class Event {
    public var type:SDLEventType;
    public var window:WindowEvent;
    public var key:KeyboardEvent;
    public var edit:TextEditingEvent;
    public var text:TextInputEvent;
    public var motion:MouseMotionEvent;
    public var button:MouseButtonEvent;
    public var wheel:MouseWheelEvent;
    public var jaxis:JoyAxisEvent;
    public var jball:JoyBallEvent;
    public var jhat:JoyHatEvent;
    public var jbutton:JoyButtonEvent;
    public var jdevice:JoyDeviceEvent;
    public var caxis:ControllerAxisEvent;
    public var cbutton:ControllerButtonEvent;
    public var cdevice:ControllerDeviceEvent;
    public var adevice:AudioDeviceEvent;
    public var quit:QuitEvent;
    // public var user:UserEvent;
    // public var syswm:SysWMEvent;
    public var tfinger:TouchFingerEvent;
    public var mgesture:MultiGestureEvent;
    public var dgesture:DollarGestureEvent;
    public var drop:DropEvent;
}


@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_QuitEvent")
extern class QuitEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_DropEvent")
extern class DropEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var file: cpp.ConstCharStar;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_TextEditingEvent")
extern class TextEditingEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var windowID: UInt;
    public var text: cpp.ConstCharStar;
    public var start: cpp.Int64;
    public var end: cpp.Int64;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_TextInputEvent")
extern class TextInputEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var windowID: UInt;
    public var text: cpp.ConstCharStar;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_WindowEvent")
extern class WindowEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var windowID: UInt;
    public var event: sdl.SDL.SDLWindowEventID;
    public var data1: UInt;
    public var data2: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_KeyboardEvent")
extern class KeyboardEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var windowID: UInt;
    public var state: UInt;
    public var repeat: UInt;
    public var keysym: SDLKeysym;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_Keysym")
extern class SDLKeysym {
    public var scancode: UInt;
    public var sym: UInt;
    public var mod: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MouseMotionEvent")
extern class MouseMotionEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var windowID: UInt;
    public var which: UInt;
    public var state: UInt;
    public var x: UInt;
    public var y: UInt;
    public var xrel: UInt;
    public var yrel: UInt;
}


@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyAxisEvent")
extern class JoyAxisEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
    public var axis: UInt;
    public var value: Int;
}


@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyBallEvent")
extern class JoyBallEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
    public var ball: UInt;
    public var xrel: cpp.Int64;
    public var yrel: cpp.Int64;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyHatEvent")
extern class JoyHatEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
    public var hat: UInt;
    public var value: sdl.SDL.SDLHatValue;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyButtonEvent")
extern class JoyButtonEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
    public var button: UInt;
    public var state: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_JoyDeviceEvent")
extern class JoyDeviceEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
}


@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_ControllerAxisEvent")
extern class ControllerAxisEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
    public var axis: UInt;
    public var value: Int;
}


@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_ControllerButtonEvent")
extern class ControllerButtonEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
    public var button: UInt;
    public var state: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_ControllerDeviceEvent")
extern class ControllerDeviceEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_AudioDeviceEvent")
extern class AudioDeviceEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var which: UInt;
    public var iscapture: UInt;
}


@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_TouchFingerEvent")
extern class TouchFingerEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var touchId: cpp.Int64;
    public var fingerId: cpp.Int64;
    public var x: UInt;
    public var y: UInt;
    public var dx: UInt;
    public var dy: UInt;
    public var pressure: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MultiGestureEvent")
extern class MultiGestureEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var touchId: cpp.Int64;
    public var dTheta: Float;
    public var dDist: Float;
    public var x: Float;
    public var y: Float;
    public var numFingers: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_DollarGestureEvent")
extern class DollarGestureEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var touchId: cpp.Int64;
    public var gestureId: cpp.Int64;
    public var numFingers: UInt;
    public var error: Float;
    public var x: Float;
    public var y: Float;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MouseButtonEvent")
extern class MouseButtonEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var windowID: UInt;
    public var which: UInt;
    public var button: UInt;
    public var state: UInt;
    public var clicks: UInt;
    public var x: UInt;
    public var y: UInt;
}

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_MouseWheelEvent")
extern class MouseWheelEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
    public var windowID: UInt;
    public var which: UInt;
    public var x: UInt;
    public var y: UInt;
    public var direction: UInt;
}

