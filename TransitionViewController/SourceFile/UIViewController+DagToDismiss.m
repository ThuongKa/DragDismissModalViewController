//
//  UIViewController+DagToDismiss.m
//  TransitionViewController
//
//  Created by ThuyenBV on 7/31/15.
//  Copyright (c) 2015 ThuyenBV. All rights reserved.
//

#import "UIViewController+DagToDismiss.h"

#import "TransitionObject.h"
#import <objc/runtime.h>

NSString const *keyObjectTransition = @"keyObjectTransition";
NSString const *keyPanGesture       = @"keyPanGesture";

@implementation UIViewController (DagToDismiss)
@dynamic objTransition,panGesture;

#pragma mark - ObjTransiton

- (void)setObjTransition:(TransitionObject *)objTransition {
    objc_setAssociatedObject(self, &keyObjectTransition, objTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TransitionObject *)objTransition {
    return objc_getAssociatedObject(self, &keyObjectTransition);
}

#pragma mark - PanGesture

- (void)setPanGesture:(DetectScrollPanGesture *)panGesture {
    objc_setAssociatedObject(self, &keyPanGesture, panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DetectScrollPanGesture *)panGesture {
    return objc_getAssociatedObject(self, &keyPanGesture);
}

#pragma mark - Public Method

- (void)setUpTransition {
    self.objTransition = [[TransitionObject alloc] init];
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    self.transitioningDelegate = self.objTransition;
    self.modalPresentationCapturesStatusBarAppearance = YES;
}

- (void)didPanWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self dismissInteraction:YES animation:YES];
    }
    else {
        [self.objTransition didPanWithPanGestureRecognizer:panGestureRecognizer
                                                 viewToPan:self.view
                                               anchorPoint:self.boundsCenterPoint];
    }
}

- (void)dismissInteraction:(BOOL)isInteraction animation:(BOOL)animated {
    self.objTransition.isInteraction = isInteraction;
    [self dismissViewControllerAnimated:animated completion: ^{
    }];
}

#pragma mark - Private Method

- (CGPoint)boundsCenterPoint {
    return CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end