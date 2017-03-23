//
//  XMNContactFramework.h
//  Pods
//
//  Created by XMFraker on 17/3/22.
//
//

#ifndef XMNContactFramework_h
#define XMNContactFramework_h


FOUNDATION_EXPORT double XMNContactVersionNumber;
FOUNDATION_EXPORT const unsigned char XMNContactVersionString[];


#if __has_include(<XMNContact/XMNContactFramework.h>)

    #import <XMNContact/XMNContact.h>
    #import <XMNContact/XMNContactDefines.h>
    #import <XMNContact/XMNContactManager.h>
#else

    #import "XMNContact.h"
    #import "XMNContactDefines.h"
    #import "XMNContactManager.h"
#endif

#endif /* XMNContactFramework_h */
