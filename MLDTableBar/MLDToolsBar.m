//
//  MLDToolsBar.m
//  MLDToolsBar
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 Moliy. All rights reserved.
//

#import "MLDToolsBar.h"
#import "UIButton+Edge.h"
#import "UIColor+Hex.h"




@implementation MLDToolsBar




#pragma mark 初始化方法

-(instancetype)initWithFrame:(CGRect)frame withToolsBarStyle:(ToolsBarType)toolsBarType withButtonImageArray:(NSArray<NSDictionary *> *)buttonImageArray withButtonTitleArray:(NSArray<NSDictionary *> *)buttonTitleArray
{
    self = [super initWithFrame:frame];
    if (self)
    {

        
        if (toolsBarType == ToolsBarImageType)
        {
            [self setImageButton:buttonImageArray];
        }
        if (toolsBarType == ToolsBarTitleType)
        {
            [self setTitleButton:buttonTitleArray];

        }
        if (toolsBarType == ToolsBarImageTextType)
        {
            [self setImageTextButtonWithButtonImageArray:buttonImageArray withTitleButtonArray:buttonTitleArray];
        }
        
    }
    return self;
}




#pragma mark 图片按钮

-(void)setImageButton:(NSArray<NSDictionary *> *)buttonArray
{
    CGFloat buttonWidth = self.frame.size.width / buttonArray.count;

    self.buttonArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < buttonArray.count; i++)
    {

        NSDictionary *dic = buttonArray[i];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        
        [self creatButtonImage:dic withButton:button];
        
        if (i == self.currrentIndex)
        {
            button.selected = YES;
        }else
        {
            button.selected = NO;
        }

        
        
        button.tag = i;
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, self.frame.size.height);
        
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
}


#pragma mark 文字按钮

-(void)setTitleButton:(NSArray<NSDictionary *> *)buttonArray
{
    CGFloat buttonWidth = self.frame.size.width / buttonArray.count;
    self.buttonArray = [[NSMutableArray alloc] init];

    
    for (NSInteger i = 0; i < buttonArray.count; i++)
    {
        
        NSDictionary *dic = buttonArray[i];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        [self creatButtonTitle:dic withButton:button];

        
        
        button.tag = i;
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth , self.frame.size.height);
        [self addSubview:button];
        
        [self.buttonArray addObject:button];

    }

}


#pragma mark 图文按钮

-(void)setImageTextButtonWithButtonImageArray:(NSArray<NSDictionary *> *)buttonImageArray withTitleButtonArray:(NSArray<NSDictionary *> *)buttonTitleArray
{
    CGFloat buttonWidth = self.frame.size.width / buttonImageArray.count;
    self.buttonArray = [[NSMutableArray alloc] init];

    
    for (NSInteger i = 0; i < buttonTitleArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSDictionary *dicStr = buttonTitleArray[i];
        
        NSDictionary *dicImage = buttonImageArray[i];
        
        
        [self creatButtonImage:dicImage withButton:button];
        [self creatButtonTitle:dicStr withButton:button];
        
        
        
        /*--------文字选中颜色 未留接口------------------*/
        [button setTitleColor:[UIColor colorWithHexString:@"#ff4965"] forState:UIControlStateSelected];

        [button setTitleColor:[UIColor colorWithHexString:@"#484848"] forState:UIControlStateNormal];
        /*--------------------------------------------*/
        
        
        button.tag = i;
        button.frame = CGRectMake(i * buttonWidth, 0,buttonWidth, self.frame.size.height);
        
        [button layoutButtonWithEdgeInsetsStyle:EdgeStyleImageTop imageTitlespace:0];
        
        
        
        [self addSubview:button];
        
        
        [self.buttonArray addObject:button];

    }
    
}





#pragma mark 创建按钮样式

-(void)creatButtonTitle:(NSDictionary *)dic withButton:(UIButton *)button
{
    NSString *labelNormal = dic[@"normal"];
    NSString *labelHighlighted = dic[@"highlighted"];
    NSString *labelSelected = dic[@"selected"];
    [button setTitle:labelNormal forState:UIControlStateNormal];
    [button setTitle:labelHighlighted forState:UIControlStateHighlighted];
    [button setTitle:labelSelected forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

}



-(void)creatButtonImage:(NSDictionary *)dic withButton:(UIButton *)button
{
    UIImage *imageNormal = dic[@"normal"];
    UIImage *imageHighlighted = dic[@"highlighted"];
    UIImage *imageSelected = dic[@"selected"];
    
    
    
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:imageHighlighted forState:UIControlStateHighlighted];
    [button setImage:imageSelected forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}




#pragma mark - 代理调用

-(void)buttonClick:(UIButton *)sender
{
    NSLog(@"MLDToolsBar 点击Button.tag = %ld",sender.tag);
    self.lastButton.selected = NO;
    sender.selected = YES;
    self.lastButton = sender;
    if ([self.delegate respondsToSelector:@selector(toolsBarButtonClick:)])
    {
        [self.delegate toolsBarButtonClick:sender];
    }
}





@end
