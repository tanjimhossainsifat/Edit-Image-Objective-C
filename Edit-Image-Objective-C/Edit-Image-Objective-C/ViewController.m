//
//  ViewController.m
//  Edit-Image-Objective-C
//
//  Created by Tanjim Hossain on 12/31/17.
//  Copyright © 2017 Tanjim Hossain. All rights reserved.
//

#import "ViewController.h"

#import "CLImageEditor.h"

@interface ViewController ()<CLImageEditorDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *contentView = [UIView new];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default"]];
    [contentView addSubview:imageView];
    [_scrollView addSubview:contentView];
    _imageView = imageView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self refreshImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action Methods

-(void) onButtonNew {
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.editing = NO;
        imagePicker.delegate = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:imagePicker animated:YES completion:nil];
        });
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.editing = NO;
        imagePicker.delegate = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:imagePicker animated:YES completion:nil];
        });
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose any" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:libraryAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - TabbarDelegate Methods

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
            NSLog(@"New button pressed");
            [self onButtonNew];
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


#pragma mark- ScrollView related Methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView.superview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _imageView.superview.frame.size.width;
    CGFloat H = _imageView.superview.frame.size.height;
    
    CGRect rct = _imageView.superview.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _imageView.superview.frame = rct;
}

- (void)resetImageViewFrame
{
    CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
    CGFloat ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
    CGFloat W = ratio * size.width;
    CGFloat H = ratio * size.height;
    _imageView.frame = CGRectMake(0, 0, W, H);
    _imageView.superview.bounds = _imageView.bounds;
}

- (void)resetZoomScaleWithAnimate:(BOOL)animated
{
    CGFloat Rw = _scrollView.frame.size.width / _imageView.frame.size.width;
    CGFloat Rh = _scrollView.frame.size.height / _imageView.frame.size.height;
    
    //CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat scale = 1;
    Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
    Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
    
    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
    
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:animated];
    [self scrollViewDidZoom:_scrollView];
}

- (void)refreshImageView
{
    [self resetImageViewFrame];
    [self resetZoomScaleWithAnimate:NO];
}

#pragma mark- ImagePickerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

@end
