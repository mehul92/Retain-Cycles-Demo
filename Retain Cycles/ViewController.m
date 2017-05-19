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
    
    //Self referring from Main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Capturing Self %@", self);
    });
    
    //Self referring from Custom queue
    dispatch_async(dispatch_queue_create("com.test.app", NULL),^{
        NSLog(@"Capturing Self %@", self);
    });
    
    //Self referring from a block
    self.myArray = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    [self.myArray enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    //Self referring from Custom block saved as Ivar
    self.simpleBlock = ^(){
        NSLog(@"Capturing Self %@", self);
    };
    
   
    //Parent Child Reference
    Person * person = [[Person alloc] init];
    Department * department = [[Department alloc] init];
    person.department = department;
    department.person = person;
}

@end




