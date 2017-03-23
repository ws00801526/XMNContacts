//
//  NSArray+XMNUtils.h
//  LCWelfareMall
//
//  Created by XMFraker on 16/11/24.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (XMNUtils)

/**
 执行map方法,将已有数组内数据 过滤成一个新的数组

 @param block 执行过滤的block
 @return 返回结果
 */
- (NSArray *)xmn_map:(id(^)(ObjectType obj, NSInteger index))block;

/**
 提供数组过滤功能

 @param filterBlock 过滤block  YES 保留 NO 过滤数据
 @return 过滤后的数组
 */
- (NSArray *)xmn_filter:(BOOL(^)(ObjectType obj))filterBlock;

/**
 执行查询方法,判断数组内是否有符合条件的元素

 @param block 执行判断的block方法
 @return YES or NO
 */
- (BOOL)xmn_any:(BOOL(^)(ObjectType obj))block;


/**
 安全获取数组内元素,数组存在越界情况

 @param index  需要获取的index
 @return       index对应的数据 or nil
 */
- (nullable ObjectType)xmn_safeObjectAtIndex:(NSUInteger)index;


/**
 获取元素对应的index

 @param object 需要获取的数据
 @return       index  or NSNotFound
 */
- (NSUInteger)xmn_safeIndexOfObject:(ObjectType)object;

@end

NS_ASSUME_NONNULL_END
