//
//  MLDAnimations.m
//  BasketBall
//
//  Created by Moliy on 2017/3/1.
//  Copyright © 2017年 Moliy. All rights reserved.
//

#import "MLDAnimations.h"

@implementation MLDAnimations

+ (void)topSpringAnimation:(UIView *)animationView
             withSuperView:(UIView *)superView
{
    CGFloat toValue = superView.bounds.size.height + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y - toValue)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"topSpringAnimation"];
}

+ (void)bottomSpringAnimation:(UIView *)animationView
                withSuperView:(UIView *)superView
{
    CGFloat toValue = superView.bounds.size.height + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y + toValue)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"bottomSpringAnimation"];
}

+ (void)leftSpringAnimation:(UIView *)animationView
              withSuperView:(UIView *)superView
{
    CGFloat toValue = superView.bounds.size.width + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x - toValue, point.y)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"leftSpringAnimation"];
}

+ (void)leftTopSpringAnimation:(UIView *)animationView
                    withSuperView:(UIView *)superView
{
    CGFloat toValueH = superView.bounds.size.height + 10;
    CGFloat toValueW = superView.bounds.size.width + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x - toValueW, point.y - toValueH)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"leftTopSpringAnimation"];
}

+ (void)leftBottomSpringAnimation:(UIView *)animationView
                withSuperView:(UIView *)superView
{
    CGFloat toValueH = superView.bounds.size.height + 10;
    CGFloat toValueW = superView.bounds.size.width + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x - toValueW, point.y + toValueH)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"leftBottomSpringAnimation"];
}

+ (void)rightSpringAnimation:(UIView *)animationView
              withSuperView:(UIView *)superView
{
    CGFloat toValue = superView.bounds.size.width + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x + toValue, point.y)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"rightSpringAnimation"];
}

+ (void)rightTopSpringAnimation:(UIView *)animationView
                 withSuperView:(UIView *)superView
{
    CGFloat toValueH = superView.bounds.size.height + 10;
    CGFloat toValueW = superView.bounds.size.width + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x + toValueW, point.y - toValueH)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"rightTopSpringAnimation"];
}

+ (void)rightBottomSpringAnimation:(UIView *)animationView
                    withSuperView:(UIView *)superView
{
    CGFloat toValueH = superView.bounds.size.height + 10;
    CGFloat toValueW = superView.bounds.size.width + 10;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = animationView.center;
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x + toValueW, point.y + toValueH)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"rightBottomSpringAnimation"];
}

+ (void)backSpringAnimation:(UIView *)animationView
              withSuperView:(UIView *)superView
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(superView.center.x, superView.center.y)];
    //弹性值
    springAnimation.springBounciness = 10;
    //弹性速度
    springAnimation.springSpeed = 60;
    [animationView pop_addAnimation:springAnimation forKey:@"backSpringAnimation"];
}

@end
