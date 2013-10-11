//
//  SnapViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/08/03.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "SnapViewController.h"

@interface SnapViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@end

@implementation SnapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.square addGestureRecognizer:pan];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    CGPoint point = CGPointMake(self.view.frame.size.width/2,
                                self.view.frame.size.height/2);
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.square snapToPoint:point];
    [self.animator addBehavior:snap];
}

- (void)panHandler:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *view = gestureRecognizer.view;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        // タッチした座標に長さ0のattachmentを作る
        CGPoint location = [gestureRecognizer locationInView:[view superview]];
        UIOffset offset = UIOffsetMake(location.x - view.center.x,
                                       location.y - view.center.y);
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:view offsetFromCenter:offset attachedToAnchor:location];
        [self.animator addBehavior:self.attachment];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // anchorをドラッグに追随させる
        CGPoint locationInSuperview = [gestureRecognizer locationInView:[view superview]];
        self.attachment.anchorPoint = locationInSuperview;
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        // attachmentを削除
        [self.animator removeBehavior:self.attachment];
        self.attachment = nil;
    }
}
@end
