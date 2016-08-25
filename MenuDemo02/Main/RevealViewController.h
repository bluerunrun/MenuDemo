//
//  RevealViewController.h
//  DirCare
//
//  Created by canduo on 13/4/2016.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevealViewController : UIViewController

@property (strong, nonatomic) UIViewController *menuViewController;
@property (strong, nonatomic) UIViewController *contentViewController;

@property (assign, nonatomic) BOOL isShowing;

@end
