package sdl;

@:keep
typedef SDLAudioCVT = cpp.RawPointer<cpp.Void>;

@:keep
typedef SDLAudioCallback = 
	cpp.Callable <
		cpp.RawPointer<cpp.Void> -> cpp.RawPointer<cpp.UInt8> -> Int -> cpp.Void > ;
	
@:keep
typedef SDLAudioFilter = 
	cpp.Callable <SDLAudioCVT -> _SDL_AudioFormat-> cpp.Void>;

		
@:keep @:include('linc_sdl.h') @:native("SDL_AudioSpec")
extern class SDL_AudioSpec {
	var freq:Int;
	var format:_SDL_AudioFormat;
	var channels:cpp.UInt8;
	var silence:cpp.UInt8;
	var samples:cpp.UInt16;
	var size:cpp.UInt32;
	var callback : SDLAudioCallback;
	var userdata : cpp.RawPointer<cpp.Void>;
	
	@:native("new SDL_AudioSpec")
	public static function create():cpp.Pointer<SDL_AudioSpec>;
}
typedef AudioSpec = cpp.Pointer<SDL_AudioSpec>;
typedef ConstAudioSpec = cpp.ConstPointer<SDL_AudioSpec>;

@:keep @:native("SDL_AudioCVT") @:include('linc_sdl.h')
extern class SDL_AudioCVT {
	/**< Set to 1 if conversion possible */
	var needed:Int;
	var src_format:_SDL_AudioFormat;
	var dst_format:_SDL_AudioFormat;
	var rate_incr:cpp.Float64;
	var but : cpp.Pointer<cpp.UInt8>;
	var len:Int;
	var len_cvt:Int;
	var len_mult:Int;
	var len_ratio:cpp.Float64;
	var filters:cpp.Pointer<SDLAudioFilter>;
	var filter_index:Int;
}
typedef AudioCVT = cpp.Pointer<SDL_AudioCVT>;

//@:enum abstract SDLAudioFormat(UInt) from UInt to UInt { }

@:keep @:include('linc_sdl.h') @:native("SDL_AudioFormat")	
extern class _SDL_AudioFormat { }

@:keep @:include('linc_sdl.h')
class AudioFormat {
	/*
	function MASK_BITSIZE() 				return 0xFF;
	function MASK_DATATYPE()				return 1<<8;
	function MASK_ENDIAN() 					return 1<<12;
	function MASK_SIGNED() 					return 1 << 15;
	
	public function BITSIZE() 				return this & MASK_BITSIZE();
	public function ISFLOAT() 				return this & MASK_DATATYPE();
	public function ISBIGENDIAN()			return this & MASK_ENDIAN();
	public function ISSIGNED()				return this & MASK_SIGNED();
	       
	public function ISINT()					return 0!=ISFLOAT();
	public function ISLITTLEENDIAN()		return 0!=ISBIGENDIAN();
	public function ISUNSIGNED()			return 0 != ISSIGNED();
	*/
	public static inline var af_u8 		= 0x0008;  		/**< Unsigned 8-bit samples */
	public static inline var af_s8        	= 0x8008;  		/**< Signed 8-bit samples */
	public static inline var af_u16lsb    	= 0x0010; 		/**< Unsigned 16-bit samples */
	public static inline var af_s16lsb    	= 0x8010;  		/**< Signed 16-bit samples */
	public static inline var af_u16msb    	= 0x1010;  		/**< As above, but big-endian byte order */
	public static inline var af_s16msb    	= 0x9010;  		/**< As above, but big-endian byte order */
	//public var AUDIO_U16      	() AUDIO_U16LSB();
	//public var AUDIO_S16      	() AUDIO_S16LSB();
	public static var af_s32lsb    	= 0x8020;  		/**< 32-bit integer samples */
	public static var af_s32msb    	= 0x9020;  		/**< As above, but big-endian byte order */
	//public var AUDIO_S32      	() AUDIO_S32LSB();
	public static var af_f32lsb    	= 0x8120;  		/**< 32-bit floating point samples */
	public static var af_f32msb    	= 0x9120; 		/**< As above, but big-endian byte order */
	//public var AUDIO_F32       	() AUDIO_F32LSB();
	
	@:unreflective
	public static function toNative(v:Int) : _SDL_AudioFormat {
		return untyped __cpp__("((SDL_AudioFormat)({0}))",v);
	}

	
} //SDLAudioFormat


@:enum
abstract SDLAllowChange(UInt)
from UInt to UInt {
	var SDL_AUDIO_ALLOW_FREQUENCY_CHANGE 	= 0x00000001;
	var SDL_AUDIO_ALLOW_FORMAT_CHANGE 		= 0x00000002;
	var SDL_AUDIO_ALLOW_CHANNELS_CHANGE 	= 0x00000004;
	var SDL_AUDIO_ALLOW_ANY_CHANGE = (0x00000001 | 0x00000002 | 0x00000004);
}

@:enum
abstract SDLAudioDeviceID (Int) from Int to Int{
	
}

@:enum
abstract SDLAudioStatus(UInt)
from UInt to UInt {
	var SDL_AUDIO_STOPPED 	= 0;
	var SDL_AUDIO_PLAYING 	= 1;
	var SDL_AUDIO_PAUSED 	= 2;
}
