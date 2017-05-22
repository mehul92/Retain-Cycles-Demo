//
//  NSObject+SampleObject.h
//  Retain Cycles
//
//  Created by Mehul Srivastava on 19/05/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SampleObject : NSObject

- (void)sampleMethodWithCompletion:(void (^)(void))completionBlock;
@property (nonatomic, copy) void (^completionBlock)(void);

@end
