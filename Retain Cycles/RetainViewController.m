//
//  ViewController.m
//  Retain Cycles
//
//  Created by Mehul Srivastava on 5/19/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import "RetainViewController.h"
#import "SampleObject.h"
#import "SomeViewController.h"

/* Please read the readme attached in this project to understand the context of the below placed code
 *
 */

@interface RetainViewController() {
            
     NSArray* anotherArray;
}

@property (nonatomic, copy) void (^simpleBlock)(void);
@property (nonatomic, copy) void (^simpleBlock2)(void);

@property (nonatomic, copy) NSArray *myArray;
@property (nonatomic) BOOL *myBoolValue;
@property (nonatomic) SampleObject *sampleObject;
@property (nonatomic) SomeViewController *someViewController;

@end


//RETAIN CYCLES IN BLOCKS
@implementation RetainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak RetainViewController *weakSelf = self;

    self.myArray = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    anotherArray = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    self.myBoolValue = 0;
    self.sampleObject = [[SampleObject alloc] init];
    self.someViewController = [[SomeViewController alloc] init];

    
    
    // 1.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Capturing Self %@", self);
    });
    
    
    
    // 2.
    dispatch_async(dispatch_queue_create("com.test.app", NULL),^{
        NSLog(@"Capturing Self %@", self);
    });
    
    
    
    // 3.
    [self.myArray enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    
    // 4.   
    self.simpleBlock = ^(){
        NSLog(@"Capturing Self %@", self);
    };
    
    
 
    // 5.
    self.simpleBlock2 = ^(){
        NSLog(@"Print array %@", anotherArray);
        NSLog(@"Capturing Self %@", weakSelf);
    };
    
    
    
    
    // 6.
    self.simpleBlock = ^(){
        NSLog(@"Print array %@", _myArray);
        NSLog(@"Capturing Self %@", weakSelf);
    };

    
    
    // 7.
    self.simpleBlock = ^(){
        NSLog(@"Capturing Self %@", weakSelf);
        NSLog(@"Value type property", _myBoolValue);
    };

    
  
    // 8.
    [self.myArray enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
        
        NSLog(@"Capturing Self %@", weakSelf);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });
        
    }];

    
    
    // 9.
    self.simpleBlock = ^(){
        //NSLog(@"Print array %@", weakSelf.myArray);
        NSLog(@"Capturing Self %@", weakSelf);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });
    };
    
    
    
    
    // 10.
    [self.sampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
    }];
    

    
    
    // 11.
    SampleObject *anotherSampleObject = [[SampleObject alloc] init];
    [anotherSampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    
    
    // 12.
    [self.sampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });

    }];
    
    
    
    
    // 13.
    [self.someViewController sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self.someViewController);
    }];

    
    
    
    // 14.
    [self.sampleObject setCompletionBlock:^{
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    
    // 15.
    [self sampleMethodWhichRunsABlock];
    
    
    
    
    //16.
    [self sampleMethodTakingSampleParameter:_myArray];
    
}




-(void)sampleMethodWhichRunsABlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Capturing Self %@", self);
    });

}


-(void)sampleMethodTakingSampleParameter: (NSArray*)myBoolValue {
    self.simpleBlock = ^{
        NSLog(@"Capturing Self %@", myBoolValue);
    };
};

@end




