//
//  SomeViewController.h
//  Retain Cycles
//
//  Created by Mehul Srivastava on 19/05/17.
//  Copyright © 2017 Mehul Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SomeViewController : UIViewController

- (void)sampleMethodWithCompletion:(void (^)(void))completionBlock;

@end
