//
//  SomeViewController.m
//  Retain Cycles
//
//  Created by Mehul Srivastava on 19/05/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import "SomeViewController.h"

@interface SomeViewController ()

@end

@implementation SomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)sampleMethodWithCompletion:(void (^)(void))completionBlock{
    completionBlock();
}

@end
