//
//  ViewController.m
//  Edit-Image-Objective-C
//
//  Created by Tanjim Hossain on 12/31/17.
//  Copyright © 2017 Tanjim Hossain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TabbarDelegate Methods

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
            NSLog(@"New button pressed");
            break;
        case 1:
            NSLog(@"Edit button pressed");
            break;
        case 2:
            NSLog(@"Save button pressed");
            break;
        default:
            break;
    }
    
    tabBar.selectedItem = nil;
}


@end
