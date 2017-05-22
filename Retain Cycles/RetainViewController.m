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
    self.myBoolValue = TRUE;
    self.sampleObject = [[SampleObject alloc] init];
    self.someViewController = [[SomeViewController alloc] init];

    
    // 1.
    //Referring self from Main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Capturing Self %@", self);
    });
    
    
    // 2.
    //Referring self from Custom queue
    dispatch_async(dispatch_queue_create("com.test.app", NULL),^{
        NSLog(@"Capturing Self %@", self);
    });
    
    
    // 3.
    //Referring self from a block
    [self.myArray enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    // 4.
    //Self referring from block saved as Ivar
    self.simpleBlock = ^(){
        NSLog(@"Capturing Self %@", self);
    };

 
    // 5.
    //Self referring from Custom block saved as Ivar & from array which is not a property
    self.simpleBlock2 = ^(){
        NSLog(@"Print array", anotherArray);
        NSLog(@"Capturing Self %@", weakSelf);
    };
    
    
    // 6.
    //Self referring from Custom block saved as Ivar & from array which is a property
    self.simpleBlock = ^(){
        NSLog(@"Print array", _myArray);
        NSLog(@"Capturing Self %@", weakSelf);
    };

     
    // 7.
    //Self referring from Custom block saved as Ivar & from array which is a property
    self.simpleBlock = ^(){
        NSLog(@"Capturing Self %@", weakSelf);
        NSLog(@"Value type property", self.myBoolValue);
    };

  
    // 8.
    //Self referring from a block
    [self.myArray enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
        
        NSLog(@"Capturing Self %@", weakSelf);
        
        //Self referring from Main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });
        
    }];

    
    // 9.
    //Self referring dispatch inside a custom block
    self.simpleBlock = ^(){
        NSLog(@"Print array", weakSelf.myArray);
        NSLog(@"Capturing Self %@", weakSelf);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });
    };

    
    // 10.
    //Sample object stored as ivar with completion block
    [self.sampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
    }];
    

    
    // 11.
    //Sample object with completion block
    SampleObject *anotherSampleObject = [[SampleObject alloc] init];
    [anotherSampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    
    // 12.
    //Sample object stored as ivar with completion block
    [self.sampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });

    }];
    
    
    // 13.
    //Sample controller set as a strong property with its custom completion handler
    [self.someViewController sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self.someViewController);
    }];

    
    // 14.
    [self sampleMethodWhichRunsABlock];
}




-(void)sampleMethodWhichRunsABlock {
    
    //Referring self from Main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Capturing Self %@", self);
    });

}

@end




