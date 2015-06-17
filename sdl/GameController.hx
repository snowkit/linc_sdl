package sdl;

@:native("SDL_GameController")
@:include('./native_sdl.h')
extern private class SDL_GameController {}
typedef GameController = cpp.Pointer<SDL_GameController>;
