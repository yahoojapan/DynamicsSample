//
//  PushViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/08/03.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "PushViewController.h"

@interface PushViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@property (nonatomic, strong) UIPushBehavior *pushInstantaneous;
@property (nonatomic, strong) UIPushBehavior *pushContinuous;
@end

@implementation PushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.square1.frame = CGRectMake(self.square1.frame.origin.x,
                                    self.view.frame.size.height - self.square1.frame.size.height,
                                    self.square1.frame.size.width,
                                    self.square1.frame.size.height);
    self.square2.frame = CGRectMake(self.square2.frame.origin.x,
                                    self.view.frame.size.height - self.square2.frame.size.height,
                                    self.square2.frame.size.width,
                                    self.square2.frame.size.height);
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler1:)];
    [self.square1 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler2:)];
    [self.square2 addGestureRecognizer:tap2];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square1, self.square2]];
    gravity.magnitude = 0.5;
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.square1, self.square2]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}

- (void)tapHandler1:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.pushInstantaneous == nil) {
        self.pushInstantaneous = [[UIPushBehavior alloc] initWithItems:@[gestureRecognizer.view] mode:UIPushBehaviorModeInstantaneous];
        self.pushInstantaneous.pushDirection = CGVectorMake(0.0f, -3.0f);
        [self.animator addBehavior:self.pushInstantaneous];
    }
    else {
        self.pushInstantaneous.active = YES;
    }
}

- (void)tapHandler2:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.pushContinuous == nil) {
        self.pushContinuous = [[UIPushBehavior alloc] initWithItems:@[gestureRecognizer.view] mode:UIPushBehaviorModeContinuous];
        self.pushContinuous.pushDirection = CGVectorMake(0.0f, -3.0f);
        [self.animator addBehavior:self.pushContinuous];
    }
}

@end
