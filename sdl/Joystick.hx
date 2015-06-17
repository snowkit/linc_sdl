package sdl;

@:native("SDL_Joystick")
@:include('./native_sdl.h')
extern private class SDL_Joystick {}
typedef Joystick = cpp.Pointer<SDL_Joystick>;
