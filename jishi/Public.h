//
//  Public.h
//  xiaoyixiu
//
//  Created by 柯南 on 16/6/12.
//  Copyright © 2016年 柯南. All rights reserved.
//

#ifndef Public_h
#define Public_h

#pragma mark Log

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}
#endif
#pragma clang diagnostic ignored"-Wdeprecated"

#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"%s <第%d行> %@",__FUNCTION__,  __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif
//#ifndef __OPTIMIZE__
//#define NSLog(...) printf(" %s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
//#endif
#pragma mark ScreenWH

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define Rect(x,y,w,h)  CGRectMake(x*WIDTH/1242, y*HEIGHT/2208, w*WIDTH/1242, h*HEIGHT/2208)

#pragma mark Color

#define kColorFromARGBHex(value,a) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:a] //a:透明度
#define kColorFromRGBHex(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:1.0]
#define kColorFromRGB(r,g,b) [UIColor colorWithRed:(float)r /255.0 green:(float)g /255.0 blue:(float)b /255.0 alpha:1.0]
#define AppButtonbackgroundColor kColorFromRGBHex(0x4e72a5)//app  按钮颜色
#define BaseColor kColorFromRGBHex(0xF3F3F3)  //app  底色
#define AppgreenColor  kColorFromRGBHex(0x4ed19d)
#define AppPageColor kColorFromRGB(235,235,241)  //灰色
#define AppThemeBackColor [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1]
#define AppBackColor [UIColor colorWithRed:10.0/255 green:96.0/255 blue:254.0/255 alpha:1]  //蓝色
#define AppThemeColor kColorFromRGBHex(0xFCAA1B)//
#define PageColor kColorFromRGB(186,186,186)
#define LineColor kColorFromRGBHex(0xafafaf)
#define fontLightGray kColorFromRGBHex(0xc6c6c6)
#define TableViewBGcolor kColorFromRGBHex(0xECECEC)
#define FontBlack kColorFromRGBHex(0x646464)
#define RedBackGround kColorFromRGBHex(0xFF4D4D)
#define AppBlue kColorFromRGBHex(0x1786e2)


#pragma mark 系统文件位置

#define DOCUMENT_FOLDER(fileName) [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:fileName]
#define CACHE_FOLDER(fileName) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName]

#define WS(weakSelf) __weak typeof(self) weakSelf = self


