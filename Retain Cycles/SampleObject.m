//
//  NSObject+SampleObject.m
//  Retain Cycles
//
//  Created by Mehul Srivastava on 19/05/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import "SampleObject.h"

@interface SampleObject()

@end


@implementation SampleObject

- (void)sampleMethodWithCompletion:(void (^)(void))completionBlock{
    completionBlock();
}

@end
