//
//  MotionEffectsViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/09/26.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "MotionEffectsViewController.h"

@interface MotionEffectsViewController ()

@end

@implementation MotionEffectsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *gridPattern = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Grid"]];
    self.view.backgroundColor = gridPattern;
    
    [self applyMotionEffectsToView:self.backView withValue:10.0f];
    [self applyMotionEffectsToView:self.frontView withValue:20.0f];
}

- (void)applyMotionEffectsToView:(UIView *)view withValue:(CGFloat)value
{
    UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xAxis.minimumRelativeValue = @(-value);
    xAxis.maximumRelativeValue = @(value);
    
    UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yAxis.minimumRelativeValue = @(-value);
    yAxis.maximumRelativeValue = @(value);
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[xAxis, yAxis];
    [view addMotionEffect:group];
}

@end
