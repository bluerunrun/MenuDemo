//
//  MainViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "clsMenu.h"
#import "CustomNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark -LifeCycle

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowMenu:) name:@"ShowMenu" object:nil];
    
    MenuViewController *  menuVC=[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    menuVC.currentIndex=MenuID_Home;
    
    HomeViewController * homeVC=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    CustomNavigationController * nav=[[CustomNavigationController alloc] initWithRootViewController:homeVC];
    nav.navigationBarHidden=YES;
    
    self.contentViewController = nav;
    self.menuViewController = menuVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -PraviteMethods

-(void)menuAction{
    self.isShowing=YES;
}

-(void)ShowMenu:(NSNotification *)sender{
    self.isShowing=[sender.object boolValue];
}

@end
