//
//  MonacaNavigationController.m
//  MonacaFramework
//
//  Created by air on 12/06/28.
//  Copyright (c) 2012年 ASIAL CORPORATION. All rights reserved.
//

#import "MFNavigationController.h"
#import "MFUtility.h"
#import "NativeComponents.h"
#import "MFDummyViewController.h"
#import "MFViewManager.h"
#import "MFSpinnerView.h"

@interface MFNavigationController ()

@end

@implementation MFNavigationController

- (id)init
{
    self = [super init];

    if (self) {
        popFlag = NO;
    }

    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([MFSpinnerView isAnimating])
        return NO;
    if ([MFViewManager currentViewController]) {
        if ([MFViewManager currentViewController].screenOrientations == UIInterfaceOrientationMaskAll)
            return [MFUtility getAllowOrientationFromPlist:toInterfaceOrientation];
        else
            return [MFViewManager currentViewController].screenOrientations & 1 << toInterfaceOrientation;
    } else {
        return [MFUtility getAllowOrientationFromPlist:toInterfaceOrientation];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    id viewController;
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    if (![[viewControllers objectAtIndex:[viewControllers count]-2] isKindOfClass:[MFDummyViewController class]]) {
        popFlag = YES;
        viewController = [super popViewControllerAnimated:animated];
        popFlag = NO;
        return viewController;
    }
    return nil;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    int index = 0;
    if ([viewControllers count] > 1) {
        index = 1;
    }
    popFlag = YES;
    NSArray *_viewControllers = [self popToViewController:[viewControllers objectAtIndex:index] animated:animated];
    popFlag = NO;
    return _viewControllers;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    if (!popFlag) {
        [[(MFViewController *)self.topViewController backButton] didTap:self forEvent:nil];
    } else {
        return YES;
    }
    return NO;
}

- (void)destroy
{
    for (MFViewController *view in self.viewControllers) {
        [view destroy];
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([MFSpinnerView isAnimating]) {
        return 0;
    }

    UIInterfaceOrientationMask mask = nil;
    if ([MFUtility getAllowOrientationFromPlist:UIInterfaceOrientationPortrait]) {
        mask |= UIInterfaceOrientationMaskPortrait;
    }
    if ([MFUtility getAllowOrientationFromPlist:UIInterfaceOrientationPortraitUpsideDown]){
        mask |= UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    if ([MFUtility getAllowOrientationFromPlist:UIInterfaceOrientationLandscapeRight]){
        mask |= UIInterfaceOrientationMaskLandscapeRight;
    }
    if ([MFUtility getAllowOrientationFromPlist:UIInterfaceOrientationLandscapeLeft]){
        mask |= UIInterfaceOrientationMaskLandscapeLeft;
    }
    if ([MFViewManager currentViewController]) {
        if ([MFViewManager currentViewController].screenOrientations == UIInterfaceOrientationMaskAll)
            return mask;
        else
            return [MFViewManager currentViewController].screenOrientations;
    } else {
        return mask;
    }
    
}

@end
