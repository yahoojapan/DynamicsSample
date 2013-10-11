//
//  CollisioinViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/08/03.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "CollisioinViewController.h"

@interface CollisioinViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation CollisioinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square1, self.square2]];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.square1, self.square2]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
//    collision.collisionMode = UICollisionBehaviorModeBoundaries;
    [self.animator addBehavior:collision];
}

@end
