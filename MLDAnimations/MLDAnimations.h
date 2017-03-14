//
//  MLDAnimations.h
//  BasketBall
//
//  Created by Moliy on 2017/3/1.
//  Copyright © 2017年 Moliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <POP/POP.h>

@interface MLDAnimations : NSObject
/**
 向上做动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)topSpringAnimation:(UIView *)animationView
             withSuperView:(UIView *)superView;

/**
 向下做动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)bottomSpringAnimation:(UIView *)animationView
                withSuperView:(UIView *)superView;

/**
 向左做动画

 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)leftSpringAnimation:(UIView *)animationView
              withSuperView:(UIView *)superView;

/**
 向左上做动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)leftTopSpringAnimation:(UIView *)animationView
                 withSuperView:(UIView *)superView;

/**
 向左下做动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)leftBottomSpringAnimation:(UIView *)animationView
                    withSuperView:(UIView *)superView;

/**
 向右做动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)rightSpringAnimation:(UIView *)animationView
              withSuperView:(UIView *)superView;

/**
 向右上做动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)rightTopSpringAnimation:(UIView *)animationView
               withSuperView:(UIView *)superView;

/**
 向右下做动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)rightBottomSpringAnimation:(UIView *)animationView
               withSuperView:(UIView *)superView;






/**
 返回动画
 
 @param animationView 做动画的View
 @param superView 点击的按钮
 */
+ (void)backSpringAnimation:(UIView *)animationView
              withSuperView:(UIView *)superView;
@end
