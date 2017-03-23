//
//  NSArray+XMNUtils.m
//  LCWelfareMall
//
//  Created by XMFraker on 16/11/24.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "NSArray+XMNUtils.h"

@implementation NSArray (XMNUtils)

- (NSArray *)xmn_map:(id(^)(id obj, NSInteger index))block {
 
    if (!block) {

        block = ^id(id obj ,NSInteger index){
            return obj;
        };
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [array addObject:block(obj,idx)];
    }];
    return [NSArray arrayWithArray:array];
}

- (NSArray *)xmn_filter:(BOOL(^)(id obj))filterBlock {
    
    if (!filterBlock) {
        
        return self;
    }
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        return filterBlock ? filterBlock(evaluatedObject) : NO;
    }]];
}

- (BOOL)xmn_any:(BOOL(^)(id obj))block {
    
    if (!block || !self || !self.count) {
        return NO;
    }
    
    __block BOOL ret = NO;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (block(obj)) {
            ret = YES;
            *stop = YES;
        }
    }];
    return ret;
}

- (id)xmn_safeObjectAtIndex:(NSUInteger)index {
    
    if (!self || ![self isKindOfClass:[NSArray class]] || !self.count) {
        return nil;
    }
    if (self && index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (NSUInteger)xmn_safeIndexOfObject:(id)object {
    
    if (!object) {
        return nil;
    }
    if (!self || ![self isKindOfClass:[NSArray class]] || !self.count) {
        return NSNotFound;
    }
    if (![self containsObject:object]) {
        return NSNotFound;
    }
    return [self indexOfObject:object];
}
@end
