//
//  ViewController.m
//  SafeMutableArrayDemo
//
//  Created by xiaoL on 17/3/1.
//  Copyright © 2017年 xiaolin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4,@5]];
    
    NSObject *obj1 = nil;
    [array addObject:obj1];
    NSLog(@"1  array:%@",array);
    
    NSObject *obj2 = [array objectAtIndex:7];
    NSLog(@"2  array:%@    obj2:%@",array,obj2);
    
    
    NSObject *obj5 = nil;
//    [array insertObject:obj5 atIndex:1];
    NSLog(@"5  array:%@",array);
    
    
    [array insertObject:@6 atIndex:6];
    NSLog(@"6  array:%@",array);

    
    [array removeObjectAtIndex:20];
    NSLog(@"8  array:%@",array);
    
    
    [array replaceObjectAtIndex:100 withObject:@201];
    NSLog(@"10  array:%@",array);

    
    [array exchangeObjectAtIndex:0 withObjectAtIndex:202];
    NSLog(@"11  array:%@",array);
    
    [array removeObject:@1 inRange:NSMakeRange(2, 30)];
    NSLog(@"12  array:%@",array);
    
    [array removeObjectsInRange:NSMakeRange(0, 100)];
    NSLog(@"13  array:%@",array);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
