//
//  MLDToolsBar.h
//  MLDToolsBar
//
//  Created by MoliySDev on 16/6/13.
//  Copyright © 2016年 Moliy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLDToolsBarDelegate <NSObject>

-(void)toolsBarButtonClick:(UIButton *)sender;

@end


typedef enum : NSInteger
{
    ToolsBarImageType = 0,
    ToolsBarTitleType = 1,
    ToolsBarImageTextType = 2,
}ToolsBarType;



@interface MLDToolsBar : UIView

@property (nonatomic,weak) id<MLDToolsBarDelegate> delegate;


//当前高亮按钮的tag
@property (nonatomic) NSInteger currrentIndex;


//上一次点击的Button
@property (nonatomic,strong) UIButton *lastButton;


/*
 这个数组，可以拿到所有按钮
 */
@property (nonatomic,strong) NSMutableArray *buttonArray;


//这个是风格
@property (nonatomic,unsafe_unretained) NSInteger type;





/*传参实例 图片
-(NSArray *)getImageArray
{
    NSDictionary *today = @{@"normal":[UIImage imageNamed:@"ic_tabbar_sale_n"],@"selected":[UIImage imageNamed:@"ic_tabbar_sale_h"]};
    
    NSDictionary *global = @{@"normal":[UIImage imageNamed:@"ic_tabbar_global_n"],@"selected":[UIImage imageNamed:@"ic_tabbar_global_h"]};
    
    NSDictionary *group = @{@"normal":[UIImage imageNamed:@"ic_tabbar_tuan_n"],@"selected":[UIImage imageNamed:@"ic_tabbar_tuan_h"]};
    
    
    NSDictionary *trolley = @{@"normal":[UIImage imageNamed:@"ic_tabbar_cart_n"],@"selected":[UIImage imageNamed:@"ic_tabbar_cart_h"]};
    
    
    
    NSDictionary *main = @{@"normal":[UIImage imageNamed:@"ic_tabbar_mine_n"],@"selected":[UIImage imageNamed:@"ic_tabbar_mine_h"]};
    
    
    
    NSArray *array = @[today,global,group,trolley,main];
    return array;
    
}
 */

/*传参实例 文字
-(NSArray *)getTitleArray
{
    NSDictionary *today = @{@"normal":@"今日特卖",@"selected":@"今日特卖"};
    
    NSDictionary *global = @{@"normal":@"全球购",@"selected":@"全球购"};
    
    NSDictionary *group = @{@"normal":@"团拼",@"selected":@"团拼"};
    
    
    NSDictionary *trolley = @{@"normal":@"购物车",@"selected":@"购物车"};
    
    
    
    NSDictionary *main = @{@"normal":@"我的",@"selected":@"我的"};
    
    
    NSArray *array = @[today,global,group,trolley,main];
    
    return array;
}
*/



-(instancetype)initWithFrame:(CGRect)frame withToolsBarStyle:(ToolsBarType)toolsBarType withButtonImageArray:(NSArray<NSDictionary *> *)buttonImageArray withButtonTitleArray:(NSArray<NSDictionary *> *)buttonTitleArray;

@end
