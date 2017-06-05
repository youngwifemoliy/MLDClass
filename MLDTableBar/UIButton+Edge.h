//
//  UIButton+Edge.h
//  MLDToolsBar
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 Moliy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, EdgeStyle)
{
    EdgeStyleImageLeft,
    EdgeStyleImageRight,
    EdgeStyleImageTop,
    EdgeStyleImageBottom
};


@interface UIButton (Edge)

- (void)layoutButtonWithEdgeInsetsStyle:(EdgeStyle)style imageTitlespace:(CGFloat)space;

@end
