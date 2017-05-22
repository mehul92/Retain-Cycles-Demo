//
//  ParentObject.h
//  Retain Cycles
//
//  Created by Mehul Srivastava on 5/22/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyChildClass.h"

@interface MyParentClass : NSObject

@property (nonatomic, strong) NSString *Name;
@property (nonatomic) MyChildClass *myChild;

@end
