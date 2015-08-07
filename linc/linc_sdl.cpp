//This file is included, so this is required!
#ifndef _LINC_SDL_CPP_
#define _LINC_SDL_CPP_

#include <hxcpp.h>
#include "./linc_sdl.h"

#include "../lib/sdl/include/SDL_revision.h"
#include <vector>
#include <map>

    namespace linc {

        namespace sdl {

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

            ::cpp::Struct<SDL_Event> pollEvent() {

                SDL_Event event;
                SDL_PollEvent(&event);
                return event;

            } //pollEvent

            ::cpp::Struct<SDL_Event> waitEvent() {

                SDL_Event event;
                SDL_WaitEvent(&event);
                return event;

            } //waitEvent

            ::cpp::Struct<SDL_Event> waitEventTimeout(int _timeout) {

                SDL_Event event;
                SDL_WaitEventTimeout(&event, _timeout);
                return event;

            } //waitEventTimeout

            ::String getBasePath() {

                char *base_path = SDL_GetBasePath();

                if (base_path) {
                    ::String res(base_path);
                    SDL_free(base_path);
                    return res;
                }

                return null();

            } //getBasePath

            ::String getPrefPath(::String org, ::String app) {

                char *pref_path = SDL_GetPrefPath(org.c_str(), app.c_str());

                if (pref_path) {
                    ::String res(pref_path);
                    SDL_free(pref_path);
                    return res;
                }

                return null();

            } //getPrefPath


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

            SDL_Cursor* createSystemCursor(int id) {

                return SDL_CreateSystemCursor((SDL_SystemCursor)id);

            } //createSystemCursor

            Dynamic joystickGetBall(SDL_Joystick* joystick, int ball, Dynamic into) {

                int dx,dy;
                SDL_JoystickGetBall(joystick, ball, &dx, &dy);

                return convert::set_point_into(into, dx, dy);

            } //joystickGetBall

            void setModState(int modstate) {

                SDL_SetModState((SDL_Keymod)modstate);

            } //setModState

            void setTextInputRect(Dynamic rect) {

                SDL_Rect _rect = convert::get_rect_from(rect);

                SDL_SetTextInputRect(&_rect);

            } //setTextInputRect

            Dynamic getWindowSize(SDL_Window* window, Dynamic into) {

                int w, h;
                SDL_GetWindowSize(window, &w, &h);

                return convert::set_size_into(into, w, h);

            } //getWindowSize

            Dynamic getWindowPosition(SDL_Window* window, Dynamic into) {

                int x, y;
                SDL_GetWindowPosition(window, &x, &y);

                return convert::set_point_into(into, x, y);

            } //getWindowPosition


            Dynamic GL_GetDrawableSize(SDL_Window* window, Dynamic into) {

                int w, h;
                SDL_GL_GetDrawableSize(window, &w, &h);

                return convert::set_size_into(into, w, h);

            } //GL_GetDrawableSize


            Dynamic getDisplayBounds(int display_index, Dynamic into) {

                SDL_Rect from;
                SDL_GetDisplayBounds(display_index, &from);

                return convert::set_rect_into(into, from);

            } //getDisplayBounds

            int renderCopy(SDL_Renderer* renderer, SDL_Texture* texture, Dynamic srcrect, Dynamic dstrect) {

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

            Dynamic getDisplayMode(int display_index, int mode_index) {

                SDL_DisplayMode mode;
                int res = SDL_GetDisplayMode(display_index, mode_index, &mode);

                if(res != 0) return null();

                return convert::display_mode_to_hx(mode);

            } //getDisplayMode

            Dynamic getDesktopDisplayMode(int display_index) {

                SDL_DisplayMode mode;
                int res = SDL_GetDesktopDisplayMode(display_index, &mode);

                if(res != 0) return null();

                return convert::display_mode_to_hx(mode);

            } //getDesktopDisplayMode

            Dynamic getCurrentDisplayMode(int display_index) {

                SDL_DisplayMode mode;
                int res = SDL_GetCurrentDisplayMode(display_index, &mode);

                if(res != 0) return null();

                return convert::display_mode_to_hx(mode);

            } //getCurrentDisplayMode


            //internal
            static InternalEventFilterFN event_fn = 0;
            static bool inited_event_watch = false;

            //sdl ignores the return value
            static int InternalEventFilter(void* userdata, SDL_Event* event) {

                if(!inited_event_watch) return 0;

                event_fn(event);

                return 0;

            } //InternalEventFilter

            void init_event_watch( InternalEventFilterFN fn ) {

                if(inited_event_watch) return;

                event_fn = fn;

                SDL_AddEventWatch(InternalEventFilter, 0);

                inited_event_watch = true;

            } //init_event_watch

        #if defined(__IPHONEOS__) || defined(IPHONE)

            //iOS callback

                static InternaliOSCallbackFN ios_fn;

                static void InternaliOSCallback(void* userdata) {

                    ios_fn();

                } //InternaliOSCallback

                void init_ios_callback( SDL_Window* window, int interval, InternaliOSCallbackFN fn ) {

                    SDL_iPhoneSetAnimationCallback(window, interval, InternaliOSCallback, NULL);

                } //init_ios_callback

        #endif //iOS

        //conversions

            namespace convert {

                Dynamic render_info_to_hx(SDL_RendererInfo info) {

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

                    // returns {
                    //     var name:String;
                    //     var flags:UInt;
                    //     var num_texture_formats:UInt;
                    //     var texture_formats:Array<UInt>;
                    //     var max_texture_width:Int;
                    //     var max_texture_height:Int;
                    // }

                } //render_info_to_hx

                Dynamic display_mode_to_hx(SDL_DisplayMode mode) {

                    hx::Anon out = hx::Anon_obj::Create();

                        out->Add(HX_CSTRING("w"), mode.w);
                        out->Add(HX_CSTRING("h"), mode.h);
                            //:note: this was UInt32, but the ranges appear to fit in int and Dynamic hates unsigned int
                        out->Add(HX_CSTRING("format"), (int)mode.format);
                        out->Add(HX_CSTRING("refresh_rate"), mode.refresh_rate);

                    return out;

                } //display_mode_to_hx

                Dynamic set_color_into(Dynamic into, Uint8 r, Uint8 g, Uint8 b, Uint8 a) {

                        into->__FieldRef(HX_CSTRING("r")) = r;
                        into->__FieldRef(HX_CSTRING("g")) = g;
                        into->__FieldRef(HX_CSTRING("b")) = b;
                        into->__FieldRef(HX_CSTRING("a")) = a;

                    return into;

                } //set_color_into

                Dynamic set_size_into(Dynamic into, int w, int h) {

                        into->__FieldRef(HX_CSTRING("w")) = w;
                        into->__FieldRef(HX_CSTRING("h")) = h;

                    return into;

                } //set_size_into

                Dynamic set_scale_into(Dynamic into, float x, float y) {

                        into->__FieldRef(HX_CSTRING("x")) = x;
                        into->__FieldRef(HX_CSTRING("y")) = y;

                    return into;

                } //set_scale_into

                Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h) {

                        into->__FieldRef(HX_CSTRING("x")) = x;
                        into->__FieldRef(HX_CSTRING("y")) = y;
                        into->__FieldRef(HX_CSTRING("w")) = w;
                        into->__FieldRef(HX_CSTRING("h")) = h;

                    return into;

                } //set_rect_into

                Dynamic set_point_into(Dynamic into, int x, int y) {

                        into->__FieldRef(HX_CSTRING("x")) = x;
                        into->__FieldRef(HX_CSTRING("y")) = y;

                    return into;

                } //set_point_into

                Dynamic set_rect_into(Dynamic into, SDL_Rect from) {

                        into->__FieldRef(HX_CSTRING("x")) = from.x;
                        into->__FieldRef(HX_CSTRING("y")) = from.y;
                        into->__FieldRef(HX_CSTRING("w")) = from.w;
                        into->__FieldRef(HX_CSTRING("h")) = from.h;

                    return into;

                } //set_rect_into

                SDL_Rect get_rect_from(Dynamic from) {

                    SDL_Rect r;

                        r.x = from->__FieldRef(HX_CSTRING("x"));
                        r.y = from->__FieldRef(HX_CSTRING("y"));
                        r.w = from->__FieldRef(HX_CSTRING("w"));
                        r.h = from->__FieldRef(HX_CSTRING("h"));

                    return r;

                } //get_rect_from

            } //convert namespace


        } //sdl namespace

    } //linc namespace

#endif //_LINC_SDL_CPP_
