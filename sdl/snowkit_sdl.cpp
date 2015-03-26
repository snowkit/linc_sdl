
#include <hxcpp.h>
#include "./snowkit_sdl.h"

namespace snowkit_sdl {

    namespace convert {
        static Dynamic render_info_to_hx(SDL_RendererInfo info);
        static Dynamic set_color_into(Dynamic into, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
        static Dynamic set_size_into(Dynamic into, int w, int h);
        static Dynamic set_scale_into(Dynamic into, float x, float y);
        static Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h);
        static Dynamic set_rect_into(Dynamic into, SDL_Rect from);
        static SDL_Rect get_rect_from(Dynamic from);
    }


        // return { window:cpp.Pointer<SDL_Window>, renderer:cpp.Pointer<SDL_Renderer> }
    Dynamic createWindowAndRenderer(int x, int y, int flags) {

        SDL_Window* window = 0;
        SDL_Renderer* renderer = 0;

        int res = SDL_CreateWindowAndRenderer(x, y, flags, &window, &renderer );
        if(res == 0) {


            ::cpp::Pointer<SDL_Window> window_p(window);
            ::cpp::Pointer<SDL_Renderer> renderer_p(renderer);

            hx::Anon out = hx::Anon_obj::Create();

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


        // return { major:UInt, minor:UInt, patch:UInt }
    Dynamic VERSION() {

            SDL_version ver;
            SDL_VERSION(&ver);

        hx::Anon out = hx::Anon_obj::Create();

            out->Add(HX_CSTRING("major"), ver.major);
            out->Add(HX_CSTRING("minor"), ver.minor);
            out->Add(HX_CSTRING("patch"), ver.patch);

        return out;

    } //VERSION

        //return { major:UInt, minor:UInt, patch:UInt }
    Dynamic getVersion() {

            SDL_version ver;
            SDL_GetVersion(&ver);

        hx::Anon out = hx::Anon_obj::Create();
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

    ::String getError() {

        return ::String(SDL_GetError());

    } //getRevision


        //return { texw:Float, texh:Float }
    Dynamic GL_BindTexture(SDL_Texture* texture) {

        float texw, texh;
        SDL_GL_BindTexture(texture, &texw, &texh);

        printf("%f %f\n", texw, texh);

        hx::Anon out = hx::Anon_obj::Create();

            out->Add(HX_CSTRING("texw"), texw);
            out->Add(HX_CSTRING("texh"), texh);

        return out;

    } //GL_BindTexture

    int setRenderDrawBlendMode(SDL_Renderer* renderer, int blend) {

        return SDL_SetRenderDrawBlendMode(renderer, (SDL_BlendMode)blend );

    } //setRenderDrawBlendMode


    int getRenderDrawBlendMode(SDL_Renderer* renderer) {

        SDL_BlendMode mode;
        SDL_GetRenderDrawBlendMode(renderer, &mode);

        return (int)mode;

    } //getRenderDrawBlendMode

    Dynamic getRenderDrawColor(SDL_Renderer* renderer, Dynamic into) {

        Uint8 r, g, b, a;

        SDL_GetRenderDrawColor(renderer, &r, &g, &b, &a);

        return convert::set_color_into(into, r, g, b, a);

    } //getRenderDrawColor

    Dynamic getRenderDriverInfo(int index) {

        SDL_RendererInfo info;
        SDL_GetRenderDriverInfo(index, &info);

        return convert::render_info_to_hx(info);

    } //getRenderDriverInfo

    Dynamic getRendererInfo(SDL_Renderer* renderer) {

        SDL_RendererInfo info;
        SDL_GetRendererInfo(renderer, &info);

        return convert::render_info_to_hx(info);

    } //getRendererInfo

    Dynamic getRendererOutputSize(SDL_Renderer* renderer, Dynamic into) {

        int w, h;
        SDL_GetRendererOutputSize(renderer, &w, &h);

        return convert::set_size_into(into, w, h);

    } //getRendererOutputSize

    Uint8 getTextureAlphaMod(SDL_Texture* texture) {

        Uint8 alpha;
        SDL_GetTextureAlphaMod(texture, &alpha);

        return alpha;

    } //getTextureAlphaMod

    int getTextureBlendMode(SDL_Texture* texture) {

        SDL_BlendMode blend;
        SDL_GetTextureBlendMode(texture, &blend);

        return (int)blend;

    } //getTextureBlendMode

    Dynamic getTextureColorMod(SDL_Texture* texture, Dynamic into) {

        Uint8 r, g, b;
        SDL_GetTextureColorMod(texture, &r, &g, &b);

        return convert::set_color_into(into, r, g, b, 0);

    } //getTextureColorMod

    int renderDrawRect(SDL_Renderer* renderer, Dynamic rect) {

        SDL_Rect _rect = convert::get_rect_from(rect);

        return SDL_RenderDrawRect(renderer, &_rect);

    } //renderDrawRect

    int renderFillRect(SDL_Renderer* renderer, Dynamic rect) {

        SDL_Rect _rect = convert::get_rect_from(rect);

        return SDL_RenderFillRect(renderer, &_rect);

    } //renderFillRect

    Dynamic renderGetClipRect(SDL_Renderer* renderer, Dynamic into) {

        SDL_Rect from;
        SDL_RenderGetClipRect(renderer, &from);

        return convert::set_rect_into(into, from);

    } //renderGetClipRect

    Dynamic renderGetLogicalSize(SDL_Renderer* renderer, Dynamic into) {

        int w, h;
        SDL_RenderGetLogicalSize(renderer, &w, &h);

        return convert::set_size_into(into, w, h);

    } //renderGetLogicalSize

    Dynamic renderGetScale(SDL_Renderer* renderer, Dynamic into) {

        float x, y;
        SDL_RenderGetScale(renderer, &x, &y);

        return convert::set_scale_into(into, x, y);

    } //renderGetLogicalSize

    Dynamic renderGetViewport(SDL_Renderer* renderer, Dynamic into) {

        SDL_Rect from;
        SDL_RenderGetViewport(renderer, &from);

        return convert::set_rect_into(into, from);

    } //renderGetViewport

    int renderSetClipRect(SDL_Renderer* renderer, Dynamic rect) {

        SDL_Rect _rect = convert::get_rect_from(rect);

        return SDL_RenderSetClipRect(renderer, &_rect);

    } //renderSetClipRect

    int renderSetViewport(SDL_Renderer* renderer, Dynamic rect) {

        SDL_Rect _rect = convert::get_rect_from(rect);

        return SDL_RenderSetViewport(renderer, &_rect);

    } //renderSetViewport

    namespace convert {

            // return {
            //     var name:String;
            //     var flags:UInt;
            //     var num_texture_formats:UInt;
            //     var texture_formats:Array<UInt>;
            //     var max_texture_width:Int;
            //     var max_texture_height:Int;
            // }
        static Dynamic render_info_to_hx(SDL_RendererInfo info) {

            hx::Anon out = hx::Anon_obj::Create();

            Array< int > arr = Array_obj< int >::__new();
            for(int i = 0; i < (int)info.num_texture_formats; ++i) {
                arr.Add( (int)info.texture_formats[i] );
            }

                out->Add(HX_CSTRING("name"), ::String(info.name));
                out->Add(HX_CSTRING("flags"), (int)info.flags);
                out->Add(HX_CSTRING("num_texture_formats"), (int)info.num_texture_formats);
                out->Add(HX_CSTRING("texture_formats"), arr);
                out->Add(HX_CSTRING("max_texture_width"), info.max_texture_width);
                out->Add(HX_CSTRING("max_texture_height"), info.max_texture_height);

            return out;

        } //render_info_to_hx

        static Dynamic set_color_into(Dynamic into, Uint8 r, Uint8 g, Uint8 b, Uint8 a) {

            into->__FieldRef(HX_CSTRING("r")) = r;
            into->__FieldRef(HX_CSTRING("g")) = g;
            into->__FieldRef(HX_CSTRING("b")) = b;
            into->__FieldRef(HX_CSTRING("a")) = a;

            return into;

        } //set_color_into

        static Dynamic set_size_into(Dynamic into, int w, int h) {

            into->__FieldRef(HX_CSTRING("w")) = w;
            into->__FieldRef(HX_CSTRING("h")) = h;

            return into;

        } //set_size_into

        static Dynamic set_scale_into(Dynamic into, float w, float h) {

            into->__FieldRef(HX_CSTRING("w")) = w;
            into->__FieldRef(HX_CSTRING("h")) = h;

            return into;

        } //set_scale_into

        static Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h) {

            into->__FieldRef(HX_CSTRING("x")) = x;
            into->__FieldRef(HX_CSTRING("y")) = y;
            into->__FieldRef(HX_CSTRING("w")) = w;
            into->__FieldRef(HX_CSTRING("h")) = h;

            return into;

        } //set_rect_into

        static Dynamic set_rect_into(Dynamic into, SDL_Rect from) {

            into->__FieldRef(HX_CSTRING("x")) = from.x;
            into->__FieldRef(HX_CSTRING("y")) = from.y;
            into->__FieldRef(HX_CSTRING("w")) = from.w;
            into->__FieldRef(HX_CSTRING("h")) = from.h;

            return into;

        } //set_rect_into

        static SDL_Rect get_rect_from(Dynamic from) {
            SDL_Rect r;

                r.x = from->__FieldRef(HX_CSTRING("x"));
                r.y = from->__FieldRef(HX_CSTRING("y"));
                r.w = from->__FieldRef(HX_CSTRING("w"));
                r.h = from->__FieldRef(HX_CSTRING("h"));

            return r;
        }

    }


} //snowkit_sdl namespace
