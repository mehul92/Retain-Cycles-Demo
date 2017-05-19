//
//  Parent Child Reference.m
//  Retain Cycles
//
//  Created by Mehul Srivastava on 5/19/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Department;

@interface Person:NSObject
@property (strong,nonatomic)Department * department;
@end

@implementation Person
-(void)dealloc{
    NSLog(@"dealloc person");
}

@end
@interface Department: NSObject
@property (strong,nonatomic)Person * person;
@end

@implementation Department
-(void)dealloc{
    NSLog(@"dealloc Department");
}
@end
