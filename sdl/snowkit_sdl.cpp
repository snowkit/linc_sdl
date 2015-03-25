
#include <hxcpp.h>
#include "./snowkit_sdl.h"

namespace snowkit_sdl {

    Dynamic createWindowAndRenderer(int x, int y, int flags) {

        SDL_Window* window = 0;
        SDL_Renderer* renderer = 0;

        int res = SDL_CreateWindowAndRenderer(x, y, flags, &window, &renderer );
        if(res == 0) {
            hx::Anon out = hx::Anon_obj::Create();
                out->__FieldRef(HX_HCSTRING("window", "\xf0","\x93","\x8c","\x52")) = ::cpp::Pointer<SDL_Window>(window);
                out->__FieldRef(HX_HCSTRING("renderer","\x43","\xc5","\xdb","\xb2")) = ::cpp::Pointer<SDL_Renderer>(renderer);
            return out;
        }

        return null();
    }

}