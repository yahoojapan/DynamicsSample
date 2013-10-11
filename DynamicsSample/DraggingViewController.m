//
//  DraggingViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/08/03.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "DraggingViewController.h"

@interface DraggingViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@end

@implementation DraggingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.square addGestureRecognizer:pan];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square]];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.square]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}

- (void)panHandler:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *view = gestureRecognizer.view;

    // ↓ これじゃだめ。viewの座標をanimatorの外から直接変更しても反映されない。
    // また、一度止まったアニメーションは再開されない。
//    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
//        CGPoint location = [gestureRecognizer locationInView:[view superview]];
//        view.center = location;
//    }
    
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
