//
//  AttachmentViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/08/03.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "AttachmentViewController.h"

@interface AttachmentViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation AttachmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square1, self.square2]];
    [self.animator addBehavior:gravity];
    
    CGPoint anchorPoint1 = self.anchor1.center;
    UIAttachmentBehavior *attachment1 = [[UIAttachmentBehavior alloc] initWithItem:self.square1 attachedToAnchor:anchorPoint1];
    [self.animator addBehavior:attachment1];
    
    CGPoint anchorPoint2 = self.anchor2.center;
    UIAttachmentBehavior *attachment2 = [[UIAttachmentBehavior alloc] initWithItem:self.square2 attachedToAnchor:anchorPoint2];
    attachment2.frequency = 1;
    attachment2.damping = 0.01;
    [self.animator addBehavior:attachment2];
}

@end
