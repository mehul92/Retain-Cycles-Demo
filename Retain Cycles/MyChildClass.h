//
//  MyChildClass.h
//  Retain Cycles
//
//  Created by Mehul Srivastava on 5/22/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyParentClass.h"


@interface MyChildClass : NSObject

@property (nonatomic) MyParentClass *myParent;

@end
