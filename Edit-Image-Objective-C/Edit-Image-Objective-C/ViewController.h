//
//  ViewController.h
//  Edit-Image-Objective-C
//
//  Created by Tanjim Hossain on 12/31/17.
//  Copyright © 2017 Tanjim Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITabBarDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

