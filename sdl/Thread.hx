package sdl;

@:native("SDL_cond")
@:include('linc_sdl.h')
extern private class SDL_cond {}
typedef Cond = cpp.Pointer<SDL_cond>;

@:native("SDL_sem")
@:include('linc_sdl.h')
extern private class SDL_sem {}
typedef Sem = cpp.Pointer<SDL_sem>;

@:native("SDL_mutex")
@:include('linc_sdl.h')
extern private class SDL_mutex {}
typedef Mutex = cpp.Pointer<SDL_mutex>;


@:native("SDL_Thread")
@:include('linc_sdl.h')
extern private class SDL_Thread {}
typedef Thread = cpp.Pointer<SDL_Thread>;

typedef ThreadID = UInt; //unsigned long
typedef TLSID = UInt; //unsigned int