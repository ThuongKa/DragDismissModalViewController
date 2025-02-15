//
//  UIViewController+DagToDismiss.h
//  TransitionViewController
//
//  Created by ThuyenBV on 7/31/15.
//  Copyright (c) 2015 ThuyenBV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionObject.h"
#import "DetectScrollPanGesture.h"

@interface UIViewController (DagToDismiss) <UIGestureRecognizerDelegate>

@property (nonatomic, strong) TransitionObject *objTransition;
@property (strong, nonatomic) DetectScrollPanGesture *panGesture;

- (void)setUpTransition;
- (void)dismissInteraction:(BOOL)isInteraction animation:(BOOL)animated;
- (void)didPanWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
