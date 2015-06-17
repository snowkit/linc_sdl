#ifndef _NATIVE_SDL_
#define _NATIVE_SDL_

#include <hxcpp.h>
#include "./native_sdl.h"
#include <vector>
#include <map>

    namespace native_sdl {

            //forward declarations of conversions
        namespace convert {
            static  Dynamic render_info_to_hx(SDL_RendererInfo info);
            static  Dynamic set_color_into(Dynamic into, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
            static  Dynamic set_size_into(Dynamic into, int w, int h);
            static  Dynamic set_scale_into(Dynamic into, float x, float y);
            static  Dynamic set_point_into(Dynamic into, int x, int y);
            static  Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h);
            static  Dynamic set_rect_into(Dynamic into, SDL_Rect from);
            static SDL_Rect get_rect_from(Dynamic from);
        }


            // return { window:cpp.Pointer<SDL_Window>, renderer:cpp.Pointer<SDL_Renderer> }
        static Dynamic createWindowAndRenderer(int x, int y, int flags) {

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
        static ::String REVISION() {

            return ::String(SDL_REVISION);

        } //REVISION


            // return { major:UInt, minor:UInt, patch:UInt }
        static Dynamic VERSION() {

                SDL_version ver;
                SDL_VERSION(&ver);

            hx::Anon out = hx::Anon_obj::Create();

                out->Add(HX_CSTRING("major"), ver.major);
                out->Add(HX_CSTRING("minor"), ver.minor);
                out->Add(HX_CSTRING("patch"), ver.patch);

            return out;

        } //VERSION

            //return { major:UInt, minor:UInt, patch:UInt }
        static Dynamic getVersion() {

                SDL_version ver;
                SDL_GetVersion(&ver);

            hx::Anon out = hx::Anon_obj::Create();
                out->Add(HX_CSTRING("major"), ver.major);
                out->Add(HX_CSTRING("minor"), ver.minor);
                out->Add(HX_CSTRING("patch"), ver.patch);
            return out;

        } //getVersion

        static ::String getBasePath() {

            char *base_path = SDL_GetBasePath();

            if (base_path) {
                ::String res(base_path);
                SDL_free(base_path);
                return res;
            }

            return null();

        } //getBasePath

        static ::String getPrefPath(::String org, ::String app) {

            char *pref_path = SDL_GetPrefPath(org.c_str(), app.c_str());

            if (pref_path) {
                ::String res(pref_path);
                SDL_free(pref_path);
                return res;
            }

            return null();

        } //getPrefPath


            //return { texw:Float, texh:Float }
        static Dynamic GL_BindTexture(SDL_Texture* texture) {

            float texw, texh;
            SDL_GL_BindTexture(texture, &texw, &texh);

            printf("%f %f\n", texw, texh);

            hx::Anon out = hx::Anon_obj::Create();

                out->Add(HX_CSTRING("texw"), texw);
                out->Add(HX_CSTRING("texh"), texh);

            return out;

        } //GL_BindTexture

        static int setRenderDrawBlendMode(SDL_Renderer* renderer, int blend) {

            return SDL_SetRenderDrawBlendMode(renderer, (SDL_BlendMode)blend );

        } //setRenderDrawBlendMode


        static int getRenderDrawBlendMode(SDL_Renderer* renderer) {

            SDL_BlendMode mode;
            SDL_GetRenderDrawBlendMode(renderer, &mode);

            return (int)mode;

        } //getRenderDrawBlendMode

        static Dynamic getRenderDrawColor(SDL_Renderer* renderer, Dynamic into) {

            Uint8 r, g, b, a;

            SDL_GetRenderDrawColor(renderer, &r, &g, &b, &a);

            return convert::set_color_into(into, r, g, b, a);

        } //getRenderDrawColor

        static Dynamic getRenderDriverInfo(int index) {

            SDL_RendererInfo info;
            SDL_GetRenderDriverInfo(index, &info);

            return convert::render_info_to_hx(info);

        } //getRenderDriverInfo

        static Dynamic getRendererInfo(SDL_Renderer* renderer) {

            SDL_RendererInfo info;
            SDL_GetRendererInfo(renderer, &info);

            return convert::render_info_to_hx(info);

        } //getRendererInfo

        static Dynamic getRendererOutputSize(SDL_Renderer* renderer, Dynamic into) {

            int w, h;
            SDL_GetRendererOutputSize(renderer, &w, &h);

            return convert::set_size_into(into, w, h);

        } //getRendererOutputSize

        static Uint8 getTextureAlphaMod(SDL_Texture* texture) {

            Uint8 alpha;
            SDL_GetTextureAlphaMod(texture, &alpha);

            return alpha;

        } //getTextureAlphaMod

        static int getTextureBlendMode(SDL_Texture* texture) {

            SDL_BlendMode blend;
            SDL_GetTextureBlendMode(texture, &blend);

            return (int)blend;

        } //getTextureBlendMode

        static Dynamic getTextureColorMod(SDL_Texture* texture, Dynamic into) {

            Uint8 r, g, b;
            SDL_GetTextureColorMod(texture, &r, &g, &b);

            return convert::set_color_into(into, r, g, b, 0);

        } //getTextureColorMod

        static int renderDrawRect(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderDrawRect(renderer, &_rect);

        } //renderDrawRect

        static int renderFillRect(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderFillRect(renderer, &_rect);

        } //renderFillRect

        static Dynamic renderGetClipRect(SDL_Renderer* renderer, Dynamic into) {

            SDL_Rect from;
            SDL_RenderGetClipRect(renderer, &from);

            return convert::set_rect_into(into, from);

        } //renderGetClipRect

        static Dynamic renderGetLogicalSize(SDL_Renderer* renderer, Dynamic into) {

            int w, h;
            SDL_RenderGetLogicalSize(renderer, &w, &h);

            return convert::set_size_into(into, w, h);

        } //renderGetLogicalSize

        static Dynamic renderGetScale(SDL_Renderer* renderer, Dynamic into) {

            float x, y;
            SDL_RenderGetScale(renderer, &x, &y);

            return convert::set_scale_into(into, x, y);

        } //renderGetLogicalSize

        static Dynamic renderGetViewport(SDL_Renderer* renderer, Dynamic into) {

            SDL_Rect from;
            SDL_RenderGetViewport(renderer, &from);

            return convert::set_rect_into(into, from);

        } //renderGetViewport

        static int renderSetClipRect(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderSetClipRect(renderer, &_rect);

        } //renderSetClipRect

        static int renderSetViewport(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderSetViewport(renderer, &_rect);

        } //renderSetViewport

        static SDL_Cursor* createSystemCursor(int id) {

            return SDL_CreateSystemCursor((SDL_SystemCursor)id);

        } //createSystemCursor

        static Dynamic joystickGetBall(SDL_Joystick* joystick, int ball, Dynamic into) {

            int dx,dy;
            SDL_JoystickGetBall(joystick, ball, &dx, &dy);

            return convert::set_point_into(into, dx, dy);

        } //joystickGetBall

        static void setModState(int modstate) {

            SDL_SetModState((SDL_Keymod)modstate);

        } //setModState

        static void setTextInputRect(Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            SDL_SetTextInputRect(&_rect);

        } //setTextInputRect

        static Dynamic getWindowSize(SDL_Window* window, Dynamic into) {

            int w, h;
            SDL_GetWindowSize(window, &w, &h);

            return convert::set_size_into(into, w, h);

        } //getWindowSize

        static Dynamic getWindowPosition(SDL_Window* window, Dynamic into) {

            int x, y;
            SDL_GetWindowPosition(window, &x, &y);

            return convert::set_point_into(into, x, y);

        } //getWindowPosition


        static Dynamic GL_GetDrawableSize(SDL_Window* window, Dynamic into) {

            int w, h;
            SDL_GL_GetDrawableSize(window, &w, &h);

            return convert::set_size_into(into, w, h);

        } //GL_GetDrawableSize


        static Dynamic getDisplayBounds(int display_index, Dynamic into) {

            SDL_Rect from;
            SDL_GetDisplayBounds(display_index, &from);

            return convert::set_rect_into(into, from);

        } //getDisplayBounds

        static int renderCopy(SDL_Renderer* renderer, SDL_Texture* texture, Dynamic srcrect, Dynamic dstrect) {

            bool has_src = srcrect != null();
            bool has_dst = dstrect != null();

                //neither?
            if(!has_src && !has_dst) {
                return SDL_RenderCopy(renderer, texture, NULL, NULL);
            }

                //just src?
            if(has_src && !has_dst) {
                SDL_Rect _src = convert::get_rect_from(srcrect);
                return SDL_RenderCopy(renderer, texture, &_src, NULL);
            }

                //just dst?
            if(has_dst && !has_src) {
                SDL_Rect _dst = convert::get_rect_from(dstrect);
                return SDL_RenderCopy(renderer, texture, NULL, &_dst);
            }

            SDL_Rect _src = convert::get_rect_from(srcrect);
            SDL_Rect _dst = convert::get_rect_from(dstrect);

            return SDL_RenderCopy(renderer, texture, &_src, &_dst);

        } //renderCopy

        typedef ::cpp::Function < Void(Dynamic, Dynamic)> EventFilterFN;
        static std::map<void*, EventFilterFN> filter_list;

        inline static int _filter(void* userdata, SDL_Event* event) {

            //todo: unpack dynamic and event
            EventFilterFN filter = filter_list[userdata];
            filter(null(), null());

            return 0; //ignored by SDL

        } //_filter

        static void addEventWatch(EventFilterFN filter, Dynamic userdata) {

            void* ptr = hx::DynamicPtr(userdata);
            filter_list[ptr] = filter;
            SDL_AddEventWatch( _filter, ptr );

        } //addEventWatch

        static void delEventWatch(EventFilterFN filter, Dynamic userdata) {

            void* ptr = hx::DynamicPtr(userdata);
            filter_list.erase(ptr);
            SDL_DelEventWatch( _filter, ptr );

        } //delEventWatch

        typedef ::cpp::Function < int(::String)> FN;
        static std::vector<FN> list;
        static int testfunc( FN fn ) {
            list.push_back(fn);
            return list.size() - 1;
        }

        static void run() {
            for(int i = 0; i < list.size(); ++i) {
                list[i]( ::String("good ole c") );
            }
        }

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

                    //array of texture formats
                Array< int > arr = Array_obj< int >::__new();

                for(int i = 0; i < (int)info.num_texture_formats; ++i) {
                    arr.Add( (int)info.texture_formats[i] );
                }

                //fill the object

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

            static Dynamic set_scale_into(Dynamic into, float x, float y) {

                    into->__FieldRef(HX_CSTRING("x")) = x;
                    into->__FieldRef(HX_CSTRING("y")) = y;

                return into;

            } //set_scale_into

            static Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h) {

                    into->__FieldRef(HX_CSTRING("x")) = x;
                    into->__FieldRef(HX_CSTRING("y")) = y;
                    into->__FieldRef(HX_CSTRING("w")) = w;
                    into->__FieldRef(HX_CSTRING("h")) = h;

                return into;

            } //set_rect_into

            static Dynamic set_point_into(Dynamic into, int x, int y) {

                    into->__FieldRef(HX_CSTRING("x")) = x;
                    into->__FieldRef(HX_CSTRING("y")) = y;

                return into;

            } //set_point_into

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

            } //get_rect_from

        } //convert namespace


    } //native_sdl namespace

#endif //NATIVE_SDL