#define NoticDefaultCenter                  [NSNotificationCenter defaultCenter]
#define ApplicationDelegate                 ((ZGAppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define ViewWidth(v)                        v.frame.size.width
#define View_Height(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define Rect_Width(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), Rect_Width(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), Rect_Width(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, Rect_Width(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, Rect_Width(f), RectHeight(f))
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define SelfDefaultToolbarHeight            self.navigationController.navigationBar.frame.size.height
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define ISIOS7LATER                         !(IOSVersio

//////////////////////////////////////////////////////////////////////////
/* ∆ΩÃ®œ‡πÿµƒ“ª–©∂®“Â */
/** µ˜”√∑Ω Ω‘º∂® */
#if (defined WIN32 || defined WIN64)
//-----------windows-----------------------------
#define STD_CDECL   __cdecl         //Cµ˜”√‘º∂®
#define STD_STDCALL __stdcall       //pascallµ˜”√‘º∂®
#define STD_EXPORTS __declspec(dllexport)
#define STD_WINAPI  __stdcall
#else
//-----------linux-------------------------------
#define STD_CDECL
#define STD_STDCALL
#define STD_EXPORTS __attribute__ ((visibility("default")))
#endif

/* µº≥ˆ∑Ω Ω∂®“Â */
#ifndef STD_EXTERN_C
#ifdef __cplusplus
#define STD_EXTERN_C  extern "C"
#else
#define STD_EXTERN_C  extern
#endif
#endif

/* Ω”ø⁄∂®“Â:≤…”√±Í◊ºµƒCµ˜”√‘º∂® */
#ifndef STD_API
#define STD_API(rettype) STD_EXTERN_C STD_EXPORTS rettype STD_CDECL
/* Ω”ø⁄ µœ÷:≤…”√±Í◊ºµƒCµ˜”√‘º∂® */
#define STD_IMPL STD_EXTERN_C STD_EXPORTS
#endif
/* C++Ω”ø⁄∂®“Â */
#ifndef CPP_API
#define CPP_API(rettype) STD_EXPORTS rettype STD_CDECL
#define CPP_IMPL STD_EXPORTS
#endif

//////////////////////////////////////////////////////////////////////////
//≥£”√∂®“Â∫Í
/* MIN, MAX, ABS */
#define ZMIN(a, b)	((a)>(b) ? (b) : (a))
#define ZMAX(a, b)	((a)<(b) ? (b) : (a))
#define ZABS(a)		((a) < 0 ? (-(a)) : a)
#define ZSIGN(x)    (((x) < 0) ? -1 : 1)

#define ZFALSE		(0)
#define ZTRUE		(1)
#define ZPI			(3.1415926535)
#define PROCNAME(name)  static const char procName[] = name
#define ROUND(a) ((int)((a) + ((a) >= 0 ? 0.5 : -0.5)))
#define FLOOR(a) ( ROUND(a) + ((a - ROUND(a)) < 0 ) )
#define CEIL(a)  ( ROUND(a) + ((ROUND(a) - a) < 0 ) )

//////////////////////////////////////////////////////////////////////////
//64Œª¥Û ˝£¨”…”⁄œ¬√Êlong±ª÷ÿ∂®“Â¡À£¨À˘“‘’‚∏ˆ“™Ã·«∞
#if (defined WIN32 || defined WIN64)
typedef __int64			TInt64;
#else
typedef long long		TInt64;
#endif

//”…”⁄longµƒ≥§∂»”–32Œª∫√64ŒªµƒŒ Ã‚£¨Õ≥“ª”√int¿¥¥¶¿Ì£¨ ∂±ƒ⁄∫À√ª”–Œ Ã‚
//#define long int
//////////////////////////////////////////////////////////////////////////
/**common data types, when we write code, we must use this data type to make our code partable
 *more easily, and make our code write more precise in data type.*/
typedef signed char	    TInt8;
typedef signed short	TInt16;
typedef signed int	    TInt32;
typedef signed int	    TInt;
typedef signed long     TLong;      //≥§∂»x32£¨4byte£¨x64 «8byte
typedef unsigned char	TUint8;
typedef unsigned short	TUint16;
typedef unsigned int	TUint32;
typedef unsigned int	TUint;      //DWORD
typedef unsigned char   TUchar;     //BYTE
typedef unsigned short  TUshort;    //WORD
typedef unsigned long   TUlong;     //≥§∂»x32£¨4byte£¨x64 «8byte
typedef float		    TReal32;
typedef double		    TReal64;
typedef int		        TBool;
typedef void		    TVoid;
typedef void*           THandle;    // handle=void*
typedef int				TStatus;
typedef int				TSTATUS;
typedef void*			THandle;

//////////////////////////////////////////////////////////////////////////
/* µ„ */
typedef struct TPoint_
{
    int x;
    int y;
}TPoint;

/* æÿ–Œ(∞¸∫¨πÿœµ) */
typedef struct TRect_
{
    int nLft;
    int nRgt;
    int nTop;
    int nBtm;
}TRect;

//////////////////////////////////////////////////////////////////////////
// ˝æ›¿‡–Õ◊Ó¥Û÷µ∫Õ◊Ó–°÷µ
#define TINT8_MIN  (-128)
#define TINT16_MIN (-32768)
#define TINT32_MIN (-2147483647 - 1)
#define TINT64_MIN (-9223372036854775807LL - 1)

#define TINT8_MAX  127
#define TINT16_MAX 32767
#define TINT32_MAX 2147483647
#define TINT64_MAX 9223372036854775807LL

#define TUINT8_MAX  0xff /* 255U */
#define TUINT16_MAX 0xffff /* 65535U */
#define TUINT32_MAX 0xffffffff  /* 4294967295U */
#define TUINT64_MAX 0xffffffffffffffffULL /* 18446744073709551615ULL */

//////////////////////////////////////////////////////////////////////////
//¥ÌŒÛ¿‡–Õ ¥ÌŒÛ±‡¬Î <0 ∑¢…˙¥ÌŒÛ ∑Ò‘Ú’˝»∑£¨32Œªµƒ¥ÌŒÛ±‡¬Î
/** ≈–∂œ”Ôæ‰ */
#define ISFAILED(iStatus)	 ((iStatus) <  0 )
#define ISSUCCEEDED(iStatus) ((iStatus) >= 0 )

/** √ª”–¥ÌŒÛ */
#define STATUS_OK                   (0     )
/** ƒ⁄¥Ê≤ª◊„ */
#define STATUS_NOMEMORY             (-80001)
/**  ‰»Î≤Œ ˝≤ª∂‘ */
#define STATUS_INVALIDARG           (-80002)
/** Œﬁ¥ÀΩ”ø⁄ */
#define STATUS_NOINTERFACE          (-80003)
/** Œﬁ–ß÷∏’Î */
#define STATUS_INVALIDPTR           (-80004)
/* Œƒº˛¥ÌŒÛ */
#define STATUS_FILEERROR            (-80005)
/**  ∂±◊÷µ‰√ª”–≥ı ºªØ */
#define STATUS_DICT_UNINIT			(-80006)
/**  ∂±◊÷µ‰¥ÌŒÛ */
#define STATUS_RECG_ERROR			(-80007)
/** ◊÷µ‰≥ı ºªØ¥ÌŒÛ */
#define STATUS_DICT_ERROR			(-80008)
/** ÷∏’ÎŒ™ø’ */
#define STATUS_NULLPTR				(-80009)
/** not supported image formate    */
#define	STATUS_UNKNOWFMT			(-80010)
/** ÕºœÒ¥ÌŒÛ */
#define STATUS_BADIMAGE				(-80011)
/** ÃÌº”∆‰À˚¥ÌŒÛ ........................ */
/** ∂®Œª¥ÌŒÛ */
#define STATUS_DETECTERR			(-80020)
/** Ω‚¬Î¥ÌŒÛ */
#define STATUS_DECODEERR			(-80021)
/** ±‡¬Î¥ÌŒÛ */
#define STATUS_ENCODEERR			(-80022)
/** ø‚π˝∆⁄¡À*/
#define STATUS_OVERTIME				(-80023)
/**∆‰À˚¥ÌŒÛ */
#define STATUS_UNEXPECTED			(-88888)

//////////////////////////////////////////////////////////////////////////



#pragma mark 其它

#define Context [UserInfoContext sharedContext]

#endif /* Public_h */
