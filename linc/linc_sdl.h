#ifndef _LINC_SDL_H_
#define _LINC_SDL_H_

#include "../lib/sdl/include/SDL.h"
#include <hxcpp.h>

namespace linc {

        namespace sdl {

                //forward declarations
            namespace convert {

                extern  Dynamic render_info_to_hx(SDL_RendererInfo info);
                extern  Dynamic display_mode_to_hx(SDL_DisplayMode mode);
                extern  Dynamic set_color_into(Dynamic into, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
                extern  Dynamic set_texture_query_into(Dynamic into, Uint32 format, int access, int w, int h);
                extern  Dynamic set_size_into(Dynamic into, int w, int h);
                extern  Dynamic set_scale_into(Dynamic into, float x, float y);
                extern  Dynamic set_point_into(Dynamic into, int x, int y);
                extern  Dynamic set_mouse_state_into(Dynamic into, int x, int y, Uint32 buttons);
                extern  Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h);
                extern  Dynamic set_rect_into(Dynamic into, SDL_Rect from);
                extern SDL_Rect get_rect_from(Dynamic from);
                extern SDL_Point get_point_from(Dynamic from);

            } //convert

            extern Dynamic createWindowAndRenderer(int x, int y, int flags);
            extern ::String REVISION();
            extern Dynamic VERSION();
			extern Dynamic getVersion();
            extern ::cpp::Struct<SDL_Event> pollEvent();
            extern ::cpp::Struct<SDL_Event> waitEvent();
            extern ::cpp::Struct<SDL_Event> waitEventTimeout(int _timeout);
			extern ::String getBasePath();
			extern ::String getPrefPath(::String org, ::String app);
			extern Dynamic GL_BindTexture(SDL_Texture* texture);
			extern int setRenderDrawBlendMode(SDL_Renderer* renderer, int blend);
			extern int getRenderDrawBlendMode(SDL_Renderer* renderer);
			extern Dynamic getRenderDrawColor(SDL_Renderer* renderer, Dynamic into);
			extern Dynamic getRenderDriverInfo(int index);
			extern Dynamic getRendererInfo(SDL_Renderer* renderer);
			extern Dynamic getRendererOutputSize(SDL_Renderer* renderer, Dynamic into);
			extern Uint8 getTextureAlphaMod(SDL_Texture* texture);
			extern int getTextureBlendMode(SDL_Texture* texture);
            extern Dynamic getTextureColorMod(SDL_Texture* texture, Dynamic into);
			extern Dynamic queryTexture(SDL_Texture* texture, Dynamic into);
			extern int renderDrawRect(SDL_Renderer* renderer, Dynamic rect);
			extern int renderFillRect(SDL_Renderer* renderer, Dynamic rect);
			extern Dynamic renderGetClipRect(SDL_Renderer* renderer, Dynamic into);
			extern Dynamic renderGetLogicalSize(SDL_Renderer* renderer, Dynamic into);
			extern Dynamic renderGetScale(SDL_Renderer* renderer, Dynamic into);
			extern Dynamic renderGetViewport(SDL_Renderer* renderer, Dynamic into);
			extern int renderSetClipRect(SDL_Renderer* renderer, Dynamic rect);
			extern int renderSetViewport(SDL_Renderer* renderer, Dynamic rect);
			extern SDL_Cursor* createSystemCursor(int id);
			extern Dynamic joystickGetBall(SDL_Joystick* joystick, int ball, Dynamic into);
			extern void setModState(int modstate);
			extern void setTextInputRect(Dynamic rect);
			extern Dynamic getWindowSize(SDL_Window* window, Dynamic into);
			extern Dynamic getWindowPosition(SDL_Window* window, Dynamic into);
			extern Dynamic GL_GetDrawableSize(SDL_Window* window, Dynamic into);
			extern Dynamic getDisplayBounds(int display_index, Dynamic into);
            extern int renderCopy(SDL_Renderer* renderer, SDL_Texture* texture, Dynamic srcrect, Dynamic dstrect);
			extern int renderCopyEx(SDL_Renderer* renderer, SDL_Texture* texture, Dynamic srcrect, Dynamic dstrect, Float angle, Dynamic center, int flip);
			extern Dynamic getDisplayMode(int display_index, int mode_index);
			extern Dynamic getDesktopDisplayMode(int display_index);
            extern Dynamic getCurrentDisplayMode(int display_index);
            extern Dynamic getGlobalMouseState(Dynamic into);
            extern Dynamic getMouseState(Dynamic into);
            extern Dynamic getRelativeMouseState(Dynamic into);
			extern int waitThread(SDL_Thread* thread);


            //internal
            typedef ::cpp::Function < Void(::cpp::Reference<SDL_Event>) > InternalEventFilterFN;
            extern void init_event_watch( InternalEventFilterFN fn );

            //iOS callbacks
            #if defined(__IPHONEOS__) || defined(IPHONE)
                typedef ::cpp::Function < Void() > InternaliOSCallbackFN;
                extern void init_ios_callback( SDL_Window* window, int interval, InternaliOSCallbackFN fn );
            #endif

    } //sdl

} //linc

#endif //_LINC_SDL_H_
