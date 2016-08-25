//
//  RevealViewController.m
//  DirCare
//
//  Created by canduo on 13/4/2016.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import "RevealViewController.h"

const CGFloat coefficient = 0.8;

@interface RevealViewController ()

@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UIView *menuBgView;
@property (strong, nonatomic) UIView *contentView;

@end

@implementation RevealViewController

@synthesize menuViewController;
@synthesize contentViewController;
@synthesize isShowing;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];

    self.menuBgView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.menuBgView.backgroundColor=[UIColor blackColor];
    self.menuBgView.alpha=0;
    self.menuView.hidden=YES;
    self.menuBgView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
    [self.menuBgView addGestureRecognizer:tap];
    
    UIPanGestureRecognizer * pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
    [self.menuBgView addGestureRecognizer:pan];
    
    [self.view addSubview:self.menuBgView];
    
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(-self.view.bounds.size.width, 20, self.view.bounds.size.width*coefficient, self.view.bounds.size.height-20)];
    self.menuView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.menuView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.menuView];
    
    if (menuViewController) {
        UIViewController *temp = menuViewController;
        menuViewController = nil;
        self.menuViewController = temp;
    }
    
    if (contentViewController) {
        UIViewController *temp = contentViewController;
        contentViewController = nil;
        self.contentViewController = temp;
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setMenuViewController:(UIViewController *)menuVC{
    if (menuViewController == nil) {
        menuVC.view.frame = _menuView.bounds;
        menuViewController = menuVC;
        [self addChildViewController:menuViewController];
        [_menuView addSubview:menuViewController.view];
        [menuViewController didMoveToParentViewController:self];
    } else if (menuViewController != menuVC) {
        menuVC.view.frame = _menuView.bounds;
        [menuViewController willMoveToParentViewController:nil];
        [self addChildViewController:menuVC];
        self.view.userInteractionEnabled = NO;
        [self transitionFromViewController:menuViewController
                          toViewController:menuVC
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{}
                                completion:^(BOOL finished){
                                    self.view.userInteractionEnabled = YES;
                                    [menuViewController removeFromParentViewController];
                                    [menuVC didMoveToParentViewController:self];
                                    menuViewController = menuVC;
                                }
         ];
    }

}


-(void) setContentViewController:(UIViewController *)contentVC{
    if (contentViewController == nil) {
        contentVC.view.frame = _contentView.bounds;
        contentViewController = contentVC;
        [self addChildViewController:contentViewController];
        [_contentView addSubview:contentViewController.view];
        [contentViewController didMoveToParentViewController:self];
    } else if (contentViewController != contentVC) {
        contentVC.view.frame = _contentView.bounds;
        [contentViewController willMoveToParentViewController:nil];
        [self addChildViewController:contentVC];
        
        self.view.userInteractionEnabled = NO;
//        contentVC.view.alpha=0;
//        contentVC.view.transform=CGAffineTransformMakeScale(0.95,0.95);
        [self transitionFromViewController:contentViewController
                          toViewController:contentVC
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{
//                                    contentViewController.view.alpha=0;
//                                    contentVC.view.alpha=1;
//                                    contentVC.view.transform=CGAffineTransformIdentity;
                                }
                                completion:^(BOOL finished){
                                    self.view.userInteractionEnabled = YES;
                                    [contentViewController removeFromParentViewController];
                                    [contentVC didMoveToParentViewController:self];
                                    contentViewController = contentVC;
                                }
         ];
    }

}

-(void) setIsShowing:(BOOL)pisShowing{
    if(isShowing!=pisShowing){
        isShowing=pisShowing;
        if(isShowing){
            self.menuBgView.hidden=NO;
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                self.menuView.frame=CGRectMake(0, self.menuView.frame.origin.y, self.menuView.bounds.size.width, self.menuView.bounds.size.height);
                self.menuBgView.alpha=0.4;
            } completion:^(BOOL finished) {
                
            }];

        }else{
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                self.menuView.frame=CGRectMake(-self.view.bounds.size.width, self.menuView.frame.origin.y, self.menuView.bounds.size.width, self.menuView.bounds.size.height);
                self.menuBgView.alpha=0;
            } completion:^(BOOL finished) {
                self.menuBgView.hidden=YES;

            }];

        }
    }
}

-(void)hideMenu{
    self.isShowing=NO;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
