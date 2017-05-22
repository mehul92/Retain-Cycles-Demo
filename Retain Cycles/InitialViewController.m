//
//  InitialViewController.m
//  Retain Cycles
//
//  Created by Mehul Srivastava on 19/05/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import "InitialViewController.h"
#import "MyChildClass.h"
#import "MyParentClass.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    MyParentClass *newParent = [[MyParentClass alloc] init];
    MyChildClass *newChild = [[MyChildClass alloc] init];
    
    newParent.Name = @"Johnny";
    newParent.myChild = newChild;
    
    newChild.myParent = newParent;

}

@end
