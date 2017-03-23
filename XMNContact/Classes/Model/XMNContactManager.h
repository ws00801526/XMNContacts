//
//  XMNContactManager.h
//  Pods
//
//  Created by XMFraker on 17/3/20.
//
//


#import "XMNContact.h"
#import "XMNContactDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMNContactManager : NSObject

+ (instancetype)sharedManager;

- (void)loadContactsWithCompletionBlock:(void(^)(NSArray<XMNContact *> *contacts))completionBlock;
@end


@interface XMNContactManager (Deprecated)

- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("use sharedMangaer");

@end
NS_ASSUME_NONNULL_END
