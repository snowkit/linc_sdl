
#include <hxcpp.h>
#include "./snowkit_sdl.h"

namespace snowkit_sdl {

    Dynamic createWindowAndRenderer(int x, int y, int flags) {

        SDL_Window* window = 0;
        SDL_Renderer* renderer = 0;

        int res = SDL_CreateWindowAndRenderer(x, y, flags, &window, &renderer );
        if(res == 0) {

                //return { window:cpp.Pointer<SDL_Window>, renderer:cpp.Pointer<SDL_Renderer> }

            hx::Anon out = hx::Anon_obj::Create();

                ::cpp::Pointer<SDL_Window> window_p(window);
                ::cpp::Pointer<SDL_Window> renderer_p(renderer);

                out->Add(HX_CSTRING("window"), window_p);
                out->Add(HX_CSTRING("renderer"), renderer_p);

            return out;

        } //res == 0

        return null();

    } //createWindowAndRenderer

        //needed because the macro has no ()
    ::String REVISION() {

        return ::String(SDL_REVISION);

    } //REVISION

    Dynamic VERSION() {

        //return { major:UInt, minor:UInt, patch:UInt }

        hx::Anon out = hx::Anon_obj::Create();

            SDL_version ver;

            SDL_VERSION(&ver);

        out->Add(HX_CSTRING("major"), ver.major);
        out->Add(HX_CSTRING("minor"), ver.minor);
        out->Add(HX_CSTRING("patch"), ver.patch);

        return out;

    } //VERSION

    Dynamic getVersion() {

        //return { major:UInt, minor:UInt, patch:UInt }

        hx::Anon out = hx::Anon_obj::Create();

            SDL_version ver;

            SDL_GetVersion(&ver);

        out->Add(HX_CSTRING("major"), ver.major);
        out->Add(HX_CSTRING("minor"), ver.minor);
        out->Add(HX_CSTRING("patch"), ver.patch);

        return out;

    } //getVersion

        // needed because:
        //hxcpp : error: no viable conversion from 'const char *' to '::String'
    ::String getRevision() {

        return ::String(SDL_GetRevision());

    } //getRevision

}