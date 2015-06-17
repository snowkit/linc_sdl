package sdl;

@:native("SDL_Haptic")
@:include('./native_sdl.h')
extern private class SDL_Haptic {}
typedef Haptic = cpp.Pointer<SDL_Haptic>;

@:native("SDL_HapticEffect")
@:include('./native_sdl.h')
extern private class SDL_HapticEffect {}
typedef HapticEffect = cpp.Pointer<SDL_HapticEffect>;
