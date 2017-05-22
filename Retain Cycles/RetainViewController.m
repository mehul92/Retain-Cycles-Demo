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

    //Which one of the following code snippets will cause a retain cycle?
    
    
    // 1.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Capturing Self %@", self);
    });
    
    
    
    // 2.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    dispatch_async(dispatch_queue_create("com.test.app", NULL),^{
        NSLog(@"Capturing Self %@", self);
    });
    
    
    
    // 3.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    [self.myArray enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    
    // 4.
    // Answer: Yes
    // Reason: The block is being held with a strong reference by self. The block is holding a strong reference of self.
    self.simpleBlock = ^(){
        NSLog(@"Capturing Self %@", self);
    };
    
    
 
    // 5.
    // Answer: Yes
    // Reason: The block is being held with a strong reference by self. The block is holding a strong reference of self via anotherArray variable which is strong.
    self.simpleBlock2 = ^(){
        NSLog(@"Print array %@", anotherArray);
        NSLog(@"Capturing Self %@", weakSelf);
    };
    
    
    
    
    // 6.
    // Answer: Yes
    // Reason: The block is being held with a strong reference by self. The block is holding a strong reference of self via _myArray strong ivar property.
    self.simpleBlock = ^(){
        NSLog(@"Print array %@", _myArray);
        NSLog(@"Capturing Self %@", weakSelf);
    };

    
    
    // 7.
    // Answer: Yes
    // Reason: The block is being held with a strong reference by self. The block is holding a strong reference of self via _myBoolValue value type which compiler links to self.
    self.simpleBlock = ^(){
        NSLog(@"Capturing Self %@", weakSelf);
        NSLog(@"Value type property", _myBoolValue);
    };

    
  
    // 8.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    [self.myArray enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
        
        NSLog(@"Capturing Self %@", weakSelf);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });
        
    }];

    
    
    // 9.
    // Answer: Yes
    // Reason: The block is being held with a strong reference by self. The block keeps a reference to dispatch. Dispatch has a strong reference to self.
    self.simpleBlock = ^(){
        NSLog(@"Print array %@", weakSelf.myArray);
        NSLog(@"Capturing Self %@", weakSelf);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });
    };
    
    
    
    
    // 10.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    [self.sampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
    }];
    

    
    
    // 11.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    SampleObject *anotherSampleObject = [[SampleObject alloc] init];
    [anotherSampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    
    
    // 12.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    [self.sampleObject sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Capturing Self %@", self);
        });

    }];
    
    
    
    
    // 13.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    [self.someViewController sampleMethodWithCompletion:^{
        NSLog(@"Capturing Self %@", self.someViewController);
    }];

    
    
    
    // 14.
    // Answer: Yes
    // Reason: Self has a strong referece to sample object. Sample object has a strong reference of block. Block has a strong reference of self.
    [self.sampleObject setCompletionBlock:^{
        NSLog(@"Capturing Self %@", self);
    }];
    
    
    
    // 15.
    // Answer: No
    // Reason: The block is not being held with a strong reference
    [self sampleMethodWhichRunsABlock];
    
    
    
    
    //16.
    // Answer: No
    // Reason: Pointer to _myArray ivar which retains self is passed as paramter. The pointer however does not retain self.
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




