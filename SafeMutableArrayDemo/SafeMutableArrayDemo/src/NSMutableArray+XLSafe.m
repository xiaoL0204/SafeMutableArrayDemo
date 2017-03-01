//
//  NSMutableArray+XLSafe.m
//
//
//  Created by xiaoL on 17/2/28.
//  Copyright © 2017年 xiaolin. All rights reserved.
//

#import "NSMutableArray+XLSafe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (XLSafe)


+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id object = [[self alloc] init];
        
        [object swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        [object swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
        [object swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
        [object swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:)];
        [object swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(safeReplaceObjectAtIndex:withObject:)];
        [object swizzleMethod:@selector(exchangeObjectAtIndex:withObjectAtIndex:) withMethod:@selector(safeExchangeObjectAtIndex:withObjectAtIndex:)];
        [object swizzleMethod:@selector(removeObject:inRange:) withMethod:@selector(safeRemoveObject:inRange:)];
        [object swizzleMethod:@selector(removeObjectsInRange:) withMethod:@selector(safeRemoveObjectsInRange:)];
    });
}




#pragma mark - addObject
- (void)safeAddObject:(id)anObject {
    if (anObject) {
        [self safeAddObject:anObject];
    }
}
#pragma mark - objectAtIndex
- (id)safeObjectAtIndex:(NSInteger)index {
    if (index >= 0 && index < self.count) {
        return [self safeObjectAtIndex:index];
    }
    return nil;
}
#pragma mark - insertObject:atIndex:
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject && index <= self.count) {
        [self safeInsertObject:anObject atIndex:index];
    }
}
#pragma mark - removeObjectAtIndex
-(void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self safeRemoveObjectAtIndex:index];
    }
}
#pragma mark - replaceObjectAtIndex:withObject
-(void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (index < self.count) {
        [self safeReplaceObjectAtIndex:index withObject:anObject];
    }
}
#pragma mark - exchangeObjectAtIndex:withObjectAtIndex
- (void)safeExchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2{
    if (idx1 < self.count && idx2 < self.count) {
        [self safeExchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}
#pragma mark - removeObject:inRange:
- (void)safeRemoveObject:(id)anObject inRange:(NSRange)range{
    if (anObject && range.location+range.length<= self.count) {
        [self safeRemoveObject:anObject inRange:range];
    }
}
#pragma mark - removeObjectsInRange:
- (void)safeRemoveObjectsInRange:(NSRange)range{
    if (range.location+range.length<= self.count) {
        [self safeRemoveObjectsInRange:range];
    }
}


#pragma mark - swizzle method
- (void)swizzleMethod:(SEL)originSelector withMethod:(SEL)newSelector {
    Class cls = [self class];
    
    Method originMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    BOOL existMethod = class_addMethod(cls, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (existMethod) {
        class_replaceMethod(cls, newSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}
@end
