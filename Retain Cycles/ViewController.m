//
//  ViewController.m
//  Retain Cycles
//
//  Created by Mehul Srivastava on 5/19/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import "ViewController.h"
#import "ParentChildReference.m"

@interface ViewController ()

@property (nonatomic, copy) void (^simpleBlock)(void);
@property (nonatomic, copy) NSArray *myArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

@end




