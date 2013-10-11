//
//  BlurSampleViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/09/26.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "BlurSampleViewController.h"
#import "UIImage+ImageEffects.h"

@interface BlurSampleViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@property (nonatomic, strong) UIPushBehavior *push;
@end

@implementation BlurSampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.shutterView addGestureRecognizer:panGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.backgroundImageView.image == nil) {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.0);
        [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
        UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        bgImage = [bgImage applyLightEffect];
        self.backgroundImageView.image = bgImage;
    }
    
    if (self.animator == nil) {
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.shutterView]];
        gravity.magnitude = 2.0;
        gravity.action = ^{
            CGRect frame = self.backgroundImageView.frame;
            frame.origin.y =  -self.shutterView.frame.origin.y;
            self.backgroundImageView.frame = frame;
        };
        [self.animator addBehavior:gravity];
        
        UICollisionBehavior *collition = [[UICollisionBehavior alloc] initWithItems:@[self.shutterView]];
        [collition addBoundaryWithIdentifier:@"ground"
                                   fromPoint:CGPointMake(0, self.view.frame.size.height+1)
                                     toPoint:CGPointMake(self.view.frame.size.width, self.view.frame.size.height+1)];
        [self.animator addBehavior:collition];
        
        UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.shutterView]];
        itemBehavior.allowsRotation = NO;
        itemBehavior.elasticity = 0.5;
        [self.animator addBehavior:itemBehavior];
        
        self.push = [[UIPushBehavior alloc] initWithItems:@[self.shutterView] mode:UIPushBehaviorModeInstantaneous];
        self.push.magnitude = 0;
        [self.animator addBehavior:self.push];
    }
}

- (void)panHandler:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        // ドラッグ開始点をanchorにしてatachmentを生成
        CGPoint anchor = [panGesture locationInView:self.view];
        CGPoint locationInView = [panGesture locationInView:self.shutterView];
        UIOffset offset = UIOffsetMake(locationInView.x - self.shutterView.frame.size.width/2.0,
                                       locationInView.y - self.shutterView.frame.size.height/2.0);
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.shutterView offsetFromCenter:offset attachedToAnchor:anchor];
        [self.animator addBehavior:self.attachment];
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged) {
        // ドラッグに合わせてanchorのy座標を更新
        CGPoint point = self.attachment.anchorPoint;
        point.y = [panGesture locationInView:self.view].y;
        self.attachment.anchorPoint = point;
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled) {
        // attachmentを解除
        [self.animator removeBehavior:self.attachment];
        // ドラッグの速度に比例した力でpush
        CGPoint v = [panGesture velocityInView:self.view];
        self.push.pushDirection = CGVectorMake(0, v.y/10.0);
        self.push.active = YES;
    }
}

@end
