//
//  XMNContactDefines.h
//  Pods
//
//  Created by XMFraker on 17/3/20.
//
//

#ifndef XMNContactDefines_h
#define XMNContactDefines_h

#pragma mark - 相关宏定义

/// ========================================
/// @name   个人使用的打印日志
/// ========================================

#ifndef WMLog
    #if DEBUG
        #define XMNLog(FORMAT,...) fprintf(stderr,"=============Log===================== \n       %s  %s %d :\n       %s                         \n\n\n\n",__TIME__,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
    #else
        #define XMNLog(FORMAT,...);
    #endif
#endif


#ifndef WMTick
    #if DEBUG
        #define WMTick  NSDate *_tickDate = [NSDate date];
        #define WMTock  NSLog(@"Time Cost: %f", -[_tickDate timeIntervalSinceNow]);
    #else
        #define WMTick
        #define WMTock
    #endif
#endif

/// ========================================
/// @name   相关版本宏
/// ========================================

#ifndef iOS7Later
    #define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#endif

#ifndef iOS8Later
    #define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#endif

#ifndef iOS9Later
    #define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#endif

#ifndef iOS10Later
    #define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#endif


/// ========================================
/// @name   相关尺寸宏
/// ========================================

#ifndef SCREEN_WIDTH
    #define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#endif

#ifndef SCREEN_HEIGHT
    #define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#endif

/**
 *  判断设备是否是4s机型
 *
 *  @return YES or NO
 */
#ifndef iPhone4s
    #define iPhone4s (((int)SCREEN_HEIGHT == 480) ? YES : NO)
#endif

/**
 *  判断设备是否是5s机型
 *
 *  @return YES or NO
 */
#ifndef iPhone5s
    #define iPhone5s (((int)SCREEN_HEIGHT == 568) ? YES : NO)
#endif

/**
 *  判断设备是否是6s机型
 *
 *  @return YES or NO
 */
#ifndef iPhone6s
    #define iPhone6s (((int)SCREEN_HEIGHT == 667) ? YES : NO)
#endif

/**
 *  判断设备是否是Plus机型
 *
 *  @return YES or NO
 */
#ifndef iPhonePlus
    #define iPhonePlus (((int)SCREEN_HEIGHT == 736) ? YES : NO)
#endif

/// ========================================
/// @name   相关颜色宏定义
/// ========================================

#ifndef RGBA
    #define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
    #define RGB(r,g,b)    RGBA(r,g,b,1.f)
    /** 生成随机颜色 */
    #define RGBRandom [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#endif


#ifndef HEXColor
    #define HEXColorA(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
                                                  green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
                                                  blue:((float)(hexValue & 0xFF))/255.0 \
                                                 alpha:a]
    #define HEXColor(hexValue) HEXColorA(hexValue,1.f)
#endif

#ifndef XMN_EXTERN
    #ifdef __cplusplus
        #define XMN_EXTERN extern "C" __attribute__((visibility ("default")))
    #else
        #define XMN_EXTERN extern __attribute__((visibility ("default")))
    #endif
#endif


#if __has_include(<Contacts/Contacts.h>)
//    #define kContactsFrameworkAvailable 1
//    #import <Contacts/Contacts.h>
    /** test */
    #define kContactsFrameworkAvailable 0
    #import <AddressBook/AddressBook.h>
#else
    #define kContactsFrameworkAvailable 0
    #import <AddressBook/AddressBook.h>
#endif

#pragma mark - 相关枚举定义

typedef NS_ENUM(NSUInteger, XMNContactType) {
    /** 普通个人联系人 */
    XMNContactTypePerson,
    /** 企业联系人 */
    XMNContactTypeOrganization,
};

#pragma mark - 相关常量定义

XMN_EXTERN NSString *XMNContactDidLoadFinishedNotification;

#endif /* XMNContactDefines_h */
