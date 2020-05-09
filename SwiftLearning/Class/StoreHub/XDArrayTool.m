//
//  XDArrayTool.m
//  SwiftLearning
//
//  Created by caixiaodong on 2020/5/9.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

#import "XDArrayTool.h"

@implementation XDArrayTool

+ (void)test {
    NSMutableArray *array = @[@"1",@"2",@"3",@"4",@"5"].mutableCopy;
    
    [self deleteAllObjectInArray:array];
}

+ (void)deleteAllObjectInArray:(NSMutableArray *)array {
    
    for (NSInteger i = (array.count - 1); i >= 0; i--) {
        [array removeObjectAtIndex:i];
    }
    
}

@end
