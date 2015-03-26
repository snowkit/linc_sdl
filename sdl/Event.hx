package sdl;

import sdl.SDL.SDLEventType;

@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_Event")
extern class Event {
        public var type:SDLEventType;
    // public var window:WindowEvent;
    // public var key:KeyBoardEvent;
    // public var edit:TextEditingEvent;
    // public var text:TextInputEvent;
    // public var motion:MouseMotionEvent;
    // public var button:MouseButtonEvent;
    // public var wheel:MouseWheelEvent;
    // public var jaxis:JoyAxisEvent;
    // public var jball:JoyBallEvent;
    // public var jhat:JoyHatEvent;
    // public var jbutton:JoyButtonEvent;
    // public var jdevice:JoyDeviceEvent;
    // public var caxis:ControllerAxisEvent;
    // public var cbutton:ControllerButtonEvent;
    // public var cdevice:ControllerDeviceEvent;
    // public var adevice:AudioDeviceEvent;
    public var quit:QuitEvent;
    // public var user:UserEvent;
    // public var syswm:SysWMEvent;
    // public var tfinger:TouchFingerEvent;
    // public var mgesture:MultiGestureEvent;
    // public var dgesture:DollarGestureEvent;
    // public var drop:DropEvent;
}


@:include('./snowkit_sdl.h')
@:structAccess
@:unreflective
@:native("SDL_QuitEvent")
extern class QuitEvent {
    public var type: SDLEventType;
    public var timestamp: UInt;
}